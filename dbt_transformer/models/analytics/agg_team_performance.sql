{{ config(materialized='table') }}

WITH team_performance AS (
  SELECT
    races.championship_id,
    team_id,
    races.year AS season,
    COALESCE(SUM(race_points), 0) AS total_race_points,
    SUM(CASE WHEN race_result_position = 1 THEN 1 ELSE 0 END) AS total_wins,
    SUM(CASE WHEN race_result_position <= 3 THEN 1 ELSE 0 END) AS total_podiums,
    SUM(CASE WHEN race_time = 'DNF' THEN 1 ELSE 0 END) AS total_dnf,
    COALESCE(CAST(ROUND(AVG(race_points)) AS INTEGER), 0) AS avg_points_per_race
  FROM {{ ref('fct_race_results') }} res
    LEFT JOIN {{ ref('dim_races') }} races
      ON res.race_id = races.race_id
  GROUP BY championship_id, team_id, races.year
),

final AS (
    SELECT
    t.team_id,
    t.season,
    s.position AS constructor_standing,
    t.total_race_points,
    t.total_wins,
    t.total_podiums,
    t.total_dnf,
    t.avg_points_per_race
    FROM team_performance t
    JOIN {{ source('raw', 'constructors_standings') }} s
    ON t.championship_id = s.championship_id AND t.team_id = s.team_id
)

SELECT * FROM final

