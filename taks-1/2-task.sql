-- create datbase qilamiz 
CREATE DATABASE  Store;

-- database tanladig 
USE Store ;

-- Region table yaratamiz 
CREATE TABLE  Region(
    REGION_CODE INT PRIMARY KEY  IDENTITY(1,1),
    REGION_DESCRIPT CHAR(200)
)

-- Region data insert qilamiz
INSERT INTO 
       Region(REGION_DESCRIPT)
VALUES ('EAST'),('WEST')

-- Store table yaratamiz 
CREATE TABLE  Store(
    STORE_CODE INT PRIMARY KEY  IDENTITY(1,1),
    STORE_NAME CHAR(100),
    STORE_YTD_SALES FLOAT CONSTRAINT sts CHECK(STORE_YTD_SALES>=0),
    REGION_CODE INT FOREIGN  KEY REFERENCES Region(REGION_CODE) ,
    EMP_CODE INT
)

-- store table data insert qilamiz
INSERT INTO
      Store(STORE_NAME, STORE_YTD_SALES, REGION_CODE, EMP_CODE)
VALUES 
      ('DatabAse corner',0,2,1), 
      ('DatBase corner' ,0,2,1), 
      ('DatBase corner' ,0,2,1)

-- Employee Table create qilamiz 
CREATE TABLE Employee(
    EMP_CODE INT PRIMARY KEY  IDENTITY(1,1),
    EMP_TITLE  CHAR(250) ,
    EMP_LNAME  CHAR(100),
    EMP_FNAME  CHAR(100) ,
    EMP_INTIAL CHAR(10) ,
    EMP_BOB DATE ,
    STORE_CODE INT FOREIGN  KEY REFERENCES Store(STORE_CODE) DEFAULT 3
);

-- Employee insert qilamiz STORE_CODE default = 3 
INSERT INTO 
         Employee(EMP_TITLE, EMP_LNAME, EMP_FNAME, EMP_INTIAL, EMP_BOB)
VALUES  ('Mr.','Smith','Peter','N',GETDATE())

-- Employee insert qilamiz STORE_CODE yes
INSERT INTO 
        Employee(EMP_TITLE, EMP_LNAME, EMP_FNAME, EMP_INTIAL, EMP_BOB,STORE_CODE)
VALUES ('Mr.','Smith','Peter','N',GETDATE(),2)

-- Tugadi savolar bo'lsa @bubiznihikoya