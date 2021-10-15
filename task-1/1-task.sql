-- create datbase qilamiz .
CREATE DATABASE  HR;

-- database tanladig .
USE HR ;

-- Employee table yasaymiz  
CREATE TABLE Employee(
    Employee_ID INT PRIMARY KEY  IDENTITY(1000,1),
    Employee_FName CHAR(100) NOT NULL,
    Employee_LName CHAR(100) NOT NULL,
    Employee_HireDate DATE ,
    Employee_Title CHAR(250) DEFAULT 'unknown',
);

-- insert ma'lumotlar qilamiz 
INSERT INTO 
       Employee(Employee_FName,Employee_LName,Employee_HireDate,Employee_Title)
VALUES ('O`tkir','Xo`jayev',GETDATE(),'Dev'),
       ('O`tkir','Xo`jayev',GETDATE(),'Dev'),
       ('O`tkir','Xo`jayev',GETDATE(),'Dev');

-- Skill table yaratamiz 
CREATE TABLE Skill(
    Skill_ID INT PRIMARY KEY IDENTITY(100,10),
    Skill_Name CHAR(100) ,
    Skill_description CHAR(250) ,
    CONSTRAINT idCheck CHECK(Skill_ID>=100 AND Skill_ID<220)
);

-- Skill insert qilamiz 
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


-- CERTIFIED tbale yaratamiz 
CREATE TABLE CERTIFIED(
    Employee_ID INT FOREIGN KEY REFERENCES Employee(Employee_ID) ,
    Skill_ID INT FOREIGN KEY REFERENCES Skill(Skill_ID) ,
    Certified_Date DATE ,
);

-- CERTIFIED insert data qilamiz 
INSERT INTO 
      CERTIFIED(Employee_ID, Skill_ID, Certified_Date) 
VALUES (1001,100,GETDATE()),(1001,110,GETDATE())



-- Tugadi savolar bo'lsa @bubiznihikoya