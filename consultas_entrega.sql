-- CONSULTA 1: Crea el esquema de la BBDD. (En archivo adjunto "ddl.sql")

-- CONSULTA 2: Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select title
from film
where rating = 'R'

-- CONSULTA 3:  Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select first_name 
from actor
where actor_id between 30 and 40

--Si se quiere nombre completo haremos la siguiente consulta
select first_name, last_name
from actor
where actor_id between 30 and 40

-- CONSULTA 4: Obtén las películas cuyo idioma coincide con el idioma original.
select film_id, title
from film
where language_id = original_language_id 

--En este caso no hay ninguna que coincida ya que todos los valores de "original_language_id" son nulos, para comprobar haremos lo siguiente
SELECT film_id, title
FROM film
WHERE original_language_id IS NOT NULL
  AND language_id = original_language_id;


-- CONSULTA 5: Ordena las películas por duración de forma ascendente.
select film_id, title, length
from film
order by length asc

-- CONSULTA 6: Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select first_name, last_name
from actor
where last_name = 'Allen' --Revisando la base de datos se ve que los nombres están escritos en mayúsculas, por lo que se prcede a lo siguiente

select first_name, last_name
from actor
where last_name = 'ALLEN'

-- CONSULTA 7: Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select rating, COUNT(*) AS number_films
from film
group by rating 

-- CONSULTA 8: Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select title
from film
where rating = 'PG-13' or length > 180

-- CONSULTA 9:  Encuentra la variabilidad de lo que costaría reemplazar las películas.
select ROUND(STDDEV(replacement_cost),2) as replacement_deviation
from film

-- CONSULTA 10: Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MAX(length), MIN(length)
from film

-- CONSULTA 11: Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount
from payment
order by payment_date desc
limit 1 offset 2

-- CONSULTA 12: Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select title, rating
from film
where rating not in ('NC-17','G')

-- CONSULTA 13: Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select rating, ROUND(AVG(length),2) as promedio_duracion
from film
group by rating

-- CONSULTA 14: Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title
from film
where length > 180

-- CONSULTA 15: ¿Cuánto dinero ha generado en total la empresa?
select SUM(amount)
from payment

-- CONSULTA 16:  Muestra los 10 clientes con mayor valor de id.
select customer_id
from customer
order by customer_id desc
limit 10

-- CONSULTA 17: Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title = 'Egg Igby' --Revisando la base de datos se ve que los títulos están escritos en mayúsculas, por lo que se prcede a lo siguiente

select a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title = 'EGG IGBY'

-- CONSULTA 18: Selecciona todos los nombres de las películas únicos.
select distinct title
from film

-- CONSULTA 19:  Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Comedy' and f.length > 180;

-- CONSULTA 20: Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c.name, ROUND(AVG(f.length),2) as promedio_duracion
from category c 
join film_category fc on c.category_id = fc.category_id 
join film f on f.film_id = fc.film_id 
group by c."name"
having AVG(f.length) > 110

-- CONSULTA 21: ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(return_date - rental_date) AS duracion_alquiler
FROM rental -- para leer mejor el resultado vamos aplicar la función DATE

SELECT ROUND(AVG(DATE(return_date) - DATE(rental_date)),2) AS duracion_alquiler
FROM rental

-- CONSULTA 22: Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(first_name,' ', last_name) as nombre_completo_actores
from actor a 

-- CONSULTA 23: Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select DATE(rental_date) as fecha_alquiler, COUNT(*) AS total_alquileres
from rental
group by DATE(rental_date)
order by total_alquileres desc

-- CONSULTA 24: Encuentra las películas con una duración superior al promedio.
select title, length 
from film f 
where length > (
	select AVG(length) 
	from film)

-- CONSULTA 25: Averigua el número de alquileres registrados por mes.
select  DATE_TRUNC('month', rental_date)::DATE as mes,  COUNT(*) as total_alquileres
from rental
group by DATE_TRUNC('month', rental_date)
order by mes
	
-- CONSULTA 26: Encuentra el promedio, la desviación estándar y varianza del total pagado.
select ROUND(AVG(amount),2) as promedio_totalpagado, ROUND(STDDEV(amount),2) as desviacion_estandar_totalpagado, ROUND(VARIANCE(amount),2) as varianza_totalpagado
from payment

-- CONSULTA 27: ¿Qué películas se alquilan por encima del precio medio?
select title, rental_rate
from film
where rental_rate > (
	select AVG(rental_rate) 
	from film)

