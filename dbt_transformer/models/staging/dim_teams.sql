SELECT
  team_id,
  team_name,
  team_nationality
FROM {{ source('raw', 'teams')}}