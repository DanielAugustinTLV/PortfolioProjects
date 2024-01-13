
-- Formula 1 Data Manipulation
Use [Formula 1]

-- Retrieveing the total number of races in the dataset.
select 
	r.year as Season,
	count(distinct r.raceid) as 'Total Races'
from
	races as r
group by
	r.year
order by
	r.year desc

-- Finding the average points earned by each driver in a specific season.
select 
	d.driverId as 'Driver ID',
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
	r.year as 'Season',
	avg(rs.points) as 'Average Points'
from
	drivers as d
		join 
			results as rs on rs.driverId=d.driverId
		join
			races as r on r.raceId=rs.raceId
group by 
	d.driverId,
	d.code,
	d.forename,
	d.surname,
	r.year
order by
	r.year,
	avg(rs.points) desc

-- Identifing the drivers with the most wins in the dataset.
select 
	d.driverId as 'Driver ID',
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
	count(rs.raceId) as 'Num of Races Won'
from
	drivers as d
		join 
			results as rs on rs.driverId=d.driverId
where
	rs.positionOrder=1
group by 
	d.driverId,
	d.code,
	d.forename,
	d.surname
order by
	count(rs.raceId) desc

-- Calculating the average lap time for each race.
select 
	r.year as Season,
	r.name as 'Race Name',
	avg(cast(substring(convert(varchar, lt.time, 108), 1, 2) as int)*60+
        cast(substring(convert(varchar, lt.time, 108), 4, 2) as int)+
        cast(substring(convert(varchar, lt.time, 108), 7, 1) as float)/10) as 'Average Lap Time'
from
	lap_times as lt
		join
			races as r on lt.raceId=r.raceId
group by 
	r.year,
	r.name
order by
	r.year

-- Retrieving the number of races held in each country.
select 
	r.year as Season,
	c.country as Country,
	count(distinct raceId) as 'Num of Races'
from
	races as r
		join 
			circuits as c on c.circuitId=r.circuitId
group by 
	r.year,
	c.country
order by
	r.year desc,
	[Num of Races] desc

-- Finding the drivers with the most podium finishes.
select
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
	count(*) as 'Num of Podiums'
from
	drivers as d
		join 
			results as rs on rs.driverId=d.driverId
where
	rs.positionOrder <=3
group by 
	d.code,
	d.forename,
	d.surname
order by
	count(rs.raceId) desc

-- Calculating the age of drivers in the dataset.
select
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
	datediff(year,d.dob,GETDATE()) as 'Age'
from
	drivers as d

-- Calculating the total number of points earned by each constructor over all seasons.
select
	r.year as Season,
	c.name as 'Constructor Name',
	sum(rs.points) as 'Total Points'
from
	results as rs
		join	
			constructors as c on rs.constructorId=c.constructorId
		join
			races as r on rs.raceId=r.raceId
group by 
	r.year,
	c.name
order by
	r.year desc,
	sum(rs.points) desc

-- Retrieving the number of races held at each circuit.
select
	c.name as 'Circuit Name',
	r.name as 'Race Name',
	count(raceId) as 'Num of Races Held'
from
	races as r
		join
			circuits as c on c.circuitId=r.circuitId
group by 
	c.name,
	r.name
order by
	count(raceId) desc

-- Determining the average number of laps completed by drivers in each race.
select
	r.year as Season,
	r.name as 'Name of Race',
	avg(rs.laps) as 'Average Laps Completed'
from
	races as r 
		join
			results as rs on r.raceId=rs.raceId
group by 
	r.year,
	r.name
order by
	r.year desc

-- Calculating the average duration of races.
select 
	r.year as Season,
	r.name as 'Race Name',
    avg([Total Race Time in Minutes]) AS 'Average Race Time in Minutes'
from 
	races as r
		join
	(select
		r.year,
        r.name,
        lt.driverId,
        sum(lt.milliseconds)/(1000*60) AS 'Total Race Time in Minutes'
	from 
        races as r
    join
        lap_times as lt on r.raceId=lt.raceId
    group by 
        r.name,
        r.year,
        lt.driverId ) as subquery on r.name=subquery.name
group by 
    r.year,
	r.name
order by
    r.year desc,
	r.name

-- Retrieving the total number of pole positions for each driver. (pole position = 1st on the race grid)
select
    r.year as Season,
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
    count(*) as 'Total Pole Positions'
from
    results as rs
		join
			drivers as d on rs.driverId=d.driverId
		join
			races as r on rs.raceId=r.raceId
where
    rs.grid=1
group by
    r.year,
	d.code,
	d.forename,
	d.surname
order by
    r.year desc,
	[Total Pole Positions] desc

-- Identifing the constructor with the most wins in the dataset.
select 
    r.year as Season,
	c.name as 'Most Winning Constructor',
    count(*) as 'Total Wins'
from
    results as rs
		join
			constructors as c on rs.constructorId=c.constructorId
		join
			races as r on rs.raceId=r.raceId
where
    position = '1'
group by
    r.year,
	c.name
order by
	r.year desc,
    [Total Wins] desc

-- Calculating the percentage of races won by each driver.
select
    r.year as Season,
	d.code as Code,
	d.forename+' '+d.surname as 'Driver Name',
    count(case when rs.positionOrder=1 then 1 else null end) as Wins,
    count(*) as 'Total Races',
    (count(case when rs.positionOrder=1 then 1 else null end)*1.0)/count(*) as 'Win Percentage'
from
    results as rs
		join
			drivers as d on rs.driverId=d.driverId
		join
			races as r on rs.raceId=r.raceId
group by
    r.year,
	d.code,
	d.forename,
	d.surname
order by
	r.year desc,
    Wins desc
