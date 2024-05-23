/*
DataCoach SQL Case Study 
Esports Tournament (CHALLENGE 2)
Link: https://mattsteel87.wixsite.com/datacoach/steve-s-car-showroom-copy

Problem Statement: 
The top eSports competitors from across the globe have gathered to battle it out.
My job is to analyse the following data to find out all about the tournament.

TABLES
Here are the tables you will be using: 
*/
CREATE TABLE datacoach.Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    captain_id INT
);
-- --------------------------------------------------------------------------------------------------------------------
INSERT INTO datacoach.Teams (team_id, team_name, country, captain_id)
VALUES (1, 'Cloud9', 'USA', 1),
(2, 'Fnatic', 'Sweden', 2),
(3, 'SK Telecom T1', 'South Korea', 3),
(4, 'Team Liquid', 'USA', 4),
(5, 'G2 Esports', 'Spain', 5);
-- --------------------------------------------------------------------------------------------------------------------
CREATE TABLE datacoach.Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    role VARCHAR(50),
    salary INT,
    FOREIGN KEY (team_id)
        REFERENCES Teams (team_id)
);
-- --------------------------------------------------------------------------------------------------------------------
INSERT INTO datacoach.Players (player_id, player_name, team_id, role, salary)
VALUES (1, 'Shroud', 1, 'Rifler', 100000),
(2, 'JW', 2, 'AWP', 90000),
(3, 'Faker', 3, 'Mid laner', 120000),
(4, 'Stewie2k', 4, 'Rifler', 95000),
(5, 'Perkz', 5, 'Mid laner', 110000),
(6, 'Castle09', 1, 'AWP', 120000),
(7, 'Pike', 2, 'Mid Laner', 70000),
(8, 'Daron', 3, 'Rifler', 125000),
(9, 'Felix', 4, 'Mid Laner', 95000),
(10, 'Stadz', 5, 'Rifler', 98000),
(11, 'KL34', 1, 'Mid Laner', 83000),
(12, 'ForceZ', 2, 'Rifler', 130000),
(13, 'Joker', 3, 'AWP', 128000),
(14, 'Hari', 4, 'AWP', 90000),
(15, 'Wringer', 5, 'Mid laner', 105000);
COMMIT;
-- --------------------------------------------------------------------------------------------------------------------
CREATE TABLE datacoach.Matches (
    match_id INT PRIMARY KEY,
    team1_id INT,
    team2_id INT,
    match_date DATE,
    winner_id INT,
    score_team1 INT,
    score_team2 INT,
    FOREIGN KEY (team1_id)
        REFERENCES Teams (team_id),
    FOREIGN KEY (team2_id)
        REFERENCES Teams (team_id),
    FOREIGN KEY (winner_id)
        REFERENCES Teams (team_id)
);
-- --------------------------------------------------------------------------------------------------------------------
INSERT INTO datacoach.Matches (match_id, team1_id, team2_id, match_date, winner_id, score_team1, score_team2)
VALUES (1, 1, 2, '2022-01-01', 1, 16, 14),
(2, 3, 5, '2022-02-01', 3, 14, 9),
(3, 4, 1, '2022-03-01', 1, 17, 13),
(4, 2, 5, '2022-04-01', 5, 13, 12),
(5, 3, 4, '2022-05-01', 3, 16, 10),
(6, 1, 3, '2022-02-01', 3, 13, 17),
(7, 2, 4, '2022-03-01', 2, 12, 9),
(8, 5, 1, '2022-04-01', 1, 11, 15),
(9, 2, 3, '2022-05-01', 3, 9, 10),
(10, 4, 5, '2022-01-01', 4, 13, 10);
commit;

-- --------------------------------------------------------------------------------------------------------------------
SELECT  * FROM datacoach.TEAMS;
SELECT * FROM datacoach.players;
SELECT  * FROM datacoach.matches;
-- --------------------------------------------------------------------------------------------------------------------
-- 1. What are the names of the players whose salary is greater than 100,000?
SELECT 
    p.player_id, p.player_name, p.salary
FROM
    datacoach.players p
WHERE
    P.salary > 100000;

-- 2. What is the team name of the player with player_id = 3?
SELECT 
    p.player_id, p.player_name, t.team_name
FROM
    datacoach.players p
        JOIN
    datacoach.teams t ON p.team_id = t.team_id
WHERE
    p.player_id = 3;

-- 3. What is the total number of players in each team?
SELECT 
    p.team_id, t.team_name, COUNT(*) AS NumberPlayer
FROM
    datacoach.players p
        JOIN
    datacoach.teams t ON p.team_id = t.team_id
GROUP BY p.team_id;

-- 4. What is the team name and captain name of the team with team_id = 2?
SELECT 
    t.team_name, p.player_name AS Captain_Name
FROM
    datacoach.players p
        JOIN
    datacoach.teams t ON p.team_id = t.team_id
WHERE
    p.team_id = 2
        AND t.captain_id = p.player_id;

-- 5. What are the player names and their roles in the team with team_id = 1?
SELECT 
    P.player_id, P.player_name, P.role
FROM
    datacoach.players P
WHERE
    P.team_id = 1;

-- 6. What are the team names and the number of matches they have won?
SELECT 
    t.team_id, t.team_name, COUNT(M.winner_id) AS NumberWonMatch
FROM
    datacoach.teams T
        JOIN
    datacoach.matches M ON T.team_id = M.winner_id
GROUP BY t.team_id , t.team_name
ORDER BY NumberWonMatch DESC;

-- 7. What is the average salary of players in the teams with country 'USA'?
SELECT 
    t.team_name, ROUND(AVG(P.salary)) AS Average_Salary
FROM
    datacoach.players P
        JOIN
    datacoach.teams T ON P.team_id = T.team_id
WHERE
    T.country = 'USA'
GROUP BY t.team_name;

-- 8. Which team won the most matches?
SELECT 
    T.team_name, COUNT(M.winner_id) AS NumberWonMatch
FROM
    datacoach.teams T
        JOIN
    datacoach.matches M ON T.team_id = M.winner_id
GROUP BY T.team_name
ORDER BY NumberWonMatch DESC
LIMIT 1;

-- 9. What are the team names and the number of players in each team whose salary is greater than 100,000?
SELECT 
    t.team_name, COUNT(*) AS Number_of_Players
FROM
    datacoach.players P
        JOIN
    datacoach.teams T ON P.team_id = T.team_id
WHERE
    p.salary > 100000
GROUP BY t.team_name;

-- 10. What is the date and the score of the match with match_id = 3?
SELECT 
    M.match_id,
    M.match_date,
    M.score_team1,
    M.score_team2,
    (M.score_team1 + M.score_team2) AS Total_Score
FROM
    datacoach.matches M
WHERE
    M.match_id = 3;
