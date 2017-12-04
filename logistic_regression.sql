SELECT ROUND(review_count, -1) as review_count,  YEAR(yelping_since) as yelping_since_year,  ROUND(useful, -1) as useful,  ROUND(funny, -1) as funny, ROUND(cool, -1) as cool, ROUND(fans, -1) as fans, year IS NOT NULL AS is_elite 
FROM user LEFT JOIN elite_years ON user.id = elite_years.user_id
WHERE review_count < 200  AND useful < 50 AND funny < 25 AND cool < 25 AND FANS < 20 
