#  SQL Data Analytics Portfolio

### Data Cleaning + Exploratory Data Analysis using MySQL

---

##  About Me
**Riddhima Nath** | B.Com Student, Allahabad University | McKinsey Forward Scholar  
Aspiring Business & Data Analyst | [LinkedIn](https://www.linkedin.com/in/riddhima-nath/)

---

##  Overview
This repository contains two end-to-end SQL projects built on a real-world tech industry layoffs dataset. The projects cover the complete data analytics workflow — from raw messy data to clean, structured insights using advanced SQL techniques.

---

##  Repository Structure
```
├── Data_Cleaning_portfolio.sql   # Project 1 - Data Cleaning
├── SQL_EDA_Project.sql           # Project 2 - Exploratory Data Analysis
└── README.md                     # Project documentation
```

---

##  Dataset
- **Source:** Real-world Tech Industry Layoffs Data (2020–2023)
- **Records:** 2,361 raw records → 1,995 after cleaning
- **Columns:** Company, Location, Industry, Total Laid Off, Percentage Laid Off, Date, Stage, Country, Funds Raised (Millions)

---

##  Tools Used
| Tool | Purpose |
|---|---|
| MySQL | Database management and querying |
| MySQL Workbench | Development environment |
| SQL | Data cleaning and analysis |

---

##  Project 1 — Data Cleaning

### Objective
Transform a raw, messy layoffs dataset into a clean, analysis-ready table using industry-standard data cleaning techniques.

### Steps Performed

**1. Remove Duplicates**
- Created a staging table to preserve raw data backup
- Used `ROW_NUMBER()` with `PARTITION BY` to detect duplicate records
- Used `COALESCE()` to handle NULL values during duplicate detection
- Removed 366 duplicate/irrelevant rows

**2. Standardize the Data**
- Trimmed leading/trailing whitespace from company names using `TRIM()`
- Standardized industry names (e.g., merged "Crypto", "Crypto Currency" → "Crypto")
- Fixed country name inconsistencies (e.g., "United States." → "United States")
- Converted date column from TEXT format to proper DATE type using `STR_TO_DATE()`

**3. Handle NULL & Blank Values**
- Identified NULL and blank industry values
- Used a self JOIN to populate missing industry values from matching company records
- Removed rows where both `total_laid_off` and `percentage_laid_off` were NULL (unusable records)

**4. Remove Unnecessary Columns**
- Dropped the `row_num` helper column after duplicate removal

### Key SQL Concepts Used
- `ROW_NUMBER()` Window Function
- `PARTITION BY`
- `COALESCE()` for NULL handling
- Self JOINs
- `STR_TO_DATE()` date conversion
- `ALTER TABLE` / `DROP COLUMN`
- Staging table approach for data safety

---

##  Project 2 — Exploratory Data Analysis (EDA)

### Objective
Analyze the cleaned layoffs dataset to uncover patterns in tech industry layoffs across companies, industries, countries, and time periods.

### Analysis Performed

**1. Basic Exploration**
- Identified maximum layoffs in a single event
- Found companies with 100% layoff rate (complete shutdowns) ordered by funding raised
- Key Finding: Several well-funded startups went completely bankrupt

**2. Company Level Analysis**
- Ranked companies by total layoffs across entire dataset
- Amazon, Google, Meta led in total workforce reductions

**3. Industry Level Analysis**
- Consumer and Retail industries hit hardest overall
- Finance and Healthcare showed relatively lower layoff rates

**4. Country Level Analysis**
- United States accounted for the vast majority of tech layoffs globally
- India ranked second — significant given its large tech workforce

**5. Time Series Analysis**
- Year-wise and month-wise layoff trends identified
- 2022–2023 saw the peak of tech layoffs post-COVID correction

**6. Rolling Totals**
- Built a month-by-month rolling total of layoffs using CTE + Window Function
- Revealed the accelerating pace of layoffs through 2022-2023

**7. Ranking Analysis**
- Built a double CTE with `DENSE_RANK()` to find Top 5 companies with highest layoffs per year
- Identified which companies dominated layoffs in each specific year

### Key SQL Concepts Used
- Common Table Expressions (CTEs)
- Window Functions (`DENSE_RANK()`, `SUM() OVER()`)
- `PARTITION BY` + `ORDER BY` in Window Functions
- `GROUP BY` with aggregate functions
- `SUBSTRING()` for date manipulation
- Rolling totals using `SUM() OVER(ORDER BY)`
- Subqueries and nested CTEs

---

##  Key Business Insights

1. **Funding ≠ Survival** - Several companies with $1B+ in funding still laid off 100% of employees
2. **2022-2023 was the worst period** - Post-COVID correction triggered a massive wave of tech layoffs
3. **Consumer & Retail hit hardest** - Direct-to-consumer businesses were most vulnerable
4. **US dominates global tech layoffs** - Over 70% of recorded layoffs occurred in the United States
5. **Late-stage companies cut deepest** - Post-IPO companies showed higher absolute layoff numbers

---

##  How to Run

**Prerequisites:** MySQL or MySQL Workbench installed

```sql
-- Step 1: Run Data Cleaning file first
SOURCE Data_Cleaning_portfolio.sql;

-- Step 2: Then run EDA file
SOURCE SQL_EDA_Project.sql;
```

**Note:** You will need the original `layoffs` dataset loaded in your MySQL database before running these scripts.

---

##  Connect With Me
-  [LinkedIn](https://www.linkedin.com/in/riddhima-nath/)
-  [Tableau Public](https://public.tableau.com/app/profile/riddhima.nath)
-  [IPO EDA Project](https://github.com/nathriddhima/Indian-IPO-EDA)

---
*This project was created as part of my Data Analytics portfolio following industry-standard SQL practices.*
