Ejercicio 13.

CREATE OR REPLACE FUNCTION keepcoding.fnc_clean_number(number FLOAT64) RETURNS INT64 AS
(IFNULL(CAST(number AS INT64), -999999))