INSERT INTO analysis.tmp_rfm_recency
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
ORDER BY last_order_dt