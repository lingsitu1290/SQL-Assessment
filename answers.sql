1

-----

Select all fields for all brands in the brands table.

The result set for this query should be every record in the brands table.

-----


select * from brands; 


==========
2

-----

Select all fields for all car models made by Pontiac in the 
models table. 

The result set should be:
  id   | year  | brand_name |    name
-------+-------+------------+------------
    25 |  1961 | Pontiac    | Tempest
    27 |  1962 | Pontiac    | Grand Prix
    36 |  1963 | Pontiac    | Grand Prix
    42 |  1964 | Pontiac    | GTO
    43 |  1964 | Pontiac    | LeMans
    44 |  1964 | Pontiac    | Bonneville
    45 |  1964 | Pontiac    | Grand Prix
(7 rows)


-----


select * from models where brand_name='Pontiac'; 


==========
3

-----

Select the brand name and model name for all models made in 
1964 from the models table. 

The result set should be:
 brand_name |    name
------------+-------------
 Chevrolet  | Corvette
 Ford       | Mustang
 Ford       | Galaxie
 Pontiac    | GTO
 Pontiac    | LeMans
 Pontiac    | Bonneville
 Pontiac    | Grand Prix
 Plymouth   | Fury
 Studebaker | Avanti
 Austin     | Mini Cooper
 (10 rows)
 

-----


select brand_name, name from models where year='1964';


==========
4

-----

Select the model name, brand name, and headquarters for 
the Ford Mustang from the models and brands tables.

The result set should be:
  name   | brand_name | headquarters
---------+------------+--------------
 Mustang | Ford       | Dearborn, MI
 (1 rows)


-----


select models.name, models.brand_name,brands.headquarters from models full outer join brands on models.brand_name = brands.name where models.name='Mustang';


==========
5

-----

Select all rows for the three oldest brands from the brands
table.

The result set should be:
  id   |    name    | founded |    headquarters     | discontinued
-------+------------+---------+---------------------+--------------
    10 | Studebaker |    1852 | South Bend, Indiana |         1967
    13 | Rambler    |    1901 | Kenosha, Washington |         1969
     6 | Cadillac   |    1902 | New York City, NY   |
(3 rows)


-----


select * from brands order by brands.founded limit 3;


==========
6

-----

Count the Ford models in the database The output should be a 
number.

The result set should be:
   count
------------
          6
(1 rows)


-----


select count(*) from models where brand_name='Ford';


==========
7

-----

Select the name of any and all car brands that are not 
discontinued.

The result set should be:
   name
-----------
 Ford
 Chrysler
 Chevrolet
 Cadillac
 BMW
 Buick
 Tesla
(7 rows)


-----


select name from brands where discontinued is NULL; 


==========
8

-----

Select everything from rows 15-24 of the models table in 
alphabetical order by name. The result set should have 10 records.

The result set should be:
  id   | year  | brand_name |   name
-------+-------+------------+----------
    38 |  1963 | Chevrolet  | Corvette
    11 |  1957 | Chevrolet  | Corvette
    20 |  1960 | Chevrolet  | Corvette
     5 |  1953 | Chevrolet  | Corvette
    13 |  1958 | Chevrolet  | Corvette
    10 |  1956 | Chevrolet  | Corvette
    17 |  1959 | Chevrolet  | Corvette
    26 |  1961 | Chevrolet  | Corvette
     8 |  1955 | Chevrolet  | Corvette
    28 |  1962 | Chevrolet  | Corvette
(10 rows)


-----


select * from models order by name asc limit 10 offset 14;


==========
9

-----

Select the brand, name, and year the model's brand was 
founded for all of the models from 1960. Include row(s)
for model(s) even if their brand(s) are not in the brands table.

Note that in the result set, the year the brand was founded should be NULL if
the brand is not in the brands table.

So, the result set should be:
   name   | brand_name | founded
----------+------------+---------
 Corvette | Chevrolet  |    1911
 Corvair  | Chevrolet  |    1911
 Rockette | Fairthorpe |    1954
 Fillmore | Fillmore   |
(4 rows)


-----


select models.name, brand_name, founded from models left join brands on brands.name=brand_name where year=1960;


==========
10

-----

Modify the query so that it shows all brands that are 
not discontinued regardless of whether they have any models in the models table.
The correct output should not include records for Fillmore and Outback, but should
show information about Tesla, a brand with no models in the models table.

-----


select b.name, b.founded, m.name
from brands as b 
left join models as m
on m.brand_name = b.name
where b.discontinued is null;


==========
11

-----

Modify the query so it only selects models whose brands ARE in the brands table.
So, we shouldn't see models who brands aren't in the brands table (a.k.a. Fillmore,
Outback) nor should we see information about brands who don't have any models in 
the models table (a.k.a. Tesla).

-----


select m.name, m.brand_name, b.founded
from models as m 
join brands as b 
on b.name = m.brand_name;


==========
12

-----

Modify the query so that it only selects brands that do NOT have any
models in the models table.

The correct result set is:

 name  | founded
-------+---------
 Tesla |    2003
(1 rows)

-----


  SELECT b.name,
         founded
  FROM brands AS b
    LEFT JOIN models AS m
      ON b.name = m.brand_name
  WHERE m.name is null;;


==========
14

-----

Select the name of any brand with more than 5 models in the 
database using a HAVING clause.

The correct result set is:

 brand_name
------------
 Chevrolet
 Pontiac
 Ford
(3 rows)


-----


select brand_name 
from models
group by brand_name
having count(brand_name)>5;


==========
15

-----

Using a subquery, select the name and year of any model whose 
year is the same year that ANY brand was founded.

The result set should be:

   name    | year
-----------+-------
 Imperial  |  1926
 Corvette  |  1954
 Fleetwood |  1954
(3 rows)

-----


select name, year from models where year in (select brands.founded from brands); 