/* In-Class Assignment 5 */


/*************************************************************************************/
/* This is #1 Part A from Homework 4: */
		/* # 1 PART A: Join tables [Person] and [BusinessEntityAddress] (25 pts)
 
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
/*************************************************************************************/

/*************************************************************************************/
/* Instructions for In-Class-Assignment: Part A */
		/* We saw that [BusinessEntityAddress] has duplicate rows for the same [BusinessEntityID]
		when that [BusinessEntityID] has multiple address, such as a shipping and main address.

		The solution proposed relied on a somewhat difficult to remember point: Without accounting 
		for possible values from not matching, the query is an INNER JOIN!

		Therefore, the solution query was:

		select
			   a.[BusinessEntityID]
			  ,[FirstName]
			  ,[LastName]
			  ,[AddressID]
		from [AdventureWorks].[Person].[Person] a
		left join [AdventureWorks].[Person].[BusinessEntityAddress] b
		on a.[BusinessEntityID] = b.[BusinessEntityID]
		where addresstypeid in (2, 3) or addresstypeid is null

		We can also accomplish the results as show above with a nested SELECT or 
		a temporary table. */
/*************************************************************************************/



/* #1 So how can we re-write the solution to Part A with a nested SELECT? */

/* #2: So how can we re-write the solution to Part A with a temporary table? */



/*************************************************************************************/
/* Instructions for In-Class-Assignment: Part B */
		/* Write a single query with two joins to accomplish Parts A & C from Homework
		4 in one query.*/
/*************************************************************************************/