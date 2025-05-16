-- Part 1: Database and Tables Creation
USE master;
GO
DROP DATABASE IF EXISTS MusicDB;
GO
CREATE DATABASE MusicDB;
GO
USE MusicDB;
GO

-- Create base tables in the correct order
CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY IDENTITY(1,1),
    ArtistName VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY IDENTITY(1,1),
    AlbumName VARCHAR(100) NOT NULL,
    ArtistID INT NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE CASCADE
);
GO

CREATE TABLE Songs (
    SongID INT PRIMARY KEY IDENTITY(1,1),
    SongName VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    Duration INT,
    ArtistID INT,
    AlbumID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID) ON DELETE NO ACTION,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID) ON DELETE CASCADE
);
GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY IDENTITY(1,1),
    PlaylistName VARCHAR(50) NOT NULL,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);
GO

CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    song_order INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
GO

CREATE TABLE Favorites (
    FavoriteID INT PRIMARY KEY IDENTITY(1,1),
    SongID INT,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
GO

CREATE TABLE Recent (
    RecentID INT PRIMARY KEY IDENTITY(1,1),
    SongID INT,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
GO

CREATE TABLE SongTransactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    song_id INT,
    action_type VARCHAR(20), -- 'play', 'download', 'share'
    action_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(UserID),
    FOREIGN KEY (song_id) REFERENCES Songs(SongID)
);
GO

-- Part 2: Inserting Base Data
-- Insert artists
INSERT INTO Artist (ArtistName) VALUES
('Taylor Swift'),
('Ed Sheeran'),
('Adele'),
('Dua Lipa'),
('Harry Styles'),
('Olivia Rodrigo');
GO

-- Insert albums
INSERT INTO Albums (AlbumName, ArtistID) VALUES
('1989', 1),
('Divide', 2),
('25', 3),
('Future Nostalgia', 4),
('Fine Line', 5),
('SOUR', 6);
GO

-- Insert songs (30 songs)
INSERT INTO Songs (SongName, Genre, Duration, ArtistID, AlbumID) VALUES
('Shake It Off', 'Pop', 219, 1, 1),
('Blank Space', 'Pop', 231, 1, 1),
('Style', 'Pop', 231, 1, 1),
('Wildest Dreams', 'Pop', 220, 1, 1),
('Bad Blood', 'Pop', 191, 1, 1),
('Shape of You', 'Pop', 234, 2, 2),
('Thinking Out Loud', 'Pop', 281, 2, 2),
('Perfect', 'Pop', 263, 2, 2),
('Galway Girl', 'Folk Pop', 170, 2, 2),
('Castle on the Hill', 'Rock', 261, 2, 2),
('Hello', 'Pop', 355, 3, 3),
('Someone Like You', 'Pop', 285, 3, 3),
('Rolling in the Deep', 'Soul', 228, 3, 3),
('Set Fire to the Rain', 'Pop', 241, 3, 3),
('When We Were Young', 'Pop', 293, 3, 3),
('Don''t Start Now', 'Disco Pop', 183, 4, 4),
('Physical', 'Synth-pop', 193, 4, 4),
('New Rules', 'Dance-pop', 209, 4, 4),
('Levitating', 'Disco Pop', 203, 4, 4),
('Break My Heart', 'Dance-pop', 221, 4, 4),
('Watermelon Sugar', 'Pop', 174, 5, 5),
('Adore You', 'Pop', 207, 5, 5),
('Lights Up', 'Pop', 172, 5, 5),
('Falling', 'Pop', 240, 5, 5),
('Golden', 'Pop', 208, 5, 5),
('drivers license', 'Pop', 242, 6, 6),
('good 4 u', 'Pop Punk', 178, 6, 6),
('deja vu', 'Pop', 235, 6, 6),
('happier', 'Pop', 175, 6, 6),
('traitor', 'Pop', 229, 6, 6);
GO

-- Insert users (needed before Playlists due to foreign key)
INSERT INTO Users (UserName) VALUES
('MusicLover1'),
('DJ_MixMaster'),
('MelodyFanatic');
GO

-- Insert playlists
INSERT INTO Playlists (PlaylistName, UserID) VALUES
('Pop Hits', 1),
('Chill Vibes', 2),
('Workout Mix', 3),
('Road Trip Anthems', 1),
('Throwback Thursday', 2);
GO

-- Insert songs into playlists
-- Pop Hits
INSERT INTO PlaylistSongs (PlaylistID, SongID, song_order) VALUES
(1, 1, 1),
(1, 6, 2),
(1, 11, 3),
(1, 16, 4),
(1, 21, 5),
(1, 26, 6);
GO

-- Chill Vibes
INSERT INTO PlaylistSongs (PlaylistID, SongID, song_order) VALUES
(2, 3, 1),
(2, 8, 2),
(2, 13, 3),
(2, 18, 4),
(2, 23, 5),
(2, 28, 6);
GO

-- Workout Mix
INSERT INTO PlaylistSongs (PlaylistID, SongID, song_order) VALUES
(3, 5, 1),
(3, 10, 2),
(3, 15, 3),
(3, 20, 4),
(3, 25, 5),
(3, 30, 6);
GO

-- Road Trip Anthems
INSERT INTO PlaylistSongs (PlaylistID, SongID, song_order) VALUES
(4, 2, 1),
(4, 7, 2),
(4, 12, 3),
(4, 17, 4),
(4, 22, 5),
(4, 27, 6);
GO

-- Throwback Thursday
INSERT INTO PlaylistSongs (PlaylistID, SongID, song_order) VALUES
(5, 4, 1),
(5, 9, 2),
(5, 14, 3),
(5, 19, 4),
(5, 24, 5),
(5, 29, 6);
GO

-- Insert favorite songs
INSERT INTO Favorites (SongID) VALUES
(1),
(7),
(13),
(19),
(25);
GO

-- Insert recently played songs
INSERT INTO Recent (SongID) VALUES
(2),
(8),
(14),
(20),
(26),
(5);
GO

-- Insert song plays
INSERT INTO SongTransactions (user_id, song_id, action_type) VALUES
(1, 5, 'play'),
(1, 10, 'play'),
(2, 15, 'play'),
(3, 20, 'play'),
(1, 25, 'play'),
(2, 3, 'play'),
(3, 8, 'play'),
(1, 12, 'play'),
(2, 18, 'play'),
(3, 22, 'play');
GO

-- Verify the data
SELECT * FROM Artist;
SELECT * FROM Albums;
SELECT * FROM Songs;
SELECT * FROM Playlists;
SELECT * FROM PlaylistSongs;
SELECT * FROM Favorites;
SELECT * FROM Recent;
SELECT * FROM Users;
SELECT * FROM SongTransactions;
GO

-- Part 3: Data Query Language (DQL) Commands
-- (Statistics and Analysis Queries)

-- 1. Total number of songs in the system
SELECT COUNT(*) AS total_songs FROM Songs;
GO

-- 2. Number of songs per genre
SELECT Genre, COUNT(*) AS song_count
FROM Songs
GROUP BY Genre
ORDER BY song_count DESC;
GO

-- 3. Longest and shortest songs
-- Top 5 longest songs
SELECT TOP 5 SongName, Duration
FROM Songs
ORDER BY Duration DESC;
GO

-- Top 5 shortest songs
SELECT TOP 5 SongName, Duration
FROM Songs
ORDER BY Duration ASC;
GO

-- 4. Average song duration per artist
SELECT a.ArtistName, AVG(s.Duration) AS avg_duration
FROM Songs s
JOIN Artist a ON s.ArtistID = a.ArtistID
GROUP BY a.ArtistName
ORDER BY avg_duration DESC;
GO

-- 5. Number of songs in each playlist
SELECT p.PlaylistName, COUNT(ps.SongID) AS song_count
FROM Playlists p
LEFT JOIN PlaylistSongs ps ON p.PlaylistID = ps.PlaylistID
GROUP BY p.PlaylistName;
GO

-- 6. Songs that appear in the most playlists (most popular)
SELECT TOP 5 s.SongName, COUNT(ps.PlaylistID) AS playlist_count
FROM Songs s
JOIN PlaylistSongs ps ON s.SongID = ps.SongID
GROUP BY s.SongName
ORDER BY playlist_count DESC;
GO

-- 7. Favorite songs with artist and album info
SELECT s.SongName, a.ArtistName, al.AlbumName
FROM Favorites f
JOIN Songs s ON f.SongID = s.SongID
JOIN Artist a ON s.ArtistID = a.ArtistID
JOIN Albums al ON s.AlbumID = al.AlbumID;
GO

-- 8. Most recently played songs (from Recent table)
SELECT TOP 5 s.SongName, r.Timestamp
FROM Recent r
JOIN Songs s ON r.SongID = s.SongID
ORDER BY r.Timestamp DESC;
GO

-- 9. Number of albums per artist
SELECT a.ArtistName, COUNT(al.AlbumID) AS album_count
FROM Artist a
LEFT JOIN Albums al ON a.ArtistID = al.ArtistID
GROUP BY a.ArtistName
ORDER BY album_count DESC;
GO

-- 10. Most played songs
SELECT TOP 5 s.SongName, COUNT(t.transaction_id) AS play_count
FROM SongTransactions t
JOIN Songs s ON t.song_id = s.SongID
WHERE t.action_type = 'play'
GROUP BY s.SongName
ORDER BY play_count DESC;
GO

-- 11. Most active users
SELECT TOP 3 u.UserName, COUNT(t.transaction_id) AS activity_count
FROM Users u
JOIN SongTransactions t ON u.UserID = t.user_id
GROUP BY u.UserName
ORDER BY activity_count DESC;
GO

-- 12. Songs not added to any playlist
SELECT s.SongName, a.ArtistName
FROM Songs s
LEFT JOIN PlaylistSongs ps ON s.SongID = ps.SongID
JOIN Artist a ON s.ArtistID = a.ArtistID
WHERE ps.PlaylistID IS NULL;
GO

-- 13. Get the names and durations of all pop songs longer than 220 seconds
SELECT s.SongName, s.Duration
FROM Songs s
WHERE s.Genre = 'Pop' AND s.Duration > 220;
GO

-- 14. Get the song name and the playlist name for all songs in the 'Pop Hits' playlist
SELECT s.SongName, p.PlaylistName
FROM Songs s
JOIN PlaylistSongs ps ON s.SongID = ps.SongID
JOIN Playlists p ON ps.PlaylistID = p.PlaylistID
WHERE p.PlaylistName = 'Pop Hits';
GO

-- 15. Find the names of songs by 'Taylor Swift' that are present in the 'Chill Vibes' playlist
SELECT s.SongName
FROM Songs s
JOIN Artist a ON s.ArtistID = a.ArtistID
JOIN PlaylistSongs ps ON s.SongID = ps.SongID
JOIN Playlists p ON ps.PlaylistID = p.PlaylistID
WHERE a.ArtistName = 'Taylor Swift' AND p.PlaylistName = 'Chill Vibes';
GO

-- 16. Get the names of songs that are in the 'Favorites' list
SELECT s.SongName
FROM Songs s
WHERE s.SongID IN (SELECT SongID FROM Favorites);
GO

-- 17. Find the artist who has the most songs in the 'Workout Mix' playlist
SELECT TOP 1 a.ArtistName, COUNT(s.SongID) AS SongCount
FROM Artist a
JOIN Songs s ON a.ArtistID = s.ArtistID
JOIN PlaylistSongs ps ON s.SongID = ps.SongID
JOIN Playlists p ON ps.PlaylistID = p.PlaylistID
WHERE p.PlaylistName = 'Workout Mix'
GROUP BY a.ArtistName
ORDER BY SongCount DESC;
GO

-- 18. Get the names of songs that are not listed in the 'Favorites' table
SELECT s.SongName
FROM Songs s
LEFT JOIN Favorites f ON s.SongID = f.SongID
WHERE f.SongID IS NULL;
GO

-- 19. Find all 'play' actions that occurred on a specific date
SELECT s.SongName, u.UserName, st.action_date
FROM SongTransactions st
JOIN Songs s ON st.song_id = s.SongID
JOIN Users u ON st.user_id = u.UserID
WHERE st.action_type = 'play' AND CAST(st.action_date AS DATE) = '2025-05-02';
GO

-- 20. Find all song names that start with the letter 'S'
SELECT SongName
FROM Songs
WHERE SongName LIKE 'S%';
GO

-- 21. Get the top 3 most recently added songs to the 'Recent' table
SELECT TOP 3 s.SongName, r.Timestamp
FROM Recent r
JOIN Songs s ON r.SongID = s.SongID
ORDER BY r.Timestamp DESC;
GO

-- 22. Users who created the most playlists
SELECT u.UserName, COUNT(p.PlaylistID) AS playlist_count
FROM Users u
LEFT JOIN Playlists p ON u.UserID = p.UserID
GROUP BY u.UserName
ORDER BY playlist_count DESC;
GO

-- 23. Playlists with the highest genre diversity
SELECT TOP 3 p.PlaylistName, COUNT(DISTINCT s.Genre) AS genre_count
FROM Playlists p
JOIN PlaylistSongs ps ON p.PlaylistID = ps.PlaylistID
JOIN Songs s ON ps.SongID = s.SongID
GROUP BY p.PlaylistName
ORDER BY genre_count DESC;
GO

-- 24. Most frequently played genres recently
SELECT s.Genre, COUNT(r.RecentID) AS play_count
FROM Recent r
JOIN Songs s ON r.SongID = s.SongID
GROUP BY s.Genre
ORDER BY play_count DESC;
GO

-- 25. Most shared songs
SELECT TOP 5 s.SongName, COUNT(t.transaction_id) AS share_count
FROM SongTransactions t
JOIN Songs s ON t.song_id = s.SongID
WHERE t.action_type = 'share'
GROUP BY s.SongName
ORDER BY share_count DESC;
GO

-- 26. Artists with longest total song runtime
SELECT a.ArtistName, SUM(s.Duration) AS total_duration_seconds
FROM Artist a
JOIN Songs s ON a.ArtistID = s.ArtistID
GROUP BY a.ArtistName
ORDER BY total_duration_seconds DESC;
GO
 
 -- Part 4: Data Control Language (DCL) Commands
-- This section handles the creation of database users and roles, and manages permissions
DECLARE @DCLMessages TABLE (Message NVARCHAR(MAX)); -- Temporary table to store messages for DCL operations

BEGIN TRY
    -- Check if ReadOnlyUser exists, create it if it doesn't
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'ReadOnlyUser')
    BEGIN
        CREATE USER ReadOnlyUser WITHOUT LOGIN; -- Create a user without login credentials
        INSERT INTO @DCLMessages (Message) VALUES ('ReadOnlyUser created successfully.'); -- Log success
    END
    ELSE
    BEGIN
        INSERT INTO @DCLMessages (Message) VALUES ('ReadOnlyUser already exists.'); -- Log if user exists
    END

    -- Check if DataEntry role exists, create it if it doesn't
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'DataEntry')
    BEGIN
        CREATE ROLE DataEntry; -- Create a new role
        INSERT INTO @DCLMessages (Message) VALUES ('DataEntry role created successfully.'); -- Log success
    END
    ELSE
    BEGIN
        INSERT INTO @DCLMessages (Message) VALUES ('DataEntry role already exists.'); -- Log if role exists
    END

    -- Check if RiskyUser exists, create it if it doesn't
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'RiskyUser')
    BEGIN
        CREATE USER RiskyUser WITHOUT LOGIN; -- Create a user without login credentials
        INSERT INTO @DCLMessages (Message) VALUES ('RiskyUser created successfully.'); -- Log success
    END
    ELSE
    BEGIN
        INSERT INTO @DCLMessages (Message) VALUES ('RiskyUser already exists.'); -- Log if user exists
    END

    -- Grant SELECT permission on Artist table to ReadOnlyUser
    GRANT SELECT ON Artist TO ReadOnlyUser;
    INSERT INTO @DCLMessages (Message) VALUES ('SELECT permission granted on Artist to ReadOnlyUser.');

    -- Revoke INSERT permission on Songs table from DataEntry role
    REVOKE INSERT ON Songs FROM DataEntry;
    INSERT INTO @DCLMessages (Message) VALUES ('INSERT permission revoked on Songs from DataEntry.');

    -- Deny DELETE permission on Albums table to RiskyUser
    DENY DELETE ON Albums TO RiskyUser;
    INSERT INTO @DCLMessages (Message) VALUES ('DELETE permission denied on Albums to RiskyUser.');

    -- Display all DCL messages in the Results window
    SELECT Message AS DCL_Result FROM @DCLMessages;
