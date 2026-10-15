# Layoffs Data Cleaning Using SQL Server

## Project Overview

This project focuses on exploring, inspecting, and cleaning a layoffs dataset using Microsoft SQL Server and SQL Server Management Studio (SSMS). The objective is to identify missing values, inconsistent labels, potential data quality issues, and inappropriate data types before preparing a clean dataset for further analysis.

The raw dataset was imported from `layoffs.csv` into SQL Server as `dbo.layoffs_raw`, with all nine columns initially stored as `VARCHAR`.

**Important:** The raw table is preserved unchanged. All future cleaning operations will be performed on a separate clean table.

## Tools and Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL

## Dataset Overview

The dataset contains **2,361 records** and the following nine columns:

| Column | Description |
|---|---|
| `company` | Name of the company reporting layoffs |
| `location` | Location associated with the layoff event |
| `industry` | Industry in which the company operates |
| `total_laid` | Number of employees laid off |
| `percentage_laid_off` | Proportion of employees laid off |
| `date` | Date of the layoff event |
| `stage` | Company funding or business stage |
| `country` | Country associated with the company |
| `funds_raised_millions` | Funding raised, expressed in millions |

## Data Inspection and Profiling

Before modifying the dataset, each column was inspected individually to identify missing values, inconsistent labels, formatting issues, and potential data type problems.

### 1. Company

- Checked for missing values.
- Identified two company names containing leading spaces: ` E Inc.` and ` Included Health`.
- Observed that some company names appeared multiple times. These were not automatically considered duplicates because a company may report layoffs on multiple occasions.
- Identified `#Paid` as a company name requiring no automatic correction without further evidence.

**Planned action:** Remove unnecessary leading and trailing spaces while preserving legitimate company names.

### 2. Location

- Checked for missing values, blank strings, and leading or trailing spaces.
- Identified possible spelling or accent variations, including:
  - `Malmö` and `Malmo`
  - `Düsseldorf` and `Dusseldorf`

**Planned action:** Review these variations before standardizing them, since accent differences alone do not necessarily indicate incorrect data.

### 3. Industry

- Identified three actual SQL `NULL` values.
- Found values stored as the text `'NULL'`, which are different from actual SQL `NULL` values.
- Identified inconsistent industry labels:
  - `Crypto Currency` — 2 records
  - `CryptoCurrency` — 1 record

**Planned action:**
- Standardize missing-value representations.
- Replace `CryptoCurrency` with `Crypto Currency` in the clean table.

### 4. Total Laid Off

- Identified 740 records containing the text `'NULL'`.
- The numeric values ranged from 3 to 12,000.
- Found 285 distinct numeric values.
- Confirmed that the populated numeric values could be converted to integers.

**Planned action:**
- Replace text `'NULL'` with actual SQL `NULL`.
- Convert the column to an integer data type.
- Preserve valid numeric values rather than replacing missing values with zero.

### 5. Percentage Laid Off

- Identified 785 records containing the text `'NULL'`.
- Found no actual SQL `NULL` values or blank strings.
- The minimum value was 0 and the maximum was 1.
- Found no non-numeric values or values outside the expected range of 0 to 1.

The column stores proportions rather than whole-number percentages. For example, `0.25` represents 25%, while `1` represents 100%.

**Planned action:**
- Convert text `'NULL'` values to actual SQL `NULL`.
- Convert the column to an appropriate decimal data type.
- Preserve the original proportion scale and decimal precision.

### 6. Date

- Identified one record containing the text `'NULL'`.
- Confirmed that all 2,360 non-missing date values could be converted to SQL `DATE` using the default conversion.
- Earliest date: `2020-03-11`
- Latest date: `2023-03-06`
- Number of distinct dates: 483

**Planned action:**
- Convert the text `'NULL'` value to actual SQL `NULL`.
- Convert the column to the `DATE` data type.
- Preserve the original date information and verify date interpretation where necessary.

### 7. Stage

- Identified six records containing the text `'NULL'`.
- Found 16 distinct non-missing stage labels.
- Observed values such as `Seed`, `Series A`, `Series B`, `Post-IPO`, `Private Equity`, `Acquired`, `Subsidiary`, and `Unknown`.

**Planned action:**
- Convert text `'NULL'` values to actual SQL `NULL`.
- Preserve `Unknown` as a distinct category because it is not equivalent to a missing value.
- Avoid unnecessary changes to valid stage labels.

### 8. Country

- Found no actual SQL `NULL`, text `'NULL'`, or blank values.
- Identified an inconsistent country label:
  - `United States` — 1,541 records
  - `United States.` — 4 records

**Planned action:** Standardize `United States.` to `United States` in the clean table.

### 9. Funds Raised (Millions)

- Identified 209 records containing the text `'NULL'`.
- The numeric values ranged from 0 to 121,900 million.
- Found no non-numeric or negative values.

**Planned action:**
- Convert text `'NULL'` values to actual SQL `NULL`.
- Convert the column to an appropriate decimal data type.
- Preserve valid numeric values, including large funding amounts, unless further investigation establishes that they are incorrect.

## SQL Concepts Practiced

During the inspection and profiling phase, the following SQL concepts were used:

- `SELECT`, `WHERE`, `GROUP BY`, and `ORDER BY`
- Aggregate functions such as `COUNT`, `MIN`, and `MAX`
- `CASE` expressions for classifying missing values
- `TRIM` and `UPPER` for examining whitespace and text variations
- `DISTINCT` for identifying unique values
- `TRY_CONVERT` for checking numeric and date convertibility
- Conditional aggregation for counting data quality issues
- `LEN` and `DATALENGTH` for investigating string formatting
- Data type validation and range checks

## Current Status

**Completed:**
- Imported the CSV dataset into SQL Server.
- Preserved the original raw table.
- Inspected all nine columns individually.
- Identified missing-value representations, inconsistent labels, and potential standardization requirements.
- Checked numeric ranges and date convertibility.

**Next steps:**
1. Create a separate clean table with appropriate data types.
2. Standardize missing values and inconsistent labels.
3. Apply transformations without modifying the raw table.
4. Validate the cleaned data by checking row counts, data types, missing values, and remaining inconsistencies.
5. Prepare the clean dataset for exploratory data analysis.

## Project Objective

The goal is to build a reliable, analysis-ready dataset through a structured SQL workflow that emphasizes data profiling, careful transformation, data integrity, and validation.
