/*** Homework 3 ***/

/****************************************************
Instructions:
(1) All questions must be answered with a query.
(2) Name any returned columns without names with a relevant column name.
****************************************************/

/****************************************************
#1 A-C: Use the [Person] schema in [AdventureWorks]
****************************************************/

/* PART A: Join tables [Person] and [BusinessEntityAddress] (20 pts)
 
We always want to return results from the [Person] table regardless of whether there
is a match in the other table.

Return these fields from [Person] table:
	   [BusinessEntityID]
      ,[FirstName]
      ,[LastName]

Return this field from [BusinessEntityAddress] table:
       [AddressID]

So, the results should have 4 columns.

The primary key is [BusinessEntityID], which is shared between the two tables. */


/* PART B: Find unmatched (15 pts)

Return [BusinessEntityID] when a [BusinessEntityID]
in the [Person] table has no matching [AddressID] field
in the [BusinessEntityAddress] table. As in the real world, 
all IDs may have a match. */


/* PART C: Join tables [BusinessEntityAddress] and [Address] (30 pts)
 
We always want to return results from the [BusinessEntityAddress] table regardless of whether there
is a match in the other table.

Return these fields from [BusinessEntityAddress] table:
	   [BusinessEntityID]
      ,[AddressID]

Return these fields from [Address] table:
      [AddressLine1]
      ,[AddressLine2]
      ,[City]
      ,[StateProvinceID]
      ,[PostalCode]

So, the results should have 7 columns. For [AddressLine2], return an empty string, '', 
if the field is NULL.

The primary key is [AddressID], which is shared between the two tables. */



/****************************************************
#2 A-B Use [AdventureWorks].[Production].[ProductListPriceHistory]
****************************************************/

/* PART A: Create a segmentation for [ListPrice]. (25 pts)

Use a CASE expression to count the number of ProductID in the following segments:
(1) listprice = 0
(2) listprice > 0 and <= 25
(3) listprice > 25 and <= 100
(4) listprice > 100

Be sure to:
(1) Only include records when the [EndDate] field is null. This implies that this is
    the current listprice and not a listprice from the past.
(2) Name the segments and the column alias with intuitive names.
(3) Group by your CASE expression. */


/* PART B: Check for duplicates.  (10 pts)

Ensure that only including records when the [EndDate] field is null does not return
more duplicate [ProductID]. */