-- CONSULTA 28: Muestra el id de los actores que hayan participado en más de 40 películas.
select actor_id
from film_actor
group by actor_id
having COUNT(film_id) > 40

-- CONSULTA 29: Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.film_id, f.title, COUNT(i.inventory_id) as cantidad_disponible
from film f
join inventory i on f.film_id = i.film_id
group by f.film_id, f.title
order by cantidad_disponible desc

-- CONSULTA 30: Obtener los actores y el número de películas en las que ha actuado.
select actor_id, COUNT(film_id) as peliculas_actuadas
from film_actor
group by actor_id
order by peliculas_actuadas desc -- si queremos los nombres y apellidos aplicamos la siguiente consulta

select a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) as peliculas_actuadas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by peliculas_actuadas desc

-- CONSULTA 31: Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.film_id, f.title, a.actor_id, a.first_name, a.last_name
from film f
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
order by f.film_id, a.last_name, a.first_name -- si queremos ordenar los nombres en una lista por película para una mejor visualización hacemos la siguiente consulta

select f.film_id, f.title, COALESCE(STRING_AGG(a.first_name || ' ' || a.last_name, ', ' ORDER BY a.last_name, a.first_name), 'Sin actores asociados') as actores
from film f
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
group by f.film_id, f.title
order by f.film_id

-- CONSULTA 32: Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select a.actor_id, a.first_name, a.last_name, f.film_id, f.title
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
order by a.actor_id, f.title -- si queremos ordenar las peliculas en una lista por actor para una mejor visualización hacemos la siguiente consulta

select a.actor_id, a.first_name, a.last_name, COALESCE(STRING_AGG(f.title, ', ' order by f.title),'Sin películas asociadas') as peliculas
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
group by a.actor_id, a.first_name, a.last_name
order by a.actor_id

-- CONSULTA 33: Obtener todas las películas que tenemos y todos los registros de alquiler.
select   f.film_id, f.title, r.rental_id, r.rental_date, r.return_date, r.customer_id
from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
order by f.film_id, r.rental_date

-- CONSULTA 34: Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.customer_id, c.first_name, c.last_name, SUM(p.amount) as total_gastado
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_gastado desc
limit 5

-- CONSULTA 35: Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select actor_id, first_name, last_name
from actor
where first_name = 'Johnny'--Revisando la base de datos se ve que los nombres están escritos en mayúsculas, por lo que se prcede a lo siguiente

select actor_id, first_name, last_name
from actor
where first_name = 'JOHNNY'

-- CONSULTA 36: Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select first_name as nombre, last_name as apellido
from actor

-- CONSULTA 37: Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN(actor_id) as id_mas_bajo, MAX(actor_id) as id_mas_alto
from actor

-- CONSULTA 38: Cuenta cuántos actores hay en la tabla “actorˮ.
select COUNT(*) as total_actores
from actor a  -- hacemos una revisión para confirmar que no hay duplicados

select first_name, last_name, COUNT(*)
from actor
group by first_name, last_name
having COUNT(*) > 1 -- en efecto hay un duplicado SUSAN DAVIS, habría que consultar si realmente son dos actrices diferentes, si se debe a un error o si se debe a un problema de calidad de datos

-- CONSULTA 39: Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select actor_id, first_name, last_name
from actor
order by last_name asc

-- CONSULTA 40: Selecciona las primeras 5 películas de la tabla “filmˮ.
select *
from film
limit 5

-- CONSULTA 41: Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select first_name, COUNT(*) as total_actores
from actor
group by first_name
order by total_actores desc 
limit 1 

-- CONSULTA 42: Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date, r.return_date
from customer c
left join rental r on c.customer_id = r.customer_id
order by c.customer_id, r.rental_date -- si queremos agrupar alquileres en una lista por cliente procedemos con la siguiente consulta

select c.customer_id, c.first_name, c.last_name, COALESCE(STRING_AGG(r.rental_id::text, ', ' order by r.rental_date), 'Sin alquileres') as alquileres
from customer c
left JOIN rental r ON c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by c.customer_id

-- CONSULTA 43: Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date, r.return_date
from customer c
left join rental r on c.customer_id = r.customer_id
order by c.customer_id, r.rental_date -- si queremos el total de alquileres por cliente procedemos con la siguiente consulta

select c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as total_alquileres
from customer c
left JOIN rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc

