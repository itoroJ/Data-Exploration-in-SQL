SELECT * 
FROM jamb_exam_results_staging;

-- COUNTING STUDENTS
SELECT COUNT(*) AS total_students
FROM jamb_exam_results_staging;

-- AVERAGE JAMB SCORE
SELECT AVG(JAMB_Score) AS average_jamb_score
FROM jamb_exam_results_staging;

-- DISTINCT SCHOOL TYPES 
SELECT DISTINCT School_Type
FROM jamb_exam_results_staging;

-- COUNTING GENDERS
SELECT DISTINCT Gender, COUNT(gender)
FROM jamb_exam_results_staging
GROUP BY(gender);

-- SORTING BY GENDER
SELECT *
FROM jamb_exam_results_staging
WHERE Gender = 'Male';

SELECT *
FROM jamb_exam_results_staging
WHERE Gender = 'Female';

-- BASIC SUMMARY
SELECT 
    AVG(JAMB_Score) AS avg_score, 
    MIN(JAMB_Score) AS min_score, 
    MAX(JAMB_Score) AS max_score,
    AVG(Study_Hours_Per_Week) AS avg_study_hours, 
    AVG(Attendance_Rate) AS avg_attendance_rate
FROM jamb_exam_results_staging;

-- FINDING CORRELATION BETWEEN JAMB SCORE AND STUDY HOURS
SELECT 
    (SUM((JAMB_Score - avg_jamb) * (Study_Hours_Per_Week - avg_study_hours)) / COUNT(*)) / 
    (STD(JAMB_Score) * STD(Study_Hours_Per_Week)) AS correlation
FROM jamb_exam_results_staging,
    (SELECT AVG(JAMB_Score) AS avg_jamb, AVG(Study_Hours_Per_Week) AS avg_study_hours
     FROM jamb_exam_results_staging) averages;

-- AVERAGE SCORE FOR STUDENTS BASED ON WHETHER THEY HAD EXTRA LESSONS
SELECT Extra_Tutorials, AVG(JAMB_Score) AS avg_score
FROM jamb_exam_results_staging
GROUP BY Extra_Tutorials;

-- AVERAGE JAMB SCORE BASED ON SCHOOL TYPE AND LOCATION
SELECT School_Type, School_Location, AVG(JAMB_Score) AS avg_score
FROM jamb_exam_results_staging
GROUP BY School_Type, School_Location;

-- MOVING AVERAGE OF JAMB SCORE BASED ON ATTENANCE RATE
SELECT Student_ID, JAMB_Score, Attendance_Rate,
       AVG(JAMB_Score) OVER (ORDER BY Attendance_Rate) AS running_avg_score
FROM jamb_exam_results_staging;

-- STUDENTS WHO ARE OLDER THAN 18 AND SCORED ABOVE AVERAGE
SELECT *
FROM jamb_exam_results_staging
WHERE Age > 18 AND JAMB_Score > (SELECT AVG(JAMB_Score) FROM jamb_exam_results_staging);

-- STUDENTS WHO ARE YOUNGER THAN 18 AND SCORED ABOVE AVERAGE
SELECT *
FROM jamb_exam_results_staging
WHERE Age < 18 AND JAMB_Score > (SELECT AVG(JAMB_Score) FROM jamb_exam_results_staging);

-- PERCENTAGE OF STUDENTS WHO SCORED ABOVE 200 AND ATTENDED EXTRA CLASSES
SELECT 
    100.0 * SUM(CASE WHEN JAMB_Score > 200 AND Extra_Tutorials = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS percentage_above_200
FROM jamb_exam_results_staging;

-- PERCENTAGE OF STUDENTS WHO SCORED ABOVE 200 AND DIDN'T ATTENDED EXTRA CLASSES
SELECT 
    100.0 * SUM(CASE WHEN JAMB_Score > 200 AND Extra_Tutorials = 'No' THEN 1 ELSE 0 END) / COUNT(*) AS percentage_above_200
FROM jamb_exam_results_staging;

-- 	TOP PERFORMING STUDENTS BASED ON STUDY HOURS AND ATTENDANCE RATES 
SELECT Student_ID, JAMB_Score, Study_Hours_Per_Week, Attendance_Rate
FROM jamb_exam_results_staging
WHERE Study_Hours_Per_Week > (SELECT AVG(Study_Hours_Per_Week) FROM jamb_exam_results_staging)
  AND Attendance_Rate > (SELECT AVG(Attendance_Rate) FROM jamb_exam_results_staging)
ORDER BY JAMB_Score DESC;

-- TOP 25 STUDENTS FOR BOTH JAMB SCORE AN ATTENDANCE RATES 
WITH TopStudents AS (
    SELECT *, 
           NTILE(4) OVER (ORDER BY JAMB_Score DESC) AS score_quartile,
           NTILE(4) OVER (ORDER BY Attendance_Rate DESC) AS attendance_quartile
    FROM jamb_exam_results_staging
)
SELECT Student_ID, JAMB_Score, Attendance_Rate, Study_Hours_Per_Week
FROM TopStudents
WHERE score_quartile = 1 AND attendance_quartile = 1
ORDER BY Study_Hours_Per_Week DESC;




