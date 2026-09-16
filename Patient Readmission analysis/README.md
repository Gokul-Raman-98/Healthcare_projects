# Project Description
Hospitals can face financial penalties when patients are readmitted within 30 days of discharge.
This project analyzes 10 years of data (1999 - 2008) from 130 U.S. hospitals to identify patient characteristics, diagnoses, and care patterns associated with a higher risk of readmission.
The objective is to help healthcare teams identify high-risk patients, prioritize follow-up care, and reduce preventable hospital readmissions.

# Dataset used

The dataset consists of three tables patient_data, discharge_disposition map and admission_source_map

patient_data contains patient_number, encounter_id, race gender, age and readmission data.

<img width="1882" height="837" alt="image" src="https://github.com/user-attachments/assets/fa0b1021-b0b8-47bd-b360-a279c6512a2f" />

admission_source_map contains the admission description and their respective id

<img width="637" height="642" alt="image" src="https://github.com/user-attachments/assets/7dcb0fd8-2336-4f9a-808c-6fb541105d19" />


discharge_disposition_map contains the discharge description and their respective id.

<img width="1051" height="762" alt="image" src="https://github.com/user-attachments/assets/f07fa518-9325-4259-bde6-8e6de6eaa496" />


# SQL queries and results

1. Replace the question mark values in the race, weight, payer_code, medical_specialty, diag_1, diag_2, diag_3 columns with NULL

<img width="571" height="397" alt="image" src="https://github.com/user-attachments/assets/0dd5fb87-f11e-4f04-8c17-36b300f2b2ff" />


<img width="1462" height="292" alt="image" src="https://github.com/user-attachments/assets/0b50d5a3-6390-4795-adcb-0ca71408c5e4" />


2. Find the percentage of missing values in weight, payer_code and medical specialty columns

<img width="1042" height="240" alt="image" src="https://github.com/user-attachments/assets/b7d88702-5cce-4b84-83ec-3c53300fb9e3" />


<img width="590" height="65" alt="image" src="https://github.com/user-attachments/assets/8c62c7d6-96cd-472c-9fb2-2c53d1c0b6f7" />


3. Find the duplicate records in the dataset

<img width="442" height="312" alt="image" src="https://github.com/user-attachments/assets/b6902c6d-2140-47e2-8f0b-f72f5ccc97d1" />


<img width="307" height="297" alt="image" src="https://github.com/user-attachments/assets/586e04b7-f68c-4de4-9f39-4b1c6092c4eb" />

4. Create a new table removing all the duplicate patient encounters. Consider their first encounter as their only encounter

<img width="411" height="616" alt="image" src="https://github.com/user-attachments/assets/10978bb6-2330-4437-a67b-9708d4bedb35" />


<img width="1547" height="507" alt="image" src="https://github.com/user-attachments/assets/77234265-05fe-4f30-b4b9-d8279bec7b48" />


5. Exclude the patients from the dataset who were expired or sent to hospice

<img width="662" height="497" alt="image" src="https://github.com/user-attachments/assets/dfd386b7-6351-495e-86a7-582d2eea99ed" />


<img width="135" height="70" alt="image" src="https://github.com/user-attachments/assets/109ccdbf-5efe-4e10-9421-47cd669b2b95" />


6. Create an age column where the age of patients are changed from range to a fixed value

<img width="347" height="577" alt="image" src="https://github.com/user-attachments/assets/077482cc-c9c1-49c2-a08c-728b61819d20" />


7. Find the Total patient visits with respect to the readmission column and find the respective pct of total values

<img width="700" height="347" alt="image" src="https://github.com/user-attachments/assets/9c9cfb22-ddc3-4a41-a849-05fecb15034d" />


<img width="415" height="126" alt="image" src="https://github.com/user-attachments/assets/e955a8dc-960c-4c20-83ae-d9172bc075ab" />


8. Find the same total patients and their pct values with respect to their age

<img width="900" height="342" alt="image" src="https://github.com/user-attachments/assets/9f5fa386-166b-43ee-9fdf-8192b3374459" />


