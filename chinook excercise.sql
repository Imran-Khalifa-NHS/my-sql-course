
/*
The Chinook database contains details of an online music store.
Here are some example answers to the question
*/

-- List all customers
SELECT * 
FROM Customer c 

-- List all customers. Show only the CustomerId, FirstName and LastName columns
SELECT CustomerId, 
       FirstName, 
       LastName 
FROM Customer c 


-- List customers in the United Kingdom  
SELECT CustomerId, 
       FirstName, 
       LastName 
FROM Customer c 
WHERE Country = 'United Kingdom'

-- List customers whose first names begins with an A.
-- Hint: use LIKE and the % wildcard
SELECT CustomerId, 
       FirstName, 
       LastName 
FROM Customer c 
WHERE FirstName LIKE 'A%'

-- List Customers with an apple email address
SELECT CustomerId, 
       FirstName, 
       LastName ,
       c.Email
FROM Customer c 
WHERE c.Email LIKE '%@apple.com'


-- Which customers have the initials LK?
SELECT CustomerId, 
       FirstName, 
       LastName 
FROM Customer c 
WHERE FirstName LIKE 'L%' AND LastName LIKE 'K%'


-- Which are the corporate customers i.e. those with a value, not NULL, in the Company column?
SELECT CustomerId, 
       FirstName, 
       LastName,
       Company,
       *
FROM Customer c 
WHERE c.Company IS NOT NULL AND c.Company != ''

-- How many customers are in each country.  Order by the most popular country first.
SELECT Country, 
       COUNT(*) AS NumberOfCustomers
FROM Customer c
GROUP BY Country
ORDER BY NumberOfCustomers DESC

-- When was the oldest employee born?  Who is that?
SELECT TOP 1
       EmployeeId, 
       FirstName, 
       LastName, 
       BirthDate
FROM Employee e
ORDER BY BirthDate ASC

SELECT  TOP 1
       MIN(BirthDate) AS MBirthDate
FROM Employee e

-- List the 10 latest invoices. Include the InvoiceId, InvoiceDate and Total
SELECT TOP 10
       InvoiceId, 
       InvoiceDate, 
       Total
FROM Invoice i
ORDER BY InvoiceDate DESC
-- Then  also include the customer full name (first and last name together)
SELECT TOP 10
       InvoiceId, 
       InvoiceDate, 
       Total,
       c.FirstName + ' ' + c.LastName AS CustomerName
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
ORDER BY InvoiceDate DESC

-- List the customers who have spent more than £45
SELECT c.CustomerId, 
       c.FirstName, 
       c.LastName, 
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
HAVING SUM(i.Total) > 45
ORDER BY TotalSpent DESC

-- List the City, CustomerId and LastName of all customers in Paris and London, 
-- and the Total of their invoices
SELECT c.City, 
       c.CustomerId, 
       c.LastName, 
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE c.City IN ('Paris', 'London')
GROUP BY c.City, c.CustomerId, c.LastName
ORDER BY TotalSpent DESC
	
-- Show all details about customer Michelle Brooks.  List salient details of her invoices.
SELECT *
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE c.FirstName = 'Michelle' AND c.LastName = 'Brooks'

/*
Which employees were born in the 1960s?  Show only the EmployeeId, FirstName, LastName and BirthDate columns
Note: Define a date value as with the region independent format 'yyyy-mm-dd' e.g. '1969-12-31'*/
SELECT EmployeeId, 
       FirstName, 
       LastName, 
       BirthDate
FROM Employee e
WHERE BirthDate >= '1960-01-01' AND BirthDate < '1970-01-01'



-- List countries, and the number of customers and the total invoiced amount
SELECT Country, 
       COUNT(DISTINCT c.CustomerId) AS NumberOfCustomers,
       SUM(i.Total) AS TotalInvoiced
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY Country
ORDER BY TotalInvoiced DESC
-- Order  high to low in terms of the number of customers
SELECT Country, 
       COUNT(DISTINCT c.CustomerId) AS NumberOfCustomers,
       SUM(i.Total) AS TotalInvoiced
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY Country
ORDER BY NumberOfCustomers DESC

-- What are the top 10 most popular artists in terms of number of tracks bought by customers?
SELECT TOP 10
       a.Name AS ArtistName,
       COUNT(*) AS NumberOfTracksBought
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY a.Name
ORDER BY NumberOfTracksBought DESC

-- List the albums in alphabetical order of Title
SELECT Title
FROM Album
ORDER BY Title ASC

-- List 10 albums and their artist.  Order by album title.
SELECT TOP 10
       a.Name AS ArtistName,
       al.Title AS AlbumTitle
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
ORDER BY al.Title ASC