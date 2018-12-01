/*** Homework 4 Join Deep Dive ***/

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

select
	   a.[BusinessEntityID]
      ,[FirstName]
      ,[LastName]
	  ,[AddressID]
from [AdventureWorks].[Person].[Person] a
left join [AdventureWorks].[Person].[BusinessEntityAddress] b
on a.[BusinessEntityID] = b.[BusinessEntityID]
--19996 records

select count(*) from [AdventureWorks].[Person].[Person] --this has 19972 records

/*
Why did it return more records? Because there was more than one record (in either
or both tables) with the SAME [BusinessEntityID]. 

If a key is represented twice in a table, each iteration of that key will be matched.
*/ 

select businessentityid, count(*) 
from [AdventureWorks].[Person].[Person] 
group by businessentityid having count(*) > 1

/*
The left table does not have duplicate keys, so the right table must.

If a single key in left has two keys in the right table, the results will contain two
results for that key.
*/

select *
from
	(values (1, 500), (2, 300), (3, 100), (4, 1000)) as X(xkey, xvalue)
	left join 
	(values (1, 'yellow'), (1, 'blue'), (2, 'black'), (3, '')) as Y(ykey, yvalue)
	on xkey = ykey

select [BusinessEntityID], count(*) 'count'
from [AdventureWorks].[Person].[BusinessEntityAddress]
group by [BusinessEntityID] having count(*) >= 2
--several duplicates

/*
Why would there be duplicates? In most cases, there is a logical reason 
other than terrible data.

Let's see what's in the right table for some of those duplicate results.
*/

select * from [AdventureWorks].[Person].[BusinessEntityAddress]
where [BusinessEntityID] in (332, 430, 472) order by [BusinessEntityID]
--the same BusinessEntityID can have a different AddressID and a different AddressTypeID

/* 
AddressType must mean something 
*/

select distinct addresstypeid from [AdventureWorks].[Person].[BusinessEntityAddress]
--2, 3, and 5 are only values

select * FROM [AdventureWorks].[Person].[AddressType] 
--should exclude type 5 and 6

/* 
Introduce logic
*/

select [BusinessEntityID], count(*)
from [AdventureWorks].[Person].[BusinessEntityAddress]
where addresstypeid in (2, 3)
group by [BusinessEntityID] having count(*) >= 2
--no more duplicates

/*
corrected query
*/

select
count(*)
from [AdventureWorks].[Person].[Person] a
left join [AdventureWorks].[Person].[BusinessEntityAddress] b
on a.[BusinessEntityID] = b.[BusinessEntityID]
where addresstypeid in (2, 3)
--18774 records; remember table a had 


/*
Why are not all of the a table values represented?

Because we did not account for the fact that if
a.[BusinessEntityID] is not found in table b, then
[AddressTypeID] is NULL
*/

select
	   a.[BusinessEntityID]
      ,[FirstName]
      ,[LastName]
	  ,[AddressID]
from [AdventureWorks].[Person].[Person] a
left join [AdventureWorks].[Person].[BusinessEntityAddress] b
on a.[BusinessEntityID] = b.[BusinessEntityID]
where addresstypeid in (2, 3) or addresstypeid is null

--without accounting for possible values from not matching,
--the query is an INNER JOIN!

select
	   a.[BusinessEntityID]
      ,[FirstName]
      ,[LastName]
	  ,[AddressID]
from [AdventureWorks].[Person].[Person] a
inner join [AdventureWorks].[Person].[BusinessEntityAddress] b
on a.[BusinessEntityID] = b.[BusinessEntityID]
where addresstypeid in (2, 3) or addresstypeid is null

/*
Moral of the story is that you must always check to see if your Primary Key is unique in a table!!!
*/

