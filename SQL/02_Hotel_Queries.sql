Q1 — For every user, get user_id, last booked room_no

SELECT user_id, room_no, booking_date
FROM (
    SELECT 
        user_id,
        room_no,
        booking_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) AS t
WHERE rn = 1;

Q2 — For bookings created in November 2021, get booking_id and total bill 

SELECT 
    bc.booking_id,
    ROUND(SUM(bc.item_quantity * i.item_rate), 2) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-11-01' AND '2021-11-30 23:59:59'
GROUP BY bc.booking_id;

Q3 — Bills raised in October 2021 with amount > 1000 

SELECT 
    bc.bill_id,
    ROUND(SUM(bc.item_quantity * i.item_rate), 2) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date BETWEEN '2021-10-01' AND '2021-10-31 23:59:59'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

Q4 — For each month, get the most and least ordered item

WITH monthly_totals AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT 
        month,
        item_id,
        total_qty,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS rnk_max,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS rnk_min
    FROM monthly_totals
)
SELECT 
    month,
    item_id,
    total_qty,
    CASE 
        WHEN rnk_max = 1 THEN 'Most Ordered'
        WHEN rnk_min = 1 THEN 'Least Ordered'
    END AS category
FROM ranked
WHERE rnk_max = 1 OR rnk_min = 1
ORDER BY month, category;

Q5 — Get the 2nd highest bill amount and its bill_id 

WITH bill_totals AS (
    SELECT 
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY bc.bill_id
),
ranked AS (
    SELECT 
        bill_id,
        bill_amount,
        DENSE_RANK() OVER (ORDER BY bill_amount DESC) AS rnk
    FROM bill_totals
)
SELECT bill_id, bill_amount
FROM ranked
WHERE rnk = 2;
