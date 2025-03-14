{{ config(materialized='table') }}

SELECT
  driver_id,
  team_id,
  races.year AS season,
  races.year_date AS season_date,
  COALESCE(SUM(race_points), 0) AS total_race_points,
  SUM(CASE WHEN race_result_position = 1 THEN 1 ELSE 0 END) AS total_wins,
  SUM(CASE WHEN race_result_position <= 3 THEN 1 ELSE 0 END) AS total_podiums,
  SUM(CASE WHEN race_time = 'DNF' THEN 1 ELSE 0 END) AS total_dnf,
  COALESCE(CAST(ROUND(AVG(race_result_position)) AS INTEGER), 0) AS avg_finish_position,
  COALESCE(CAST(ROUND(AVG(race_points)) AS INTEGER), 0) AS avg_points_per_race
FROM {{ ref('fct_race_results' )}} res
  LEFT JOIN {{ ref('dim_races' )}} races
    ON res.race_id = races.race_id
GROUP BY driver_id, team_id, races.year, races.year_date