USE record_company;

----------------
## 2) Select only the Names of all the Bands
SELECT names FROM record_company.bands;
-------------------

## 3) Select the Oldest Album - 1 way
SELECT * FROM record_company.albums WHERE release_year in
(SELECT min(release_year) FROM albums);

##) Select the Oldest Album - 2nd way
SELECT * FROM albums WHERE release_year IS NOT NULL
ORDER BY release_year LIMIT 1;

-------------------
##4) Get all Bands that have Albums - Solution 1
/* This assummes all bands have a unique name */
SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
JOIN albums ON bands.id = albums.band_id;

##) Get all Bands that have Albums - Solution 2
/* If bands do not have a unique name then use this query */
/* 
  SELECT bands.name AS 'Band Name'
  FROM bands
  JOIN albums ON bands.id = albums.band_id
  GROUP BY albums.band_id
  HAVING COUNT(albums.id) > 0;
*/

##) Get all Bands that have Albums - Solution 3
/*Deepak Solution*/
SELECT b.name, count(a.id) 
FROM bands b 
LEFT JOIN albums a ON a.band_id = b.id
GROUP BY b.id HAVING count(a.id) > 0;
-------------------
##5) Get all Bands that have No Albums

/*Deepak Solution*/
SELECT bands.name AS 'Band Name', count(albums.id) FROM bands LEFT JOIN albums ON albums.band_id = bands.id
GROUP BY albums.band_id HAVING count(albums.id) = 0;

/*Posted solution*/
SELECT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;

---------------------------
##6. Get the Longest Album
SELECT
  albums.name as Name,
  albums.release_year as 'Release Year',
  SUM(songs.length) as 'Duration'
FROM albums
JOIN songs on albums.id = songs.album_id
GROUP BY songs.album_id
ORDER BY Duration DESC
LIMIT 1;

--------------------
##7. Update the Release Year of the Album with no Release Year
/* This is the query used to get the id */
/*
  SELECT * FROM albums where release_year IS NULL;
*/
UPDATE albums
SET release_year = 1986
WHERE id = 4;

------
##8. Insert a record for your favorite Band and one of their Albums
INSERT INTO bands (name)
VALUES ('Favorite Band Name');

/* This is the query used to get the band id of the band just added */
/*
  SELECT id FROM bands
  ORDER BY id DESC LIMIT 1;
*/

INSERT INTO albums (name, release_year, band_id)
VALUES ('Favorite Album Name', 2000, 8); 

----
#9. Delete the Band and Album you added in #8

/*
  SELECT id FROM albums
  ORDER BY id DESC LIMIT 1;
*/

DELETE FROM albums
WHERE id = 19;

/* This is the query used to get the band id of the band added in #8 */
/*
  SELECT id FROM bands
  ORDER BY id DESC LIMIT 1;
*/

DELETE FROM bands
WHERE id = 8;

------
##10.Get the Average Length of all Songs
SELECT AVG(length) as 'Average Song Duration'
FROM songs;

------
##11. Select the longest Song off each Album
SELECT albums.name AS 'Album', albums.release_year AS 'Release Year', 
MAX(songs.length) AS 'DURATION', 
songs.album_id FROM songs JOIN albums ON albums.id = songs.album_id
group by songs.album_id;

##11a) Deepak Created question. Find the name of the song with the maximum duration in an album
SELECT * FROM songs songs1 WHERE songs1.length IN (SELECT 
MAX(songs.length) AS 'DURATION' 
FROM songs JOIN albums ON albums.id = songs.album_id
group by songs.album_id);


SELECT songs.id, 
MAX(songs.length) AS 'DURATION', 
songs.album_id FROM songs JOIN albums ON albums.id = songs.album_id
group by songs.album_id;

#12) Get the number of Songs for each Band

/*Deepak SOlution*/
SELECT  bands.name AS name, count(songs.id)
FROM 
bands JOIN albums ON albums.band_id = bands.id
JOIN songs ON songs.album_id = albums.id
group by bands.id;

/*posted solution*/
SELECT
  bands.name AS 'Band',
  COUNT(songs.id) AS 'Number of Songs'
FROM bands
JOIN albums ON bands.id = albums.band_id
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.band_id;

