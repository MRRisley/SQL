/*** Nested SELECT ***/

/* 
A nested SELECT is a query, contained within parentheses, that is used in the main query. 
*/

--Here is a redundant nested select:
select *
from
(select * from [AdventureWorks].[Person].[Person]) a
--Note that the nested select, when used like a table, must receive a table alias

--The nested select limits what is returned in the main query:
select
	[First], 
	[Middle], 
	[Last]
from
	(
	select top 10 
		FirstName 'First', 
		MiddleName 'Middle',
		LastName 'Last' 
	from [AdventureWorks].[Person].[Person]
	) a
--Note that using 'FirstName' in the main select list will return an error because
--the nested SELECT is processed first.

--Nested SELECTs can be used in clauses as well:
select *
from [AdventureWorks].[Person].[Person]
where [BusinessEntityID] not in 
	(select [BusinessEntityID]
	from [AdventureWorks].[Person].[BusinessEntityAddress])
--Note that this is the answer to Part B in Homework 4
--Note that when not used in the FROM clause, there is no table alias

/*
Be wary: nested SELECTs can quickly decrease the efficiency of queries!
Temporary tables can alleviate this.
*/