END TRY
BEGIN CATCH
    -- Handle any errors during DCL operations
    INSERT INTO @DCLMessages (Message) VALUES ('Error in DCL section: ' + ERROR_MESSAGE());
    SELECT Message AS DCL_Result FROM @DCLMessages; -- Display error message in Results
END CATCH;
GO

-- Part 5: Transaction Control Language (TCL) Commands
DECLARE @TCLMessages TABLE (Message NVARCHAR(MAX)); -- Temporary table to store messages for TCL operations

-- Transaction 1: AddNewArtistAlbum
BEGIN TRY
    BEGIN TRANSACTION AddNewArtistAlbum; -- Start a new transaction
    IF NOT EXISTS (SELECT 1 FROM Artist WHERE ArtistName = 'New Artist') -- Check if New Artist exists
    BEGIN
        INSERT INTO Artist (ArtistName) VALUES ('New Artist'); -- Insert new artist
        DECLARE @NewArtistID INT = SCOPE_IDENTITY(); -- Get the ID of the newly inserted artist
        INSERT INTO Albums (AlbumName, ArtistID) VALUES ('New Album', @NewArtistID); -- Insert new album linked to artist
        COMMIT TRANSACTION AddNewArtistAlbum; -- Commit the transaction if successful
        INSERT INTO @TCLMessages (Message) VALUES ('New Artist and Album added successfully.'); -- Log success
    END
    ELSE
    BEGIN
        INSERT INTO @TCLMessages (Message) VALUES ('Artist already exists, skipping transaction.'); -- Log if artist exists
        ROLLBACK TRANSACTION AddNewArtistAlbum; -- Roll back if artist exists
    END

    -- Display TCL messages in the Results window
    SELECT Message AS TCL_Result FROM @TCLMessages;

    -- Display changes in Artist table after the transaction
    SELECT 'Artists after transaction' AS Table_Name, ArtistID, ArtistName 
    FROM Artist 
    WHERE ArtistName = 'New Artist';
    
    -- Display changes in Albums table after the transaction
    SELECT 'Albums after transaction' AS Table_Name, AlbumID, AlbumName, ArtistID 
    FROM Albums 
    WHERE AlbumName = 'New Album';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION AddNewArtistAlbum; -- Roll back transaction in case of error
    INSERT INTO @TCLMessages (Message) VALUES ('Error in transaction AddNewArtistAlbum: ' + ERROR_MESSAGE()); -- Log error
    SELECT Message AS TCL_Result FROM @TCLMessages; -- Display error in Results
