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

-- Produce a list of costly bookings
-- https://pgexercises.com/questions/joins/threejoin2.html
SELECT CONCAT(m.firstname, ' ', m.surname) AS member
       , f.NAME                            AS facility
       , ( CASE
             WHEN b.memid = 0 THEN f.guestcost
             ELSE f.membercost
           END ) * b.slots                 AS cost
FROM   cd.bookings AS b
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
                  AND DATE(b.starttime) = '2012-09-14'
                  AND ( ( CASE
                            WHEN b.memid = 0 THEN f.guestcost
                            ELSE f.membercost
                          END ) * b.slots > 30 )
       INNER JOIN cd.members AS m
               ON b.memid = m.memid
ORDER  BY cost DESC;
--
SELECT CONCAT(m.firstname, ' ', m.surname) AS member
       , f.NAME                            AS facility
       , ( CASE
             WHEN b.memid = 0 THEN f.guestcost
             ELSE f.membercost
           END ) * b.slots                 AS cost
FROM   cd.bookings AS b
       INNER JOIN cd.facilities AS f
               ON b.facid = f.facid
       INNER JOIN cd.members AS m
               ON b.memid = m.memid
WHERE  DATE(b.starttime) = '2012-09-14'
       AND ( ( CASE
                 WHEN b.memid = 0 THEN f.guestcost
                 ELSE f.membercost
               END ) * b.slots > 30 )
ORDER  BY cost DESC;

-- Produce a list of all members, along with their recommender, using no joins.
-- https://pgexercises.com/questions/joins/sub.html
SELECT DISTINCT CONCAT(m1.firstname, ' ', m1.surname) AS member
                , (SELECT CONCAT(m2.firstname, ' ', m2.surname) AS recommender
                   FROM   cd.members AS m2
                   WHERE  m1.recommendedby = m2.memid)
FROM   cd.members AS m1
ORDER  BY member;

-- Produce a list of costly bookings, using a subquery
-- https://pgexercises.com/questions/joins/tjsub.html
SELECT CONCAT(m.firstname, ' ', m.surname) AS member
       , sub.NAME                          AS facility
       , sub.cost
FROM   (SELECT b.memid
               , f.NAME
               , ( CASE
                     WHEN b.memid = 0 THEN f.guestcost
                     ELSE f.membercost
                   END ) * b.slots AS cost
        FROM   cd.bookings AS b
               INNER JOIN cd.facilities AS f
                       ON b.facid = f.facid
        WHERE  DATE(b.starttime) = '2012-09-14') AS sub
       INNER JOIN cd.members AS m
               ON sub.memid = m.memid
                  AND sub.cost > 30
ORDER  BY cost DESC;
