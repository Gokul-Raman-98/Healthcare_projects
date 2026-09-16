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
