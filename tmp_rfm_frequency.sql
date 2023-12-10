INSERT INTO analysis.tmp_rfm_frequency
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
ORDER BY order_count DESC