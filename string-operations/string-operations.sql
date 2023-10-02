-- Format the names of members
-- https://pgexercises.com/questions/string/concat.html
SELECT CONCAT(surname, ', ', firstname) AS name
FROM   cd.members ;
--
SELECT surname
              || ', '
              || firstname AS name
FROM   cd.members;

-- Find facilities by a name prefix
-- https://pgexercises.com/questions/string/like.html
SELECT *
FROM   cd.facilities
WHERE  name LIKE 'Tennis%';

-- Perform a case-insensitive search
-- https://pgexercises.com/questions/string/case.html
SELECT *
FROM   cd.facilities
WHERE  name ILIKE 'tennis%';
--
SELECT *
FROM   cd.facilities
WHERE  LOWER(name) LIKE 'tennis%';

-- Find telephone numbers with parentheses
-- https://pgexercises.com/questions/string/reg.html
SELECT memid,
       telephone
FROM   cd.members
WHERE  telephone LIKE '(___)%';
--
SELECT memid
       , telephone
FROM   cd.members
WHERE  telephone ~ '[()]';

-- Pad zip codes with leading zeroes
-- https://pgexercises.com/questions/string/pad.html
SELECT LPAD(zipcode :: TEXT, 5, '0') AS zip
FROM   cd.members;
--
SELECT LPAD(CAST(zipcode AS CHAR(5)), 5, '0') AS zip
FROM   cd.members; 

-- Count the number of members whose surname starts with each letter of the alphabet
-- https://pgexercises.com/questions/string/substr.html
SELECT LEFT(surname, 1) AS letter
       ,  COUNT(surname)
FROM   cd.members
GROUP  BY letter
ORDER  BY letter;
--
SELECT SUBSTR(surname, 1, 1) AS letter
       , COUNT(surname)
FROM   cd.members
GROUP  BY letter
ORDER  BY letter;

-- Clean up telephone numbers
-- https://pgexercises.com/questions/string/translate.html
SELECT memid
       , TRANSLATE(telephone, '-() ', '')
FROM   cd.members;
--
SELECT memid
       , REGEXP_REPLACE(telephone, '\D', '', 'g') AS telephone
FROM   cd.members;
--
SELECT memid
       , REGEXP_REPLACE(telephone, '[-\(\)\s]', '', 'g') AS telephone
FROM   cd.members;
