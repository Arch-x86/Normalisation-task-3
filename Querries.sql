-- Part 1: converting the table in the first normal form (1NF).
 CREATE DATABASE CLUB_MEMBERSHIP_MANAGEMENT;
  USE CLUB_MEMBERSHIP_MANAGEMENT;
   CREATE TABLE StudentClubs (
         StudentID INT,
         StudentName VARCHAR(50),
         Email VARCHAR(100),
         ClubName VARCHAR(50),
         ClubRoom VARCHAR(10),
         ClubMentor VARCHAR(50),
         JoinDate DATE,
         PRIMARY KEY (StudentID, ClubName)
     );
      INSERT INTO StudentClubs (StudentID, StudentName, Email, ClubName, ClubRoom, ClubMentor, JoinDate) VALUES
     (1, 'Asha', 'asha@email.com', 'Music Club', 'R101', 'Mr. Raman', '2024-01-10'),
     (2, 'Bikash', 'bikash@email.com', 'Sports Club', 'R202', 'Ms. Sita', '2024-01-12'),
     (1, 'Asha', 'asha@email.com', 'Sports Club', 'R202', 'Ms. Sita', '2024-01-15'),
     (3, 'Nisha', 'nisha@email.com', 'Music Club', 'R101', 'Mr. Raman', '2024-01-20'),
     (4, 'Rohan', 'rohen@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '2024-01-18'),
     (5, 'Suman', 'suman@email.com', 'Music Club', 'R101', 'Mr. Raman', '2024-01-22'),
     (2, 'Bikash', 'bikash@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '2024-01-25'),
     (6, 'Pooja', 'pooja@email.com', 'Sports Club', 'R202', 'Ms. Sita', '2024-01-27'),
     (3, 'Nisha', 'nisha@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '2024-01-28'),
     (7, 'Aman', 'aman@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '2024-01-30');
   SELECT * FROM StudentClubs;

-- Part 2: Converting the table in the second normal form (2NF).
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Email VARCHAR(100)
);
CREATE TABLE Clubs (
    ClubName VARCHAR(50) PRIMARY KEY,
    ClubRoom VARCHAR(10),
    ClubMentor VARCHAR(50)
);
CREATE TABLE Registrations (
    StudentID INT,
    ClubName VARCHAR(50),
    JoinDate DATE,
    PRIMARY KEY (StudentID, ClubName),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClubName) REFERENCES Clubs(ClubName)
);

INSERT INTO Students (StudentID, StudentName, Email) VALUES
(1, 'Asha', 'asha@email.com'),
(2, 'Bikash', 'bikash@email.com'),
(3, 'Nisha', 'nisha@email.com'),
(4, 'Rohan', 'rohan@email.com'),
(5, 'Suman', 'suman@email.com'),
(6, 'Pooja', 'pooja@email.com'),
(7, 'Aman', 'aman@email.com');

INSERT INTO Clubs (ClubName, ClubRoom, ClubMentor) VALUES
('Music Club', 'R101', 'Mr. Raman'),
('Sports Club', 'R202', 'Ms. Sita'),
('Drama Club', 'R303', 'Mr. Kiran'),
('Coding Club', 'Lab1', 'Mr. Anil');

INSERT INTO Registrations (StudentID, ClubName, JoinDate) VALUES
(1, 'Music Club', '2024-01-10'),
(2, 'Sports Club', '2024-01-12'),
(1, 'Sports Club', '2024-01-15'),
(3, 'Music Club', '2024-01-20'),
(4, 'Drama Club', '2024-01-18'),
(5, 'Music Club', '2024-01-22'),
(2, 'Drama Club', '2024-01-25'),
(6, 'Sports Club', '2024-01-27'),
(3, 'Coding Club', '2024-01-28'),
(7, 'Coding Club', '2024-01-30');

-- To verify the data in the new table after 2NF normalization.

SELECT * FROM Students;
SELECT * FROM Clubs;
SELECT * FROM Registrations;

-- Part 3: converting the table in the third normal form (3NF).
CREATE TABLE Staff (
    ClubRoom VARCHAR(10) PRIMARY KEY,
    ClubMentor VARCHAR(50)
);

INSERT INTO Staff (ClubRoom, ClubMentor) VALUES
('R101', 'Mr. Raman'),
('R202', 'Ms. Sita'),
('R303', 'Mr. Kiran'),
('Lab1', 'Mr. Anil');

ALTER TABLE Clubs DROP COLUMN ClubMentor;

ALTER TABLE Clubs 
ADD CONSTRAINT fk_room 
FOREIGN KEY (ClubRoom) REFERENCES Staff(ClubRoom);

-- TO verify the data in the new table after 3NF normalization.
SELECT * FROM Staff;
SELECT * FROM Clubs;
SELECT * FROM Students;
SELECT * FROM Registrations;

-- to view the all 4 tables as one 
SELECT 
    s.StudentID, 
    s.StudentName, 
    s.Email, 
    c.ClubName, 
    st.ClubRoom, 
    st.ClubMentor, 
    r.JoinDate
FROM Registrations r
JOIN Students s ON r.StudentID = s.StudentID
JOIN Clubs c ON r.ClubName = c.ClubName
JOIN Staff st ON c.ClubRoom = st.ClubRoom
ORDER BY s.StudentID;

-- Testing the database by inserting new data
 INSERT INTO Students (StudentID, StudentName, Email)
  VALUES (8, 'Ankit', 'ankit@email.com');
  SELECT * FROM Students;

 INSERT INTO Clubs (ClubName, ClubRoom)
  VALUES ('Photography Club', 'R303');
    SELECT * FROM Clubs;
