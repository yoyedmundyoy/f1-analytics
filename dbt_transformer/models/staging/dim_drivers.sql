SELECT
  driver_id,
  name AS first_name,
  surname AS last_name,
  name || ' ' || surname AS full_name,
  nationality,
  birthday AS date_of_birth,
  number AS driver_number,
  CASE WHEN number IS NOT NULL THEN 1 ELSE 0 END AS active_flag
FROM {{ source('raw', 'drivers') }}