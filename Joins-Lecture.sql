--JOINs

/**************************************************************************/
/*
JOINs allow you to combine additional fields (i.e., columns) from one or more 
additional data sources, typically tables.

You join ON a particular field that is shared (a key) across the two tables. You can
also join on more than one field.

There are four main types of joins, each of which depend on whether a match
on the key is found. A join returns the selected fields from each table (or
all fields if using a *).

	(a) an INNER JOIN returns all values where the key is represented in each table. When a match
		is not found at the record-level in the other table, then the values from the record are not returned.
	(b) a LEFT (OUTER) JOIN will return ALL values for records from the first joined table (left) regardless of
		whether a match is returned from the second joined (right) table. If there is not a
		match in the second table, fields returned from the second joined table will have a NULL value.
	(c) a RIGHT (OUTER) JOIN will return ALL values for records from the second joined (right) table regardless of
		whether a match is returned from the first joined (left) table. If there is not a
		match in the first table, fields returned from the second joined table will have a NULL value.	 
	(d) a FULL (OUTER) JOIN returns ALL values for records regardless of whether 
		a key is represented in the other table

OUTER keyword is optional, but you will likely see it used some times in the real world and other times not.

There are also NATURAL JOINs. This is what Itzik Ben-Gan refers to as the ISO/ANSI SQL-89 Syntax.
These are not as safe.

The most difficult part about JOINs is when they don't work they way you anticipate.
*/
/**************************************************************************/



/**************************************************************************/
/**************************************************************************/
--Inner Join
/**************************************************************************/
/**************************************************************************/
	/**************************************************************************/
	/* 
	Inner Join: Example with pseudo-code

	select *
	from [table 1] a
	inner join [table 2] b
	on a.key = b.key
	--returns all fields from both tables
	--returns values for fields only for records where keys match

	select a.*, b.*
	from [table 1] a
	inner join [table 2] b
	on a.key = b.key
	--same as above

	select a.*
	from [table 1] a
	inner join [table 2] b
	on a.key = b.key
	--returns only values for records from a that are matched in both a and b
	*/
	/**************************************************************************/
	/**************************************************************************/
	/* Inner Join: Example with Fictitious Data */

	--first table
	select * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)

	--second table
	select * 
	from
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)

	--inner join with all results
	select * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	inner join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey

	--X.xkey refers to the xkey field in the X table
	--Y.ykey refers to the ykey field in the Y table

	/*	-keys 1, 2, and 500 are shared
		across the two tables
		-all are returned */
	/*	-x.key 4 does not have a match
		-y.key 3 does not have a match
		-neither are returned */

	 --inner join with limited results
	select 
	X.xkey 'key',
	X.xvalue,
	Y.yvalue 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	inner join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey

	--note: you do not need to refer to a table name if the field names are unique across them
	select 
	xkey 'key',
	xvalue,
	yvalue 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	inner join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on xkey = ykey

	--ambiguous column name returned otherwise
	select 
	xkey 'key',
	value
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, value)
	inner join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, value)
	on xkey = ykey

	/**************************************************************************/
	/**************************************************************************/
	/* Inner Join: Example with AdventureWorks */

	select *
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	inner join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	--columns 1-6 are from table a; 7-10 are from table b
	--too much information?

	select 
	businessentityid,
	a.departmentid, /* note that a table must be selected here */
	name 'departmentname',
	groupname,
	startdate,
	enddate
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	inner join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]

	/* REMEMBER: results in table a (employee records) are only listed 
	when their departmentid has a matach in the table b (department names). */
	
	/**************************************************************************/
/**************************************************************************/
/**************************************************************************/



