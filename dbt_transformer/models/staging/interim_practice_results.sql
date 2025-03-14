WITH fp1 AS (
  SELECT
    race_id,
    driver_id,
    team_id,
    time AS best_lap
  FROM {{ source('raw', 'fp1_results')}}
),

fp2 AS (
  SELECT
    race_id,
    driver_id,
    team_id,
    time AS best_lap
  FROM {{ source('raw', 'fp2_results')}}
),

fp3 AS (
  SELECT
    race_id,
    driver_id,
    team_id,
    time AS best_lap
  FROM {{ source('raw', 'fp3_results')}}
),

fp1_fp2_joined AS (
  SELECT
    COALESCE(fp1.race_id, fp2.race_id) AS race_id,
    COALESCE(fp1.driver_id, fp2.driver_id) AS driver_id,
    COALESCE(fp1.team_id, fp2.team_id) AS team_id,
    fp1.best_lap AS fp1_best_lap,
    fp2.best_lap AS fp2_best_lap,
  FROM fp1 
  FULL OUTER JOIN fp2
  ON fp1.race_id = fp2.race_id AND fp1.driver_id = fp2.driver_id
),

final AS (
  SELECT
    COALESCE(j.race_id, fp3.race_id) AS race_id,
    COALESCE(j.driver_id, fp3.driver_id) AS driver_id,
    COALESCE(j.team_id, fp3.team_id) AS team_id,
    fp1_best_lap,
    fp2_best_lap,
    fp3.best_lap AS fp3_best_lap
  FROM fp1_fp2_joined j
  FULL OUTER JOIN fp3
  ON j.race_id = fp3.race_id AND j.driver_id = fp3.driver_id
)

SELECT * FROM final ORDER BY 1, 2