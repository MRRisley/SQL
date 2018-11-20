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
	/* Examples with Fictitious Data */

	--first table
	select 
	'X' as 'Table Name', * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)

	--second table
	select 'Y' as 'Table Name', * 
	from
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)

	--inner join with all results
	select 'Inner' as 'Join Type', * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	inner join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey

		--inner join with all results
	select 'Full' as 'Join Type', * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	full join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey

	select 'Left' as 'Join Type', * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	left join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey

		select 'Right' as 'Join Type', * 
	from
	(values (1, 500), (2, 300), (4, 100), (500, 1000)) as X(xkey, xvalue)
	right join 
	(values (3, 'yellow'), (500, 'blue'), (2, 'black'), (1, '')) as Y(ykey, yvalue)
	on X.xkey = Y.ykey
	/**************************************************************************/
/**************************************************************************/
/**************************************************************************/

