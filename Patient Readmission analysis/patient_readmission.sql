CREATE DATABASE hospital_readmissions;
USE hospital_readmissions;

SELECT COUNT(*)
FROM ids_mapping_raw;

SELECT COUNT(*)
FROM diabetic_data_raw;

SELECT *
FROM
diabetic_data_raw
LIMIT 10;

SELECT * FROM admission_source_map;
SELECT * FROM admission_type_map;
SELECT * FROM discharge_disposition_map;


-- Replace the question mark values to nulls

SET SQL_SAFE_UPDATES = 0;

ALTER table
diabetic_data_raw
MODIFY
diag_1 VARCHAR(10);

UPDATE
diabetic_data_raw
SET
race = NULLIF(race, '?'),
weight = NULLIF(weight,'?'),
payer_code = NULLIF(payer_code,'?'),
medical_specialty = NULLIF(medical_specialty, '?'),
diag_1 = NULLIF(diag_1,'?'),
diag_2 = NULLIF(diag_2,'?'),
diag_3 = NULLIF(diag_3,'?');

-- Find the percentage of missing values in weight, payer_code and medical specialty columns

SELECT
	ROUND(SUM(weight IS NULL) / COUNT(*) * 100, 1) AS pct_missing_weight,
	ROUND(SUM(payer_code IS NULL) / COUNT(*) * 100, 1) AS pct_missing_payer,
	ROUND(SUM(medical_specialty IS NULL) / COUNT(*) * 100, 1) AS pct_missing_specialty
FROM
diabetic_data_raw;

-- Find the duplicate records in the dataset

SELECT
	patient_nbr,
    COUNT(*) AS encounter_count
FROM diabetic_data_raw
GROUP BY patient_nbr
HAVING COUNT(*) >1
ORDER BY encounter_count DESC
LIMIT 10;

-- Create a new table removing all the duplicate patient encounters
-- Consider their first encounter as their only encounter

CREATE TABLE 
diabetic_data_dedup
AS
SELECT ddr.*
FROM diabetic_data_raw AS ddr

INNER JOIN

(
SELECT
	patient_nbr,
    MIN(encounter_id) AS first_encounter
FROM diabetic_data_raw
GROUP BY patient_nbr
) AS first_enc

ON 
ddr.patient_nbr = first_enc.patient_nbr
AND
ddr.encounter_id = first_enc.first_encounter;

SELECT COUNT(*) FROM diabetic_data_dedup;

-- Exclude the patients from the dataset who were expired, sent to hospice or deceased 

SELECT
	discharge_disposition_id,
    COUNT(*) encounter_count
FROM diabetic_data_raw
GROUP BY discharge_disposition_id
ORDER BY encounter_count DESC;

SELECT * FROM ids_mapping_raw;

SELECT *
FROM
discharge_disposition_map
WHERE
description LIKE '%hospice%'
OR
description LIKE '%expired%';


DELETE FROM diabetic_data_dedup
WHERE discharge_disposition_id IN (11,13,14,19,20,21);

SELECT COUNT(*) FROM diabetic_data_dedup;


-- Create an age column where the age of patients are changed from range to a fixed value

SELECT * FROM diabetic_data_dedup
LIMIT 50;

ALTER TABLE
diabetic_data_dedup
ADD COLUMN
age_midpoint
INT;

UPDATE diabetic_data_dedup
SET age_midpoint = CASE
    WHEN age = '[0-10)'   THEN 5
    WHEN age = '[10-20)'  THEN 15
    WHEN age = '[20-30)'  THEN 25
    WHEN age = '[30-40)'  THEN 35
    WHEN age = '[40-50)'  THEN 45
    WHEN age = '[50-60)'  THEN 55
    WHEN age = '[60-70)'  THEN 65
    WHEN age = '[70-80)'  THEN 75
    WHEN age = '[80-90)'  THEN 85
    WHEN age = '[90-100)' THEN 95
END;

-- EXPLORATORY ANALYSIS

-- Find the Total patient visits with respect to the radmission column and find the respective pct of total values

SELECT
	readmitted,
    COUNT(*) as encounter_count,
    ROUND(COUNT(*) / (SELECT
					COUNT(*)
				FROM diabetic_data_dedup) * 100,1) AS pct_of_total
FROM diabetic_data_dedup
GROUP BY readmitted
ORDER BY encounter_count DESC;

-- Find the same total patients and thier pct values with respect to thier age

SELECT
	age,
    age_midpoint,
    COUNT(*) AS total_encounters,
    SUM(readmitted = '<30') AS readmitted_under_30,
	ROUND (SUM(readmitted = '<30') / COUNT(*) * 100,1) AS readmissin_rate_pct
   FROM diabetic_data_dedup
   GROUP BY age, age_midpoint
   ORDER BY age_midpoint;

-- Find the readmission ratwe percent with  respect to admission source description

SELECT
	m.description AS admission_type,
    COUNT(*) AS total_encounters,
    ROUND(SUM(d.readmitted = '<30') / COUNT(*) * 100,1) AS readmission_rate_pct
FROM diabetic_data_dedup as d
JOIN admission_source_map AS m
ON d.admission_source_id = m.admission_source_id
GROUP BY m.description
ORDER BY readmission_rate_pct;


-- 

