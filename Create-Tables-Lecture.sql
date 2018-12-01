/*** creating tables ***/

/*
Example #1: Create Table with SELECT ... INTO

(a) Not available in PL/SQL
(b) When you get a real-world job, do not create permanent
	tables until you speak to your DBA and also understand
	the potential size of the table you create. Your DBAs
	will thank you.
*/

select
	[FirstName],
	[MiddleName],
	[LastName]
into adventureworks.dbo.r_names --the into clause comes before the from clause
from [AdventureWorks].[Person].[Person]
where left([LastName], 1) = 'R' 
order by [LastName], [FirstName], [MiddleName] --you can introduce any clause you wish for the query

select *
from adventureworks.dbo.r_names

--Note that when the table exists, you cannot SELECT ... INTO

--Delete the table:
drop table adventureworks.dbo.r_names


/*
Example #2: Create Table with CREATE and INSERT INTO

(a) Allows you to specify data types rather than inheriting them
	from another table.
(b) Again, when you get a real-world job, do not create permanent
	tables until you speak to your DBA and also understand
	the potential size of the table you create. Your DBAs
	will thank you.
*/

select 
max(len(FirstName)) 'Max First',
max(len(MiddleName)) 'Max Middle',
max(len(LastName)) 'Max Last'
from [AdventureWorks].[Person].[Person]

create table adventureworks.dbo.r_names 
	([First] char(30),
	[Middle] char(30),
	[Last] char(30))

insert into adventureworks.dbo.r_names 
select	
	[FirstName],
	[MiddleName],
	[LastName]
from [AdventureWorks].[Person].[Person]
where left([LastName], 1) = 'R' 
order by [LastName], [FirstName], [MiddleName]

select *
from adventureworks.dbo.r_names


--When the table exists, you can INSERT INTO
select count(*) from adventureworks.dbo.r_names 

insert into adventureworks.dbo.r_names 
select	
	[FirstName],
	[MiddleName],
	[LastName]
from [AdventureWorks].[Person].[Person]
where left([LastName], 1) = 'R' 
order by [LastName], [FirstName], [MiddleName]
--you can quickly and easily duplicate records

select count(*) from adventureworks.dbo.r_names 


--You can also manually enter values:
insert into adventureworks.dbo.r_names 
values ('Matthew', 'R.', 'Risley'),
	   ('Melissa', 'J', 'Risley'),
	   ('Albert', '', 'Risley')

select *
from adventureworks.dbo.r_names
where [Last] = 'Risley'

delete 
from adventureworks.dbo.r_names
where [Last] = 'Risley'


--errors based on data type?
insert into adventureworks.dbo.r_names 
values ('11/20/2013', 'R.', 'Risley') --treats data as character

insert into adventureworks.dbo.r_names 
values ('11/20/2013', 'R.', 123) --coerces to string

insert into adventureworks.dbo.r_names 
values ('11/20/2013', 'R.', 123.0) --coerces to string

insert into adventureworks.dbo.r_names 
values ('11/20/2013', 'R.', 'What does it take to break an INSERT INTO?') --too long

select *
from adventureworks.dbo.r_names
where [First] = '11/20/2013'

--Alter the table:
alter table adventureworks.dbo.r_names
drop column [Middle]

alter table adventureworks.dbo.r_names
add [Added Column] char(100)

select *
from adventureworks.dbo.r_names

--Delete the table:
drop table adventureworks.dbo.r_names


/*
Example #3: Create Temporary Tables

(a) Temporary Tables are removed when the connection is closed.
(b) Two types of "temp" tables:
	(1) #   a single pound sign is a Local temporary table.
	    They are created in the tempdb database.
		It is visible only to the session that created it.
		They are dropped when the session is closed.
	(2) ##  a double pound sign is a Global temporary table.
	    They are also created in the tempdb database.
		They are accessible to other sessions, so they can be changed by anyone.
		They are dropped when the creating session is closed.
(c) Use global when you need to access from another session (including R).
(d) Use local in a procedure.
*/

--local
select 
	[FirstName],
	[MiddleName],
	[LastName]
into #temp --the name never matters in a local session
from [AdventureWorks].[Person].[Person]
where left([LastName], 1) = 'R' 
order by [LastName], [FirstName], [MiddleName]

----try to access in another session:
--select * from #temp
----can create same local temp table in another session
--select 
--	[FirstName],
--	[MiddleName],
--	[LastName]
--into #temp --the name never matters in a local session
--from [AdventureWorks].[Person].[Person]
--where left([LastName], 1) = 'R' 
--order by [LastName], [FirstName], [MiddleName]

--global
select 
	[FirstName],
	[MiddleName],
	[LastName]
into ##mrr --the name MATTERS in a global session; you may want to create a custom table name you use
from [AdventureWorks].[Person].[Person]
where left([LastName], 1) = 'R' 
order by [LastName], [FirstName], [MiddleName]

----try to access in another session--it will be available:
--select * from ##mrr











