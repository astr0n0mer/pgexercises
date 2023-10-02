# [String Operations](https://pgexercises.com/questions/string/)

- [Format the names of members](https://pgexercises.com/questions/string/concat.html)

  ```SQL
  SELECT CONCAT(surname, ', ', firstname) AS name
  FROM   cd.members ;
  ```

  ```SQL
  SELECT surname
                || ', '
                || firstname AS name
  FROM   cd.members;
  ```

- [Find facilities by a name prefix](https://pgexercises.com/questions/string/like.html)

  ```SQL
  SELECT *
  FROM   cd.facilities
  WHERE  name LIKE 'Tennis%';
  ```

- [Perform a case-insensitive search](https://pgexercises.com/questions/string/case.html)

  ```SQL
  SELECT *
  FROM   cd.facilities
  WHERE  name ILIKE 'tennis%';
  ```

  ```SQL
  SELECT *
  FROM   cd.facilities
  WHERE  LOWER(name) LIKE 'tennis%';
  ```

- [Find telephone numbers with parentheses](https://pgexercises.com/questions/string/reg.html)

  ```SQL
  SELECT memid,
         telephone
  FROM   cd.members
  WHERE  telephone LIKE '(___)%';
  ```

  ```SQL
  SELECT memid
         , telephone
  FROM   cd.members
  WHERE  telephone ~ '[()]';
  ```

- [Pad zip codes with leading zeroes](https://pgexercises.com/questions/string/pad.html)

  ```SQL
  SELECT LPAD(zipcode :: TEXT, 5, '0') AS zip
  FROM   cd.members;
  ```

  ```SQL
  SELECT LPAD(CAST(zipcode AS CHAR(5)), 5, '0') AS zip
  FROM   cd.members;
  ```

- [Count the number of members whose surname starts with each letter of the alphabet](https://pgexercises.com/questions/string/substr.html)

  ```SQL
  SELECT LEFT(surname, 1) AS letter
         ,  COUNT(surname)
  FROM   cd.members
  GROUP  BY letter
  ORDER  BY letter;
  ```

  ```SQL
  SELECT SUBSTR(surname, 1, 1) AS letter
         , COUNT(surname)
  FROM   cd.members
  GROUP  BY letter
  ORDER  BY letter;
  ```

- [Clean up telephone numbers](https://pgexercises.com/questions/string/translate.html)

  ```SQL
  SELECT memid
         , TRANSLATE(telephone, '-() ', '')
  FROM   cd.members;
  ```

  ```SQL
  SELECT memid
         , REGEXP_REPLACE(telephone, '\D', '', 'g') AS telephone
  FROM   cd.members;
  ```

  ```SQL
  SELECT memid
         , REGEXP_REPLACE(telephone, '[-\(\)\s]', '', 'g') AS telephone
  FROM   cd.members;
  ```
