-- Insert some data into a table
-- https://pgexercises.com/questions/updates/insert.html
INSERT INTO cd.facilities
            (facid
             , name
             , membercost
             , guestcost
             , initialoutlay
             , monthlymaintenance)
VALUES      (9
             , 'Spa'
             , 20
             , 30
             , 100000
             , 800);

-- Insert multiple rows of data into a table
-- https://pgexercises.com/questions/updates/insert2.html
INSERT INTO cd.facilities
            (facid
             , name
             , membercost
             , guestcost
             , initialoutlay
             , monthlymaintenance)
VALUES      (9
             , 'Spa'
             , 20
             , 30
             , 100000
             , 800),
            (10
             , 'Squash Court 2'
             , 3.5
             , 17.5
             , 5000
             , 80);
--
INSERT INTO cd.facilities
            (facid
             , name
             , membercost
             , guestcost
             , initialoutlay
             , monthlymaintenance)
SELECT 9
       , 'Spa'
       , 20
       , 30
       , 100000
       , 800
UNION ALL
SELECT 10
       , 'Squash Court 2'
       , 3.5
       , 17.5
       , 5000
       , 80;

-- Insert calculated data into a table
-- https://pgexercises.com/questions/updates/insert3.html
INSERT INTO cd.facilities
            (facid
             , name
             , membercost
             , guestcost
             , initialoutlay
             , monthlymaintenance)
SELECT (SELECT MAX(facid)
        FROM   cd.facilities)
       + 1
       , 'Spa'
       , 20
       , 30
       , 100000
       , 800;

-- Update some existing data
-- https://pgexercises.com/questions/updates/update.html
UPDATE cd.facilities AS f
SET    initialoutlay = 10000
WHERE  f.facid = 1;

-- Update multiple rows and columns at the same time
-- https://pgexercises.com/questions/updates/updatemultiple.html
UPDATE cd.facilities
SET    membercost = 6
       , guestcost = 30
WHERE  facid IN ( 0, 1 );

-- Update a row based on the contents of another row
-- https://pgexercises.com/questions/updates/updatecalculated.html
UPDATE cd.facilities AS f
SET    membercost = (SELECT membercost
                     FROM   cd.facilities
                     WHERE  facid = 0) * 1.1
       , guestcost = (SELECT guestcost
                      FROM   cd.facilities
                      WHERE  facid = 0) * 1.1
WHERE  facid = 1;
--
UPDATE cd.facilities
SET    membercost = f2.membercost * 1.1
       , guestcost = f2.guestcost * 1.1
FROM   (SELECT membercost
               , guestcost
        FROM   cd.facilities
        WHERE  facid = 0) AS f2
WHERE  facid = 1;

-- Delete all bookings
-- https://pgexercises.com/questions/updates/delete.html
DELETE FROM cd.bookings;

-- Delete a member from the cd.members table
-- https://pgexercises.com/questions/updates/deletewh.html
DELETE FROM cd.members
WHERE  memid = 37;

-- Delete based on a subquery
-- https://pgexercises.com/questions/updates/deletewh2.html
DELETE FROM cd.members
WHERE  memid NOT IN (SELECT memid
                     FROM   cd.bookings);
