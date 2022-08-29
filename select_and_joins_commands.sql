use sql_store;
select * from customers;
select customer_id, first_name from customers;
select * from customers where customer_id = 1;
select * from customers where customer_id > 3 order by first_name;
select * from customers order by city;
select * from customers order by customer_id desc;
select points + 100 from customers;
select points, points + 100 as bunos from customers;
select points, (points + 10) * 100 as bunos from customers;
select * from products;
select name, unit_price, unit_price * 1.1 as new_price from products;
select state from customers;
select distinct state from customers;
select * from customers where points > 3000;
select * from customers where points > 2500 and birth_date > '1980-01-01';
select * from customers where points > 2500 or birth_date > '1980-01-01';
select * from customers where state = "va";
select * from customers where state != "va";
select * from customers where state <> "va";
select * from customers where birth_date > "1990-01-01";
select * from customers where birth_date > "1990-01-01" or points > 1000;
select * from customers where not birth_date > "1990-01-01" and points > 1000;
select * from customers where not first_name = "freddi";
select * from customers where not points < 2000;
select * from customers where state in ("va","fl","ca");
select * from customers where first_name in ("ines", "romola");
select * from customers where customer_id in (6,7,9);
select * from customers where state not in ("va", "fl");
select * from customers where points between 1000 and 3000;
select * from customers where points not between 1000 and 3000;
select * from customers where birth_date between "1980-01-01" and "1990-01-01";
select * from customers where birth_date not between "1980-01-01" and "1990-01-01";
select * from customers where last_name like "b%";
select * from customers where last_name like "%y";
select * from customers where last_name like "%a%";
select * from customers where first_name not like "b%";
select * from customers where first_name like "____r";
select * from customers where first_name like "_r";
select * from customers where first_name like "a____";
select * from customers where first_name like "b___";
select * from customers where address like "%trail%" or address like "%avenue%";
select * from customers where last_name regexp "field";
select * from customers where last_name regexp "field$";
select * from customers where last_name regexp "^bo";
select * from customers where last_name regexp "^og$";
select * from customers where last_name regexp "^ry$";
select * from customers where last_name regexp "field|gay|son";
select * from customers where last_name regexp "^b[rus]";
select * from customers where last_name regexp "[urg]h$";
select * from customers where phone is Null;
select * from customers where phone is not null;
select * from customers order by customer_id desc;
select * from customers limit 5;
select * from customers where points < 1000 order by points limit 3;
select * from order_items order by quantity * unit_price desc;
select * from customers limit 5,3;
select * from customers order by points desc limit 3; 
select * from orders;
-- inner join, joning tables inside one database 
select * from orders join customers on orders.customer_id = customers.customer_id;
select orders.order_id, customers.customer_id from orders join customers on orders.customer_id = customers.customer_id;
select order_id, customers.customer_id, first_name, last_name from orders join customers on orders.customer_id = customers.customer_id;
select order_id, o.customer_id, first_name, last_name from orders o join customers c on o.customer_id = c.customer_id;
select * from order_items;
select * from products;
select name, p.product_id, order_id from products p join order_items os on p.product_id = os.product_id;
use sql_invoicing;
select p.payment_id, p.client_id, c.name as client_name, p.payment_method from payments p join clients c on c.client_id = p.client_id;
-- joining a table from a database to a table from another database
select * from order_items oi join sql_inventory.products on oi.product_id = sql_inventory.products.product_id;
select order_id, oi.product_id, name, quantity_in_stock from order_items oi join
sql_inventory.products on oi.product_id = sql_inventory.products.product_id;
-- self join...joining a column with other column in the same table
use sql_hr;
select * from employees;
select * from employees e join employees m on e.reports_to = m.employee_id;
select e.employee_id, e.first_name, m.first_name as manager_name, e.reports_to as manager_id from employees e join
employees m on e.reports_to = m.employee_id;
-- joining mulitple tables 
select * from orders o join customers c on o.customer_id = c.customer_id join order_statuses os on o.status = os.order_status_id;
select o.order_id, o.customer_id, os.order_status_id, os.name as statuses from orders o join
customers c on o.customer_id = c.customer_id join
order_statuses os on o.status = os.order_status_id;
-- joining composed keys tables
use sql_store;
select * from order_items oi join order_item_notes oin on oi.order_id = oin.order_Id and oi.product_id = oin.product_id;
-- impilisit join
select * from orders o, customers c where o.customer_id = c.customer_id;
select * from order_items oi, order_item_notes oin where oi.order_id = oin.order_Id and oi.product_id = oin.product_id;
-- outer joins are two types left outer join and right outer join if we want to see all content of a column in a table including NULL records 
-- on the left table we should use left outer join and if we want to see all content of a column in a table including NULL records
-- on the right side we should use right outer join
select c.customer_id, c.first_name, o.order_id from customers c left outer join orders o on c.customer_id = o.customer_id;
select c.customer_id, c.first_name, o.order_id from customers c right outer join orders o on c.customer_id = o.customer_id; 
select o.order_id, o.shipped_date, s.shipper_id, s.name as shipper_name from orders o left outer join shippers s on o.shipper_id = s.shipper_id;
select o.order_id, o.shipped_date, s.shipper_id, s.name as shipper_name from orders o right outer join shippers s on o.shipper_id = s.shipper_id;
-- muliple outer joins
select c.customer_id, c.first_name, o.order_id, o.shipped_date, s.shipper_id, s.name as shipper_name from customers c
left outer join orders o on c.customer_id = o.customer_id
left outer join shippers s on  o.shipper_id = s.shipper_id;
-- self outer join
use sql_hr;
select e.employee_id, e.first_name, c.first_name as manager_name, e.reports_to as manager_id
from employees e left outer join employees c on e.reports_to = c.employee_id;
-- if the columns that we want to join on them have the same names we can use from USING to join them simpler
use sql_store;
select c.first_name as customer_name, c.customer_id, o.order_id from customers c left outer join orders o using (customer_id);
select c.first_name as customer_name, c.customer_id, o.order_id, s.name as shipper_name, s.shipper_id from customers c 
left outer join orders o using (customer_id)
left outer join shippers s using (shipper_id);
select oin.order_Id, oin.product_id, oin.note_id, oin.note from order_item_notes oin left outer join order_items oi using(order_id, product_id);
-- natural join
select o.order_id, c.first_name as customer_name from orders o natural join customers c;
-- UNION by using union we can join sevral quiery records togather
select order_id, order_date, "active" as status from orders where order_date >= "2019-01-01"
union 
select order_id, order_date, "inactive" as status from orders where order_date < "2019-01-01";




