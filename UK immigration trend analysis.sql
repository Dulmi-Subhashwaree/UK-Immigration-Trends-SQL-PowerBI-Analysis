-- 1. DATABASE SETUP AND CLEANUP
-- ====================================================================================

USE master;
ALTER DATABASE UK_Immigration SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE IF EXISTS UK_Immigration;
GO

CREATE DATABASE UK_Immigration;
GO
USE UK_Immigration;
GO

-- Data cleaning 
-- ====================================================================================

-- Removes all letters and symbols, extracts digits only 
CREATE FUNCTION dbo.ExtractNumbers (@str NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
    DECLARE @num NVARCHAR(MAX) = '';
    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@str);

    WHILE @i <= @len
    BEGIN
        IF SUBSTRING(@str, @i, 1) LIKE '[0-9]'
            SET @num += SUBSTRING(@str, @i, 1);
        SET @i += 1;
    END

    RETURN CASE WHEN @num = '' THEN 0 ELSE CAST(@num AS INT) END;
END;
GO

-- 2. CAS_D01: Study by Institution
-- ====================================================================================

CREATE TABLE CAS_D01_Study_Type (
    Col1 NVARCHAR(MAX),
    Col2 NVARCHAR(MAX),
    Col3 NVARCHAR(MAX),
    Col4 NVARCHAR(MAX),
    Col5_Merged NVARCHAR(MAX)
);
GO

BULK INSERT CAS_D01_Study_Type
FROM 'C:\sql assi\Data - CAS_D01.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 3);
GO

ALTER TABLE CAS_D01_Study_Type
ADD Applications_Count INT, Sponsorship_Year INT, Institution_Type NVARCHAR(MAX);
GO

UPDATE CAS_D01_Study_Type
SET 
    Institution_Type =
        CASE WHEN PATINDEX('%[0-9]%', Col5_Merged) > 0
            THEN TRIM(LEFT(Col5_Merged, PATINDEX('%[0-9]%', Col5_Merged) - 1))
            ELSE Col5_Merged END,

    Applications_Count = dbo.ExtractNumbers(Col5_Merged),

    Sponsorship_Year =
        CASE WHEN ISNUMERIC(Col1) = 1 THEN CAST(Col1 AS INT) ELSE 0 END
WHERE Col1 NOT LIKE 'End of%';
GO

ALTER TABLE CAS_D01_Study_Type
DROP COLUMN Col1, Col5_Merged;
GO

EXEC sp_rename 'CAS_D01_Study_Type', 'CAS_D01_Study_Type_Clean';
EXEC sp_rename 'CAS_D01_Study_Type_Clean.Col2', 'Sponsorship_Quarter', 'COLUMN';
EXEC sp_rename 'CAS_D01_Study_Type_Clean.Col3', 'Application_Type', 'COLUMN';
EXEC sp_rename 'CAS_D01_Study_Type_Clean.Col4', 'Institution_Group', 'COLUMN';

ALTER TABLE CAS_D01_Study_Type_Clean
ADD CAS_ID INT IDENTITY(1,1) PRIMARY KEY;
GO

-- 3. CAS_D02: Study by Geography
-- ====================================================================================

CREATE TABLE CAS_D02_Study_Geo (
    Col1 NVARCHAR(MAX),
    Col2 NVARCHAR(MAX),
    Col3 NVARCHAR(MAX),
    Col4 NVARCHAR(MAX),
    Col5 NVARCHAR(MAX),
    Col6 NVARCHAR(MAX),
    Col7 NVARCHAR(MAX)
);
GO

BULK INSERT CAS_D02_Study_Geo
FROM 'C:\sql assi\Data - CAS_D02.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 3);
GO

ALTER TABLE CAS_D02_Study_Geo
ADD Applications_Count INT, Sponsorship_Year INT;
GO

UPDATE CAS_D02_Study_Geo
SET
    Applications_Count = dbo.ExtractNumbers(Col7),
    Sponsorship_Year = CASE WHEN ISNUMERIC(Col1)=1 THEN CAST(Col1 AS INT) ELSE 0 END
WHERE Col1 NOT LIKE 'End of%';
GO

ALTER TABLE CAS_D02_Study_Geo
DROP COLUMN Col1, Col7;
GO

EXEC sp_rename 'CAS_D02_Study_Geo', 'CAS_D02_Study_Geo_Clean';
EXEC sp_rename 'CAS_D02_Study_Geo_Clean.Col2', 'Sponsorship_Quarter', 'COLUMN';
EXEC sp_rename 'CAS_D02_Study_Geo_Clean.Col3', 'Application_Type', 'COLUMN';
EXEC sp_rename 'CAS_D02_Study_Geo_Clean.Col4', 'Region_of_Applicant', 'COLUMN';
EXEC sp_rename 'CAS_D02_Study_Geo_Clean.Col5', 'Applicant_Nationality', 'COLUMN';
EXEC sp_rename 'CAS_D02_Study_Geo_Clean.Col6', 'Institution_Group', 'COLUMN';

