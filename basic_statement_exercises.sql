SHOW DATABASES;

# 1. Use the albums_db database.
USE albums_db;
SELECT database();

# 2. What is the primary key for the albums table?
DESCRIBE albums; -- Primary key is ID

# 3. What does the column named 'name' represent?
SELECT name 
FROM albums;
-- colum "name" is a varchar column that contains names of events 240 charactures long

# 4. What do you think the sales column represents?
SELECT sales
FROM albums;
-- column "sales" contains sale prices in float datatype

# 5. Find the name of all albums by Pink Floyd.
SELECT name
FROM albums
WHERE artist = "Pink Floyd";

# 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

# 7. What is the genre for the album Nevermind?
SELECT genre
FROM albums
WHERE name = "Nevermind";

# 8. Which albums were released in the 1990s?
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 AND 2000;

# 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums
FROM albums
WHERE sales <= 20;

