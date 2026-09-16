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


7. Find the Total patient visits with respect to the radmission column and find the respective pct of total values

<img width="700" height="347" alt="image" src="https://github.com/user-attachments/assets/9c9cfb22-ddc3-4a41-a849-05fecb15034d" />


<img width="415" height="126" alt="image" src="https://github.com/user-attachments/assets/e955a8dc-960c-4c20-83ae-d9172bc075ab" />


8. 
