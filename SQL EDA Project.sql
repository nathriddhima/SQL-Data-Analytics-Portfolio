-- Exploratory Data Analytics 

-- 1. BASIC EXPLORATION

SELECT *
FROM layoffs_staging1 ;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging1 ;

SELECT *
FROM layoffs_staging1 
WHERE percentage_laid_off = 1 
ORDER BY funds_raised_millions DESC;

-- 2. COMPANY LEVEL ANALYSIS  

SELECT company, SUM(total_laid_off)
FROM layoffs_staging1 
GROUP BY company
ORDER BY 2 DESC ;

SELECT MIN(`date`), Max(`date`)
FROM layoffs_staging1 ;

-- 3. INDUSTRY LEVEL ANALYSIS

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging1 
GROUP BY industry
ORDER BY 2 DESC ;

SELECT *
FROM layoffs_staging1 ;

-- 4. COUNTRY LEVEL ANALYSIS

SELECT country, SUM(total_laid_off)
FROM layoffs_staging1 
GROUP BY country
ORDER BY 2 DESC ;

-- 5. TIME SERIES ANALYSIS

SELECT YEAR(`date`) AS Years, SUM(total_laid_off) AS Total_laid_off
FROM layoffs_staging1 
GROUP BY Years
ORDER BY 1 DESC ;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging1 
GROUP BY stage
ORDER BY 2 DESC ;


SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging1
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC;

-- 6. ROLLING TOTALS

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging1
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH` 
ORDER BY 1 ASC
)
SELECT `MONTH` , total_off
 ,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total ;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging1 
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- 7. RANKING ANALYSIS

WITH Company_Year(company, years, total_laid_off) AS
(
SELECT company, Year(`date`), SUM( total_laid_off)
FROM layoffs_staging1
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *,
 DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year 
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5 ;

-- END --
