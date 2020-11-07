/*
1.
Show the first name and the email address of customer with CompanyName 'Bike World'
 */

SELECT
  firstname, emailaddress
FROM
  Customer
WHERE
  CompanyName='Bike World';

/*
2.
Show the CompanyName for all customers with an address in City 'Dallas'.
 */

SELECT
  Customer.CompanyName, Address.City FROM Customer
INNER JOIN
  CustomerAddress ON CustomerAddress.CustomerId=Customer.CustomerId
INNER JOIN
  Address ON CustomerAddress.AddressID=Address.AddressID
WHERE
  Address.City='Dallas'

/*
3.
How many items with ListPrice more than $1000 have been sold?
 */

SELECT
  Customer.CompanyName
FROM
  SalesOrderHeader
JOIN
  Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE
  SalesOrderHeader.SubTotal + SalesOrderHeader.TaxAmt + SalesOrderHeader.Freight > 100000;

/*
4.
Give the CompanyName of those customers with orders over $100000.
Include the subtotal plus tax plus freight.
 */

SELECT
  Customer.CompanyName
FROM
  Customer
INNER JOIN
  SalesOrderHeader on Customer.CustomerID=SalesOrderHeader.CustomerID
WHERE
  SubTotal+TaxAmt+Freight>100000

/*
5.
Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
 */

SELECT
  sum(SalesOrderDetail.OrderQty)
FROM
  SalesOrderDetail
INNER JOIN
  SalesOrderHeader ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
INNER JOIN
  Customer ON Customer.CustomerID=SalesOrderHeader.CustomerID
INNER JOIN
  Product ON SalesOrderDetail.ProductID=Product.ProductID
WHERE
  Customer.CompanyName='Riding Cycles' and Product.Name='Racing Socks, L';

/*
6.
A "Single Item Order" is a customer order where only one item is ordered.
Show the SalesOrderID and the UnitPrice for every Single Item Order.
 */

SELECT
  SalesOrderID, UnitPrice
FROM
  SalesOrderDetail
WHERE
  OrderQty=1;

/*
7.
Where did the racing socks go? List the product name and the CompanyName for all
Customers who ordered ProductModel 'Racing Socks'.
 */

SELECT
  Product.Name, Customer.CompanyName
FROM
  Customer
INNER JOIN
  SalesOrderHeader ON Customer.CustomerID=SalesOrderHeader.CustomerID
INNER JOIN
  SalesOrderDetail ON SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID
INNER JOIN
  Product ON SalesOrderDetail.ProductID=Product.ProductID
INNER JOIN
  ProductModel ON Product.ProductModelID=ProductModel.ProductModelID
WHERE
  ProductModel.Name='Racing Socks'

/*
8.
Show the product description for culture 'fr' for product with ProductID 736.
 */

SELECT
  ProductDescription.Description
FROM
  ProductDescription
INNER JOIN
  ProductModelProductDescription ON ProductDescription.ProductDescriptionID=ProductModelProductDescription.ProductDescriptionID
INNER JOIN
  Product ON Product.ProductModelID=ProductModelProductDescription.ProductModelID
WHERE
  ProductModelProductDescription.Culture='fr' and Product.ProductID=736

/*
9.
Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest.
For each order show the CompanyName and the SubTotal and the total weight of the order.
 */

SELECT
  Customer.CompanyName, SalesOrderHeader.SubTotal, SUM(SalesOrderDetail.OrderQty*Product.Weight)
FROM
  Customer
INNER JOIN
  SalesOrderHeader ON SalesOrderHeader.CustomerID=Customer.CustomerID
INNER JOIN
  SalesOrderDetail ON SalesOrderDetail.SalesOrderID=SalesOrderHeader.SalesOrderID
INNER JOIN
  Product ON Product.ProductID=SalesOrderDetail.ProductID
GROUP BY
  Customer.CompanyName, SalesOrderHeader.SubTotal
ORDER BY
  SalesOrderHeader.SubTotal DESC;

/*
10.
How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
 */

SELECT
  COUNT(SalesOrderDetail.OrderQty)
FROM
  ProductCategory
INNER JOIN
  Product on Product.ProductCategoryID=ProductCategory.ProductCategoryID
INNER JOIN
  SalesOrderDetail on SalesOrderDetail.ProductID=Product.ProductID
INNER JOIN
  SalesOrderHeader on SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID
INNER JOIN
  Address on Address.AddressID=SalesOrderHeader.ShipToAddressID
WHERE
  ProductCategory.Name='Cranksets' AND Address.City='London'
