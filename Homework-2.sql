/********************************************************************************
Homework #2 

All questions MUST be answered with a query to show how you arrived at the answer
********************************************************************************/


/*******************************************************************
Use [AdventureWorks].[Person].[Address] for questions 1-3
*******************************************************************/
--#1: How many records have a city of York? Note: Strings, such as 
--York, must be enclosed in single apostrophes, i.e., 'York'
--(10 pts)

--#2: How many records were modified in 2014 according to the field
--ModifiedDate? Note: dates must also be inclused in single 
--apostrophes, e.g., '12/31/2013' (10 pts)
	
--#3: Return only AddressID and City for records with StateProvinceId 
--of 8. Also, sort the records first by City, then AddressID, both
--in ascending order. (10 pts)
/******************************************************************/


/*******************************************************************
#4: According to [AdventureWorks].[HumanResources].[Shift], what is 
the StartTime for the work shift with the name "Day"? (10 pts)
*******************************************************************/


/*******************************************************************
#5: In [AdventureWorks].[Person].[BusinessEntityAddress],
	what is the BusinessEntityID associated with the 
	AddressID of 665? (10 pts)
*******************************************************************/


/*******************************************************************
#6: In [AdventureWorks].[Production].[ProductCostHistory],
	what is the current StandardCost for ProductID 711?
	Hint: Sort StartDate in descending order. (15 pts)
*******************************************************************/


/*******************************************************************
Use [AdventureWorks].[Production].[ProductInventory] 
for questions 7-10.
*******************************************************************/
--#7: How many products in inventory have a 
--	LocationID of 60? (5 pts)

--#8: How many products in inventory have a 
--	quantity less than 50? (5 pts)

--#9: How many products (i.e., not total quantity) 
--have a bin of zero? (5 pts)

--#10: Use the SUM function to return the inventory quantity for 
--ach LocationID. Name the returned column 'Total'.
--Sort LocationID in ascending order. (20 pts)
/******************************************************************/


