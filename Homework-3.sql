/*** Homework 3 ***/

/****************************************************
Instructions:
(1) All questions must be answered with a query.
(2) Name any returned columns without names with a relevant column name.
****************************************************/

/********************************************************************************
Note: In the order by clause, you can either use the column alias you provide for
the calculated field or you can use the calculation itself. This is NOT
the case for WHERE, GROUP BY, and HAVING clauses. For these clauses you must
provide the full function/calculation. 
********************************************************************************/



/****************************************************
#1-3 [AdventureWorks].[Production].[ProductInventory] 
****************************************************/

/* Answer with a query:
#1: Return the total quantity for each ProductID regardless of product location (i.e., 
this will require a GROUP BY statement). Exclude groupings that have quantities less than
100. Order by ProductID in ascending order. 
(12.5 pts) */

/* Answer with a query:
#2: Return the total quantity for each LocationID regardless of product. 
Order the results by the total quantity in descending order. 
(12.5 pts) */

/* Answer with a query:
#3: Return the total number of records modified each year. Sort
by year in ascending order. Include only years 2012-2015. 
(12.5 pts) */



/***********************************************************
#4   [AdventureWorks].[Production].[ProductListPriceHistory] 
***********************************************************/

/* Answer with a query:
#4: Return the current listprice for each productid. The current listprice
for each product is the record with a NULL value for the enddate field. Round
each listprice to a single decimal place. Thus, for productid 707, the current
list price should read 35.0. Order the results by the list price in descending 
order. 

Hint: you may need to first return the max listprice in order to see what precision is
required. 
(10 pts) */



/*******************************************
#5-8  [AdventureWorks].[Production].[Product]
********************************************/

/* Answer with a query:
#5: Return the count of products by their color (note that each productid only
has a single record). Exclude products with a NULL color. Sort the results by
the count of products in descending order. 
(12.5 pts) */


/* Answer with a query:
#6: Return the first three columns in the table and add 
an additional column as the fourth column. Name this column
'description'. This column should join 
both productnumber and name in a single field. Separate
productnumber and name with a space.

For example, productid 1 should read 'AR-5381 Adjustable Race'
in this 'description' field.  
(10 pts) */


/* Answer with a query:
#7: How many products (records) have a Class with a value of 'M' or 'H'? 
(7.5 pts) */


/* Answer with a query:
#8: How many products (records) are exist for each
class value that is not 'M' or 'H'? 
Ensure that all possible values for this field 
are included. 

This means that sum of counts in #7 and #8 should 
equal the total number of records in the table. 
(10 pts) */



/*******************************************
#9-10  (No table)
********************************************/

/* Answer with a query:
#9: How many characters are in the following two sentences?

'In SQL Server (Transact-SQL), the LEN function returns the length of the specified string. It is important to note that the LEN function does not include trailing space characters at the end the string when calculating the length.'
(5 pts) */


/* Answer with a query:
#10: Use the DATEDIFF function to return the number of years, months, and days between
January 1, 1903, and March 1, 1986. You can ignore fractional units.
(7.5 pts) */
