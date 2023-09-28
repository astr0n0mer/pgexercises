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

-- Retrieve the start times of members' bookings
-- https://pgexercises.com/questions/joins/simplejoin.html
SELECT b.starttime
FROM   cd.bookings AS b
       INNER JOIN cd.members AS m
               ON b.memid = m.memid
WHERE  m.firstname = 'David'
       AND m.surname = 'Farrell';
--
SELECT b.starttime
FROM   cd.bookings AS b
       INNER JOIN cd.members AS m
               ON b.memid = m.memid
                  AND m.firstname = 'David'
                  AND m.surname = 'Farrell';

-- Work out the start times of bookings for tennis courts
-- https://pgexercises.com/questions/joins/simplejoin2.html
SELECT b.starttime AS start
       , f.name    AS name
FROM   cd.bookings AS b
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
                  AND f.name LIKE 'Tennis Court %'
                  AND DATE(b.starttime) = '2012-09-21'
ORDER  BY start
          , name;

-- Produce a list of all members who have recommended another member
-- https://pgexercises.com/questions/joins/self.html
SELECT firstname
       , surname
FROM   cd.members
WHERE  memid IN (SELECT DISTINCT recommendedby
                 FROM   cd.members)
ORDER  BY surname
          , firstname;

-- Produce a list of all members, along with their recommender
-- https://pgexercises.com/questions/joins/self2.html
SELECT m1.firstname   AS memfname
       , m1.surname   AS memsname
       , m2.firstname AS recfname
       , m2.surname   AS recsname
FROM   cd.members AS m1
       LEFT OUTER JOIN cd.members AS m2
              ON m1.recommendedby = m2.memid
ORDER  BY memsname
          , memfname
          , recsname
          , recfname;

-- Produce a list of all members who have used a tennis court
-- https://pgexercises.com/questions/joins/threejoin.html
SELECT DISTINCT CONCAT(m.firstname, ' ', m.surname) AS member
                , f.name                            AS facility
FROM   cd.members AS m
       INNER JOIN cd.bookings AS b
               ON m.memid = b.memid
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
                  AND f.name LIKE 'Tennis %'
ORDER  BY member
          , facility;

--
