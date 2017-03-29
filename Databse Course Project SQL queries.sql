#Database Project SQL Script

USE ddaiteam8;

#Top 10 directors by revenue
SELECT 
	first_name, 
    last_name, 
    Director_Director_Id, 
    format(Total_Revenue,0) AS Total_Revenue 
FROM
(SELECT
	b.first_name,
    b.last_name,
    a.Director_Director_ID,
    sum(a.Gross_Revenue) as Total_Revenue 
 FROM
	Film a 
		INNER JOIN 
	Director b on b.Director_ID = a.Director_Director_Id 
 GROUP BY b.Director_ID
 ORDER BY Total_Revenue DESC
 LIMIT 10)  as directors_by_revenue_table;


#Most popular director in FB based on number of likes
SELECT 
	first_name,
    last_name,
    FB_likes
FROM
	Director
ORDER BY FB_likes DESC
LIMIT 10;

#Most popular director in FB based on number of likes and count of moives directed.
SELECT 
	a.first_name,
    a.last_name,
    a.FB_likes,
    a.Director_Id,
    COUNT(b.Director_Director_Id) As No_of_movies_directed
FROM
	Director a
		INNER JOIN
	film b ON a.Director_ID = b.Director_Director_Id
GROUP BY a.Director_Id
ORDER BY FB_likes DESC
LIMIT 10;

#Most popular director in FB based on number of likes and count of moives directed and IMDB score.
SELECT 
	a.first_name,
    a.last_name,
    a.FB_likes,
    a.Director_Id,
    COUNT(b.Director_Director_Id) As No_of_movies_directed
FROM
	Director a
		INNER JOIN
	film b ON a.Director_ID = b.Director_Director_Id
WHERE b.IMDB_score > 6
GROUP BY a.Director_Id
HAVING No_of_movies_directed > 2
ORDER BY FB_likes DESC
LIMIT 10;

#Top 15 films by facebook likes?
SELECT
	Title,
    format(FB_likes,0) AS facebook_likes
FROM
(SELECT
	Title,
    FB_likes
FROM
	film
ORDER BY FB_likes DESC
LIMIT 15) AS second_table;

#Which year was the most profitable in the film industry?
SELECT
	Year,
    SUM(Gross_revenue) - SUM(Budget) AS Profit
FROM
	Film
GROUP BY
	Year
ORDER BY
	Profit Desc
LIMIT 1;

#Which 10 movies have the highest IMDB scores and highest gross revenue?
SELECT
	a.first_name,
	a.last_name,
    AVG(b.IMDB_score) AS Average_IMDB_Score
FROM
	Director a
		INNER JOIN
	Film b ON a.Director_Id = b.Director_Director_Id
GROUP BY a.Director_Id
ORDER BY Average_IMDB_Score DESC
LIMIT 10;

# Top 10 actors largest profits in total
SELECT first_name, last_name, format(Profit,0) AS Profit FROM (
SELECT d.first_name,
	   d.last_name,
	  (SUM(a.Gross_Revenue - a.Budget)) AS Profit
FROM 
	ddaiteam8.Film a
		INNER JOIN 
	ddaiteam8.Film_has_Actor c ON a.Film_ID = c.Film_Film_ID
		INNER JOIN 
	ddaiteam8.Actor d ON c.Actor_Actor_Id = d.Actor_Id
GROUP BY c.Actor_Actor_Id
ORDER BY Profit DESC
LIMIT 10) TABLE_5;

#Which actor’s movies have received the most critic-reviews?
SELECT
	a.first_name,
    a.last_name,
    SUM(c.Num_critic_reviews) AS Total_Crtics_Review
FROM
	Actor a
		INNER JOIN
	Film_has_Actor b ON a.Actor_Id = b.Actor_Actor_Id
		INNER JOIN
	Film c ON b.Film_Film_ID = c.Film_ID
GROUP BY a.Actor_Id
ORDER BY Total_Crtics_Review DESC
LIMIT 10;

#Which genre has the highest number of votes?
SELECT
	a.Genre,
    SUM(c.Num_user_votes) AS Total_number_of_votes
FROM
	Genre a 
		INNER JOIN
	Film_has_Genre b ON a.Genre_Id = b.Genre_Genre_Id
		INNER JOIN
	Film c ON b.Film_Film_ID = c.Film_ID
GROUP BY a.Genre
ORDER BY Total_number_of_votes DESC;

#Which country has the top grossing movies till date?
SELECT 
	Country, 
	sum(Gross_revenue) AS Revenue_by_Country
FROM
	Film 
GROUP BY Country 
ORDER BY Revenue_by_Country DESC;

#Total profits by genre?
SELECT genre, format(Profit,0) AS Profit FROM (
SELECT
	a.genre,
    SUM(c.Gross_revenue) - SUM(c.Budget) AS Profit
FROM
	Genre a
		INNER JOIN
	Film_has_Genre b ON a.Genre_Id = b.Genre_Genre_Id
		INNER JOIN
	Film c ON b.Film_Film_ID = c.Film_ID
GROUP BY a.genre
ORDER BY Profit DESC) AS third_table;
