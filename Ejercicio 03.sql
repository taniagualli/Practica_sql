Ejercicio 3

CREATE OR REPLACE TABLE keepcoding.ivr_detail AS
SELECT calls.ivr_id  as calls_ivr_id
      , IFNULL(calls.phone_number, 'DESCONOCIDO') AS calls_phone_number
      , IFNULL (calls.ivr_result, 'DESCONOCIDO') AS calls_ivr_result 
      , IFNULL (calls.vdn_label, 'DESCONOCIDO') AS calls_vdn_label
      , IFNULL(DATETIME(TIMESTAMP(calls.start_date), 'Europe/Madrid'), '9999-12-31') AS calls_start_date
      , FORMAT_TIMESTAMP('%Y%m%d', calls.start_date) AS start_date_id  
      , IFNULL(DATETIME(TIMESTAMP(calls.end_date), 'Europe/Madrid'), '9999-12-31') AS calls_end_date
      , FORMAT_TIMESTAMP('%Y%m%d', calls.end_date) AS end_date_id
      , calls.total_duration AS calls_total_duration 
      , IFNULL (calls.customer_segment, 'DESCONOCIDO') AS calls_customer_segment 
      , IFNULL (calls.ivr_language, 'DESCONOCIDO') AS calls_ivr_language
      , calls.steps_module AS calls_steps_module 
      , IFNULL (calls.module_aggregation, 'DESCONOCIDO')  AS calls_module_aggregation 
      , modules.module_sequece AS module_sequece 
      , IFNULL (modules.module_name, 'DESCONOCIDO')  AS module_name 
      , modules.module_duration AS module_duration 
      , IFNULL (modules.module_result, 'DESCONOCIDO')  AS module_result 
      , steps.step_sequence AS step_sequence 
      , IFNULL (steps.step_name, 'DESCONOCIDO') AS step_name 
      , IFNULL (steps.step_result, 'DESCONOCIDO') AS step_result 
      , IFNULL (steps.step_description_error, 'DESCONOCIDO') AS step_description_error 
      , IFNULL (steps.document_type, 'DESCONOCIDO') AS document_type 
      , IFNULL (steps.document_identification, 'DESCONOCIDO') AS document_identification 
      , IFNULL (steps.customer_phone, 'DESCONOCIDO') AS customer_phone 
      , IFNULL (steps.billing_account_id, 'DESCONOCIDO') AS billing_account_id
FROM keepcoding.ivr_calls calls
LEFT
JOIN keepcoding.ivr_modules modules
  ON calls.ivr_id = modules.ivr_id
LEFT
JOIN keepcoding.ivr_steps steps
  ON (modules.ivr_id  = steps.ivr_id) AND
      (modules.module_sequece = steps.module_sequece)