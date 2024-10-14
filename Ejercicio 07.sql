Ejercicio 7

SELECT calls_ivr_id
     , MAX(billing_account_id) AS billing_account_id
  FROM keepcoding.ivr_detail
 GROUP BY calls_ivr_id