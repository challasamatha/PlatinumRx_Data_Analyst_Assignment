PlatinumRx Data Analyst Assignment – README

This project demonstrates proficiency in SQL, Spreadsheet Data Analysis, and Python programming.
It covers real-world scenarios for Hotel Management, Clinic Management, and Customer Support Ticket Systems.

The assignment evaluates:

Database design & querying

Data lookup & time-based spreadsheet analysis

Programming logic with loops, arithmetic, and date/time handling

📁 Project Structure
PlatinumRx_Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
│
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
│
└── README.md

 Phase 1 – SQL Proficiency

This assignment includes two database systems:

Hotel Management Database

Clinic Management Database

A. Hotel Management System
 Step 1: Database Setup

Created SQL tables:

users

bookings

items

booking_commercials

booking_items_mapping

Inserted all sample values as provided.

Step 2: SQL Query Solutions

Find last booked room for a given user
→ Used MAX(checkin_date) or sorted by date.

Calculate total billing for bookings in Nov 2021
→ Joined bookings + commercials + items.
→ Aggregated using SUM(qty * rate).

Find bookings with total bill > 1000
→ Used GROUP BY and HAVING.

Find most & least ordered items month-wise
→ Used GROUP BY MONTH(item_date) + window functions (ROW_NUMBER, RANK).

Find the 2nd highest bill for a given month
→ Applied ranking using ROW_NUMBER() or DENSE_RANK().

All final SQL stored in /SQL/02_Hotel_Queries.sql.

B. Clinic Management System

Tables created:

clinics

customer

clinic_sales

expenses

Sample values inserted exactly as provided.

SQL Solutions

Revenue from each sales channel (Year-wise)
→ GROUP BY sales_channel

Top 10 highest-value customers (Year-wise)
→ SUM(amount) + ORDER BY DESC + LIMIT 10

Month-wise Revenue, Expense & Profit with Status
→ Revenue = SUM from clinic_sales
→ Expense = SUM from expenses
→ Profit = Revenue − Expense
→ Status = CASE WHEN Profit > 0 THEN "Profitable" ELSE "Not Profitable" END

Most profitable clinic per city (per month)
→ MONTH( date ) aggregation + ranking.

Second-least profitable clinic per state (per month)
→ Used RANK() to identify 2nd lowest profit.

All final SQL stored in /SQL/04_Clinic_Queries.sql.

Phase 2 – Spreadsheet Proficiency

Sheets used:

ticket

feedbacks

Columns (ticket):

ticket_id

created_at

closed_at

outlet_id

cms_id

Columns (feedbacks):

outlet_id

cms_id

feedback

(We add created_at using INDEX)

Task 1: Bring created_at from ticket → feedbacks 

=INDEX(ticket!B:B,
       MATCH(SUBSTITUTE(TRIM(CLEAN(A2)),CHAR(160),""), 
             SUBSTITUTE(TRIM(CLEAN(ticket!E:E)),CHAR(160),""), 0))

Task 2: Time Analysis – Same Day & Same Hour 

=LEFT(RIGHT(B2,8),2) = LEFT(RIGHT(C2,8),2) 


Phase 3 – Python Proficiency

Task 1: Convert Minutes → Hours/Minutes

File: Python/01_Time_Converter.py

Logic:

hours = minutes // 60

remaining = minutes % 60


Task 2: Remove Duplicate Characters from a String

File: Python/02_Remove_Duplicates.py

Logic:

Loop through characters
If not in result → add it

Author 

Name : Challa Samatha 
Email : samathachowdary2004@gmail.com

