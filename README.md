# SQLite University Rankings Database Assignment

## Table of Contents
1. [Overview](#overview)
   - 1.1 [Files Structure](#files-structure)
   - 1.2 [Quick Start](#quick-start)
2. [Setup and Installation](#setup-and-installation)
   - 2.1 [Installing SQLite](#installing-sqlite)
   - 2.2 [Project Setup](#project-setup)
3. [How to Run](#how-to-run)
   - 3.1 [Method 1: Run All Queries at Once](#method-1-run-all-queries-at-once-recommended)
   - 3.2 [Method 2: Interactive Mode](#method-2-interactive-mode)
4. [Database Connection](#database-connection)
5. [Basic Analysis](#basic-analysis)
   - 5.1 [Query 1: Total Records](#query-1-total-records)
   - 5.2 [Query 2: Years Covered](#query-2-years-covered)
   - 5.3 [Query 3: Universities Per Year](#query-3-universities-per-year)
   - 5.4 [Query 4: Top 10 Universities](#query-4-top-10-universities-2015)
   - 5.5 [Query 5: Score Statistics](#query-5-score-statistics-by-year)
   - 5.6 [Query 6: Top Countries](#query-6-top-countries)
6. [CRUD Operations](#crud-operations)
   - 6.1 [CREATE - Insert Duke Tech](#1-create---insert-duke-tech)
   - 6.2 [READ - Japanese Universities](#2-read---japanese-universities-count)
   - 6.3 [UPDATE - Oxford Score](#3-update---oxford-score-correction)
   - 6.4 [DELETE - Low Scores](#4-delete---remove-low-scores)

---

## Overview
This assignment demonstrates database operations using SQLite with the University Rankings dataset (2012-2015).

## Files Structure
- `queries.sql` - All SQL queries used in this assignment
- `README.md` - This documentation file

## 

### Quick Start
```bash
# 1. Ensure SQLite is installed
sqlite3 --version

# 2. Navigate to project directory
cd sqlite-university-rankings

# 3. Run all queries
sqlite3 university_database.db < queries.sql
```

---

## Setup and Installation

### Installing SQLite

**macOS:**
SQLite comes pre-installed on macOS. Verify by running:
```bash
sqlite3 --version
```

If not installed:
```bash
brew install sqlite3
```

**Windows:**
1. Download SQLite from https://www.sqlite.org/download.html
2. Extract the zip file
3. Add the folder to your system PATH
4. Verify installation:
```cmd
sqlite3 --version
```

### Project Setup

1. **Clone or download this repository**
```bash
git clone <your-repo-url>
cd sqlite-university-rankings
```

2. **Verify you have the database file**
   - Ensure `university_database.db` is in your project directory
   - If not, download it from the course materials

3. **Verify the database**
```bash
sqlite3 university_database.db ".tables"
```
You should see: `university_rankings`

---

## How to Run

### Method 1: Run All Queries at Once (Recommended)

1. **Open terminal/command prompt in your project directory**

2. **Connect to the database and run the queries file**
```bash
sqlite3 university_database.db < queries.sql
```

This will execute all queries in sequence and display the results.

### Method 2: Interactive Mode

1. **Connect to the database**
```bash
sqlite3 university_database.db
```

2. **Run the queries file**
```sql
.read queries.sql
```

3. **Or run queries individually**
```sql
SELECT COUNT(*) FROM university_rankings;
-- ... continue with other queries
```

4. **Exit SQLite**
```sql
.exit
```

## Database Connection
Successfully connected to `university_database.db` using SQLite3.
- **Table name**: `university_rankings`
- **Columns**: world_rank, institution, country, national_rank, quality_of_education, alumni_employment, quality_of_faculty, publications, influence, citations, broad_impact, patents, score, year

---

## Basic Analysis

### Query 1: Total Records
**Analysis Query**
```sql
SELECT COUNT(*) as total_records FROM university_rankings;
```
**Result:** 2200

**Observation:** The database contains 2,200 university ranking records across all years.

---

### Query 2: Years Covered
**Analysis Query**
```sql
SELECT DISTINCT year FROM university_rankings ORDER BY year;
```
**Result:** 
- 2012
- 2013
- 2014
- 2015

**Observation:** The dataset covers four consecutive years from 2012 to 2015.

---

### Query 3: Universities Per Year
**Analysis Query**
```sql
SELECT year, COUNT(*) as university_count
FROM university_rankings
GROUP BY year
ORDER BY year;
```
**Result:** 
- 2012: 100 universities
- 2013: 100 universities
- 2014: 1,000 universities
- 2015: 1,000 universities

**Observation:** The dataset significantly expanded from 100 universities in 2012-2013 to 1,000 universities in 2014-2015, indicating a major increase in the scope of the rankings.

---

### Query 4: Top 10 Universities (2015)
**Analysis Query**
```sql
SELECT institution, country, world_rank, score
FROM university_rankings
WHERE year = 2015
ORDER BY world_rank
LIMIT 10;
```
**Result:**
1. Harvard University (USA) - 100.0
2. Stanford University (USA) - 98.66
3. Massachusetts Institute of Technology (USA) - 97.54
4. University of Cambridge (United Kingdom) - 96.81
5. University of Oxford (United Kingdom) - 96.46
6. Columbia University (USA) - 96.14
7. University of California, Berkeley (USA) - 92.25
8. University of Chicago (USA) - 90.7
9. Princeton University (USA) - 89.42
10. Cornell University (USA) - 86.79

---

### Query 5: Score Statistics by Year
**Analysis Query**
```sql
SELECT year, 
       ROUND(AVG(score), 2) as avg_score,
       MIN(score) as min_score,
       MAX(score) as max_score
FROM university_rankings
GROUP BY year
ORDER BY year;
```
**Result:**
- 2012: avg=54.94, min=43.36, max=100.0
- 2013: avg=55.27, min=44.26, max=100.0
- 2014: avg=47.27, min=44.18, max=100.0
- 2015: avg=46.86, min=44.02, max=100.0

---

### Query 6: Top Countries
**Analysis Query**
```sql
SELECT country, COUNT(*) as university_count
FROM university_rankings
GROUP BY country
ORDER BY university_count DESC
LIMIT 10;
```
**Result:**
1. USA: 573 universities
2. China: 167 universities
3. Japan: 159 universities
4. United Kingdom: 144 universities
5. Germany: 115 universities
6. France: 109 universities
7. Italy: 96 universities
8. Spain: 81 universities
9. South Korea: 72 universities
10. Canada: 72 universities

---

## CRUD Operations

### 1. CREATE - Insert Duke Tech

**INSERT Operation**
```sql
INSERT INTO university_rankings (
    institution,
    country,
    world_rank,
    year,
    score
) VALUES (
    'Duke Tech',
    'USA',
    350,
    2014,
    60.5
);
```

**Verification Query**
```sql
SELECT * FROM university_rankings 
WHERE institution = 'Duke Tech' AND year = 2014;
```

**Result:** 
```
350|Duke Tech|USA||||||||||60.5|2014
```

**What Changed:** Successfully inserted 1 new row for Duke Tech university into the 2014 rankings. The university was assigned world rank 350 with a score of 60.5. Other columns (national_rank, quality metrics, etc.) were left NULL as they were not specified.

---

### 2. READ - Japanese Universities Count

**SELECT Query**
```sql
SELECT COUNT(*) as japan_universities_top_200
FROM university_rankings
WHERE country = 'Japan' 
    AND year = 2013
    AND world_rank <= 200;
```

**Result:** 6

**Detail Query**
```sql
SELECT institution, world_rank, score
FROM university_rankings
WHERE country = 'Japan' 
    AND year = 2013
    AND world_rank <= 200
ORDER BY world_rank;
```

**Result:**
1. University of Tokyo - Rank 14 - Score 76.23
2. Kyoto University - Rank 15 - Score 69.46
3. Osaka University - Rank 35 - Score 52.79
4. Keio University - Rank 70 - Score 47.05
5. Nagoya University - Rank 91 - Score 44.78
6. Tohoku University - Rank 95 - Score 44.52

**Observation:** Japan had 6 universities in the global top 200 in 2013. The University of Tokyo and Kyoto University were the highest-ranked Japanese institutions at positions 14 and 15, with scores above 69. The remaining 4 universities ranged from rank 35 to 95, showing strong representation in the top 100.

---

### 3. UPDATE - Oxford Score Correction

**Before Update - Check Current Value**
```sql
SELECT institution, year, score
FROM university_rankings
WHERE institution = 'University of Oxford' AND year = 2014;
```
**Result:** University of Oxford | 2014 | 97.51

**UPDATE Operation**
```sql
UPDATE university_rankings
SET score = score + 1.2
WHERE institution = 'University of Oxford' AND year = 2014;
```

**After Update - Verify Changes**
```sql
SELECT institution, year, score
FROM university_rankings
WHERE institution = 'University of Oxford' AND year = 2014;
```
**Result:** University of Oxford | 2014 | 98.71

**What Changed:** Successfully updated 1 row. University of Oxford's 2014 score increased from 97.51 to 98.71 (an increase of 1.2 points). This correction reflects the ranking committee's revised calculation for Oxford's 2014 performance.

---

### 4. DELETE - Remove Low Scores

**Before Delete - Count Affected Rows**
```sql
SELECT COUNT(*) as rows_to_delete
FROM university_rankings
WHERE year = 2015 AND score < 45;
```
**Result:** 556 rows

**Preview Records to be Deleted**
```sql
SELECT institution, country, world_rank, score
FROM university_rankings
WHERE year = 2015 AND score < 45
ORDER BY score
LIMIT 10;
```
**Result:** 
- University of A Coruña (Spain) - Rank 999 - Score 44.02
- China Pharmaceutical University (China) - Rank 1000 - Score 44.02
- Xidian University (China) - Rank 991 - Score 44.03
- Federal University of Bahia (Brazil) - Rank 992 - Score 44.03
- Southwest Jiaotong University (China) - Rank 993 - Score 44.03
- Ryerson University (Canada) - Rank 994 - Score 44.03
- King Abdulaziz University (Saudi Arabia) - Rank 995 - Score 44.03
- University of the Algarve (Portugal) - Rank 996 - Score 44.03
- Alexandria University (Egypt) - Rank 997 - Score 44.03
- Federal University of Ceará (Brazil) - Rank 998 - Score 44.03

**DELETE Operation**
```sql
DELETE FROM university_rankings
WHERE year = 2015 AND score < 45;
```

**Verify Deletion - Should Return 0**
```sql
SELECT COUNT(*) as remaining_low_scores
FROM university_rankings
WHERE year = 2015 AND score < 45;
```
**Result:** 0

**What Changed:** Successfully deleted 556 rows from the 2015 rankings. All universities with scores below 45 were removed from the dataset. These were primarily lower-ranked universities (ranks 991-1000) from various countries. After deletion, the 2015 dataset now contains only 444 universities (down from 1,000), all with scores of 45 or higher, as per the ranking committee's decision.

---