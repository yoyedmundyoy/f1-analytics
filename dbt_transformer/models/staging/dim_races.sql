SELECT
  s.year,
  DATE(s.year, 1, 1) AS year_date,
  race_id,
  r.championship_id,
  race_name,
  s.championship_name
  laps,
  round,
  circuit__circuit_id AS circuit_id,
  PARSE_TIMESTAMP("%Y-%m-%d %H:%M:%SZ", CAST(schedule__race__date AS STRING) || ' ' || CAST(schedule__race__time AS STRING)) AS scheduled_race_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__fp1__date AS STRING) || ' ' || CAST(schedule__fp1__time AS STRING)
  ) AS scheduled_fp1_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__fp2__date AS STRING) || ' ' || CAST(schedule__fp2__time AS STRING)
  ) AS scheduled_fp2_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__fp3__date AS STRING) || ' ' || CAST(schedule__fp3__time AS STRING)
  ) AS scheduled_fp3_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__qualy__date AS STRING) || ' ' || CAST(schedule__qualy__time AS STRING)
  ) AS scheduled_qualifying_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__sprint_qualy__date AS STRING) || ' ' || CAST(schedule__sprint_qualy__time AS STRING)
  ) AS scheduled_sprint_qualifying_time,
  PARSE_TIMESTAMP(
    "%Y-%m-%d %H:%M:%SZ", 
    CAST(schedule__sprint_race__date AS STRING) || ' ' || CAST(schedule__sprint_race__time AS STRING)
  ) AS scheduled_sprint_time
FROM {{ source('raw', 'races')}} r
 LEFT JOIN {{ source('raw', 'seasons')}} s
    ON r.championship_id = s.championship_id
    