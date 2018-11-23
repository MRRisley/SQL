
# File Information --------------------------------------------------------

#IS6030
#
#This script:
#
#(1) demonstrates how to access an Other Database Connection ('ODBC') 
#through R. 
#
#(2) outlines the basics of the R merge function from the base package,
#which has similar feature to the SQL join.
#
#(3) outlines the basics of data.table, which is an R package
#that allows data manipulation in a way similar to a SQL query. It is 
#comparable to the functionality of the dplyr package.

#Global Option
options(stringsAsFactors = FALSE)

# Install/Load Packages --------------------------------------------------------

#install.packages('RODBC')
#install.packages('data.table')

library(RODBC); library(data.table)


# Connect to ODBC ---------------------------------------------------------
?RODBC
RShowDoc("RODBC", package="RODBC")

ch <- odbcConnect("SQLEXPRESS")
print(ch)

#what tables are on the server?
sqlTables(ch) #reaches max.print
?sqlTables

sqlTables(ch, catalog = 'AdventureWorks', tableType = 'TABLE') #only returns tables from AdventureWorks DB


# The Basic Query ---------------------------------------------------------

#write a query
Q = "select * from [AdventureWorks].[Person].[Person]"
print(Q)

df1 <- sqlQuery(ch, query=Q)
head(df1); tail(df1)

#can specify how to return NULL values
df2 <- sqlQuery(ch, query=Q, nullstring="NULL")
head(df2)

#remove both df1 and df2
rm(df1); rm(df2)



#any query will work
Q = "select * 
from [AdventureWorks].[Person].[Person]
where MiddleName is null"
print(Q)

df1 <- sqlQuery(ch, query=Q)
head(df1); tail(df1)


#or you can do the work in R
Q = "select * from [AdventureWorks].[Person].[Person]"
print(Q)

df2 <- sqlQuery(ch, query=Q, nullstring="NULL")

df2 <- df2[which(df2["MiddleName"]=="NULL"),]

#check equivalence
nrow(df1)==nrow(df2)
head(cbind(df1[,1:5], df2[,1:5]))

#remove both df1 and df2
rm(df1); rm(df2)


# Perform a Join in R -----------------------------------------------------
#refer to examples in Homework-4.sql

#read in three tables

Q = 
"select 
[BusinessEntityID]
,[FirstName]
,[LastName]
from [AdventureWorks].[Person].[Person]"

df1 <- sqlQuery(ch, query=Q)

Q = 
"select 
[BusinessEntityID],
[AddressID]
from [AdventureWorks].[Person].[BusinessEntityAddress]"

df2 <- sqlQuery(ch, query=Q)

#Part A in Homework
?merge

#The MERGE function
#provide two data frames (or tables), x and y
#x is your "left"; y is your "right"

#INNER JOIN
#all=F
#all.x=F, all.y=F

#LEFT JOIN
#all.x=T, all.y=F (False is default)

#RIGHT JOIN
#all.x=F, all.y=T (False is default)

#OUTER JOIN
#all = T
#all.x=T, all.y=T


#inner <- merge(df1, df2, all=F, by="BusinessEntityID")
left <- merge(df1, df2, all.x=T, by="BusinessEntityID")
head(left); tail(left)

nrow(df1)==nrow(left) #do this after all merges

#Remove AddressType = 5
Q = 
"select 
[BusinessEntityID],
[AddressID]
from [AdventureWorks].[Person].[BusinessEntityAddress]
where [AddressTypeID] in (2, 3)" #no need to control for NULLs since this will be its own table

df2 <- sqlQuery(ch, query=Q)

left <- merge(df1, df2, all.x=T, by="BusinessEntityID")
head(left); tail(left)

nrow(df1)==nrow(left)
#right <- merge(df1, df2, all.y=T, by.x="BusinessEntityID", by.y="BusinessEntityID") #use by.x and by.y if column names are different
#full <- merge(df1, df2, all=T, by="BusinessEntityID")

#Part B in Homework
#unmatched with merge function are returned as NA
no.match <- left[which(is.na(left["AddressID"])), c("BusinessEntityID", "AddressID")]

nrow(no.match)

#Part C in Homework
Q = 
"select 
[AddressID]
,[AddressLine1]
,[AddressLine2]
,[City]
,[StateProvinceID]
,[PostalCode]
from [AdventureWorks].[Person].[Address]"

df3 <- sqlQuery(ch, query=Q)

#merge
left2 <- merge(df2, df3, all.x=T, by="AddressID")
head(left2); tail(left2)

nrow(df2)==nrow(left2)

#unmatched with merge function are returned as NA
no.match <- left2[which(is.na(left2["AddressID"])), c("AddressID")]
nrow(no.match)

#Convert NULL AdressLine2 to ""
left2[is.na(left2["AddressLine2"]),]$AddressLine2 <- ""
head(left2); tail(left2)


#Final Application - Join the Joins
names(left)
names(left2)

final.data <- merge(left, left2, all.x=T, by=c("BusinessEntityID", "AddressID"))
head(final.data); tail(final.data)

#unmatched?
nrow(final.data[which(is.na(final.data["AddressID"])), c("BusinessEntityID", "AddressID")])
head(final.data[which(is.na(final.data["AddressID"])), c("BusinessEntityID", "AddressID")])
tail(final.data[which(is.na(final.data["AddressID"])), c("BusinessEntityID", "AddressID")])

#Remove AddressID field
final.data$AddressID <- NULL
head(final.data); tail(final.data)

rm(df1); rm(df2); rm(df3); rm(left); rm(left2); rm(final.data)

# data.table --------------------------------------------------------------

#data frames are terribly inefficient for processes shown above
#
#alternatives are to use dplyr or data.table
#
#dplyr is owned/maintained by RStudio
#
#data.table was created by a person
#
#data.table is the fastest

?data.table #see "Introduction to data.table" link

#syntax is:
#dt[i, j, by] where dt is your data table
#i are the rows (or records); think of this as your WHERE clause (applies to individual records)
#j are your columns; think of this as your select list
#by is your GROUP BY clause
#
#ordering and filter based on grouping are outside these brackets

Q = 
"select *
from [AdventureWorks].[Person].[Person]"

df1 <- sqlQuery(ch, query=Q)

dt <- as.data.table(df1)
dt
rm(df1)

#return records where FirstName is Matthew
dt[FirstName=="Matthew"]

#return 1st seven columns
dt[FirstName=="Matthew", 1:7]

#return 1 and 7
dt[FirstName=="Matthew", c(1, 7)] #data.frame syntax
dt[FirstName=="Matthew", c("BusinessEntityID", "LastName")] #data.frame syntax, again
dt[FirstName=="Matthew", .(BusinessEntityID, LastName)] #data.table syntax

#return a count
dt[FirstName=="Matthew", .N] #.N is analogous to count(*)
dt[FirstName=="Matthew", .(count=.N)] #provide a column alias

#return some counts by FirstName
dt[, .N, by=.(FirstName)] #there are 1018 unique FirstNames
dt[, .N, by=.(FirstName, LastName)][order(-N)] #Laura Norman is most frequent name - this is your order clause
dt[, .N, by=.(FirstName, LastName)][order(-N)][N > 1] #380 names have duplicates - this is your having clause

