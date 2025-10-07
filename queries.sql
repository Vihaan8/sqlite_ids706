-- ============================================
-- BASIC ANALYSIS
-- ============================================

-- Total records
SELECT COUNT(*) as total_records FROM university_rankings;

-- Years covered
SELECT DISTINCT year FROM university_rankings ORDER BY year;

-- Universities per year
SELECT year, COUNT(*) as university_count
FROM university_rankings
GROUP BY year
ORDER BY year;

-- Top 10 universities in 2015
SELECT institution, country, world_rank, score
FROM university_rankings
WHERE year = 2015
ORDER BY world_rank
LIMIT 10;

-- Average score by year
SELECT year, 
       ROUND(AVG(score), 2) as avg_score,
       MIN(score) as min_score,
       MAX(score) as max_score
FROM university_rankings
GROUP BY year
ORDER BY year;

-- Top countries by university count
SELECT country, COUNT(*) as university_count
FROM university_rankings
GROUP BY country
ORDER BY university_count DESC
LIMIT 10;


-- ============================================
-- CRUD OPERATION 1: CREATE (INSERT)
-- ============================================

-- Insert Duke Tech into 2014 rankings
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

-- Verify insertion
SELECT * FROM university_rankings 
WHERE institution = 'Duke Tech' AND year = 2014;


-- ============================================
-- CRUD OPERATION 2: READ
-- ============================================

-- Count Japanese universities in top 200 for 2013
SELECT COUNT(*) as japan_universities_top_200
FROM university_rankings
WHERE country = 'Japan' 
    AND year = 2013
    AND world_rank <= 200;

-- View the universities
SELECT institution, world_rank, score
FROM university_rankings
WHERE country = 'Japan' 
    AND year = 2013
    AND world_rank <= 200
ORDER BY world_rank;


-- ============================================
-- CRUD OPERATION 3: UPDATE
-- ============================================

-- Check Oxford's current score (2014)
SELECT institution, year, score
FROM university_rankings
WHERE institution = 'University of Oxford' AND year = 2014;

-- Update: Increase score by 1.2 points
UPDATE university_rankings
SET score = score + 1.2
WHERE institution = 'University of Oxford' AND year = 2014;

-- Verify update
SELECT institution, year, score
FROM university_rankings
WHERE institution = 'University of Oxford' AND year = 2014;


-- ============================================
-- CRUD OPERATION 4: DELETE
-- ============================================

-- Count universities with score < 45 in 2015
SELECT COUNT(*) as rows_to_delete
FROM university_rankings
WHERE year = 2015 AND score < 45;

-- View universities to be deleted
SELECT institution, country, world_rank, score
FROM university_rankings
WHERE year = 2015 AND score < 45
ORDER BY score;

-- Delete records
DELETE FROM university_rankings
WHERE year = 2015 AND score < 45;

-- Verify deletion (should return 0)
SELECT COUNT(*) as remaining_low_scores
FROM university_rankings
WHERE year = 2015 AND score < 45;