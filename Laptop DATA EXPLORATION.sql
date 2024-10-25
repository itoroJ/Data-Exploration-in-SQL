-- REALLY EXPLORED THIS ONE BECAUSE I LIKE THE DATASET 

SELECT * 
FROM laptopdata;

-- LAPTOPS MADE BY DELL OR SPECIFIC COMPANY
SELECT * 
	FROM laptopdata 
	WHERE Company = 'Dell';

-- LAPTOPS BY SCREEN SIZE
SELECT * 
	FROM laptopdata 
	WHERE Inches = 15;
    
  -- SORTING BY SCREEN RESOLUTION
  SELECT * 
	  FROM laptopdata 
	  WHERE ScreenResolution = '1920x1080';
      
-- SORTING BY WEIGHT 
SELECT COUNT(*) 
	FROM laptopdata
	WHERE Weight < 2;

-- TOP 5 MOST EXPENSIVE LAPTOPS
SELECT * 
	FROM laptopdata 
	ORDER BY Price DESC 
	LIMIT 5;

-- LAPTOPS PRODUCED BY COMPANY 
SELECT Company, COUNT(*) AS Units_Produced
	FROM laptopdata 
	GROUP BY Company
    ORDER BY Units_Produced DESC;
    
-- LAPTOPS WITH SSD
SELECT * 
	FROM laptopdata 
	WHERE Memory LIKE '%SSD%';

-- LAPTOPS RUNNING ON WINDOWS 
SELECT * 
	FROM laptopdata 
	WHERE OpSys LIKE 'Windows%';
    
-- DISTINCE OPERATING SYSTEMS
SELECT COUNT(DISTINCT OpSys) 
	FROM laptopdata;
    
-- PERCENTAGE OF LAPTOPS MADE BY APPLE
SELECT (
COUNT(*) * 100.0 / (SELECT COUNT(*) FROM laptopdata)
) AS ApplePercentage 
FROM laptopdata 
WHERE Company = 'Apple';

-- AVERAGE SCREEN SIZE BY LAPTOP
SELECT TypeName, AVG(Inches) AS avg_screen_size
	FROM laptopdata 
	GROUP BY TypeName
    ORDER BY avg_screen_size;

-- PRICE DIFFERENT BTW MOST AND LEAST EXPENSIVE LAPTOP
SELECT (
MAX(Price) - MIN(Price)
) AS PriceDifference 
FROM laptopdata;

-- TOP 3 COMPANIES BY LAPTOPS PRODUCED
SELECT Company, COUNT(*) AS Laptops_Produced
	FROM laptopdata 
	GROUP BY Company 
	ORDER BY Laptops_Produced DESC 
	LIMIT 3;

-- CHEAPEST GAMING LAPTOP
SELECT * 
	FROM laptopdata 
	WHERE TypeName = 'Gaming' 
	ORDER BY Price ASC 
	LIMIT 1;

-- RATIO OF SSDs to HDDs MEMORY
SELECT 
    (SUM(CASE
        WHEN Memory LIKE '%SSD%' THEN SUBSTRING_INDEX(Memory, 'GB', 1)
        ELSE 0
    END) / SUM(CASE
        WHEN Memory LIKE '%HDD%' THEN SUBSTRING_INDEX(Memory, 'GB', 1)
        ELSE 0
    END)) AS SSD_HDD_Ratio
FROM
    laptopdata;
    
-- LAPTOPS WITH HIGHEST SCREEN RESOLUTION BUT COST LESS THAN AVERGE
SELECT *
	FROM laptopdata
WHERE ScreenResolution = (
    SELECT MAX(ScreenResolution)
        FROM laptopdata
        WHERE Price < (SELECT AVG(Price)
                FROM laptopdata)
);

-- COMPANIES PRODUCING MOR ETHAN 1 GPU
SELECT Company, COUNT(DISTINCT Gpu) as GpuTypes
	FROM laptopdata
	GROUP BY Company
	HAVING COUNT(DISTINCT Gpu) > 1
	ORDER BY GpuTypes DESC;

-- COMPANIES THAT PRODUCE HEAVY LAPTOPS WITH LOW RAM
SELECT Company 
	FROM laptopdata 
	WHERE Ram < '8GB' 
	ORDER BY Weight DESC 
	LIMIT 1;

-- MOST COMMON OPERATING SYSTEMS
SELECT OpSys, COUNT(DISTINCT Company) AS CompanyCount
	FROM laptopdata
	GROUP BY OpSys
	HAVING COUNT(DISTINCT Company) > 5
    ORDER BY CompanyCount DESC;

-- LAPTOP TYPE WITH HIGHEST PRICE VARIANCE 
SELECT TypeName, MAX(Price) - MIN(Price) AS PriceVariance
	FROM laptopdata
	GROUP BY TypeName
	ORDER BY PriceVariance DESC
	LIMIT 1;

-- CHEAPEST LAPTOPS WITH HIGH RESOLUTION
SELECT *
	FROM laptopdata
	WHERE ScreenResolution > '1920x1080'
	ORDER BY Price ASC
	LIMIT 3;

-- CORRELATION BETWEEN SCREEN SIZE AND PRICE 
SELECT 
    (AVG(Inches * Price) - AVG(Inches) * AVG(Price)) / 
    (STDDEV(Inches) * STDDEV(Price)) AS CorrelationCoefficient
FROM laptopdata;

-- MOST COMMON LAPTOP CONFIGURATION
SELECT `Cpu`,Ram, `Memory`, Gpu, COUNT(*) AS Occurrence
	FROM laptopdata
	GROUP BY `Cpu`,Ram, `Memory`, Gpu
	ORDER BY Occurrence DESC
	LIMIT 1;

-- TOP 10% OF LAPTOPS
WITH RankedLaptops AS (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY Price DESC) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM laptopdata
),
Top10PercentLaptops AS (
    SELECT *
    FROM RankedLaptops
    WHERE row_num <= total_count * 0.1
)
SELECT 
    AVG(Inches) AS AvgScreenSize, 
    AVG(Weight) AS AvgWeight, 
    AVG(Price) AS AvgPrice
FROM Top10PercentLaptops;

-- PRICE TO PERFORMANCE RATIO
SELECT *, (
SUBSTRING_INDEX(Ram, 'GB', 1) * ScreenResolution
) / Price AS PriceToPerformanceRatio
FROM laptopdata
ORDER BY PriceToPerformanceRatio DESC
LIMIT 5;

-- LIGHTEST LAPTOPS WITH DEDICATED GPU
SELECT *
	FROM laptopdata
	WHERE Gpu LIKE '%Nvidia%' OR Gpu LIKE '%AMD%'
	ORDER BY Weight ASC
	LIMIT 5;

