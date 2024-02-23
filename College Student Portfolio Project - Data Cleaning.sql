-- Find Relevant Information

SELECT *
FROM food_coded;

-- GPA Condensed 

Select FORMAT(GPA ,1) AS GPA
FROM FOOD_CODED;

-- Gender is Male Or Female

SELECT IF(Gender = 1,"F","M") As Gender
FROM FOOD_CODED;

-- Do they cook?

SELECT Cook,
CASE
	WHEN COOK = 1 THEN "Every Day"
    WHEN COOK = 2 THEN "Occasionally"
    WHEN COOK = 3 THEN "Not very often"
    WHEN COOK = 4 THEN "I only help"
    WHEN COOK = 5 THEN "Never"
    ELSE "N/A"
END AS Cooking
FROM FOOD_CODED;

-- Do they take daily vitamins?

SELECT IF(vitamins = 1,"Yes","No") As DailyVitamins
FROM FOOD_CODED;

-- Do they play sports?

SELECT IF(sports = 1,"Yes","No") As SportsActivity
FROM FOOD_CODED;

-- How many vegetables are eaten a day?

SELECT veggies_day,
CASE
	WHEN on_off_campus = 1 THEN "Very unlikely"
    WHEN on_off_campus = 2 THEN "Unlikely "
    WHEN on_off_campus = 3 THEN "Neutral"
    WHEN on_off_campus = 4 THEN "Likely"
	WHEN on_off_campus = 5 THEN "Very likely"
    ELSE "N/A"
END AS DailyVegetables
FROM FOOD_CODED;

-- Do they live on or off campus?

SELECT on_off_campus,
CASE
	WHEN on_off_campus = 1 THEN "On campus"
    WHEN on_off_campus = 2 THEN "Rent out of campus"
    WHEN on_off_campus = 3 THEN "Live with my parents and commute"
    WHEN on_off_campus = 4 THEN "Own my own house"
    ELSE "N/A"
END AS HousingSituation
FROM FOOD_CODED;

-- Do they exercise?

SELECT Exercise,
CASE
	WHEN Exercise = 1 THEN "Every Day"
    WHEN Exercise = 2 THEN "Twice or three times per week"
    WHEN Exercise = 3 THEN "Once a week"
    WHEN Exercise = 4 THEN "Sometimes"
    WHEN Exercise = 5 THEN "Never"
    ELSE "N/A"
END AS DailyExercise
FROM FOOD_CODED;

-- What is their weight?

SELECT TRIM(SUBSTRING(WEIGHT,1,3)) AS Weight
FROM food_coded
WHERE WEIGHT >=1;

-- How often do they eat out?
SELECT Eating_out,
CASE
	WHEN Eating_out = 1 THEN "Never"
    WHEN Eating_out = 2 THEN "1-2 times"
    WHEN Eating_out = 3 THEN "2-3 times"
    WHEN Eating_out = 4 THEN "3-5 times"
    WHEN Eating_out = 5 THEN "Every Day"
    ELSE "N/A"
END AS EatingOutPerWeek
FROM FOOD_CODED;

-- What Grade are they?
SELECT grade_level,
CASE
	WHEN grade_level = 1 THEN "1"
    WHEN grade_level = 2 THEN "2"
    WHEN grade_level = 3 THEN "3"
    WHEN grade_level = 4 THEN "4"
    ELSE "N/A"
END AS Grade
FROM FOOD_CODED;



-- Table of all accumulated Data

Select FORMAT(GPA ,1) AS GPA, IF(Gender = 1,"F","M") As Gender, IF(vitamins = 1,"Yes","No") As DailyVitamins, IF(sports = 1,"Yes","No") As SportsActivity, TRIM(SUBSTRING(WEIGHT,1,3)) AS Weight,
CASE
	WHEN on_off_campus = 1 THEN "Very unlikely"
    WHEN on_off_campus = 2 THEN "Unlikely "
    WHEN on_off_campus = 3 THEN "Neutral"
    WHEN on_off_campus = 4 THEN "Likely"
	WHEN on_off_campus = 5 THEN "Very likely"
    ELSE "N/A"
END AS DailyVegetables,
CASE
	WHEN on_off_campus = 1 THEN "On campus"
    WHEN on_off_campus = 2 THEN "Rent out of campus"
    WHEN on_off_campus = 3 THEN "Live with my parents and commute"
    WHEN on_off_campus = 4 THEN "Own my own house"
    ELSE "N/A"
END AS HousingSituation,
CASE
	WHEN Eating_out = 1 THEN "Never"
    WHEN Eating_out = 2 THEN "1-2 times "
    WHEN Eating_out = 3 THEN "2-3 times"
    WHEN Eating_out = 4 THEN "3-5 times"
    WHEN Eating_out = 5 THEN "Every Day"
    ELSE "N/A"
END AS EatingOutPerWeek,
CASE
	WHEN Exercise = 1 THEN "Every Day"
    WHEN Exercise = 2 THEN "Twice or three times per week"
    WHEN Exercise = 3 THEN "Once a week"
    WHEN Exercise = 4 THEN "Sometimes"
    WHEN Exercise = 5 THEN "Never"
    ELSE "N/A"
END AS ExerciseFreq,
CASE
	WHEN COOK = 1 THEN "Every Day"
    WHEN COOK = 2 THEN "Occasionally"
    WHEN COOK = 3 THEN "Not very often"
    WHEN COOK = 4 THEN "I only help"
    WHEN COOK = 5 THEN "Never"
    ELSE "N/A"
