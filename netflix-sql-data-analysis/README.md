# Netflix Data Analysis using SQL

## Project Overview

This project analyzes the **Netflix Movies and TV Shows dataset** using SQL to solve real-world business problems. The objective is to explore Netflix content and extract meaningful insights related to movies, TV shows, ratings, actors, genres, and countries.

The project answers **15 analytical business questions** using SQL queries and demonstrates key data analysis techniques used in real-world data analyst roles.

This project is part of my **Data Analyst Portfolio**.

---

## Tools & Technologies Used

- SQL (MySQL)
- Kaggle Dataset
- GitHub

---

## Dataset

Dataset Source: Kaggle

Netflix Movies and TV Shows Dataset

https://www.kaggle.com/datasets/shivamb/netflix-shows

The dataset contains information about Netflix titles such as:

- Show ID
- Content Type (Movie / TV Show)
- Title
- Director
- Cast
- Country
- Date Added
- Release Year
- Rating
- Duration
- Genre
- Description

---

## Database Schema

```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
show_id VARCHAR(5),
type VARCHAR(10),
title VARCHAR(250),
director VARCHAR(550),
casts VARCHAR(1050),
country VARCHAR(550),
date_added VARCHAR(55),
release_year INT,
rating VARCHAR(15),
duration VARCHAR(15),
listed_in VARCHAR(250),
description VARCHAR(550)
);
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
select 
	type,
    count(*) as total_content
from netflix
group by type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
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
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
select * from netflix
where 
	release_year = '2020' and
	type = 'movie';
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
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
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT 
	*
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= 
      DATE_SUB(
          (SELECT MAX(STR_TO_DATE(date_added, '%M %d, %Y')) FROM netflix),
          INTERVAL 5 YEAR
      );
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
select 
	* 
from netflix
where director like "%Rajiv Chilaka%";
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
select 
	* 
from netflix
where type = "tv show"
	and CAST(SUBSTRING_INDEX(duration, ' ', 1) AS unsigned) > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
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
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
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
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
select * from netflix
where listed_in like '%documentaries%';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
select 
	* 
from netflix
where director is null 
	or director = '' ;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
select 
	* 
from netflix
where casts like '%salman khan%'
and release_year > year(current_date())-10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
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
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
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
```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.


---
## Key SQL Concepts Used
This project demonstrates the use of several SQL techniques including:

- Aggregation functions (COUNT, MAX)
- Window functions (RANK)
- String functions (LIKE, TRIM, SUBSTRING_INDEX)
- Date functions (STR_TO_DATE, DATE_SUB)
- JSON_TABLE for splitting comma-separated values
- Subqueries
- CASE statements for data categorization

---
## Key Insights

- Netflix hosts significantly more movies compared to TV shows.
- Certain countries contribute a large portion of Netflix content.
- Some actors frequently appear in Indian Netflix productions.
- Genre distribution shows the diversity of Netflix's content library.
- Keyword analysis helps categorize potentially violent content themes.

---
## Project Structure
```
SQL-Data-Analytics
└── netflix-sql-data-analysis
    ├── Business Problems Netflix.sql
    ├── Solutions of 15 business problems.sql
    ├── netflix_titles.csv
    ├── schemas.sql
    └── README.md
```
---
## Author

**Anuj Magre**  
Aspiring Data Analyst passionate about turning data into insights.

**Skills:**  
SQL • Excel • Power BI • Python • Data Analysis  

🔗 GitHub: https://github.com/Anuj-Magre  
🔗 LinkedIn: https://www.linkedin.com/in/anujmagre/
