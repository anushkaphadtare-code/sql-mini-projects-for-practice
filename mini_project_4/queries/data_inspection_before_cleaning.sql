-- ........................................................................................
-- To inspect data:
-- 1. Check for NULL values
-- 2. Check for any empty strings
-- 3. Check if there are any leading or trailing spaces
-- 4. Check for any inconsistent data values (e.g. Airbnb/airbnb/AIRBNB are all the same)
-- .........................................................................................

SELECT * FROM dbo.layoffs_raw
WHERE country IS NULL;
-- Inference: No NULL value in company column
SELECT DISTINCT company FROM dbo.layoffs_raw;

-- check if any unwanted spaces 
SELECT company
FROM dbo.layoffs_raw
WHERE company <> LTRIM(RTRIM(company)); -- we have 2 company names 

-- check if any company name starts with random characters:
SELECT company
FROM dbo.layoffs_raw
WHERE company LIKE '#%'; -- one name found

-- check for inconsistent data values:
SELECT
	LTRIM(RTRIM(company)) AS trimmed_company,
	COUNT(*)
FROM dbo.layoffs_raw
GROUP BY LTRIM(RTRIM(company))
ORDER BY trimmed_company;

SELECT
    company AS original_company,
    LTRIM(RTRIM(company)) AS cleaned_company
FROM dbo.layoffs_raw
WHERE company <> LTRIM(RTRIM(company));

SELECT DISTINCT company
FROM dbo.layoffs_raw
WHERE company LIKE '#%';  

-- check for capitalization variations:
SELECT
    UPPER(LTRIM(RTRIM(company))) AS normalized_company,
    COUNT(DISTINCT company) AS name_variations
FROM dbo.layoffs_raw
GROUP BY UPPER(LTRIM(RTRIM(company)))
HAVING COUNT(DISTINCT company) > 1
ORDER BY normalized_company;
-- ........................END of inspecting company column...........................

-- Check location column:
-- Look for NULLs or empty strings:
SELECT * FROM dbo.layoffs_raw
WHERE location IS NULL OR TRIM(location) = '';
-- location column has no NULL values or no empty strings

-- check for any leading or trailing spaces:
SELECT location
FROM dbo.layoffs_raw 
WHERE location <> TRIM(location);

-- check for any more inconsistent values:
SELECT DISTINCT location
FROM dbo.layoffs_raw
WHERE location COLLATE Latin1_General_100_CI_AI IN ('Malmo', 'Dusseldorf')
ORDER BY location;
-- ............................END OF location column.....................

-- industry column:

--check for nulls or empty string if any:
SELECT * FROM dbo.layoffs_raw
WHERE industry IS NULL OR TRIM(industry) = '';
-- 3 NULLs found in industry

SELECT *
FROM dbo.layoffs_raw
WHERE industry IS NOT NULL
  AND LTRIM(RTRIM(industry)) = '';

SELECT DISTINCT industry
FROM dbo.layoffs_raw
WHERE industry <> LTRIM(RTRIM(industry));
-- no leading/trailing spaces found

-- Check distinct industry values:
SELECT DISTINCT industry
FROM dbo.layoffs_raw
ORDER BY industry;
-- here we have Crypto Currency and CryptoCurrency
-- hence we will now check how many rows use each value:
SELECT
    industry,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE industry IN ('Crypto Currency', 'CryptoCurrency')
GROUP BY industry
ORDER BY industry;
-- Inference: Use Crypto Currency (more count)

SELECT
    industry,
    CASE
        WHEN industry IS NULL THEN 'Actual SQL NULL'
        WHEN LTRIM(RTRIM(industry)) = '' THEN 'Empty or spaces'
        WHEN UPPER(LTRIM(RTRIM(industry))) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE industry IS NULL
   OR UPPER(LTRIM(RTRIM(industry))) = 'NULL'
   OR LTRIM(RTRIM(industry)) = ''
GROUP BY
    industry,
    CASE
        WHEN industry IS NULL THEN 'Actual SQL NULL'
        WHEN LTRIM(RTRIM(industry)) = '' THEN 'Empty or spaces'
        WHEN UPPER(LTRIM(RTRIM(industry))) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END;
-- We have 1 text 'NULL' and 3 actual SQL NULL
-- .........................END of industry...................................


-- total_laid column:
-- Check missing values and blank values:
SELECT
    COUNT(*) total_rows,
    SUM(CASE WHEN total_laid_off IS NULL THEN 1 ELSE 0 END) null_values,
    SUM(CASE WHEN TRIM(total_laid_off) = ''THEN 1 ELSE 0 END) blank_values
FROM dbo.layoffs_raw;

-- check if the values are numeric:


SELECT
    CASE
        WHEN total_laid_off IS NULL THEN 'Actual SQL NULL'
        WHEN LTRIM(RTRIM(total_laid_off)) = '' THEN 'Blank or spaces'
        WHEN UPPER(LTRIM(RTRIM(total_laid_off))) = 'NULL' THEN 'Text NULL'
        ELSE 'Other non-numeric value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE total_laid_off IS NULL
   OR LTRIM(RTRIM(total_laid_off)) = ''
   OR TRY_CONVERT(INT, total_laid_off) IS NULL
GROUP BY
    CASE
        WHEN total_laid_off IS NULL THEN 'Actual SQL NULL'
        WHEN LTRIM(RTRIM(total_laid_off)) = '' THEN 'Blank or spaces'
        WHEN UPPER(LTRIM(RTRIM(total_laid_off))) = 'NULL' THEN 'Text NULL'
        ELSE 'Other non-numeric value'
    END;