END AS CookingFreq,
CASE
	WHEN grade_level = 1 THEN "1"
    WHEN grade_level = 2 THEN "2"
    WHEN grade_level = 3 THEN "3"
    WHEN grade_level = 4 THEN "4"
    ELSE "N/A"
END AS YearInCollege
FROM Food_coded
WHERE Weight >= 1
ORDER BY YearInCollege;

-- Creating CTE

WITH CollegeFoodHabits (GPA, Gender, DailyVitamins, SportsActivity, Weight, DailyVegetables, HousingSituation, EatingOutPerWeek, ExerciseFreq, CookingFreq, YearInCollege)
AS
(
Select FORMAT(GPA ,1) AS GPA,
IF(Gender = 1,"F","M") As Gender, 
IF(vitamins = 1,"Yes","No") As DailyVitamins, 
IF(sports = 1,"Yes","No") As SportsActivity, 
TRIM(SUBSTRING(WEIGHT,1,3)) AS Weight,
CASE
	WHEN on_off_campus = 1 THEN "Very unlikely"
    WHEN on_off_campus = 2 THEN "Unlikely "
    WHEN on_off_campus = 3 THEN "Neutral"
    WHEN on_off_campus = 4 THEN "Likely"
	WHEN on_off_campus = 5 THEN "Very likely"
    ELSE "N/A"
END AS DailyVegetables,
CASE
	WHEN on_off_campus = 1 THEN "On campus"
    WHEN on_off_campus = 2 THEN "Rent out of campus"
    WHEN on_off_campus = 3 THEN "Live with my parents and commute"
    WHEN on_off_campus = 4 THEN "Own my own house"
    ELSE "N/A"
END AS HousingSituation,
CASE
	WHEN Eating_out = 1 THEN "Never"
    WHEN Eating_out = 2 THEN "1-2 times "
    WHEN Eating_out = 3 THEN "2-3 times"
    WHEN Eating_out = 4 THEN "3-5 times"
    WHEN Eating_out = 5 THEN "Every Day"
    ELSE "N/A"
END AS EatingOutPerWeek,
CASE
	WHEN Exercise = 1 THEN "Every Day"
    WHEN Exercise = 2 THEN "Twice or three times per week"
    WHEN Exercise = 3 THEN "Once a week"
    WHEN Exercise = 4 THEN "Sometimes"
    WHEN Exercise = 5 THEN "Never"
    ELSE "N/A"
END AS ExerciseFreq,
CASE
	WHEN COOK = 1 THEN "Every Day"
    WHEN COOK = 2 THEN "Occasionally"
    WHEN COOK = 3 THEN "Not very often"
    WHEN COOK = 4 THEN "I only help"
    WHEN COOK = 5 THEN "Never"
    ELSE "N/A"
END AS CookingFreq,
CASE
	WHEN grade_level = 1 THEN "1"
    WHEN grade_level = 2 THEN "2"
    WHEN grade_level = 3 THEN "3"
    WHEN grade_level = 4 THEN "4"
    ELSE "N/A"
END AS YearInCollege
FROM Food_coded
WHERE Weight >= 1
)

-- CTE CREATED
SELECT *
FROM CollegeFoodHabits
ORDER BY YearInCollege;


-- Creating View for Visualzation

CREATE VIEW CollegeStudentFoodHabits as
Select FORMAT(GPA ,1) AS GPA,
IF(Gender = 1,"F","M") As Gender, 
IF(vitamins = 1,"Yes","No") As DailyVitamins, 
IF(sports = 1,"Yes","No") As SportsActivity, 
TRIM(SUBSTRING(WEIGHT,1,3)) AS Weight,
CASE
	WHEN on_off_campus = 1 THEN "Very unlikely"
    WHEN on_off_campus = 2 THEN "Unlikely "
    WHEN on_off_campus = 3 THEN "Neutral"
    WHEN on_off_campus = 4 THEN "Likely"
	WHEN on_off_campus = 5 THEN "Very likely"
    ELSE "N/A"
END AS DailyVegetables,
CASE
	WHEN on_off_campus = 1 THEN "On campus"
    WHEN on_off_campus = 2 THEN "Rent out of campus"
    WHEN on_off_campus = 3 THEN "Live with my parents and commute"
    WHEN on_off_campus = 4 THEN "Own my own house"
    ELSE "N/A"
END AS HousingSituation,
CASE
	WHEN Eating_out = 1 THEN "Never"
    WHEN Eating_out = 2 THEN "1-2 times "
    WHEN Eating_out = 3 THEN "2-3 times"
    WHEN Eating_out = 4 THEN "3-5 times"
    WHEN Eating_out = 5 THEN "Every Day"
    ELSE "N/A"
END AS EatingOutPerWeek,
CASE
	WHEN Exercise = 1 THEN "Every Day"
    WHEN Exercise = 2 THEN "Twice or three times per week"
    WHEN Exercise = 3 THEN "Once a week"
    WHEN Exercise = 4 THEN "Sometimes"
    WHEN Exercise = 5 THEN "Never"
    ELSE "N/A"
END AS ExerciseFreq,
CASE
	WHEN COOK = 1 THEN "Every Day"
    WHEN COOK = 2 THEN "Occasionally"
    WHEN COOK = 3 THEN "Not very often"
    WHEN COOK = 4 THEN "I only help"
    WHEN COOK = 5 THEN "Never"
    ELSE "N/A"
END AS CookingFreq,
CASE
	WHEN grade_level = 1 THEN "1"
    WHEN grade_level = 2 THEN "2"
    WHEN grade_level = 3 THEN "3"
    WHEN grade_level = 4 THEN "4"
    ELSE "N/A"
END AS YearInCollege
FROM Food_coded
WHERE Weight >= 1


