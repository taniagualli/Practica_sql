Ejercicio 5
1
--Primero verifico si hay datos desconocidos en el document_identification
--SELECT distinct(document_identification)
--          FROM keepcoding.ivr_detail
--          order by document_identification desc

SELECT ivr_id
     , document_identification
     , document_type
  FROM (SELECT CAST(calls_ivr_id AS STRING) AS ivr_id
             , document_identification
             , document_type
             , IF(document_identification <> 'UNKNOWN', 1, 0) valid_document
          FROM keepcoding.ivr_detail
        QUALIFY ROW_NUMBER() OVER(PARTITION BY ivr_id ORDER BY valid_document DESC, module_sequece DESC, step_sequence DESC) = 1)