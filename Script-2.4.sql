SELECT a.album_name 
FROM album a 
JOIN performer_album pa ON a.id = pa.album_id 
JOIN performer p ON p.id = pa.performer_id 
JOIN genre_performer gp ON gp.performer_id = p.id 
JOIN genre g ON g.id = gp.genre_id 
GROUP BY p.performer_name, a.album_name 
HAVING count(gp.genre_id) > 1;

SELECT t.track_name 
FROM track t 
LEFT JOIN track_collection tc ON t.id = tc.track_id 
WHERE tc.track_id IS NULL;

SELECT p.performer_name 
FROM performer p 
JOIN performer_album pa ON p.id = pa.performer_id 
JOIN album a ON a.id = pa.album_id 
JOIN track t ON t.album_id = a.id 
WHERE duration = (SELECT min(duration) FROM track);

SELECT a.album_name, count(t.id) 
FROM album a 
JOIN track t ON a.id = t.album_id 
GROUP BY a.album_name 
HAVING count(t.id) in (
    	SELECT count(t.id) FROM album a
    	JOIN track t ON a.id = t.album_id
        GROUP BY a.album_name
        ORDER BY count(t.id))
LIMIT 2;

