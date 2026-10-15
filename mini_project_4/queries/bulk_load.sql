CREATE DATABASE layoffs_db;
GO

USE layoffs_db;
GO
-- Here we can create our own schema and then create tables inside this schema
-- Or we can use the default schema dbo 


-- Column names: company, location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions
-- Initially we import this csv into a table with all columns' datatype as varchar

CREATE TABLE dbo.layoffs_raw(
	company VARCHAR(255),
	location VARCHAR(255),
	industry VARCHAR(255),
	total_laid_off VARCHAR(100), 
	percentage_laid_off VARCHAR(100), 
	date VARCHAR(100),
	stage VARCHAR(255), 
	country VARCHAR(255), 
	funds_raised_millions VARCHAR(100)
);
GO

SELECT * FROM layoffs_raw;

-- Bulk Insert:
BULK INSERT dbo.layoffs_raw
FROM 'C:\Users\anushka\Desktop\SQLInterviewPractice\SQL_cleaning_EDA\data\layoffs.csv'
WITH(
     FORMAT = 'CSV',
	 FIRSTROW = 2, -- skips the header row
	 CODEPAGE = '65001', -- uses UTF-8 encoding
	 TABLOCK -- requests a table level lock during loading
);
GO
