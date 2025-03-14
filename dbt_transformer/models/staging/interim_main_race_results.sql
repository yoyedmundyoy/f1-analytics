SELECT
  race_id,
  driver__driver_id AS driver_id,
  team__team_id AS team_id,
  position,
  points,
  grid AS grid_position,
  time,
  retired AS retired_reason
FROM {{ source('raw', 'race_results') }}
