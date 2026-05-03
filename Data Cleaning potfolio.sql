---Data Cleaning ---

SELECT *
FROM layoffs ;

--- 1. Remove Duplicates
--- 2. Standardize the Data
--- 3. Null values or Blank values
--- 4. Remove any columns or rows


# (Creating a copy of 'layoffs' dataset called 'layoffs_staging' which we are going to edit, so we still have our 'Raw data' as a backup.)

CREATE TABLE layoffs_staging
LIKE layoffs ;

SELECT *
FROM layoffs_staging ;

INSERT layoffs_staging 
SELECT *
FROM layoffs ;

WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off,
 `date`, stage , country, funds_raised_millions ) AS row_num
 FROM layoffs_staging 
 )
 SELECT *
 FROM duplicate_cte
 where row_num > 1 ;
 
 SELECT *
FROM layoffs_staging 
WHERE company = '100 Thieves';


CREATE TABLE `layoffs_staging1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging1 ;

INSERT INTO layoffs_staging1
SELECT * ,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off,
 `date`, stage , country, funds_raised_millions ) AS row_num
 FROM layoffs_staging ;
 

SELECT *
FROM layoffs_staging1 
WHERE row_num > 1 ;

DELETE
FROM layoffs_staging1 
WHERE row_num > 1 ;

--Standardizing Data--

SELECT company, TRIM(company)
FROM layoffs_staging1 ;

UPDATE layoffs_staging1
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging1 
ORDER BY 1 ;

SELECT *
FROM layoffs_staging1 
WHERE industry LIKE 'Crypto%' ;

UPDATE layoffs_staging1
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging1 
ORDER BY 1 ;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging1 
ORDER BY 1 ;

UPDATE layoffs_staging1
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date` ,
str_to_date(`date`, '%m/%d/%Y' )
FROM layoffs_staging1 ;

UPDATE layoffs_staging1
SET  `date` = str_to_date(`date`, '%m/%d/%Y' ) ;

SELECT `date`
FROM layoffs_staging1 ;

ALTER TABLE  layoffs_staging1
MODIFY COLUMN `date` DATE ;

SELECT *
FROM layoffs_staging1 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging1 
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging1
WHERE company = 'Airbnb' ;

SELECT t1.industry, t2.industry
FROM layoffs_staging1 t1
JOIN layoffs_staging1 t2
  ON t1.company = t2.company 
  AND t1.location = t2.location
WHERE ( t1.industry IS NULL OR t1.industry = '' )
AND t2.industry IS NOT NULL ;

UPDATE layoffs_staging1
SET industry = NULL 
WHERE industry = '' ;

UPDATE layoffs_staging1 t1
JOIN layoffs_staging1 t2
        ON t1.company = t2.company 
SET  t1.industry =  t2.industry
WHERE  t1.industry IS NULL
AND t2.industry IS NOT NULL ;

SELECT *
FROM layoffs_staging1
WHERE company LIKE 'Bally%' ;

SELECT *
FROM layoffs_staging1 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging1 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging1 ;

ALTER TABLE layoffs_staging1
DROP COLUMN row_num ;