<img width="787" height="292" alt="image" src="https://github.com/user-attachments/assets/bdebdb6c-64de-47b3-9185-54fa6d6f9e86" />


9. Find the readmission rate percent with  respect to admission source description

<img width="937" height="355" alt="image" src="https://github.com/user-attachments/assets/b1845a91-13bd-4eb3-b0b4-e7923e470aab" />


<img width="700" height="450" alt="image" src="https://github.com/user-attachments/assets/f661b7ac-d27b-49f2-a00f-251ca86a320a" />


10. Create a rank column based on the num_medications gone through in each encounter

<img width="1007" height="552" alt="image" src="https://github.com/user-attachments/assets/622e3cfc-6239-4ad1-b0b5-11f82bd1dc5d" />


<img width="662" height="547" alt="image" src="https://github.com/user-attachments/assets/42e7fc49-7cd7-4874-aef9-3867cd90d48a" />


11. Create a rank column based on the num_medications gone through in each encounter


<img width="1022" height="562" alt="image" src="https://github.com/user-attachments/assets/dd5ff2d8-a205-45a7-87ac-778edb3ce77e" />


<img width="521" height="657" alt="image" src="https://github.com/user-attachments/assets/b7b4a331-00a0-446e-a0ae-24720f45d144" />


12. Create column where the num_medication values are categorised as 'Low', 'Medium' and 'High'. Create column where the num_diagnoses values are categorised as 'Low', 'Medium' and 'High' complexities

<img width="927" height="532" alt="image" src="https://github.com/user-attachments/assets/a4b16755-0a40-4103-94fd-7e5468e03682" />


<img width="757" height="677" alt="image" src="https://github.com/user-attachments/assets/ea8ba8fd-deae-4133-995a-b8afa1e8fd68" />


13. Categorize the diag_1 column as per the notes given below
-- diag_1 notes
-- 390–459: Diseases of the circulatory system
-- 460–519: Diseases of the respiratory system
-- 520–579: Diseases of the digestive system
-- 580–629: Diseases of the genitourinary system
-- 800–999: Injury and poisoning

-- Find the diagnosis_categories that have the highest readmission_rate_percentage

<img width="805" height="620" alt="image" src="https://github.com/user-attachments/assets/879979b8-6309-4d7c-8814-9a7dbdab3863" />


<img width="462" height="107" alt="image" src="https://github.com/user-attachments/assets/32eeccd0-e7dc-4ddf-ae1c-f8b8a160f08c" />


14. Find whether the change in medication affect readmission

<img width="950" height="257" alt="image" src="https://github.com/user-attachments/assets/a9a556e1-93af-4155-b88c-c5ae35d668ee" />


<img width="467" height="115" alt="image" src="https://github.com/user-attachments/assets/36a4b075-f18d-49ca-966d-b125b2ffd022" />


15. Find the impact of Discharge disposition on readmission

<img width="942" height="412" alt="image" src="https://github.com/user-attachments/assets/463d9f57-67f7-47f1-b0cf-cd1c67ef8289" />


<img width="702" height="276" alt="image" src="https://github.com/user-attachments/assets/dec9e59c-8d49-4a8a-b7f0-cd4e9d504b42" />


16. Find how the A1C affects the readmission

<img width="955" height="245" alt="image" src="https://github.com/user-attachments/assets/c9220516-e9bb-48b8-8a6c-dc84f70251de" />


<img width="497" height="157" alt="image" src="https://github.com/user-attachments/assets/23e32a32-3d1d-4aef-b7ae-762342100d40" />



# Key Findings

1. Circulatory and diabetes-related diagnoses recorded the highest readmission rates across diagnosis categories, with both exceeding the overall average.

2. Patients with a higher number of prior inpatient visits during the previous year demonstrated a significantly greater likelihood of readmission, indicating that prior healthcare utilization is a strong predictor of readmission risk.

3. Discharge disposition was also associated with readmission outcomes, with patients discharged to certain healthcare facilities showing notably different readmission rates compared with those discharged home.

4. Patterns related to medication changes at discharge and A1C testing during hospitalization provided insights relevant to the original clinical research questions underlying the dataset.
