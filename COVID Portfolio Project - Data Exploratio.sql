/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/


Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4;

-- Select Data that we are going to be starting with

SELECT Location, Date, total_cases, new_cases, total_deaths, Population
FROM PortfolioProject..CovidDeaths
ORDER by 1,2;

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT Location, Date, total_cases,total_deaths, 
(total_deaths/total_cases) * 100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2;


-- Looking at Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT Location, Date, total_cases, Population, 
(total_cases/population) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE total_cases <> 0 AND population <> 0
--WHERE location like '%states%'
ORDER BY 1,2;

-- Countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,
MAX(total_cases/population) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE total_cases <> 0 AND population <> 0
--WHERE location like '%states%'
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

SELECT Continent, MAX(Total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE Continent is not null
GROUP BY Continent
ORDER BY TotalDeathCount DESC;



-- GLOBAL NUMBERS

SELECT SUM(new_cases) as Total_cases, SUM(new_deaths) as Total_deaths, 
SUM(new_deaths)/SUM(New_cases) * 100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE Continent is not null AND new_cases is not null AND new_deaths is not null
--Group BY date
ORDER BY 1,2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.Continent, dea.Location, dea.Date, dea.Population, vac.New_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS RollingPeopleVaccinated,
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.Continent IS NOT NULL
ORDER BY 2,3;

-- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.Continent, dea.Location, dea.Date, dea.Population, vac.New_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.Continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population) * 100
FROM PopvsVac
WHERE RollingPeopleVaccinated <> 0


-- Using Temp Table to perform Calculation on Partition By in previous query


DROP Table if exists #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated
(
Contintent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations int,
RollingPeopleVaccinated numeric
);

INSERT INTO #PercentPopulationVaccinated
SELECT dea.Continent, dea.Location, dea.Date, dea.Population, vac.New_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.Continent IS NOT NULL
--ORDER BY 2,3;


SELECT *, (RollingPeopleVaccinated/Population) * 100
FROM #PercentPopulationVaccinated
WHERE RollingPeopleVaccinated <> 0;

-- Creating View to store data fro later visualizations

Create View PercentPopulationVaccinated as
SELECT dea.Continent, dea.Location, dea.Date, dea.Population, vac.New_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.Continent IS NOT NULL;