-- CONSULTA 44: Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select f.film_id, f.title, c.category_id, c.name as categoria
from film f
cross join category c
order by f.film_id, c.category_id -- No aporta valor ya que estamos repitiendo las peliculas una vez por cada categoria a la que pertenezcen, con lo cual se pierde sentido contextual (hay demasiadas entradas en la tabla), sería mejor utilizar JOIN para resulatdos reales entre las dos tablas

-- CONSULTA 45: Encuentra los actores que han participado en películas de la categoría 'Action'. 
select distinct a.actor_id, a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action'
order by a.last_name, a.first_name

-- CONSULTA 46: Encuentra todos los actores que no han participado en películas. 
select a.actor_id, a.first_name, a.last_name
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null 
order by a.last_name, a.first_name -- no hay actores que no hayan participado en peliculas

-- CONSULTA 47: Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) as peliculas_actuadas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by peliculas_actuadas desc

-- CONSULTA 48: Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado. 
create view actor_num_peliculas as select a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) as cantidad_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name -- para consultar la vista como si fuera una tabla procedemos con la siguiente consulta

select * from actor_num_peliculas order by cantidad_peliculas desc

-- CONSULTA 49: Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc

-- CONSULTA 50: Calcula la duración total de las películas en la categoría 'Action'.
select c.name as categoria, SUM(f.length) as duracion_total
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action'
group by c.name

-- CONSULTA 51: Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temp table cliente_rentas_temporal as select c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name -- para consultar la tabla temporal procedemos con la siguiente consulta

select * from cliente_rentas_temporal order by total_alquileres desc

-- CONSULTA 52: Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
create temp table peliculas_alquiladas as select f.film_id, f.title, COUNT(r.rental_id) as total_alquileres
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
having COUNT(r.rental_id) >= 10
order by total_alquileres desc -- para consultar la tabla temporal procedemos con la siguiente consulta

select * from peliculas_alquiladas order by total_alquileres desc

-- CONSULTA 53: Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select distinct f.title, DATE(r.rental_date) as fecha_alquiler
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join customer c on r.customer_id = c.customer_id
where c.first_name = 'TAMMY'and c.last_name = 'SANDERS'and r.return_date is null
order by f.title asc, DATE(r.rental_date) asc

-- CONSULTA 54: Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
select distinct a.actor_id, a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name asc, a.first_name asc

-- CONSULTA 55: Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
with primera_fecha_spartacus as (
  select MIN(r.rental_date) as fecha_inicio
  from film f
  join inventory i on f.film_id = i.film_id
  join rental r on i.inventory_id = r.inventory_id
  where f.title = 'SPARTACUS CHEAPER'
  )
select distinct a.actor_id, a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
cross join primera_fecha_spartacus pfs
where r.rental_date > pfs.fecha_inicio
order by a.last_name asc, a.first_name asc

-- CONSULTA 56: Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
select a.actor_id, a.first_name, a.last_name
from actor a
where not exists (
  select 1
  from film_actor fa
  join film_category fc on fa.film_id = fc.film_id
  join category c on fc.category_id = c.category_id
  where fa.actor_id = a.actor_id
    and c.name = 'Music'
)
order by a.last_name, a.first_name

-- CONSULTA 57: Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f.title
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where (r.return_date - r.rental_date) > INTERVAL '8 days'
order by f.title

-- CONSULTA 58: Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
select distinct f.title
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Animation'
order by f.title asc

-- CONSULTA 59: Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
select title
from film
where length = (
  select length
  from film
  where title = 'DANCING FEVER'
  limit 1
)
order by title asc

-- CONSULTA 60: Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select c.customer_id, c.first_name, c.last_name, COUNT(distinct f.film_id) as peliculas_distintas
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by c.customer_id, c.first_name, c.last_name
having COUNT(distinct f.film_id) >= 7
order by c.last_name asc, c.first_name asc

-- CONSULTA 61: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name as categoria, COUNT(r.rental_id) as total_alquileres
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by c.name
order by total_alquileres desc

-- CONSULTA 62: Encuentra el número de películas por categoría estrenadas en 2006.
select c.name as categoria, COUNT(f.film_id) as total_peliculas
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name
order by total_peliculas desc

-- CONSULTA 63: Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select s.staff_id, s.first_name, s.last_name, st.store_id, st.address_id
from staff s
cross join store st
order by s.staff_id, st.store_id;

-- CONSULTA 64: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc

