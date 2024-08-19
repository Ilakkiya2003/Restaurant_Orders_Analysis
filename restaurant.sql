create database restaurant;
use restaurant;
alter table menu_items change column ï»¿menu_item_id  menu_item_id int; -- change column name
alter table order_details change column ï»¿order_details_id  order_details_id int; -- change column name

UPDATE order_details
SET order_date = STR_TO_DATE(order_date, '%m-%d-%Y');  -- sting to date change

UPDATE order_details
SET order_date = REPLACE(order_date, '/', '-');  -- formating the date column

alter table order_details modify order_date date;
alter table order_details modify order_time varchar(100);


select * from menu_items where menu_item_id is null;  
select * from menu_items where item_name is null; 
select * from menu_items where category is null; 
select * from menu_items where price is null; 

select * from menu_items; -- All rows in the menu items 2
select * from order_details limit 5 ; -- First 5 rows in the order details 2

SET SQL_SAFE_UPDATES = 0;

select item_name, price from menu_items order by price desc; -- price in descending order 3

select round(avg(price),2) from menu_items; -- 4

select count(order_details_id) from order_details; -- 4

select item_name, order_date, order_time from order_details left join menu_items on menu_item_id = item_id; -- 5

SELECT item_name, price
FROM menu_items
WHERE price > (SELECT AVG(price) FROM menu_items); -- 6

select count(month(order_date)), month(order_date) from order_details group by month(order_date) ; -- 7

select category, avg(price),count(item_name) from menu_items group by category having avg(price) > 15 ; -- 8
select count(item_name) as counts, category from menu_items group by category; -- 8

select item_name, price, case when price > 20 then 'Expensive' end from menu_items; -- 9

update menu_items set price = 25 where menu_item_id = 101; -- 10

insert into menu_items values( 133, "panna cotta" , "Italian", 25); -- 11

delete from order_details where order_details_id < 100; -- 12
select * from order_details;

select item_name, dense_rank() OVER ( ORDER BY price) Ranks from menu_items; -- 13

SELECT item_name, price, price - LAG(price) OVER (ORDER BY item_name) AS price_diff_from_previous, 
LEAD(price) OVER (ORDER BY item_name) - price AS price_diff_from_next FROM menu_items; -- 14

with cte_name as (select item_name, price from menu_items where price > 15)
select item_name, price from cte_name;
select count(item_name) from cte_name; -- 15

select order_id, item_name, price from order_details left join menu_items on menu_item_id = item_id; -- 16

SELECT menu_item_id, 'item_name' AS property, item_name AS value
FROM menu_items
UNION ALL
SELECT menu_item_id, 'category' AS property, category AS value
FROM menu_items
UNION ALL
SELECT menu_item_id, 'price' AS property, CAST(price AS CHAR) AS value
FROM menu_items; -- 17

SET @category = 'Mexican';
SET @min_price = 5;
SET @max_price = 15;
SET @sql = CONCAT(
    'SELECT * FROM menu_items WHERE category = "', 
    @category, 
    '" AND price BETWEEN ', 
    @min_price, 
    ' AND ', 
    @max_price
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;    -- 18





