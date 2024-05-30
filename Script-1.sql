CREATE TABLE IF NOT EXISTS genre (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS performer (
	id SERIAL PRIMARY KEY,
	performer_name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS genre_performer (
	genre_id INTEGER REFERENCES genre(id),
	performer_id INTEGER REFERENCES performer(id),
	CONSTRAINT genre_performer_pk PRIMARY KEY(genre_id, performer_id)
);
CREATE TABLE IF NOT EXISTS album (
	id SERIAL PRIMARY KEY,
	album_name VARCHAR(100) NOT NULL,
	release_year INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS performer_album (
	performer_id INTEGER REFERENCES performer(id),
	album_id INTEGER REFERENCES album(id),
	CONSTRAINT performer_album_pk PRIMARY KEY(performer_id, album_id)
);
CREATE TABLE IF NOT EXISTS track (
	id SERIAL PRIMARY KEY,
	track_name VARCHAR(100) NOT NULL UNIQUE,
	duration INTEGER NOT NULL,
	album_id INTEGER REFERENCES album(id)
);
CREATE TABLE IF NOT EXISTS collection (
	id SERIAL PRIMARY KEY,
	collection_name VARCHAR(100) NOT NULL UNIQUE,
	release_year INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS track_collection (
	track_id INTEGER REFERENCES track(id),
	collection_id INTEGER REFERENCES collection(id),
	CONSTRAINT track_collection_pk PRIMARY KEY(track_id, collection_id)
);