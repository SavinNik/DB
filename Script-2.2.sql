SELECT track_name, duration 
  FROM track t
 WHERE duration = (SELECT max(duration) FROM track)
ORDER BY duration DESC;

SELECT track_name 
  FROM track t
 WHERE duration >= 350;

SELECT collection_name 
  FROM collection c
 WHERE release_year BETWEEN 2018 AND 2020;

SELECT performer_name 
  FROM performer p
 WHERE performer_name NOT LIKE '% %';

SELECT track_name 
FROM track t 
WHERE track_name LIKE '%my%';
