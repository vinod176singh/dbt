create or replace table bronze.patient_visits (
    patient_id varchar,
    dosage float,
    visit_date date
);


insert into bronze.patient_visits values
('P001', 5.0, '2024-10-01'),
('P001', 3.5, '2024-10-10'),
('P002', 7.0, '2024-11-02');
