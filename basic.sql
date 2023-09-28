-- Retrieve everything from a table
-- https://pgexercises.com/questions/basic/selectall.html
SELECT *
FROM   cd.facilities;

-- Retrieve specific columns from a table
-- https://pgexercises.com/questions/basic/selectspecific.html
SELECT name
       , membercost
FROM   cd.facilities;

-- Control which rows are retrieved
-- https://pgexercises.com/questions/basic/where.html
SELECT *
FROM   cd.facilities
WHERE  membercost > 0;

-- Control which rows are retrieved - part 2
-- https://pgexercises.com/questions/basic/where2.html
SELECT facid
       , name
       , membercost
       , monthlymaintenance
FROM   cd.facilities
WHERE  membercost > 0
       AND membercost < monthlymaintenance / 50;

-- Basic string searches
-- https://pgexercises.com/questions/basic/where3.html
SELECT *
FROM   cd.facilities
WHERE  name LIKE '%Tennis%';

-- Matching against multiple possible values
-- https://pgexercises.com/questions/basic/where4.html
SELECT *
FROM   cd.facilities
WHERE  facid IN ( 1, 5 );

-- Classify results into buckets
-- https://pgexercises.com/questions/basic/classify.html
SELECT name
       , CASE
           WHEN monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
         END AS cost
FROM   cd.facilities;

-- Working with dates
-- https://pgexercises.com/questions/basic/date.html
SELECT memid
       , surname
       , firstname
       , joindate
FROM   cd.members
WHERE  joindate >= '2012-09-01';

-- Removing duplicates, and ordering results
-- https://pgexercises.com/questions/basic/unique.html
SELECT DISTINCT surname
FROM   cd.members
ORDER  BY surname
LIMIT  10;

-- Combining results from multiple queries
-- https://pgexercises.com/questions/basic/union.html
SELECT surname
FROM   cd.members
UNION
SELECT name
FROM   cd.facilities;

-- Simple aggregation
-- https://pgexercises.com/questions/basic/agg.html
SELECT MAX(joindate) AS latest
FROM   cd.members;

-- More aggregation
-- https://pgexercises.com/questions/basic/agg2.html
SELECT firstname
       , surname
       , joindate
FROM   cd.members
WHERE  joindate = (SELECT MAX(joindate)
                   FROM   cd.members);
--
SELECT firstname
       , surname
       , joindate
FROM   cd.members
ORDER  BY joindate DESC
LIMIT  1;
