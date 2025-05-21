--- 1.Retrieve the full name and email of all customers who joined after January 1, 2023. 
SELECT
    FirstName,
	LastName,
	JoinDate 
FROM 
    Customers
WHERE 
    JoinDate > '1-1-2023';

	
--- 2 . Find the total amount of completed orders for each customer. 
SELECT 
     c.FirstName,
	 c.LastName,
	 sum(o.OrderAmount) as Total_order_amount
FROM
    Customers c
JOIN
   Orders o ON c.CustomerId = o.CustomerId
WHERE 
   OrderStatus = 'Completed'
 GROUP BY 
    c.CustomerID, c.FirstName, c.LastName;

--- 3 .List all unresolved support tickets (Status = 'Open' or 'In Progress') along with the customer's name. 
SELECT
     c.FirstName,
	 c.LastName,
	 s.Status
FROM
    Customers c 
JOIN 
   SupportTickets s ON c.CustomerID = s.CustomerID
WHERE 
   Status = 'Open' or Status = 'In Progress'

--- 4. Retrieve the most recent interaction for each customer. 
SELECT 
    c.FirstName,
	c.LastName,
	i.InteractionType,
	i.InteractionDate
FROM 
    Customers c
JOIN
   Interactions i  ON c.CustomerID = i.CustomerID
where 
i.InteractionDate = (select max(InteractionDate) from Interactions where CustomerID = i.CustomerID )

--- 5. Count the number of customers in each country. 
SELECT 
    Country,
    COUNT(*) AS CustomerCount
FROM 
    Customers
GROUP BY 
    Country

--- 6. List customers who have placed no orders. 
SELECT 
    c.CustomerId,
	c.FirstName,
	c.LastName
FROM
    Customers c 
LEFT JOIN 
    Orders o  ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID is Null

--- 7. Identify customers who have both unresolved support tickets and pending orders.
SELECT 
    c.FirstName,
	c.LastName,
	o.OrderStatus,
	s.Status
FROM 
   Customers c
JOIN 
   Orders o ON c.CustomerID = o.CustomerID
JOIN
  SupportTickets s ON c.CustomerID = s.CustomerID
WHERE
 s.Status IN ('Open','In Progress') AND
 OrderStatus = 'Pending'

--- 8 .Calculate the average order amount for each order status. 
SELECT 
  Avg(OrderAmount) as Average_order_amount,
  OrderStatus
FROM 
Orders
GROUP BY 
OrderStatus

--- 9. List all customers who have interacted with the company via email in the past month. 
SELECT 
    c.FirstName,
	c.LastName,
	c.CustomerId,
	c.Email,
	i.InteractionType
FROM
   Customers c 
JOIN 
  Interactions i  ON c.CustomerId = i.CustomerId
 WHERE 
 i.InteractionType = 'Email'
  AND i.InteractionDate >= DATEADD(DAY, -30, GETDATE());

--- 10. Show the top 5 customers with the highest total order amount. 
SELECT 
   c.FirstName,
   c.LastName,
   c.CustomerId,
   SUM(o.OrderAmount) as total_order_amount
FROM 
   Customers c
JOIN
  Orders o  ON c.CustomerId = o.CustomerId
  GROUP BY 
    c.CustomerID, c.FirstName, c.LastName
ORDER BY 
    total_order_amount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;





