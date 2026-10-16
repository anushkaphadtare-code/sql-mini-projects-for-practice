-- Use proposed business logic for handling NULL values:

CREATE TABLE dbo.layoffs_gold
(
    company VARCHAR(255),
    location VARCHAR(255),
    industry VARCHAR(255),
    total_laid_off INT,
    percentage_laid_off DECIMAL(5,4),
    date DATE,
    stage VARCHAR(255),
    country VARCHAR(255),
    funds_raised_millions DECIMAL(18,2)
);

INSERT INTO dbo.layoffs_gold
(company,
location,
industry,
total_laid_off,
percentage_laid_off,
date,
stage,
country,
funds_raised_millions
)
SELECT 
    company,
    location,
    CASE WHEN industry IS NULL THEN 'Unknown'
         ELSE industry
    END AS industry,
    total_laid_off,
    percentage_laid_off,
    date,
    CASE WHEN stage IS NULL THEN 'Unknown'
         ELSE stage
    END AS stage,
    country,
    funds_raised_millions
FROM dbo.layoffs_clean;

SELECT * FROM dbo.layoffs_gold;
SELECT COUNT(*)
FROM dbo.layoffs_gold
WHERE industry IS NULL OR stage IS NULL;

SELECT
    (SELECT COUNT(*) FROM dbo.layoffs_clean) AS silver_rows,
    (SELECT COUNT(*) FROM dbo.layoffs_gold) AS gold_rows;

-- 1) company column: Investigate missing values; don't invent names
SELECT DISTINCT company 
FROM dbo.layoffs_clean;
-- No missing/blanks;keep as-is

-- 2) location: Preserve NULL:
SELECT location
FROM dbo.layoffs_clean
WHERE location IS NULL;
-- There are no NULl values in this column

-- 3) industry column: Replace NULL with 'Unknown'
SELECT industry
FROM dbo.layoffs_clean
-- we do have 1 NULL value=> replace with 'Unknown'
SELECT industry
FROM dbo.layoffs_clean
WHERE industry  IS NULL;

--4) preserve NULL for all other columns except stage, for stage where stage is null, replace wiyh 'Unknown'

-- Checking final data validation:
SELECT
    (SELECT COUNT(*) FROM dbo.layoffs_raw) AS raw_rows,
    (SELECT COUNT(*) FROM dbo.layoffs_clean) AS silver_rows,
    (SELECT COUNT(*) FROM dbo.layoffs_gold) AS gold_rows;

