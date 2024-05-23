-- Create Movies table
CREATE TABLE datacoach.Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255),
    ReleaseYear INT,
    DirectorID INT,
    Genre VARCHAR(255),
    PlotSummary TEXT,
    IMDbRating DECIMAL(3, 1)
);

-- Populate Movies table
INSERT INTO  datacoach.Movies (MovieID, Title, ReleaseYear, DirectorID, Genre, PlotSummary, IMDbRating)
VALUES
    (1, 'The Shawshank Redemption', 1994, 1, 'Drama', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 9.3),
    (2, 'The Godfather', 1972, 2, 'Crime, Drama', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 9.2),
    (3, 'The Dark Knight', 2008, 3, 'Action, Crime, Drama', 'When the menace known as The Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 9.0),
    (4, 'Pulp Fiction', 1994, 4, 'Crime, Drama', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 8.9),
    (5, 'Forrest Gump', 1994, 5, 'Drama, Romance', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', 8.8),
    (6, 'Inception', 2010, 6, 'Action, Adventure, Sci-Fi', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 8.8);

-- Create Awards table
CREATE TABLE  datacoach.Awards (
    AwardID INT PRIMARY KEY,
    AwardName VARCHAR(255),
    Category VARCHAR(255),
    Description TEXT,
    Year INT
);

-- Populate Awards table
INSERT INTO  datacoach.Awards (AwardID, AwardName, Category, Description, Year)
VALUES
    (1, 'Academy Awards', 'Best Picture', 'Awarded for excellence in cinematic achievement.', 2023),
    (2, 'Golden Globe Awards', 'Best Director', 'Awarded for the best directing of a film.', 2023),
    (3, 'BAFTA Awards', 'Best Actor', 'Awarded for the best performance by an actor in a leading role.', 2023);

-- Create Nominations table
CREATE TABLE  datacoach.Nominations (
    NominationID INT PRIMARY KEY,
    MovieID INT,
    AwardID INT,
    NomineeName VARCHAR(255),
    Role VARCHAR(255),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (AwardID) REFERENCES Awards(AwardID)
);

-- Populate Nominations table
INSERT INTO  datacoach.Nominations (NominationID, MovieID, AwardID, NomineeName, Role)
VALUES
    (1, 1, 1, 'The Shawshank Redemption', 'Movie'),
    (2, 2, 1, 'The Godfather', 'Movie'),
    (3, 3, 1, 'The Dark Knight', 'Movie'),
    (4, 1, 2, 'Frank Darabont', 'Director'),
    (5, 2, 2, 'Francis Ford Coppola', 'Director'),
    (6, 3, 2, 'Christopher Nolan', 'Director'),
    (7, 1, 3, 'Tim Robbins', 'Actor'),
    (8, 2, 3, 'Marlon Brando', 'Actor'),
    (9, 3, 3, 'Christian Bale', 'Actor'),
    (10, 4, 1, 'Pulp Fiction', 'Movie'),
    (11, 5, 1, 'Forrest Gump', 'Movie'),
    (12, 6, 1, 'Inception', 'Movie'),
    (13, 4, 2, 'Quentin Tarantino', 'Director'),
    (14, 5, 2, 'Robert Zemeckis', 'Director'),
    (15, 6, 2, 'Christopher Nolan', 'Director'),
    (16, 4, 3, 'John Travolta', 'Actor'),
    (17, 5, 3, 'Tom Hanks', 'Actor'),
    (18, 6, 3, 'Leonardo DiCaprio', 'Actor');

-- Create Winners table
CREATE TABLE  datacoach.Winners (
    WinnerID INT PRIMARY KEY,
    AwardID INT,
    NominationID INT,
    FOREIGN KEY (AwardID) REFERENCES Awards(AwardID),
    FOREIGN KEY (NominationID) REFERENCES Nominations(NominationID)
);

-- Populate Winners table
INSERT INTO  datacoach.Winners (WinnerID, AwardID, NominationID)
VALUES
    (1, 1, 1),  
    (2, 2, 13),  
    (3, 3, 9);  
   
    commit;
-- --------------------------------------------------------------------------------
-- Easy:
-- List all the movies released in 1994.
SELECT
    a.MovieID, a.Title, a.ReleaseYear
FROM
    datacoach.movies A
WHERE
    a.ReleaseYear = 1994;

-- Find the average IMDb rating of all the movies in the dataset.
SELECT
    ROUND(AVG(IMDbRating)) AS AvgRating
FROM
    datacoach.movies;
   
-- **Retrieve the names of all the directors and their respective movies.
SELECT
    M.DirectorID, N.NomineeName AS DirectorName, M.Title
FROM
    datacoach.nominations N
        JOIN
    datacoach.movies M ON N.MovieID = M.MovieID
WHERE
    N.Role = 'Director';
   
-- Medium:
-- Find the total number of nominations each movie has received.

SELECT
    M.MovieID,
    M.Title,
    COUNT(N.NominationID) AS NumberofNomaniations
FROM
    datacoach.nominations N
        JOIN
    datacoach.movies M ON N.MovieID = M.MovieID
GROUP BY M.MovieID , M.Title;

-- List the names of all the actors/actresses who won awards.
SELECT
    N.NomineeName AS ActorsName
FROM
    datacoach.nominations N
        JOIN
    datacoach.winners W ON N.AwardID = W.AwardID
WHERE
    N.Role = 'Actor';
   
-- **Find the total number of nominations each director has received.
SELECT
    N.NomineeName AS DirectorName,
    COUNT(N.NominationID) AS TotalNominations
FROM
    datacoach.nominations N
WHERE
    N.Role = 'Director'
GROUP BY N.NomineeName
ORDER BY TotalNominations DESC;
-- ------------------------------------------------------------------------------------------
-- Hard:
-- List the movies that won awards for which they were nominated for.
SELECT
    M.Title, A.AwardName, A.Category
FROM
    datacoach.movies M
        JOIN
    datacoach.nominations N ON M.MovieID = N.MovieID
        JOIN
    datacoach.winners W ON N.NominationID = W.NominationID
        JOIN
    datacoach.awards a ON W.AwardID = A.AwardID;

-- Find the movie with the highest number of nominations.
SELECT
    M.Title, COUNT(N.NominationID) AS TotalNomination
FROM
    datacoach.movies M
        JOIN
    datacoach.nominations N ON M.MovieID = N.MovieID
GROUP BY M.Title
ORDER BY TotalNomination DESC
LIMIT 1;

-- Retrieve the names of the movies and their respective directors who won awards.
SELECT
    M.Title,N.NomineeName, A.AwardName, A.Category
FROM
    datacoach.movies M
        JOIN
    datacoach.nominations N ON M.MovieID = N.MovieID
        JOIN
    datacoach.winners W ON N.NominationID = W.NominationID
        JOIN
    datacoach.awards a ON W.AwardID = A.AwardID
    WHERE N.Role='Director';

-- Identify the director who has won the most awards.
SELECT 
    N.NomineeName AS DirectorName, 
    COUNT(W.WinnerID) AS AwardsWon
FROM datacoach.Winners W
JOIN datacoach.Nominations N ON W.NominationID = N.NominationID
JOIN datacoach.Awards A ON W.AwardID = A.AwardID
WHERE N.Role = 'Director'
GROUP BY N.NomineeName
ORDER BY AwardsWon DESC LIMIT 1;
-- -----------------------------------------------------------------------------------
-- Bonus Round
-- List the movies along with the total number of nominations they received, sorted in descending order of nominations count.
SELECT 
    M.Title AS MovieTitle, 
    COUNT(N.NominationID) AS TotalNominations
FROM 
    datacoach.Movies M
JOIN 
    datacoach.Nominations N ON M.MovieID = N.MovieID
GROUP BY 
    M.Title
ORDER BY 
    TotalNominations DESC;
    
-- Retrieve the top 3 movies with the highest average IMDb rating.
SELECT 
    Title, 
    IMDbRating
FROM 
    datacoach.Movies
ORDER BY 
    IMDbRating DESC
LIMIT 3;


-- Find the percentage of nominations each movie received compared to the total number of nominations across all movies.
SELECT  m.Title, 
    COUNT(n.NominationID) AS NominationCount,
    ROUND(COUNT(n.NominationID) / total_nominations.Total * 100, 2) AS Percentage
FROM  datacoach.Movies m
JOIN  datacoach.Nominations n ON m.MovieID = n.MovieID
JOIN  (SELECT COUNT(*) AS Total FROM datacoach.Nominations) total_nominations
GROUP BY m.Title, total_nominations.Total
ORDER BY Percentage DESC;

-- List the movies along with the count of awards they won, but only include movies that won more than one award.
SELECT 
    m.Title,
    COUNT(w.WinnerID) AS AwardCount
FROM 
    datacoach.Movies m
JOIN  datacoach.Nominations n ON m.MovieID = n.MovieID
LEFT JOIN  datacoach.Winners w ON n.NominationID = w.NominationID
GROUP BY  m.Title
HAVING COUNT(w.WinnerID) > 1;

-- For each award category, find the movie with the highest IMDb rating that was nominated for that category.
SELECT a.Category, m.Title AS Movie, m.IMDbRating AS Rating
FROM datacoach.Awards a
JOIN datacoach.Nominations n ON a.AwardID = n.AwardID
JOIN datacoach.Movies m ON n.MovieID = m.MovieID
JOIN (SELECT a.Category,MAX(m.IMDbRating) AS MaxRating
    FROM datacoach.Awards a
    JOIN datacoach.Nominations n ON a.AwardID = n.AwardID
    JOIN datacoach.Movies m ON n.MovieID = m.MovieID
    GROUP BY a.Category) max_rating_per_category 
    ON a.Category = max_rating_per_category.Category 
    AND m.IMDbRating = max_rating_per_category.MaxRating;

