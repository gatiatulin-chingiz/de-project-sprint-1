INSERT INTO analysis.dm_rfm_segments
WITH recency AS (
    SELECT a.user_id,
       NTILE(5) OVER (ORDER BY a.last_order_dt DESC) AS recency 
    FROM (
        SELECT o.user_id,
               NOW() - MAX(o.order_ts) AS last_order_dt
        FROM analysis.orders AS o
        LEFT JOIN analysis.orderstatuses AS os ON o.status=os.id
        WHERE o.order_ts >= '2022-01-01'
          AND os.key = 'Closed'
        GROUP BY o.user_id
        ORDER BY user_id
    ) as a
),
frequency AS (
    SELECT a.user_id,
       NTILE(5) OVER (ORDER BY a.order_count) AS frequency
    FROM (
        SELECT o.user_id,
               COUNT(o.order_id) AS order_count
        FROM analysis.orders AS o
        WHERE o.order_ts >= '2022-01-01'
        GROUP BY o.user_id
        ORDER BY user_id
    ) as a
),
monetary_value AS (
    SELECT a.user_id,
       NTILE(5) OVER (ORDER BY a.payment_sum) AS monetary_value 
    FROM (
        SELECT o.user_id,
               SUM(o.payment) AS payment_sum
        FROM analysis.orders AS o
        LEFT JOIN analysis.orderstatuses AS os ON o.status=os.id
        WHERE o.order_ts >= '2022-01-01'
          AND os.key = 'Closed'
        GROUP BY o.user_id
        ORDER BY user_id
    ) as a
)
SELECT r.user_id,
       r.recency,
       f.frequency,
       mv.monetary_value
FROM recency AS r
LEFT JOIN frequency AS f ON r.user_id=f.user_id
LEFT JOIN monetary_value AS mv ON r.user_id=mv.user_id
ORDER BY r.user_id



user_id recency frequency monetary_value
0	1	5	  4
1	4	3	  3
2	2	3	  5
3	2	3	  3
4	4	3	  3
5	5	5	  5
6	1	2	  5
7	4	1	  2
8	1	1	  3
9	1	3	  2
