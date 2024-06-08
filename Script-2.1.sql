INSERT INTO genre(genre_name)
     VALUES ('Rap'), ('Pop'), ('Rok-n-roll');

INSERT INTO performer(performer_name)
     VALUES ('Eminem'), ('Lady Gaga'), ('Elvis Presley'), ('Michael Jackson');
     
INSERT INTO genre_performer(genre_id, performer_id)
     VALUES (1, 1), (2, 2), (3, 3), (2, 4);

INSERT INTO album(album_name, release_year)
     VALUES ('Love Me Tender', 1956), ('Artpop', 2013), ('Encore', 2004),
            ('Xscape', 2014), ('Bad', 1987);
            
INSERT INTO performer_album(performer_id, album_id)
     VALUES (1, 3), (2, 2), (3, 1), (4, 4), (4, 5);
     
INSERT INTO track(track_name, duration, album_id)
     VALUES ('Let Me', 211, 1), ('Aura', 356, 2), ('Venus', 353, 2), ('Mosh', 517, 3),
            ('Chicago', 405, 4), ('Speed Demon', 401, 5);
            
INSERT INTO collection(collection_name, release_year)
     VALUES ('Collection1', 2001), ('Collection2', 2010),
            ('Collection3', 2011), ('Collection4', 2019);
            
INSERT INTO track_collection(track_id, collection_id)
     VALUES (1, 1), (1, 2), (2, 4), (3, 4), (4, 2), 
            (4, 3), (5, 4), (6, 1), (6, 2);