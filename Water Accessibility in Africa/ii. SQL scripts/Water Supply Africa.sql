CREATE DATABASE `Water Access and Sanitation(Africa)`;
USE `Water Access and Sanitation(Africa)`;
CREATE TABLE Water_Supply_Sanitation_Africa (
    Region VARCHAR(255),
    Country VARCHAR(255),
    `Community Name` VARCHAR(255),
    Population INT,
    `Water Source Type` VARCHAR(255),
    `Water Availability (liters per capita per day)` FLOAT,
    `Number of Functional Water Points` INT,
    `Number of Non-Functional Water Points` INT,
    `Sanitation Facility Type` VARCHAR(255),
    `Annual Maintenance Cost (USD)` INT,
    `Government Support` VARCHAR(10),
    `NGO Support` VARCHAR(10),
    `Average Distance to Water Source (km)` FLOAT,
    `Waterborne Diseases Incidence Rate (%)` FLOAT,
    `Community Satisfaction Rate (%)` FLOAT
);

-- 1. Calculate the average water availability (liters per capita per day) for each country. 
SELECT Country, ROUND(AVG(`Water Availability (liters per capita per day)`),2) AS "Avg Water Availability"
FROM Water_Supply_Sanitation_Africa
GROUP BY Country;

-- 2. Retrieve details of communities where at least one water point is non-functional 
SELECT Region, Country, `Community Name`, `Number of Non-Functional Water Points`
FROM Water_Supply_Sanitation_Africa
WHERE `Number of Non-Functional Water Points` > 0;

-- 3. Retrieve the top five communities with the highest annual sanitation maintenance costs
SELECT Region, Country, `Community Name`, `Annual Maintenance Cost (USD)`
FROM Water_Supply_Sanitation_Africa
ORDER BY `Annual Maintenance Cost (USD)` DESC
LIMIT 5;

-- 4. Calculate the total number of functional and non-functional water points per country
SELECT Country,
       SUM(`Number of Functional Water Points`) AS "Total of Functional Water Points",
       SUM(`Number of Non-Functional Water Points`) AS "Total of Non Functional Water Points"
FROM Water_Supply_Sanitation_Africa
GROUP BY Country;

-- 5. Identify communities with a high incidence rate of waterborne diseases (>20%)
SELECT Country, `Community Name`, `Waterborne Diseases Incidence Rate (%)`
FROM Water_Supply_Sanitation_Africa
WHERE `Waterborne Diseases Incidence Rate (%)` > 20;

-- 6. Find the average distance to the water source per region
SELECT Region, ROUND(AVG(`Average Distance to Water Source (km)`),2) AS "Avg Distance"
FROM Water_Supply_Sanitation_Africa
GROUP BY Region;

-- 7. List the communities that receive both government and NGO support
SELECT Country, `Community Name`, `Government Support`, `NGO Support`
FROM Water_Supply_Sanitation_Africa
WHERE `Government Support` = 'Yes' AND `NGO Support` = 'Yes';

-- 8. Identify the community with the highest population per country
SELECT Country, `Community Name`, Population
FROM (
    SELECT Country, `Community Name`, Population,
    RANK() OVER (PARTITION BY Country ORDER BY Population DESC) 
    AS rnk
    FROM Water_Supply_Sanitation_Africa
) ranked
WHERE rnk = 1;



