-- Check numeric range:

SELECT
    MIN(TRY_CONVERT(INT, total_laid_off)) AS min_total_laid,
    MAX(TRY_CONVERT(INT, total_laid_off)) AS max_total_laid,
    COUNT(DISTINCT TRY_CONVERT(INT, total_laid_off)) AS distinct_values
FROM dbo.layoffs_raw
WHERE UPPER(LTRIM(RTRIM(total_laid_off))) <> 'NULL';

-- ..............................END of total_laid_off.................................

-- percentage_laid_off:
-- Check NULL, text 'NULL', blank values:

SELECT
    CASE WHEN percentage_laid_off IS NULL THEN 'Actual SQL Null'
         WHEN TRIM(percentage_laid_off) = ''THEN 'Blank or Spaces'
         WHEN UPPER(TRIM(percentage_laid_off)) = 'NULL'THEN 'Text NULL'
         ELSE 'Other value'
    END value_type,
    COUNT(*) record_count
FROM dbo.layoffs_raw
GROUP BY 
    CASE WHEN percentage_laid_off IS NULL THEN 'Actual SQL Null'
         WHEN TRIM(percentage_laid_off) = ''THEN 'Blank or Spaces'
         WHEN UPPER(TRIM(percentage_laid_off)) = 'NULL'THEN 'Text NULL'
         ELSE 'Other value'
END;

-- we need to inspect the non-missing values are numeric and if any fall outside expected range(0,100)

SELECT
    percentage_laid_off,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE UPPER(TRIM(percentage_laid_off)) <> 'NULL'
GROUP BY percentage_laid_off
ORDER BY TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off);

-- verify range and numeric validity:

SELECT
    MIN(TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off)) AS min_percentage,
    MAX(TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off)) AS max_percentage,
    SUM(
        CASE
            WHEN UPPER(TRIM(percentage_laid_off)) <> 'NULL'
             AND TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off) IS NULL
            THEN 1
            ELSE 0
        END
    ) AS non_numeric_values,
    SUM(
        CASE
            WHEN TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off) < 0
              OR TRY_CONVERT(DECIMAL(10, 4), percentage_laid_off) > 1
            THEN 1
            ELSE 0
        END
    ) AS out_of_range_values
FROM dbo.layoffs_raw;
-- ..............................END percentage_laid_off....................................

-- column: date
-- Check for NULL values, blank spaces, text NULL
SELECT
    CASE
        WHEN date IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(date) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(date)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
GROUP BY
    CASE
        WHEN date IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(date) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(date)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END;

-- check if dates are valid:

SELECT
    date,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE UPPER(TRIM(date)) <> 'NULL'
  AND TRY_CONVERT(DATE, date) IS NULL
GROUP BY date
ORDER BY date;

-- inspect date range:

SELECT
    MIN(TRY_CONVERT(DATE, date)) AS earliest_date,
    MAX(TRY_CONVERT(DATE, date)) AS latest_date,
    COUNT(DISTINCT TRY_CONVERT(DATE, date)) AS distinct_dates
FROM dbo.layoffs_raw
WHERE UPPER(TRIM(date)) <> 'NULL';
-- .................................END date.............................................

-- stage column:

-- Check missing values, blank values, text 'NULL':

SELECT
    CASE
        WHEN stage IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(stage) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(stage)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
GROUP BY
    CASE
        WHEN stage IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(stage) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(stage)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END;
-- Inspect distinct stage values:

SELECT
    TRIM(stage) AS stage_value,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
WHERE UPPER(TRIM(stage)) <> 'NULL'
GROUP BY TRIM(stage)
ORDER BY stage_value;

-- .............................END stage............................................

-- country column:
-- Check missing values(NULL, blanks, Text NULLs):

SELECT
    CASE
        WHEN country IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(country) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(country)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
GROUP BY
    CASE
        WHEN country IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(country) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(country)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END;

-- inspect distinct country names:

SELECT
    TRIM(country) AS country_name,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
GROUP BY TRIM(country)
ORDER BY country_name;
-- United States and United States. => Data inconsistency FOUND!!

-- ................................END country.........................................

-- funds_raised_millions column:
-- Check missing values:

SELECT
    CASE
        WHEN funds_raised_millions IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(funds_raised_millions) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(funds_raised_millions)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END AS value_type,
    COUNT(*) AS record_count
FROM dbo.layoffs_raw
GROUP BY
    CASE
        WHEN funds_raised_millions IS NULL THEN 'Actual SQL NULL'
        WHEN TRIM(funds_raised_millions) = '' THEN 'Blank or spaces'
        WHEN UPPER(TRIM(funds_raised_millions)) = 'NULL' THEN 'Text NULL'
        ELSE 'Other value'
    END;

-- check numeric validity and range:

SELECT
    MIN(TRY_CONVERT(DECIMAL(18, 2), funds_raised_millions)) AS min_funds,
    MAX(TRY_CONVERT(DECIMAL(18, 2), funds_raised_millions)) AS max_funds,
    SUM(
        CASE
            WHEN UPPER(TRIM(funds_raised_millions)) <> 'NULL'
             AND TRY_CONVERT(DECIMAL(18, 2), funds_raised_millions) IS NULL
            THEN 1
            ELSE 0
        END
    ) AS non_numeric_values,
    SUM(
        CASE
            WHEN TRY_CONVERT(DECIMAL(18, 2), funds_raised_millions) < 0
            THEN 1
            ELSE 0
        END
    ) AS negative_values
FROM dbo.layoffs_raw;
