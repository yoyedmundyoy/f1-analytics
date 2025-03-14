SELECT
  race_id,
  driver_id,
  team_id,
  q1,
  q2,
  q3,
  grid_position
FROM {{ source('raw', 'qualy_results')}}
