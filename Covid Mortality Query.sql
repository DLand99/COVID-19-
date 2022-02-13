--Data Set obtained and altered from Our World In Data website.

select * from [Covid Mortality Data]
order by 3,4

--select * from [Covid Vaccination Data]
--order by 3,4
SELECT LOCATION, DATE, TOTAL_CASES, NEW_CASES, TOTAL_DEATHS, POPULATION 
FROM [Covid Mortality Data]
Where Continent is not null
order by 1,2

-- Looking at U.S. Mortality, Infection Rates.  1.18% Mortality rate, 22.935% of the population infected thus far. 

SELECT LOCATION, DATE, TOTAL_CASES, TOTAL_DEATHS, (total_deaths/total_cases)*100 as Mortality_Rate, (Total_Cases/population)*100 as Infection_Rate
FROM [Covid Mortality Data]
WHERE location like '%states%' and Continent is not null
order by 1,2


--Looking at Countries with top Infection Rates.  lots of small nations in the top of the list.  U.S. 34th in the world for infection rate.

SELECT LOCATION, Population, MAX(TOTAL_CASES) as InfectionMax, Max((Total_Cases/population)*100) as Infection_Rate
FROM [Covid Mortality Data]
Where Continent is not null
Group by Location, Population
order by Infection_rate desc

--Selecting countries with more than 2,000,000 people for same comparison.  U.S. 17th on this list

SELECT LOCATION, Population, MAX(TOTAL_CASES) as InfectionMax, Max((Total_Cases/population)*100) as Infection_Rate
FROM [Covid Mortality Data]
Where Population>2000000 and Continent is not null
Group by Location, Population
order by Infection_rate desc

-- Looking at total deaths.  

SELECT LOCATION, Max(cast(Total_Deaths as int)) as Death_Count
FROM [Covid Mortality Data]
Where Continent is not null
Group by Location
order by Death_Count desc

-- Looking at breakdown by continent. income filter added to remove classification added in original dataset

SELECT Location,  Max(cast(Total_Deaths as int)) as Death_Count
FROM [Covid Mortality Data]
Where Continent is  null and Location not like '%income%'
Group by Location
order by Death_Count desc

--Global numbers.  World and european union excluded to keep from double-counting.  Numbers current to February 4, 2022

SELECT  SUM(new_cases) as Rolling_Cases, SUM(cast(new_deaths as int)) as  Rolling_Deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Mortality_Rate
FROM [Covid Mortality Data]
WHERE Continent is null and location not like '%income' and location not like '%world%' and location not like '%European%'
order by 1,2
