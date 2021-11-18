-- CREATE DATABASE PSLStats;

USE PSLStats;

/***********
 DROP
************/

DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS League;

DROP PROCEDURE IF EXISTS League;
DROP PROCEDURE IF EXISTS InsertLeague;
DROP PROCEDURE IF EXISTS UpdateLeague;
DROP PROCEDURE IF EXISTS ReadGames;

/***********
 CREATE
************/

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
GO

CREATE TABLE Team
(
TeamID int identity primary key,
LeagueID int,
foreign key (LeagueID) references League(LeagueID),
TeamName varchar(255)
);

/** INDEX **/
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
GO

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
(1, 4, 3, 1, '10/13/2021 19:00:00'),
(2, 1, 1, 1, '08/18/2021 19:30:00'),
(1, 3, 2, 1, '09/02/2021 19:00:00'),
(1, 2, 3, 2, '11/03/2021 19:30:00'),
(4, 1, 2, 1, '09/25/2021 15:00:00'),
(7, 5, 0, 0, '10/03/2021 12:00:00'),
(8, 5, 1, 3, '08/08/2021 18:30:00'),
(5, 7, 2, 2, '10/23/2021 15:00:00'),
(6, 5, 2, 1, '09/14/2021 19:00:00'),
(5, 6, 0, 2, '11/11/2021 19:30:00');
 --Select * From Game;
GO

/*****************
STORED PROCEDURES
******************/

/** READ **/
CREATE OR ALTER PROCEDURE ReadGames @League varchar(10) = null AS

BEGIN

SELECT FullLeagueName, (HT.TeamName) AS 'HomeTeamName', (WT.TeamName) AS 'AwayTeamName', HomeTeamScore, AwayTeamScore, GameDate
FROM GAME G
	INNER JOIN Team HT ON G.HomeTeamID=HT.TeamID
	INNER JOIN Team WT ON G.AwayTeamID=WT.TeamID
	INNER JOIN League L ON L.LeagueID=HT.LeagueID
WHERE L.ShortLeagueName = COALESCE(@League, L.ShortLeagueName)
ORDER BY G.GameDate;

END
GO
EXECUTE ReadGames;
GO

EXECUTE ReadGames @League = 'NWSL';
GO

/** UPDATE **/
CREATE OR ALTER PROCEDURE UpdateLeague @League varchar(50) = null AS

BEGIN

UPDATE League
SET FullLeagueName = 'Womens Premier Soccer'
WHERE LeagueID = 2;

END
GO
EXECUTE UpdateLeague;
GO

EXECUTE UpdateLeague @League = 'NWSL';
GO

/** INSERT **/
CREATE OR ALTER PROCEDURE InsertLeague @League varchar(50) = null AS

BEGIN

INSERT INTO League (FullLeagueName, ShortLeagueName, LeagueType)
VALUES ('Major League Soccer','MLS','Mens');

END
GO
EXECUTE InsertLeague;
GO

EXECUTE InsertLeague @League = 'NWSL';
GO

/** DELETE **/
CREATE OR ALTER PROCEDURE DeleteLeague @League varchar(50) = null AS

BEGIN

DELETE FROM League WHERE ShortLeagueName = 'MLS';

END
GO
EXECUTE DeleteLeague;
GO

EXECUTE DeleteLeague @League = 'NWSL';
GO