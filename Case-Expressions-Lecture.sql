--CASE

/**************************************************************************/
/*
CASE expressions are useful for custom classification/grouping of data.

CASE expressions have the following components:
(1) the CASE keyword
(2) the WHEN keyword
(3) the THEN keyword
(4) the ELSE keyword
(5) the END keyword
(6) a column alias, while not required, is recommended

If the results are grouped by a CASE statement, then they must be included in
the GROUP BY clause (without the column alias).
*/
/**************************************************************************/



/**************************************************************************/
/*  
A simple two-way CASE expression:

CASE WHEN [condition 1 evaluates True] THEN 'value1'
	 ELSE 'value2'
END 'two-way field'
*/

--classification (that is, without grouping)
select
businessentityid,
vacationhours,
CASE
	WHEN vacationhours >= 80 then '>= 2 weeks'
	ELSE '< 2 weeks'
END 'Remaining Vacation'
from [AdventureWorks].[HumanResources].[Employee]
order by vacationhours desc

--grouping
select
count(*) '# Employees',
CASE
	WHEN vacationhours >= 80 then '>= 2 weeks'
	ELSE '< 2 weeks'
END 'Remaining Vacation'
from [AdventureWorks].[HumanResources].[Employee]
group by 
	CASE
		WHEN vacationhours >= 80 then '>= 2 weeks'
		ELSE '< 2 weeks'
	END
--Note: full CASE expression included in GROUP BY
--Note: cannot refer to column alias in GROUP BY

select
count(*) '# Employees',
CASE
	WHEN vacationhours >= 80 then '>= 2 weeks'
	ELSE '< 2 weeks'
END 'Remaining Vacation'
from [AdventureWorks].[HumanResources].[Employee]
group by 
	CASE
		WHEN vacationhours >= 80 then '>= 2 weeks'
		ELSE '< 2 weeks'
	END
order by [Remaining Vacation] desc
--Note: can refer to column alias in ORDER BY
/**************************************************************************/



/**************************************************************************/
/*  
A three-way CASE expression:

CASE WHEN [condition 1 evaluates True] THEN 'value1'
	 WHEN [condition 2 evaluates True] THEN 'value2'
	 ELSE 'value3'
END 'three-way field'
*/

--classification (that is, without grouping)
select
businessentityid,
vacationhours,
CASE
	WHEN vacationhours >= 80 then '>= 2 weeks'
	WHEN vacationhours >= 40 then '>= 1 week' /* note: do not need AND vacationhours < 80 */
	ELSE '< 1 week'
END 'Remaining Vacation'
from [AdventureWorks].[HumanResources].[Employee]
order by vacationhours desc
/* Note: If a record evaluates as true on first condition, 
it will not proceed to next condition (where it would also 
technically be true) */

--grouping
select
count(*) '# Employees',
CASE
	WHEN vacationhours >= 80 then '>= 2 weeks'
	WHEN vacationhours >= 40 then '>= 1 week' /* note: again, do not need AND vacationhours < 80 */
	ELSE '< 1 week'
END 'Remaining Vacation'
from [AdventureWorks].[HumanResources].[Employee]
group by 
	CASE
		WHEN vacationhours >= 80 then '>= 2 weeks'
		WHEN vacationhours >= 40 then '>= 1 week' 
		ELSE '< 1 week'
	END
order by [Remaining Vacation] desc
/**************************************************************************/



/**************************************************************************/
/*  
A multi-way CASE expression:

CASE	
	WHEN [condition 1 evaluates True] THEN 'value 1'
	WHEN [condition 2 evaluates True] THEN 'value 2'
	...
	ELSE
CASE 
	WHEN [condition n-1 evaluates True] THEN 'value z-1'
	WHEN [condition n evaluates True] THEN 'value z'
	...
	ELSE 'value n'
[CASE WHEN ... END]
	END
END 'multi-way field'

NOTE: there must be an END for every CASE
*/

--grouping
select
count(*) '# Employees',
CASE
	WHEN maritalstatus = 'S' and vacationhours >= 80 then 'Single >= 2 weeks'
	WHEN maritalstatus = 'S' and vacationhours >= 40 then 'Single >= 1 week' 
	WHEN maritalstatus = 'S' and vacationhours < 40 then 'Single < 1 week'
	ELSE /* when none of above are true then go to the next CASE */
CASE
	WHEN maritalstatus = 'M' and vacationhours >= 80 then 'Married >= 2 weeks'
	WHEN maritalstatus = 'M' and vacationhours >= 40 then 'Married >= 1 week' 
	WHEN maritalstatus = 'M' and vacationhours < 40 then 'Married < 1 week'
	ELSE 'Unclassified' /* when none of above are true then classify */
END END 'Remaining Vacation' /* close both CASEs */

from [AdventureWorks].[HumanResources].[Employee]

group by
	CASE
		WHEN maritalstatus = 'S' and vacationhours >= 80 then 'Single >= 2 weeks'
		WHEN maritalstatus = 'S' and vacationhours >= 40 then 'Single >= 1 week' 
		WHEN maritalstatus = 'S' and vacationhours < 40 then 'Single < 1 week'
		ELSE /* when none of above are true then go to the next CASE */
	CASE
		WHEN maritalstatus = 'M' and vacationhours >= 80 then 'Married >= 2 weeks'
		WHEN maritalstatus = 'M' and vacationhours >= 40 then 'Married >= 1 week' 
		WHEN maritalstatus = 'M' and vacationhours < 40 then 'Married < 1 week'
		ELSE 'Unclassified' /* when none of above are true then classify */
	END END /* close both CASEs */

order by [Remaining Vacation] desc
/**************************************************************************/
