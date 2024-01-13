--SQL Project - Analyzing Covid19 World Data

-- Reviewing the Data
select *
from PortfolioProjectSQL..CovidCasesAndDeaths
order by location,date

select *
from PortfolioProjectSQL..CovidVaccinations
order by location,date


-- Looking at Total Deaths against Population
-- Showing the all time Total and Percentage of deaths in each country against Population
select 
	continent,
	location, 
	population, 
	max(cast(total_deaths as int)) as TotalDeaths,
	max(cast(total_deaths as int))*100.0/population as DeathPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
group by 
	continent,
	location, 
	population
order by 
	location

-- Showing the Total and Percentage of deaths in each country by date against Population
select 
	continent,
	location,
	date,
	population, 
	total_deaths as TotalDeaths,
	cast(total_deaths as int)*100.0/cast(population as int) as DeathPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
order by 
	location,
	date


-- Looking at Total Cases against Total Deaths
-- Showing the liklihood of dying out of covid in each country by date
Select 
	continent,
	Location, 
	date, 
	total_cases as TotalCases, 
	total_deaths as TotalDeaths, 
	cast(total_deaths as int)/nullif(cast(total_cases as float),0)*100.0 as DeathPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
order by 
	location, 
	date

-- Looking at Total Cases against Population
-- Showing the countries with highest infection rate compared to population
Select 
	continent,
	Location, 
	population as Population, 
	sum(cast(new_cases as int)) as SumOfCases, 
	sum(cast(new_cases as int))/population*100.0 as TotalCasesPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
group by 
	continent,
	location, 
	population
order by 
	TotalCasesPercentage desc

-- Shows the percent of population infected in each country per date
Select 
	continent,
	Location, 
	population,
	date,
	sum(cast(total_cases as int)) as SumOfCases, 
	sum(cast(total_cases as int))/population*100.0 as CasesPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
group by 
	continent,
	location, 
	population,
	date
order by 
	location,
	date


-- Showing the countries with the highest death count per population
Select 
	continent,
	Location, 
	max(cast(total_deaths as int)) as TotalDeathCount
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
group by 
	continent,
	location
order by 
	TotalDeathCount desc

-- Looking at the data by selected categories and continents
Select 
	location,
	population,
	max(cast(total_deaths as int)) as TotalDeathCount
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is null
group by 
	location,
	population
order by 
	TotalDeathCount desc

-- Global Numbers
-- World totals by date
Select 
	date, 
	sum(cast(new_cases as int)) as TotalWorldCases, 
	sum(cast(new_deaths as int)) as TotalWorldDeaths, 
	sum(cast(new_deaths as float))/NULLIF(sum(cast(new_cases as int)),0)*100.0 as WorldDeathPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null
group by 
	date
order by 
	date

-- World all time
Select 
	sum(cast(new_cases as int)) as TotalWorldCases, 
	sum(cast(new_deaths as int)) as TotalWorldDeaths, 
	sum(cast(new_deaths as float))/NULLIF(sum(cast(new_cases as int)),0)*100.0 as WorldDeathPercentage
from 
	PortfolioProjectSQL..CovidCasesAndDeaths
where 
	continent is not null 


-- Looking at Total Population vs Vaccinations
-- Showing new and added up total vacinations in each country
Select 
	cad.continent, 
	cad.location, 
	cad.date, 
	cad.population, 
	vac.new_vaccinations, 
	sum(cast(vac.new_vaccinations as float)) 
					over 
			(partition by 
				cad.location 
			order by 
				cad.location, 
				cad.date) as AddedUpTotalVaccinations
from 
	PortfolioProjectSQL..CovidCasesAndDeaths as cad 
		join PortfolioProjectSQL..CovidVaccinations as vac 
			on cad.location=vac.location and cad.date=vac.date
where 
	cad.continent is not null
order by 
	cad.location, 
	cad.date

---Showing number of people vaccinated and the percentage of population vaccinated in each country by date
Select 
	cad.continent, 
	cad.location, 
	cad.date, 
	cad.population, 
	vac.people_vaccinated, 
	(cast(vac.people_vaccinated as float)/cad.population*100.0) as PercentageOfPeopleVaccinated
from 
	PortfolioProjectSQL..CovidCasesAndDeaths as cad 
		join PortfolioProjectSQL..CovidVaccinations as vac 
			on cad.location=vac.location and cad.date=vac.date
where 
	cad.continent is not null
order by 
	cad.location, 
	cad.date

-- Showing Total and percentage of vaccinated population in each country
Select 
	cad.continent,
	cad.location,  
	cad.population, 
	max(cast(vac.people_vaccinated as float)) as TotalVaccinatedPopulation, 
	max(cast(vac.people_vaccinated as float))/cad.population*100.0 as PercentageOfPeopleVaccinated
from 
	PortfolioProjectSQL..CovidCasesAndDeaths as cad 
		join PortfolioProjectSQL..CovidVaccinations as vac 
			on cad.location=vac.location and cad.date=vac.date
where 
	cad.continent is not null
group by 
	cad.continent,
	cad.location,  
	cad.population
order by 
	cad.location


-- Showes the liklihood of getting into ICU in each country
Select 
	continent,
	location,  
	max(cast(hosp_patients as int)) as TotalHospPatients,
	max(cast(icu_patients as int)) as TotalIcuPatients,
	max(cast(icu_patients as int))/nullif(max(cast(hosp_patients as float)),0)*100.0 as LiklihoodOfIcu
from 
	PortfolioProjectSQL..CovidCasesAndDeaths			
where 
	continent is not null
group by
	continent,
	location
order by 
	location
	


































