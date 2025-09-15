SELECT  --join tables
    SUM(o.Quantity) AS total_amount,
    p."Product Name"
FROM
    customer AS c
JOIN
    orders AS o ON c."Customer ID" = o."Customer ID"
JOIN
    products AS p ON p."Product ID" = o."Product ID"
GROUP BY
    p."Product Name"
ORDER BY
    total_amount DESC;



SELECT   --number of customers base on region
	Region, COUNT(DISTINCT"customer ID") AS clients
FROM 
	customer
GROUP BY
	 Region
ORDER BY 
	COUNT(DISTINCT"customer ID") DESC;



SELECT   --Total sales base on region
 c.Region, SUM(o.Sales) AS Total_sales
FROM 
	customer c
JOIN
	 orders  o 
ON c."Customer ID" = o."Customer ID"  
GROUP BY
	 c.Region 
ORDER BY
	 SUM(o.Sales) DESC;



SELECT   --Loyal customers
	 c."Customer Name", SUM(o.Sales) AS Total_spend, COUNT(o."Order ID") AS Total_orders  
FROM 
	customer  c
JOIN 
	orders  o
ON c."Customer ID" = o."Customer ID"
GROUP BY 
	c."Customer Name"
ORDER BY
	 Total_spend DESC
LIMIT 30;



SELECT    --initial review of discounts
	Discount
FROM 
	orders
ORDER BY
	 Discount DESC;



SELECT    --calculating profits base on customers in each segment
    c.Segment,
    SUM(o.Profit) AS Total_Profit,
    COUNT(DISTINCT c."Customer ID") AS Total_Customers
FROM
    customer AS c
JOIN
    orders AS o ON c."Customer ID" = o."Customer ID"
GROUP BY
    c.Segment;



SELECT    --calculating profits for each sub_category
    p.Category,
    p."Sub-Category" AS "Sub_Category",
    SUM(o.Profit) AS "Total_profit",
    SUM(o.Sales) AS "Total_sales"
FROM
    products AS p
JOIN
    orders AS o ON p."Product ID" = o."Product ID"
GROUP BY;



--calculation average discount on top selling products
WITH Top_10_Profitable_Products AS (
    SELECT
        "Product ID",
        SUM(Profit) AS Total_Profit
    FROM
        orders
    GROUP BY
        "Product ID"
    ORDER BY
        Total_Profit DESC
    LIMIT 10
)
SELECT
    AVG(o.Discount) AS Average_Discount_on_Top_Products
FROM
    orders AS o
JOIN
    Top_10_Profitable_Products AS t ON o."Product ID" = t."Product ID";



--calculating average discounts on low-selling products
WITH Bottom_10_Unprofitable_Products AS (
    SELECT
        "Product ID",
        SUM(Profit) AS Total_Profit
    FROM
        orders
    GROUP BY
        "Product ID"
    ORDER BY
        Total_Profit ASC
    LIMIT 10
)
SELECT
    AVG(o.Discount) AS Average_Discount_on_Bottom_Products
FROM
    orders AS o
JOIN
    Bottom_10_Unprofitable_Products AS b ON o."Product ID" = b."Product ID";

