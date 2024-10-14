Ejercicio 11

  SELECT C.calls_ivr_id
       , MAX(IF(DATE_DIFF(C.calls_start_date, RC.calls_start_date, MINUTE) BETWEEN 1 AND 24*60, 1, 0)) AS repeated_phone_24H
       , MAX(IF(DATE_DIFF(C.calls_start_date, RC.calls_start_date, MINUTE) BETWEEN -24*60  AND -1, 1, 0)) AS cause_recall_phone_24H 
    FROM keepcoding.ivr_detail C
  LEFT 
    JOIN keepcoding.ivr_detail RC
      ON C.calls_ivr_id <> RC.calls_ivr_id
     AND C.calls_phone_number = RC.calls_phone_number
    AND C.calls_phone_number <> 'UNKNOWN'
   GROUP BY C.calls_ivr_id