SELECT g.genre_name, count(gp.performer_id) 
FROM genre g
JOIN genre_performer gp ON g.id = gp.genre_id 
GROUP BY g.genre_name;

SELECT a.album_name, count(t.track_name) 
FROM album a
JOIN track t ON a.id = t.album_id 
WHERE a.release_year BETWEEN 2019 AND 20200
GROUP BY a.album_name 

SELECT a.album_name, avg(t.duration) 
FROM album a 
JOIN track t ON a.id = t.album_id 
GROUP BY a.album_name 

SELECT DISTINCT p.performer_name 
FROM performer p 
WHERE p.performer_name NOT IN (
SELECT DISTINCT p.performer_name 
FROM performer p
LEFT JOIN performer_album pa ON p.id = pa.performer_id
LEFT JOIN album a ON a.id = pa.album_id
WHERE a.release_year = 2020
)
ORDER BY p.performer_name;

SELECT c.collection_name 
FROM collection c 
JOIN track_collection tc ON c.id  = tc.collection_id 
JOIN track t ON t.id = tc.track_id
JOIN album a ON a.id = t.album_id 
JOIN performer_album pa ON a.id = pa.album_id 
JOIN performer p ON p.id = pa.performer_id 
WHERE p.performer_name LIKE '%Eminem%';
