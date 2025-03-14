{{ config(materialized='table') }}

SELECT
  driver_id,
  team_id,
  circuit_id,
  COALESCE(SUM(race_points), 0) AS total_race_points,
  SUM(CASE WHEN race_result_position = 1 THEN 1 ELSE 0 END) AS total_wins,
  SUM(CASE WHEN race_result_position <= 3 THEN 1 ELSE 0 END) AS total_podiums,
  SUM(CASE WHEN race_time = 'DNF' THEN 1 ELSE 0 END) AS total_dnf,
  COALESCE(CAST(ROUND(AVG(race_points)) AS INTEGER), 0) AS avg_points_per_race
FROM {{ ref('fct_race_results') }}
GROUP BY driver_id, team_id, circuit_id