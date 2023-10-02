-- Count the number of facilities
-- https://pgexercises.com/questions/aggregates/count.html
SELECT COUNT(*)
FROM   cd.facilities;

-- Count the number of expensive facilities
-- https://pgexercises.com/questions/aggregates/count2.html
SELECT COUNT(facid)
FROM   cd.facilities
WHERE  guestcost >= 10;

-- Count the number of recommendations each member makes.
-- https://pgexercises.com/questions/aggregates/count3.html
SELECT recommendedby
       , COUNT(recommendedby)
FROM   cd.members
WHERE  recommendedby IS NOT NULL
GROUP  BY recommendedby
ORDER  BY recommendedby;

-- List the total slots booked per facility
-- https://pgexercises.com/questions/aggregates/fachours.html
SELECT facid
       , SUM(slots) AS "Total Slots"
FROM   cd.bookings
GROUP  BY facid
ORDER  BY facid;

-- List the total slots booked per facility in a given month
-- https://pgexercises.com/questions/aggregates/fachoursbymonth.html
SELECT facid
       , SUM(slots) AS "Total Slots"
FROM   cd.bookings
WHERE  DATE_PART('year', starttime) = 2012
       AND DATE_PART('month', starttime) = 9
GROUP  BY facid
ORDER  BY "Total Slots";

-- List the total slots booked per facility per month
-- https://pgexercises.com/questions/aggregates/fachoursbymonth2.html
SELECT facid
       , DATE_PART('month', starttime) AS month
       , SUM(slots)                    AS "Total Slots"
FROM   cd.bookings
WHERE  DATE_PART('year', starttime) = 2012
GROUP  BY facid
          , DATE_PART('month', starttime)
ORDER  BY facid
          , month;
--
SELECT facid
       , EXTRACT(month FROM starttime) AS month
       , SUM(slots)                    AS "Total Slots"
FROM   cd.bookings
WHERE  EXTRACT(year FROM starttime) = 2012
GROUP  BY facid
          , month
ORDER  BY facid
          , month;

-- Find the count of members who have made at least one booking
-- https://pgexercises.com/questions/aggregates/members1.html
SELECT COUNT(DISTINCT memid)
FROM   cd.bookings;

-- List facilities with more than 1000 slots booked
-- https://pgexercises.com/questions/aggregates/fachours1a.html
SELECT facid
       , SUM(slots) AS "Total Slots"
FROM   cd.bookings
GROUP  BY facid
HAVING SUM(slots) > 1000
ORDER  BY facid;
--
SELECT sub.facid
       , sub.slots AS "Total Slots"
FROM   (SELECT facid
               , SUM(slots) AS slots
        FROM   cd.bookings
        GROUP  BY facid) AS sub
WHERE  sub.slots > 1000;

-- Find the total revenue of each facility
-- https://pgexercises.com/questions/aggregates/facrev.html
SELECT f.NAME
       , SUM(( CASE
                 WHEN b.memid = 0 THEN f.guestcost
                 ELSE f.membercost
               END ) * b.slots) AS revenue
FROM   cd.bookings AS b
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
GROUP  BY f.NAME
ORDER  BY revenue;

-- Find facilities with a total revenue less than 1000
-- https://pgexercises.com/questions/aggregates/facrev2.html
SELECT f.NAME
       , SUM(( CASE
                 WHEN b.memid = 0 THEN f.guestcost
                 ELSE f.membercost
               END ) * b.slots) AS revenue
FROM   cd.bookings AS b
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
GROUP  BY f.NAME
HAVING SUM(( CASE
               WHEN b.memid = 0 THEN f.guestcost
               ELSE f.membercost
             END ) * b.slots) < 1000
ORDER  BY revenue;
--
SELECT sub.NAME
       , sub.revenue
FROM   (SELECT f.NAME
               , SUM(( CASE
                         WHEN b.memid = 0 THEN f.guestcost
                         ELSE f.membercost
                       END ) * b.slots) AS revenue
        FROM   cd.bookings AS b
               INNER JOIN cd.facilities AS f
                       ON b.facid = f.facid
        GROUP  BY f.NAME) AS sub
WHERE  sub.revenue < 1000
ORDER  BY revenue;

-- Output the facility id that has the highest number of slots booked
-- https://pgexercises.com/questions/aggregates/fachours2.html
