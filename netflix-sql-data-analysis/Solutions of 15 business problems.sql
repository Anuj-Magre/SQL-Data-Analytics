-- -----------------------------
-- Nteflix_Data_Analysis_Project
-- -----------------------------


-- --------------------------------
-- 15 Business Problems & Solutions
-- ---------------------------------

-- 1. Count the number of Movies vs TV Shows

select 
	type,
    count(*) as total_content
from netflix
group by type;



-- 2. Find the most common rating for movies and TV shows


select 
	type,
    rating as 'most_frequent_rating'
from
(select 
	type,
    rating,
	count(*),
    rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by 1,2) as t1
where ranking = 1;



-- 3. List all movies released in a specific year (e.g., 2020)

select * from netflix
where 
	release_year = '2020' and
	type = 'movie';



-- 4. Find the top 5 countries with the most content on Netflix

SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 5;



-- 5. Identify the longest movie

select 
	* 
from netflix
where 
	type = "movie"
	and duration = (
					select max(duration) 
                    from netflix
                    )
	;



-- 6. Find content added in the last 5 years


SELECT 
	*
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= 
      DATE_SUB(
          (SELECT MAX(STR_TO_DATE(date_added, '%M %d, %Y')) FROM netflix),
          INTERVAL 5 YEAR
      );
      
      
-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select 
	* 
from netflix
where director like "%Rajiv Chilaka%";


-- 8. List all TV shows with more than 5 seasons

select 
	* 
from netflix
where type = "tv show"
	and CAST(SUBSTRING_INDEX(duration, ' ', 1) AS unsigned) > 5;


-- 9. Count the number of content items in each genre

SELECT 
    TRIM(j.genre) AS genre,
    COUNT(*) AS total_content
FROM netflix,
JSON_TABLE(
    CONCAT('["', REPLACE(listed_in, ',', '","'), '"]'),
    '$[*]' COLUMNS (
        genre VARCHAR(100) PATH '$'
    )
) AS j
GROUP BY TRIM(j.genre)
ORDER BY total_content DESC;
                    




/* 10.Find each year and the average numbers of content release in India on netflix. 
 return top 5 year with highest avg content release! */
 
 select 
	year(STR_TO_DATE(date_added, '%M %d, %Y')) as year,
    count(*) as total_release,
    round
		(count(*)/
				(select count(*) from netflix where country like '%india%')*100
		,2 
        ) as avg_release
 from netflix
 where country like "%india%"
 group by year(str_to_date(date_added, '%M %D, %Y'))
 order by avg_release desc
 limit 5;




-- 11. List all movies that are documentaries

select * from netflix
where listed_in like '%documentaries%';


-- 12. Find all content without a director

select 
	* 
from netflix
where director is null 
	or director = '' ;
    

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select 
	* 
from netflix
where casts like '%salman khan%'
and release_year > year(current_date())-10;



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
    TRIM(j.actors) AS actors,
    COUNT(*) AS total_movies
FROM netflix,
JSON_TABLE(
    CONCAT('["', REPLACE(casts, ',', '","'), '"]'),
    '$[*]' COLUMNS (
        actors VARCHAR(100) PATH '$'
    )
) AS j
WHERE country LIKE '%India%'
GROUP BY TRIM(j.actors)
ORDER BY total_movies DESC
limit 10;





/* 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
 the description field. Label content containing these keywords as 'Bad' and all other 
 content as 'Good'. Count how many items fall into each category.  */
 
 
 select 
    type,
    category,
    count(*) as content_count
from(
	select
		*,
		case 
			when 
				description like '%kill%'
				or description like '%violence%'
			then 'Bad'
	
			else 'Good'
		end as category
	from netflix) as categorize_content
group by category,type
order by type;


-- end of report