END CATCH;
GO

-- Transaction 2: UpdateSongDuration
DECLARE @TCLMessages2 TABLE (Message NVARCHAR(MAX)); -- Temporary table to store messages for second TCL operation

BEGIN TRY
    BEGIN TRANSACTION UpdateSongDuration; -- Start a new transaction
    UPDATE Songs SET Duration = 250 WHERE SongID = 1; -- Update duration of SongID 1
    SAVE TRANSACTION SongUpdateSavepoint; -- Create a savepoint
    UPDATE Songs SET Duration = 300 WHERE SongID = 2; -- Update duration of SongID 2
    COMMIT TRANSACTION UpdateSongDuration; -- Commit the transaction if successful
    INSERT INTO @TCLMessages2 (Message) VALUES ('Song durations updated successfully.'); -- Log success

    -- Display TCL messages in the Results window
    SELECT Message AS TCL_Result FROM @TCLMessages2;

    -- Display changes in Songs table after the transaction
    SELECT 'Songs after update' AS Table_Name, SongID, SongName, Duration 
    FROM Songs 
    WHERE SongID IN (1, 2); -- Show updated songs
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 -- Check if transaction is active
    BEGIN
        ROLLBACK TRANSACTION SongUpdateSavepoint; -- Roll back to savepoint in case of error
        INSERT INTO @TCLMessages2 (Message) VALUES ('Rolled back to savepoint due to error: ' + ERROR_MESSAGE()); -- Log rollback
    END
    SELECT Message AS TCL_Result FROM @TCLMessages2; -- Display message in Results
END CATCH;
GO