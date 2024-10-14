Ejercicio 12

CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
WITH documents
  AS
    (SELECT CAST(calls_ivr_id AS STRING) as calls_ivr_id
             , document_identification        
             , document_type
             , IF(document_identification <> 'UNKNOWN', 1, 0) valid_document
          FROM keepcoding.ivr_detail
        QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) 
        ORDER BY valid_document DESC, module_sequece DESC, step_sequence DESC) = 1)

SELECT C.calls_ivr_id
  , C.calls_phone_number 
  , C.calls_ivr_result
  , CASE WHEN SUBSTRING(C.calls_vdn_label, 1, 3) = 'ATC' THEN 'FRONT'
         WHEN SUBSTRING(C.calls_vdn_label, 1, 4) = 'TECH' THEN 'TECH'
         WHEN C.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation
  , C.calls_start_date
  , C.calls_end_date
  , C.calls_total_duration
  , C.calls_customer_segment
  , C.calls_ivr_language
  , C.calls_steps_module
  , C.calls_module_aggregation
  , MAX(C.customer_phone) AS customer_phone
  , MAX(C.billing_account_id) AS billing_account_id
  , MAX(IF(C.module_name = "AVERIA_MASIVA", 1, 0)) AS masiva_lg
  , MAX(IF(C.step_name = "CUSTOMERINFOBYPHONE.TX" AND C.step_result = 'OK', 1, 0)) AS info_by_phone_lg
  , MAX(IF(C.step_name = "CUSTOMERINFOBYDNI.TX" AND C.step_result = 'OK', 1, 0)) AS info_by_dni_lg
  , MAX(IF(DATE_DIFF(C.calls_start_date, RC.calls_start_date, MINUTE) BETWEEN 1 AND 24*60, 1, 0)) AS repeated_phone_24H
  , MAX(IF(DATE_DIFF(C.calls_start_date, RC.calls_start_date, MINUTE) BETWEEN -24*60  AND -1, 1, 0)) AS cause_recall_phone_24H 

FROM keepcoding.ivr_detail C
LEFT 
JOIN documents
  ON CAST(C.calls_ivr_id AS STRING) = documents.calls_ivr_id 
LEFT
JOIN keepcoding.ivr_detail RC
  ON C.calls_ivr_id <> RC.calls_ivr_id
      AND C.calls_phone_number = RC.calls_phone_number
      AND C.calls_phone_number <> 'UNKNOWN'

GROUP BY C.calls_ivr_id
  , C.calls_phone_number 
  , C.calls_ivr_result
  , vdn_aggregation
  , C.calls_start_date
  , C.calls_end_date
  , C.calls_total_duration
  , C.calls_customer_segment
  , C.calls_ivr_language
  , C.calls_steps_module
  , C.calls_module_aggregation
  , C.document_type
  , C.document_identification;
