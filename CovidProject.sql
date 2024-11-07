SELECT * FROM ..['covid-death$'] ORDER BY 3,4;

SELECT * FROM ..['covid-vaccination$'] ORDER BY 3,4;

-- Subseting the dataset for this analysis 

SELECT location, date, population, total_cases, total_deaths, new_cases
FROM ..['covid-death$']
ORDER BY 3,4;

-- Calculating the Total Covid Cases as to the total death recorded 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM ..['covid-death$']
WHERE total_cases!=0
ORDER BY 1,2;


SELECT location, date, total_cases, total_deaths, (total_cases-total_deaths) AS Case_Severity
FROM ..['covid-death$']
WHERE location like '%states%'
ORDER BY 1,2;


-- Computing the total cases as compared to the total population

SELECT location, date, total_cases, population, (total_cases/population)*100 AS PopulationPercentage
FROM ..['covid-death$']
--WHERE location like '%states%'
WHERE location = 'Nigeria'
ORDER BY 1,2


-- Computing for the Max cases

SELECT location, Max(total_cases) AS Max_Cases, population, MAX ((total_cases/population))*100 AS MaxPopulationPercentage
FROM ..['covid-death$']
--WHERE location like '%states%'
--WHERE location = 'Nigeria'
GROUP BY population, location
ORDER BY MaxPopulationPercentage DESC;


--COMPUTING COUNTRIES WITH THE HIGHEST DEATH COUNT

SELECT location, MAX(total_deaths) AS Max_DeathsCount
FROM ..['covid-death$']
--WHERE location like '%states%'
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Max_DeathsCount DESC;



SELECT location, SUM(total_deaths) AS Total_DeathsCount
FROM ..['covid-death$']
--WHERE location like '%states%'
--WHERE location = 'Nigeria'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Total_DeathsCount DESC;



-- COMPUTING CONTINENT WITH THE HIGHEST DEATH COUNT


-- JOINING BOTH TABLES

SELECT * 
FROM ..['covid-death$'] dea
JOIN ..['covid-vaccination$'] vac
ON dea.location = vac.location
AND dea.continent=vac.continent; 


-- COMPUTING THE TOTAL POPULATION AS COMPARED TO THE TOTAL PEOPLE VACCINATED
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM ..['covid-death$'] dea
JOIN ..['covid-vaccination$'] vac
ON dea.location = vac.location
AND dea.continent=vac.continent 
WHERE dea.continent IS NOT NULL; 