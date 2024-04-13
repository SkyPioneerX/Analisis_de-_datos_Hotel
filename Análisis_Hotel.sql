--CONSULTA DE DATOS
select * from data_2018
select * from data_2019
select * from data_2020

--COMBINANDO LOS DATOS
select * from data_2018
union
select * from data_2019
union
select * from data_2020

--ANÁLISIS DE DATOS EXPLORATORIOS
WITH hotels AS (
    SELECT * FROM dbo.[data_2018]
    UNION
    SELECT * FROM dbo.[data_2019]
    UNION
    SELECT * FROM dbo.[data_2020])

select * from hotels
left join dbo.market_segment
on hotels.market_segment = market_segment.market_segment
left join dbo.meal_cost
on meal_cost.meal = hotels.meal
-- 1. ¿Los ingresos de nuestro hotel crecen anualmente??
/*
select 
  (stays_in_week_nights + stays_in_weekend_nights) * adr as revenue 
from hotels

select 
arrival_date_year
sum((stays_in_week_nights + stays_in_weekend_nights) * adr) as revenue 
from hotels 
group by arrival_date_year
*/
select 
arrival_date_year, 
hotel,
round(sum((stays_in_week_nights + stays_in_weekend_nights) * adr),2) as revenue 
from hotels 
group by arrival_date_year, hotel

select * from dbo.market_segment
-- 2. ¿Deberíamos aumentar el tamaño de nuestro estacionamiento??
select
arrival_date_year, hotel,
sum((stays_in_week_nights + stays_in_weekend _nights) * adr) as revenue,
concat (round((sum(required_car_parking_spaces)/sum(stays_in_week_nights +
stays_in_weekend_nights)) * 100, 2), '%') as parking_percentage
from hotels group by arrival_date_year, hotel

-- 3. ¿Qué tendencias podemos ver en los datos??

select * from hotels
left join dbo.market_segment
on hotels.market_segment = market_segment.market_segment
left join dbo.meal_cost
on meal_cost.meal = hotels.meal