Ejercicio 6

SELECT calls_ivr_id
     , MAX(customer_phone) AS customer_phone
  FROM keepcoding.ivr_detail
 GROUP BY calls_ivr_id