-- 2



-- 3

WITH InitialData AS (
	SELECT 
		r.customer_id, 
        YEAR(r.rental_date) AS rental_year, 
        c.name, 
        COUNT(*) AS TimesRented
	FROM Rental r
		JOIN inventory i 
			ON r.inventory_id = i.inventory_id
		JOIN film f 
			ON i.film_id = f.film_id
		JOIN film_category fc
			ON f.film_id = fc.film_id
		JOIN category c 
			ON fc.category_id = c.category_id
	GROUP BY r.customer_id, YEAR(r.rental_date), c.name
    ORDER BY COUNT(*) DESC, c.name
),

FavoriteGenreData1 AS (
	SELECT 
		customer_id, 
        rental_year, 
        name AS FavoriteGenre1, 
        MAX(TimesRented) AS FavoriteGenreRentalCount1
	FROM InitialData
    GROUP BY customer_id, rental_year
),

FavoriteGenreData2 AS (
	SELECT 
		i.customer_id, 
        i.rental_year, 
        f1.FavoriteGenre1, 
        i.name AS FavoriteGenre2, 
        f1.FavoriteGenreRentalCount1,
        MAX(i.TimesRented) AS FavoriteGenreRentalCount2
	FROM InitialData i
		JOIN FavoriteGenreData1 f1
			ON i.customer_id = f1.customer_id
				AND i.rental_year = f1.rental_year
			WHERE i.name != f1.FavoriteGenre1
    GROUP BY i.customer_id, i.rental_year
),

FavoriteGenreData3 AS (
	SELECT 
		i.customer_id, 
        i.rental_year, 
        f2.FavoriteGenre1, 
        f2.FavoriteGenre2, 
        i.name AS FavoriteGenre3, 
		f2.FavoriteGenreRentalCount1,
        f2.FavoriteGenreRentalCount2,
        MAX(i.TimesRented) AS FavoriteGenreRentalCount3
	FROM InitialData i
		JOIN FavoriteGenreData2 f2
			ON i.customer_id = f2.customer_id
				AND i.rental_year = f2.rental_year
			WHERE i.name != f2.FavoriteGenre1
				AND i.name != f2.FavoriteGenre2
    GROUP BY i.customer_id, i.rental_year
)

SELECT 
	customer_id, 
	rental_year, 
    FavoriteGenre1, 
    FavoriteGenre2, 
    FavoriteGenre3
	FROM FavoriteGenreData3
    ORDER BY customer_id;