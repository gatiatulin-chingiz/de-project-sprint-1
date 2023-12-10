DROP VIEW IF EXISTS analysis.orders;
CREATE VIEW analysis.orders AS
WITH order_status AS (
    SELECT order_id,
           MAX(status_id) AS status_id
    FROM production.orderstatuslog
    GROUP BY order_id
)
SELECT o.order_id,
       o.order_ts,
       o.user_id,
       o.bonus_payment,
       o.payment,
       o."cost",
       o.bonus_grant,
       os.status_id AS status
FROM production.orders AS o
LEFT JOIN order_status AS os ON o.order_id=os.order_id