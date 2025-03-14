WITH race_results AS (
  SELECT
    COALESCE(m.race_id, q.race_id, s.race_id, p.race_id) AS race_id,
    COALESCE(m.driver_id, q.driver_id, s.driver_id, p.driver_id) AS driver_id,
    COALESCE(m.team_id, q.team_id, s.team_id, p.team_id) AS team_id,
    m.position AS race_result_position,
    m.points AS race_points,
    m.grid_position AS race_starting_grid_position,
    m.time AS race_time,
    m.retired_reason AS race_retired_reason,
    q.q1 AS race_q1,
    q.q2 AS race_q2,
    q.q3 AS race_q3,
    q.grid_position AS qualy_result_grid_position,
    s.sq1 AS sprint_q1,
    s.sq2 AS sprint_q2,
    s.sq3 AS sprint_q3,
    s.position AS sprint_result_position,
    s.grid_position AS sprint_starting_grid_position,
    s.points AS sprint_points,
    p.fp1_best_lap,
    p.fp2_best_lap,
    p.fp3_best_lap
  FROM {{ ref('interim_main_race_results')}} m
    FULL OUTER JOIN {{ ref('interim_qualy_results')}} q
      ON m.race_id = q.race_id AND m.driver_id = q.driver_id
    FULL OUTER JOIN {{ ref('interim_sprint_results')}} s
      ON m.race_id = s.race_id AND m.driver_id = s.driver_id
    FULL OUTER JOIN {{ ref('interim_practice_results')}} p
      ON m.race_id = p.race_id AND m.driver_id = p.driver_id
),

final AS (
  SELECT 
    res.*,
    race.year AS season,
    race.circuit_id
  FROM race_results res
  JOIN {{ ref('dim_races') }} race
    ON res.race_id = race.race_id
)

SELECT * FROM final