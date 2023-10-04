-- Produce a timestamp for 1 a.m. on the 31st of August 2012
-- https://pgexercises.com/questions/date/timestamp.html
SELECT TIMESTAMP '2012-08-31 01:00:00';
--
SELECT '2012-08-31 01:00:00'::TIMESTAMP;
--
SELECT CAST('2012-08-31 01:00:00' AS TIMESTAMP);

-- Subtract timestamps from each other
-- https://pgexercises.com/questions/date/interval.html
SELECT TIMESTAMP '2012-08-31 01:00:00' - TIMESTAMP '2012-07-30 01:00:00' AS interval;

-- Generate a list of all the dates in October 2012
-- https://pgexercises.com/questions/date/series.html
SELECT GENERATE_SERIES(TIMESTAMP '2012-10-01', TIMESTAMP '2012-10-31', '1 day'::INTERVAL) as ts;

-- Get the day of the month from a timestamp
-- https://pgexercises.com/questions/date/extract.html
SELECT DATE_PART('day', '2012-08-31' :: TIMESTAMP);

-- Work out the number of seconds between timestamps
-- https://pgexercises.com/questions/date/interval2.html
SELECT EXTRACT(EPOCH FROM (TIMESTAMP '2012-09-02 00:00:00' - TIMESTAMP '2012-08-31 01:00:00'))::INTEGER;

-- Work out the number of days in each month of 2012
-- https://pgexercises.com/questions/date/daysinmonth.html
SELECT   EXTRACT(MONTH FROM t.timestamp)              AS month,
                  CONCAT(COUNT(t.timestamp), ' days') AS length
FROM     (
                SELECT generate_series(TIMESTAMP '2012-01-01', TIMESTAMP '2012-12-31', '1 Day'::INTERVAL) AS TIMESTAMP) AS t
GROUP BY month
ORDER BY month;

-- Work out the number of days remaining in the month
-- https://pgexercises.com/questions/date/daysremaining.html
SELECT DATE_TRUNC('month', ts) + interval '1 month' - date_trunc('day', ts) AS remaining
FROM   (
              SELECT timestamp '2012-02-11 01:00:00' AS ts);

-- Work out the end time of bookings
-- https://pgexercises.com/questions/date/endtimes.html
SELECT   starttime,
         (starttime + slots * interval '30 min') AS endtime
FROM     cd.bookings
ORDER BY endtime DESC,
         starttime DESC limit 10;

-- Return a count of bookings for each month
-- https://pgexercises.com/questions/date/bookingspermonth.html
SELECT DATE_TRUNC('month', starttime) AS month
       , COUNT(*)
FROM   cd.bookings
GROUP  BY month
ORDER  BY month;

-- Work out the utilisation percentage for each facility by month
-- https://pgexercises.com/questions/date/utilisationpermonth.html
