--UNION

/**************************************************************************/
/*
UNION combines results (i.e., rows) from two or more queries. 

This means:
(a) the tables contain the same fields
(b) the order of the queries does not matter

A UNION is inserted between each query whose results who want to combine.
*/
/**************************************************************************/



/**************************************************************************/
--joining two queries
select
'Ford',
'F-150',
'Blue'
union
select
'Ford',
'Taurus',
'Green'

--Note that column names from the first query are retained for the results
select
'Ford' as make,
'F-150' as model,
'Blue' as color
union
select
'Ford' as make_2,
'Taurus',
'Green' as color_b
/**************************************************************************/



/**************************************************************************/
--joining three queries
select
'Ford' as make,
'Taurus' as model,
'Green' as color
union
select
'Dodge',
'Challenger',
'Red'
union
select
'Ford',
'F-150',
'Blue'

--Note: ORDER BY can only follow all UNIONs
--results in error
select
'Ford' as make,
'Taurus' as model,
'Green' as color
order by make
union
select
'Dodge',
'Challenger',
'Red'
union
select
'Ford',
'F-150',
'Blue'

--Note: ORDER BY can only follow all UNIONs
--fixed code; adding parentheses may aid in interpretability
select
'Ford' as make,
'Taurus' as model,
'Green' as color
union
select
'Dodge',
'Challenger',
'Red'
union
select
'Ford',
'F-150',
'Blue'
order by make, model, color
/**************************************************************************/