ALTER TABLE CAS_D02_Study_Geo_Clean
ADD CAS_Geo_ID INT IDENTITY(1,1) PRIMARY KEY;
GO

-- 4. CoS_D01: Work by Industry
-- ====================================================================================

CREATE TABLE CoS_D01_Work_Industry (
    Col1 NVARCHAR(MAX),
    Col2 NVARCHAR(MAX),
    Col3 NVARCHAR(MAX),
    Col4 NVARCHAR(MAX),
    Col5_Merged NVARCHAR(MAX)
);
GO

BULK INSERT CoS_D01_Work_Industry
FROM 'C:\sql assi\Data - CoS_D01.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 3);
GO

ALTER TABLE CoS_D01_Work_Industry
ADD Applications_Count INT, Sponsorship_Year INT, Industry_Type NVARCHAR(MAX);
GO

UPDATE CoS_D01_Work_Industry
SET 
    Industry_Type =
        CASE WHEN PATINDEX('%[0-9]%', Col5_Merged) > 0
            THEN TRIM(LEFT(Col5_Merged, PATINDEX('%[0-9]%', Col5_Merged) - 1))
            ELSE Col5_Merged END,

    Applications_Count = dbo.ExtractNumbers(Col5_Merged),

    Sponsorship_Year =
        CASE WHEN ISNUMERIC(Col1)=1 THEN CAST(Col1 AS INT) ELSE 0 END
WHERE Col1 NOT LIKE 'End of%';
GO

ALTER TABLE CoS_D01_Work_Industry
DROP COLUMN Col1, Col5_Merged;
GO

EXEC sp_rename 'CoS_D01_Work_Industry', 'CoS_D01_Work_Industry_Clean';
EXEC sp_rename 'CoS_D01_Work_Industry_Clean.Col2', 'Sponsorship_Quarter', 'COLUMN';
EXEC sp_rename 'CoS_D01_Work_Industry_Clean.Col3', 'Application_Type', 'COLUMN';
EXEC sp_rename 'CoS_D01_Work_Industry_Clean.Col4', 'Leave_Category', 'COLUMN';

ALTER TABLE CoS_D01_Work_Industry_Clean
ADD CoS_Key INT IDENTITY(1,1) PRIMARY KEY;
GO

-- 5. CoS_D02: Work by Geography
-- ====================================================================================

CREATE TABLE CoS_D02_Work_Geo (
    Col1 NVARCHAR(MAX),
    Col2 NVARCHAR(MAX),
    Col3 NVARCHAR(MAX),
    Col4 NVARCHAR(MAX),
    Col5_Merged NVARCHAR(MAX)
);
GO

BULK INSERT CoS_D02_Work_Geo
FROM 'C:\sql assi\Data - CoS_D02.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 3);
GO

ALTER TABLE CoS_D02_Work_Geo
ADD Applications_Count INT, Sponsorship_Year INT, Applicant_Nationality NVARCHAR(MAX);
GO

UPDATE CoS_D02_Work_Geo
SET 
    Applicant_Nationality =
        CASE WHEN PATINDEX('%[0-9]%', Col5_Merged) > 0
            THEN TRIM(LEFT(Col5_Merged, PATINDEX('%[0-9]%', Col5_Merged) - 1))
            ELSE Col5_Merged END,

    Applications_Count = dbo.ExtractNumbers(Col5_Merged),

    Sponsorship_Year =
        CASE WHEN ISNUMERIC(Col1)=1 THEN CAST(Col1 AS INT) ELSE 0 END
WHERE Col1 NOT LIKE 'End of%';
GO

ALTER TABLE CoS_D02_Work_Geo
DROP COLUMN Col1, Col5_Merged;
GO

EXEC sp_rename 'CoS_D02_Work_Geo', 'CoS_D02_Work_Geo_Clean';
EXEC sp_rename 'CoS_D02_Work_Geo_Clean.Col2', 'Sponsorship_Quarter', 'COLUMN';
EXEC sp_rename 'CoS_D02_Work_Geo_Clean.Col3', 'Application_Type', 'COLUMN';
EXEC sp_rename 'CoS_D02_Work_Geo_Clean.Col4', 'Region_of_Applicant', 'COLUMN';

ALTER TABLE CoS_D02_Work_Geo_Clean
ADD CoS_Geo_Key INT IDENTITY(1,1) PRIMARY KEY;
GO
