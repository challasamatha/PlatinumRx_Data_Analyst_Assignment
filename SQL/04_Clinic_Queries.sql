Q1 — Revenue from each sales channel in a given year

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;


Q2 — Top 10 most valuable customers in a given year 

(Value = total revenue spent)

SELECT 
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

Q3 — Month-wise revenue, expense, profit, status 

WITH rev AS (
    SELECT 
        cid,
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, month
),
exp AS (
    SELECT 
        cid,
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, month
)
SELECT 
    COALESCE(r.cid, e.cid) AS cid,
    COALESCE(r.month, e.month) AS month,
    COALESCE(revenue, 0) AS revenue,
    COALESCE(expense, 0) AS expense,
    (COALESCE(revenue, 0) - COALESCE(expense, 0)) AS profit,
    CASE 
        WHEN (COALESCE(revenue, 0) - COALESCE(expense, 0)) >= 0 
            THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM rev r
LEFT JOIN exp e 
    ON r.cid = e.cid AND r.month = e.month
UNION
SELECT 
    e.cid, e.month, 0, expense, -expense,
    'Not-Profitable'
FROM exp e
LEFT JOIN rev r 
    ON r.cid = e.cid AND r.month = e.month
WHERE r.cid IS NULL
ORDER BY month, cid;


Q4 — For each city, find the MOST profitable clinic for a given month

Profit = Revenue - Expense 

WITH profit_calc AS (
    SELECT 
        c.cid,
        c.city,
        DATE_FORMAT(cs.datetime, '%Y-%m') AS month,
        SUM(cs.amount) AS revenue,
        (SELECT COALESCE(SUM(e.amount),0)
         FROM expenses e
         WHERE e.cid = c.cid 
           AND DATE_FORMAT(e.datetime, '%Y-%m') = DATE_FORMAT(cs.datetime, '%Y-%m')
        ) AS expense
    FROM clinics c
    JOIN clinic_sales cs ON cs.cid = c.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY c.cid, c.city, month
), ranked AS (
    SELECT *,
        (revenue - expense) AS profit,
        RANK() OVER (PARTITION BY city, month ORDER BY (revenue - expense) DESC) AS rn
    FROM profit_calc
)
SELECT city, cid, month, profit
FROM ranked
WHERE rn = 1;


Q5 — For each state, find the 2nd least profitable clinic for a given month 

WITH profit_calc AS (
    SELECT 
        c.cid,
        c.state,
        DATE_FORMAT(cs.datetime, '%Y-%m') AS month,
        SUM(cs.amount) AS revenue,
        (SELECT COALESCE(SUM(e.amount),0)
         FROM expenses e
         WHERE e.cid = c.cid 
           AND DATE_FORMAT(e.datetime, '%Y-%m') = DATE_FORMAT(cs.datetime, '%Y-%m')
        ) AS expense
    FROM clinics c
    JOIN clinic_sales cs ON cs.cid = c.cid
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY c.cid, c.state, month
), ranked AS (
    SELECT *,
        (revenue - expense) AS profit,
        RANK() OVER (PARTITION BY state, month ORDER BY (revenue - expense) ASC) AS rn
    FROM profit_calc
)
SELECT state, cid, month, profit
FROM ranked
WHERE rn = 2;
