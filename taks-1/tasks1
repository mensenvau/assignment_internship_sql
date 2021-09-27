-- CREATE DATABASE
CREATE DATABASE  HR;

-- CHECK DATABASE
USE HR ;

-- Create Employee table
CREATE TABLE Employee(
    Employee_ID    CHAR(100) NOT NULL PRIMARY KEY ,
    Employee_FName CHAR(100) NOT NULL,
    Employee_LName CHAR(100) NOT NULL,
    Employee_HireDate DATE ,
    Employee_Title CHAR(250) DEFAULT 'unknown',
);

-- INSERT DATA Employee Table
INSERT INTO
       Employee(Employee_ID,Employee_FName,Employee_LName,Employee_HireDate,Employee_Title)
VALUES ('0001','O`tkir','Xo`jayev',GETDATE(),'Dev'),
       ('0002','O`tkir','Xo`jayev',GETDATE(),'Dev'),
       ('0003','O`tkir','Xo`jayev',GETDATE(),'Dev');

-- Create Skill Table
CREATE TABLE Skill(
    Skill_ID INT PRIMARY KEY IDENTITY(100,10),
    Skill_Name CHAR(100) ,
    Skill_description CHAR(250) ,
    CONSTRAINT idCheck CHECK(Skill_ID>=100 AND Skill_ID<220)
);

-- INSERT DATA Skill Table
INSERT INTO
      Skill (skill_name, skill_description)
VALUES
    ('Dasturlash asoslari ','this Lorem ......'),
    ('C++ datsurlash tili ','I love c++......') ,
    ('C++ datsurlash tili ','I love c++......') ,
    ('Dasturlash asoslari ','this Lorem ......'),
    ('C++ datsurlash tili ','I love c++......') ,
    ('C++ datsurlash tili ','I love c++......') ,
    ('Dasturlash asoslari ','this Lorem ......'),
    ('C++ datsurlash tili ','I love c++......') ,
    ('C++ datsurlash tili ','I love c++......'),
    ('Dasturlash asoslari ','this Lorem ......'),
    ('C++ datsurlash tili ','I love c++......'),
    ('C++ datsurlash tili ','I love c++......')


-- Create  CERTIFIED table
CREATE TABLE CERTIFIED(
    Employee_ID CHAR(100) FOREIGN KEY(Employee_ID) REFERENCES Employee(Employee_ID) ,
    Skill_ID INT FOREIGN KEY REFERENCES Skill(Skill_ID) ,
    Certified_Date DATE ,
);

-- INSERT DATA CERTIFIED TABLE
INSERT INTO
      CERTIFIED(Employee_ID, Skill_ID, Certified_Date)
VALUES ('0001',100,GETDATE()),('0002',110,GETDATE())



-- FINISH @bubiznihikoya
