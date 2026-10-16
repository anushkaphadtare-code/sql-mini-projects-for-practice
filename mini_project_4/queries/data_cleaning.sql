-- understand the metadata:
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'layoffs_raw'
ORDER BY ORDINAL_POSITION;


-- CREATE TABLE dbo.layoffs_clean:

CREATE TABLE dbo.layoffs_clean
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


-- Insert records into this table:
INSERT INTO dbo.layoffs_clean
(
    company,
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
      TRIM(company) AS company,

    CASE WHEN location = 'Malmö' THEN 'Malmo'
         WHEN location = 'Düsseldorf' THEN 'Dusseldorf'
         ELSE location
    END AS location,

    CASE WHEN TRIM(industry) = 'NULL' THEN NULL
         WHEN TRIM(industry) = 'CryptoCurrency' THEN 'Crypto Currency'
         ELSE TRIM(industry)
    END AS industry,

    TRY_CONVERT(INT, NULLIF(TRIM(total_laid_off),'NULL')) AS total_laid_off,

    TRY_CONVERT(DECIMAL(5,4), NULLIF(TRIM(percentage_laid_off), 'NULL')) AS percentage_laid_off,

    TRY_CONVERT(DATE, NULLIF(TRIM(date), 'NULL')) AS date,

    NULLIF(UPPER(TRIM(stage)), 'NULL') AS stage,

    CASE WHEN TRIM(country) = 'United States.' THEN 'United States'
         ELSE TRIM(country)
    END AS country,

    TRY_CONVERT(DECIMAL(18,2), NULLIF(TRIM(funds_raised_millions),'NULL')) AS funds_raised_millions

FROM dbo.layoffs_raw;

SELECT 
    COUNT(*)
FROM dbo.layoffs_clean;

SELECT *
FROM dbo.layoffs_clean;

SELECT
    (SELECT COUNT(*) FROM dbo.layoffs_raw) AS raw_rows,
    (SELECT COUNT(*) FROM dbo.layoffs_clean) AS silver_rows;

-- check datatypes for all columns:
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'layoffs_clean'
ORDER BY ORDINAL_POSITION;