WITH patient_risk_base AS (
	SELECT
		encounter_id, 
        patient_nbr, 
        age_midpoint, 
        time_in_hospital, 
        num_medications, 
        num_lab_procedures, 
        number_diagnoses, 
        number_inpatient, 
        number_emergency, 
        number_outpatient, 
        diag_1, 
        readmitted, 
        CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END AS is_readmitted_30
	FROM diabetic_data_dedup
)
SELECT * FROM patient_risk_base
LIMIT 20;

-- Create a rank column based on the num_medications gone through in each encounter

WITH patient_risk_base AS 
(
	SELECT 
		encounter_id,
        age_midpoint,
        num_medications,
        readmitted, 
		CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END AS is_readmitted_30
	FROM diabetic_data_dedup
)
SELECT
	encounter_id, 
    age_midpoint, 
    num_medications, 
    RANK() OVER (PARTITION BY age_midpoint ORDER BY num_medications DESC) as med_rank_age_group
FROM patient_risk_base
ORDER BY age_midpoint, med_rank_age_group
LIMIT 200;

--  

WITH patient_risk_base AS 
(
	SELECT 
		encounter_id,
        number_inpatient,
        readmitted, 
		CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END AS is_readmitted_30
     FROM diabetic_data_dedup
)
SELECT
	encounter_id, 
    number_inpatient, 
    NTILE(4) OVER (ORDER BY number_inpatient DESC) as risk_quartile
FROM patient_risk_base;

-- Create column where the num_medication values are categorised as 'Low', 'Medium' and 'High'
-- Create column where the num_diagnoses values are categorised as 'Low', 'Medium' and 'High' complexities

SELECT
	encounter_id, 
    num_medications, 
    CASE
		WHEN num_medications <= 10 THEN 'Low'
        WHEN num_medications BETWEEN 11 AND 20 THEN 'Medium'
        ELSE 'High'
	END AS medication_burden_tier, 
    CASE
		WHEN number_diagnoses <= 5 THEN 'Low Complexity'
        WHEN number_diagnoses BETWEEN 6 AND 9 THEN 'Moderate Complexity'
        ELSE 'High Complexity'
	END AS diagnosis_complexity_tier
FROM diabetic_data_dedup;


-- Categorize the diag_1 column as per the notes given below
-- diag_1 notes
-- 390–459: Diseases of the circulatory system
-- 460–519: Diseases of the respiratory system
-- 520–579: Diseases of the digestive system
-- 580–629: Diseases of the genitourinary system
-- 800–999: Injury and poisoning

-- Find the diagnosis_categories that have the highest readmission_rate_percentage

WITH diag_categorized AS (
	SELECT
		encounter_id, 
        readmitted, 
        CASE
			WHEN diag_1 LIKE '250%' THEN 'Diabetes'
            WHEN CAST(LEFT(diag_1, 3) AS UNSIGNED) BETWEEN 390 AND 459 THEN 'CIRCULATORY'
			WHEN CAST(LEFT(diag_1, 3) AS UNSIGNED) BETWEEN 460 AND 519 THEN 'Respiratory'
            WHEN CAST(LEFT(diag_1, 3) AS UNSIGNED) BETWEEN 520 AND 579 THEN 'Digestive'
            WHEN CAST(LEFT(diag_1, 3) AS UNSIGNED) BETWEEN 580 AND 629 THEN 'Genitourinary'
            WHEN CAST(LEFT(diag_1, 3) AS UNSIGNED) BETWEEN 800 AND 999 THEN 'Injury'
		ELSE 'Other'
	END AS diagnosis_cateogry, 
    CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END AS is_readmitted_30
	FROM diabetic_data_dedup
    WHERE diag_1 IS NOT NULL
)
SELECT
	diagnosis_cateogry, 
    COUNT(*) AS total_encounters, 
    ROUND(AVG(is_readmitted_30) * 100, 1) AS readmission_rate_pct
FROM diag_categorized
GROUP BY diagnosis_cateogry
HAVING AVG(is_readmitted_30) > (
	SELECT AVG(is_readmitted_30) FROM diag_categorized
)
ORDER BY readmission_rate_pct DESC;

--  Find whether the change in medication affect readmission

SELECT
	`change`, 
    COUNT(*) as total_encounters,
	ROUND(SUM(readmitted = '<30') / COUNT(*) * 100, 1) AS readmission_rate_pct
FROM diabetic_data_dedup
GROUP BY `change`;

-- Find the impact of Discharge disposition on readmission

SELECT
	m.description as discharge_disposition, 
    COUNT(*) AS total_encounters, 
	ROUND(SUM(d.readmitted = '<30') / COUNT(*) * 100, 1) AS readmission_rate_pct
FROM diabetic_data_dedup as d
JOIN discharge_disposition_map as m
ON d.discharge_disposition_id = m.discharge_disposition_id
GROUP BY m.description
HAVING COUNT(*) > 100
ORDER BY readmission_rate_pct DESC
LIMIT 10;

-- Find how the A1C affects the readmission

SELECT
	A1Cresult, 
    COUNT(*) as total_encounters, 
	ROUND(SUM(readmitted = '<30') / COUNT(*) * 100, 1) AS readmission_rate_pct
FROM diabetic_data_dedup
GROUP BY A1Cresult;