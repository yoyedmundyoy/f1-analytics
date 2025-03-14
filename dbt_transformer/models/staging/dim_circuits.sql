SELECT
  circuit_id,
  circuit_name,
  country AS circuit_country,
  city AS circuit_city,
  circuit_length,
  number_of_corners AS circuit_turns,
  lap_record AS fastest_lap_time,
  fastest_lap_driver_id,
  fastest_lap_team_id,
  fastest_lap_year
FROM {{ source('raw', 'circuits')}}