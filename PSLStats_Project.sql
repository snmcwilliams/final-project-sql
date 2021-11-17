-- CREATE DATABASE PSLStats;
-- GO

USE PSLStats
GO


DROP TABLE IF EXISTS League;

CREATE TABLE League
(
LeagueID int identity primary key,
FullLeagueName varchar(255),
ShortLeagueName varchar(255),
LeagueType varchar(255)
);

INSERT INTO League (FullLeagueName, ShortLeagueName, LeagueType)
VALUES
('USL Championship League','USL','Mens'),
('National Womens Soccer League', 'NWSL','Womens');
-- Select * From League;


DROP TABLE IF EXISTS Team;

CREATE TABLE Team
(
TeamID int identity primary key,
LeagueID int,
foreign key (LeagueID) references League(LeagueID),
TeamName varchar(255)
);

CREATE NONCLUSTERED INDEX idx_team_name
ON Team (TeamName DESC);

INSERT INTO Team (LeagueID, TeamName)
VALUES
(1, 'Louisville City FC'),
(1, 'Atlanta United 2'),
(1, 'FC Tulsa'),
(1, 'Sporting KC II'),
(2, 'Racing Louisville FC'),
(2, 'Gotham FC'),
(2, 'Orlando Pride'),
(2, 'Houston Dash');
-- Select * From Team;


DROP TABLE IF EXISTS Game;

CREATE TABLE Game
(
GameID int identity primary key,
HomeTeamID int,
foreign key (HomeTeamID) references Team(TeamID),
AwayTeamID int,
foreign key (AwayTeamID) references Team(TeamID),
HomeTeamScore int,
AwayTeamScore int,
GameDate datetime
);

INSERT INTO Game (HomeTeamID, AwayTeamID, HomeTeamScore, AwayTeamScore, GameDate)
VALUES
(1, 4, 3, 1, '08/08/2021 19:00:00'),
(2, 1, 1, 1, '08/18/2021 19:30:00'),
(1, 3, 2, 1, '09/02/2021 19:00:00'),
(1, 2, 3, 2, '09/14/2021 19:30:00'),
(4, 1, 2, 1, '09/25/2021 15:00:00'),
(7, 5, 0, 0, '10/03/2021 12:00:00'),
(8, 5, 1, 3, '10/13/2021 18:30:00'),
(5, 7, 2, 2, '10/23/2021 15:00:00'),
(6, 5, 2, 1, '11/03/2021 19:00:00'),
(5, 6, 0, 2, '11/11/2021 19:30:00');
 --Select * From Game;
 GO
