INSERT INTO analysis.tmp_rfm_monetary_value
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
ORDER BY a.payment_sum DESC