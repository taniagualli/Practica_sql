Ejercicio 4

SELECT calls_ivr_id
, CASE WHEN SUBSTRING(calls_vdn_label, 1, 3) = 'ATC' THEN 'FRONT'
            WHEN SUBSTRING(calls_vdn_label, 1, 4) = 'TECH' THEN 'TECH'
            WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
            ELSE 'RESTO'
END AS vdn_aggregation
FROM `keepcoding.ivr_detail`