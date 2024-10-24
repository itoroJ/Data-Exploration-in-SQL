SELECT * 
FROM nigeria_houses_data_staging2;

-- COUNTING LISTED PROPERTIES
SELECT COUNT(*) AS total_properties
FROM nigeria_houses_data_staging2;

-- AVERAGE PRICES OF PROPERTIES
SELECT AVG(price) AS average_price
FROM nigeria_houses_data_staging2;

-- FILTER BY STATE
SELECT *
FROM nigeria_houses_data_staging2
WHERE state = 'Lagos';

-- DISTINCT STATE COUNT
SELECT COUNT(DISTINCT state) AS distinct_state_count
FROM nigeria_houses_data_staging2;

-- PROPERTIES PER STATE
SELECT state, COUNT(*) AS property_count
FROM nigeria_houses_data_staging2
GROUP BY state
ORDER BY 2 DESC;

-- AVERAGE PRICE PER STATE
SELECT state, AVG(price) AS average_price
FROM nigeria_houses_data_staging2
GROUP BY state
ORDER BY 2 DESC;

-- PROPERTIES WITH MORE THAN 3 BEDROOMS AND LESS THAN 2 BATHROOMS
SELECT *
FROM nigeria_houses_data_staging2
WHERE bedrooms > 3 AND bathrooms < 2;

-- NUMBER OF PROPERTIES PER TOWN
SELECT town, COUNT(*) AS total_properties
FROM nigeria_houses_data_staging2
GROUP BY town
ORDER BY 2 DESC;

-- MAXIMUN PRICE OF PROPERTIES PER STATE
SELECT state, MAX(price) AS max_price
FROM nigeria_houses_data_staging2
GROUP BY state
ORDER BY 2 DESC;

-- PROPERTIES WITH PARKING SPACE 
SELECT *
FROM nigeria_houses_data_staging2
WHERE parking_space > 0
ORDER BY price DESC;

-- AVERAGE NUMBER OF BATHROOMS FOR PROPERTIES WITH MORE THAN 2 BEDROOMS
SELECT state, AVG(bathrooms) AS average_bathrooms
FROM nigeria_houses_data_staging2
WHERE bedrooms > 2
GROUP BY state
ORDER BY 2 DESC;

-- PRICE PER BEDROOM 
SELECT *, price / bedrooms AS price_per_bedroom
FROM nigeria_houses_data_staging2
ORDER BY price_per_bedroom DESC
LIMIT 20;

-- PROPERTIES WITH PRICE ABOVE AVERAGE PER STATE 
SELECT *
FROM nigeria_houses_data_staging2 p
WHERE price > (
    SELECT AVG(price)
    FROM nigeria_houses_data_staging2
    WHERE state = p.state
);

-- SORTING
SELECT *
FROM nigeria_houses_data_staging2
WHERE bedrooms >= 3 AND parking_space >= 2
ORDER BY town, price ASC;

-- 	TOWNS WHERE AVERAGE PRICE OF PROPERTIES IS HOGHER THAN AVERAGE PRICE
SELECT town
FROM nigeria_houses_data_staging2
GROUP BY town
HAVING AVG(price) > (SELECT AVG(price) FROM nigeria_houses_data_staging2);

-- COUNTING THE TOWNS 
SELECT COUNT(*) AS towns_above_average
FROM (
    SELECT town
    FROM nigeria_houses_data_staging2
    GROUP BY town
    HAVING AVG(price) > (SELECT AVG(price) FROM nigeria_houses_data_staging2)
) AS towns_with_high_avg_price;

-- TOP 5 TOWNS WITH HIGHEST AVERAGE PROPERTY PRICES
WITH TownAveragePrices AS (
    SELECT town, AVG(price) AS average_price
    FROM nigeria_houses_data_staging2
    GROUP BY town
)
SELECT *
FROM TownAveragePrices
ORDER BY average_price DESC
LIMIT 5;

-- MEDIAM PRICE OF PROPERTIES BY STATE
SELECT state, 
       SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(price ORDER BY price), ',', ROUND(COUNT(*)/2)), ',', -1) AS median_price
FROM nigeria_houses_data_staging2
GROUP BY state;

-- STATES WHERE NUMBER OF PROPERTIES WITH PARKING SPACES EXCEE THOSE WITHOUT 
SELECT state
FROM nigeria_houses_data_staging2
GROUP BY state
HAVING SUM(CASE WHEN parking_space > 0 THEN 1 ELSE 0 END) > SUM(CASE WHEN parking_space = 0 THEN 1 ELSE 0 END);

-- RANKING PROPERTIES BY PRICE PER STATE 
SELECT *, 
       RANK() OVER (PARTITION BY state ORDER BY price DESC) AS price_rank
FROM nigeria_houses_data_staging2;