/**************************************************************************/
/**************************************************************************/
--Left and Right Join
/**************************************************************************/
/**************************************************************************/
	/**************************************************************************/
	/* 
	Left Join: Example with pseudo-code

	select *
	from [table 1] a
	left join [table 2] b
	on a.key = b.key
	--returns all FIELDS in both tables regardless of whether a match
	--all a VALUES are returned
	--b VALUES are only returned if a.key has a matching b.key
	--when a match for b is not found in a, all a values are NULL


	Right Join: Example with pseudo-code

	select *
	from [table 1] a
	right join [table 2] b
	on a.key = b.key
	--returns all FIELDS in both tables regardless of whether a match
	--all b VALUES are returned
	--a VALUES are only returned if b.key has a matching a.key
	--when a match for a is not found in b, all a values are NULL

	/*ALL RIGHT JOINs can be written as LEFT JOINs and vice versa*/

	select a.*, b.*
	from [table 1] a
	left join [table 2] b
	on a.key = b.key
	
	--is equivalent to:

	select b.*, a.*
	from [table 2] a
	right join [table 1] b
	on a.key = b.key
	
	--The two queries return all values in [table 1]. The queries return values from
	[table 2] when a.key = b.key and NULL when a.key does not have a matching b.key
	

	--BUT these queries are not equivalent to:

	select a.*, b.*
	from [table 1] a
	right join [table 2] b
	on a.key = b.key

	--This query returns all values in [table 2]. The query returns values from
	[table 1] when a.key = b.key and NULL when b.key does not have a matching a.key
	
	*/
	/**************************************************************************/
	/**************************************************************************/
	/*Left and Right Joins: Example with Fictitious Data */

	--first table
	select * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)

	--second table
	select * 
	from
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)

	--left join with all results
	select X.*, Y.*
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	left join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey
	--note that all xkeys are represented

	--can be written as a right join (only column names are changed)
	select Y.*, X.*
	from
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as X(xkey, xvalue)
	right join 
	(values (1, 500), (2, 300), (4, 100), (500, 1000))  as Y(ykey, yvalue)
	on X.xkey = Y.ykey

	--right join on original query
	select X.*, Y.*
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	right join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey
	--note that all ykeys are represented

	/**************************************************************************/
	/**************************************************************************/
	/* Left and Right Joins: Example with AdventureWorks */
	/*LEFT JOIN*/
	select *
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	left join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	--columns 1-6 are from table a; 7-10 are from table b
	--the left join is appropriate when you want to ensure all employees are returned (i.e., all records in [EmployeeDepartmentHistory])

	select businessentityid
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	left join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	where b.[departmentid] is null
	--will return the businessentityid for any businessentityid that doesn't have a matching departmentid in [Department]


	/*RIGHT JOIN*/
	select *
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	right join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	--columns 1-6 are from table a; 7-10 are from table b; BUT NOT THE SAME AS LEFT JOIN
	--the right join is appropriate when you want to ensure all departmentids are returned(i.e., all records in [Department])

	select b.departmentid
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	right join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	where b.[departmentid] is null
	--will return the departmentid for any departmentid that doesn't have an employee in it
		
	/**************************************************************************/
/**************************************************************************/
/**************************************************************************/



/**************************************************************************/
/**************************************************************************/
--Full Join
/**************************************************************************/
/**************************************************************************/
	/**************************************************************************/
	/* 
	Full Join: Example with pseudo-code

	select *
	from [table 1] a
	full join [table 2] b
	on a.key = b.key

	--returns all fields in both tables regardless of whether a match
	--all a and b records are returned
	--when a match for b is not found in a, all a values are NULL
	--when a match for a is not found in b, all b values are NULL

	select *
	from [table 1] a
	full join [table 2] b
	on a.key = b.key
	where (a.key is null or b.key is null)

	--returns all values for records where there is not a match in the other table

	*/
	/**************************************************************************/
	/**************************************************************************/
	/* Full Join: Example with Fictitious Data */

	--first table
	select * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)

	--second table
	select * 
	from
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)

	--full join with all results
	select *
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	full join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey
	--note there are 5 records: ALL values in X and all in Y are represented

	--unmatched values
	select *
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	full join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey
	where (X.xkey is null or Y.ykey is null)

	--note there are 5 records: ALL values in X and all in Y are represented

	/**************************************************************************/
	/**************************************************************************/
	/* Full Join: Example with AdventureWorks */

	select *
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	full join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	--columns 1-6 are from table a; 7-10 are from table b

	select a.businessentityid, b.departmentid
	from 
	[AdventureWorks].[HumanResources].[EmployeeDepartmentHistory] a
	full join
	[AdventureWorks].[HumanResources].[Department] b
	on a.[DepartmentID] = b.[DepartmentID]
	where (a.[businessentityid] is null or b.[departmentid] is null)
	--we already know there are no unmatched values from the left and right joins above
		
	/**************************************************************************/
/**************************************************************************/
/**************************************************************************/