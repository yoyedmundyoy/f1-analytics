SELECT
  q.race_id,
  q.driver_id,
  q.team_id,
  q.sq1,
  q.sq2,
  q.sq3,
  q.grid_position,
  r.position,
  r.points
FROM {{ source('raw', 'sprint_qualy_results') }} q
  LEFT JOIN {{ source('raw', 'sprint_race_results')}} r
    ON q.race_id = r.race_id AND q.driver_id = r.driver_id
    