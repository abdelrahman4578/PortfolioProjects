Select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--Select Data that  we are going to be using  


select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

select location,date,total_cases,total_deaths , 
(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%egy%'
and continent is not null
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got covid

select location,date,population,total_cases,
(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%egy%'
where continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate Compared to Population


select location,population,MAX(total_cases)as HighestInfectionCount,
MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%egy%'
where continent is not null
group by location,population
order by PercentPopulationInfected	desc


-- Showing Countries with Highest Death Count per Location

select location,max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%egy%'
where continent is not null
group by location
order by TotalDeathCount desc

-- Let's Break Things Down by Continent

select continent,max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%egy%'
where continent is not null
group by continent
order by TotalDeathCount desc

-- Global Numbers

select SUM(new_cases) as Total_Cases,
SUM(new_deaths) as Total_Deaths,
case
	when sum(new_cases)=0 then null
	else (SUM(new_deaths)/SUM(new_cases))*100 
end as DeathPercentage

from PortfolioProject..CovidDeaths
--where location like '%egy%'
where continent is not null
order by 1,2

--Looking at Total Population vs Vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(convert(bigint,vac.new_vaccinations)) 
over(partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

-- USE CTE
with PopvsVac (continent,location,date,population,new_vaccination,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(convert(bigint,vac.new_vaccinations)) 
over(partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)
select *,(RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinatedp
from PopvsVac

--Temp Table
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
 Continent nvarchar(255),
 Location nvarchar(255),
 date datetime,
 Population numeric,
 New_vaccinations numeric,
 RollingPeopleVaccinated numeric
)

insert into	#PercentPopulationVaccinated
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(convert(bigint,vac.new_vaccinations)) 
over(partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
--where dea.continent is not null
--order by 2,3
select *,(RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinatedp
from #PercentPopulationVaccinated

-- Creating View to Store Data for Later Visualization
drop view if exists	PercentPopulationVaccinated
create view	 PercentPopulationVaccinated
as (
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(convert(bigint,vac.new_vaccinations)) 
over(partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)
select *
from PercentPopulationVaccinated

















