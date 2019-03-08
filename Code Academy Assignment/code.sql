Quiz Funnel:


SELECT * from survey
 LIMIT 10;



SELECT question, COUNT(distinct user_id) from survey
 GROUP BY question;


SELECT * from quiz
 LIMIT 5;
SELECT * from home_try_on
 LIMIT 5;
SELECT * from purchase
 LIMIT 5;



SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
LIMIT 10;



WITH funnels as (
SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT COUNT(*) AS 'num_browse',
SUM(is_home_try_on) AS 'home_try',
   SUM(is_purchase) AS 'num_purchase',
   1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'percentage_home_try_on',
   1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'home_try_on_to_purchase'
FROM funnels;



