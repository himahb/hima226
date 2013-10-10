create database computers;
use computers;
create table product (maker char(1), model int, ctype varchar(10));
insert into product values
('A',	1001, 'pc'),
('A',	1002,	'pc'),
('A',	1003,	'pc'),
('A',2004  ,'laptop'),
('A',2005  ,'laptop'),
('A',2006  ,'laptop'),
('B',	1004, 'pc'),
('B',	1005, 'pc'),
('B',	1006, 'pc'),
('B',	2007  ,'laptop'),
('C',	1007, 'pc'),
('D',	1008, 'pc'),
('D',	1009, 'pc'),
('D',	1010, 'pc'),
('D',	3004, 'printer'),
('D',	3005, 'printer'),
('E',	1011, 'pc'),
('E',	1012, 'pc'),
('E',	1013, 'pc'),
('E',	2001  ,'laptop'),
('E',	2002  ,'laptop'),
('E',	2003  ,'laptop'),
('E',	3001, 'printer'),
('E',	3002, 'printer'),
('E',	3003, 'printer'),
('F',	2008  ,'laptop'),
('F',	2009  ,'laptop'),
('G',	2010  ,'laptop'),
('H',	3006, 'printer'),
('H',	3007, 'printer');

create table pc (model int,	speed float, ram int, hd int, price int);
insert into pc values
(1001,	2.66,	1024,	250,	2114),
(1002,	2.10,	512,	250,	995),
(1003,	1.42,	512,	80,	    478),
(1004,	2.80,	1024,	250,	649),
(1005,	3.20,	512,	250,	630),
(1006,	3.20,	1024,	250,	1049),
(1007,	2.20,	1024,	250,	510),
(1008,	2.20,	2048,	250,	770),
(1009,	2.00,	1024,	250,	650),
(1010,	2.80,	2048,	300,	770),
(1011,	1.86,	2048,	160,	959),
(1012,	2.80,	1024,	160,	649),
(1013,	3.06,	512,	80,	    529);

create table laptop (model int,	speed float, ram int, hd int,  screen float, price int);
insert into laptop values
(2001,	2.00,	2048,	240,	20.1,	3673),
(2002,	1.73,	1024,	80,	17.0,	949),
(2003,	1.80,	512,	60,	16.4,	549),
(2004,	2.00,	512,	60,	13.3,	1150),
(2005,	2.16,	1024,	120,	17.0,	2500),
(2006,	2.00,	2048,	80,	15.4,	1700),
(2007,	1.83,	1024,	120,	13.3,	1429),
(2008,	1.60,	1024,	100,	15.4,	900),
(2009,	1.60,	512,	80,	14.1,	680),
(2010,	2.00,	2048,	160,	15.4,	2300);

create table printer (model int,	color boolean,	ctype varchar(10),	price int);
insert into printer values
(3001,	TRUE,	'ink-jet',	99),
(3002,	FALSE,	'laser',	239),
(3003,	TRUE,	'laser',	899),
(3004,	TRUE,	'ink-jet',	120),
(3005,	FALSE,	'laser',	120),
(3006,	TRUE,	'ink-jet',	100),
(3007,	TRUE,	'laser',	200);

select maker from product, laptop 
   where product.model = laptop.model;

select distinct(maker) from product
   where product.ctype = 'laptop'
      and not maker in 
(select maker from product
   where product.ctype = 'pc');

# this is a comment
select product.model, pc.model, price/100.0 as 'price', 'PC' as ctype from product, pc
   where product.maker = 'B'
 and product.model = pc.model 
union
select product.model, laptop.model, price, 'laptop' as ctype from product, laptop
   where product.maker = 'B'
 and product.model = laptop.model 
union
select product.model, printer.model, price, 'printer' as ctype from product, printer
   where product.maker = 'D'
 and product.model = printer.model; 


select maker from product natural join laptop where price < 1000;

select product.maker from product,  
     (select maker from product natural join laptop where price < 1000) B
  where product.maker = B.maker
    and product.ctype = 'pc';

select maker from product natural join laptop 
   where price < 1000
     and maker in 
		(select maker from product where ctype = 'pc');

drop table manf;
create table manf (maker char(1) key, makername varchar(30));
insert into manf values ('A', 'The A-Company'),
  ('B', 'The B-Company'),
  ('C', 'The C-Company'),
  ('D', 'The D-Company'),
  ('E', 'The E-Company'),
  ('F', 'The F-Company'),
  ('G', 'The G-Company'),
  ('H', 'The H-Company');

select maker from manf
   where
      maker in 
        (select maker from product natural join laptop where price < 1000)  
      and maker in 
		(select maker from product where ctype = 'pc');

select maker from product   
  where product.ctype = 'laptop'      
    and maker not in 
   (select maker from product where product.ctype = 'pc');

select maker from manf   
  where 
    maker in 
      (select maker from product where product.ctype = 'laptop')
    and maker not in 
      (select maker from product where product.ctype = 'pc');

select maker from product   
  where ctype = 'laptop'      
    and maker not in 
   (select maker from product where ctype = 'pc')
  group by maker;

SELECT A.maker FROM product A where ctype='pc'
  AND EXISTS
      (SELECT B.maker FROM product B 
         NATURAL JOIN laptop  WHERE price < 1000 
         AND A.maker = B.maker ) ;


SELECT A.maker FROM product A where ctype='pc'
into outfile '/tmp/test.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;

select product.model, pc.model, price/100.0 as 'price', 'PC' as ctype from product, pc
   where product.maker = 'B'
 and product.model = pc.model 
union
select product.model, laptop.model, price, 'laptop' as ctype from product, laptop
   where product.maker = 'B'
 and product.model = laptop.model 
union
select product.model, printer.model, price, 'printer' as ctype from product, printer
   where product.maker = 'D'
 and product.model = printer.model
into outfile '/tmp/test1.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;

select maker from manf ;

select maker from manf
   where maker > any (select maker from manf);

select distinct(maker) from product where ctype = 'pc';

select maker from manf
   where maker <> all (select maker from product where ctype = 'pc');

select * from product;
select * from pc;
select * from laptop;
select * from printer;
drop table pc;
#Part-1
# Q1-a Find the model number, speed, and hard-disk size for all PC’s whose price is under $1000.00.
select model, speed, hd from pc where price<1000 INTO OUTFILE 'e:/ass3tab/assign.3.1.a.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
;

# Q1-b Do the same as (a), but rename the speed column ‘gigahertz’ and the hd column ‘gigabytes’
alter table pc change speed gigahertz float;
alter table pc change hd gigabytes int;
select model, gigahertz, gigabytes from pc where price<1000 INTO OUTFILE 'e:/ass3tab/assign.3.1.b.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#just changing the column names to their original names
alter table pc change gigahertz speed float;
alter table pc change gigabytes hd int;

#Q1-c Find the manufacturers of printers.
select maker from product p, printer pr where p.model = pr.model INTO OUTFILE 'e:/ass3tab/assign.3.1.c.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q1-d Find the model number, memory size, and screen size for laptops costing more than $1000.00
select model, ram, hd, screen from laptop where price>1000 INTO OUTFILE 'e:/ass3tab/assign.3.1.d.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q1-e Find all the tuples in the Printer relation for color printers.  Remember that color is a Boolean-valued attribute.
select * from printer where color=true INTO OUTFILE 'e:/ass3tab/assign.3.1.e.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q1-f Find the model number and hard-disk size for those PC’s that have a speed of 3.2 and a price less than $2000.00
select model, hd from pc where speed=3.20 and price<2000 INTO OUTFILE 'e:/ass3tab/assign.3.1.f2.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Part-2
#Q2-a Give the manufacturer and speed of laptops with a hard disk of at least thirty gigabytes


#Q2-b 	Find the model number and price of all products (of any type) made by manufacturer B.
select  pc.model,  price, 'PC' as ctype from product, pc where product.maker = 'B'
and product.model = pc.model 
union
select  laptop.model, price, 'laptop' as ctype from product, laptop where product.maker = 'B'
and product.model = laptop.model 
union
select  printer.model, price, 'printer' as ctype from product, printer where product.maker = 'B'
and product.model = printer.model INTO OUTFILE 'e:/ass3tab/assign.3.2.b.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q2-c
select maker from product where maker in (select maker from product p where p.ctype='laptop') 
and maker not in (select maker from product p where p.ctype='pc') INTO OUTFILE 'e:/ass3tab/assign.3.2.c.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q2-d Find those hard-disk sizes that occur in two or more PC’s.
select hd, count(*)from pc  group by hd INTO OUTFILE 'e:/ass3tab/assign.3.2.d.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q2-e Find those pairs of PC models that have both the same speed and RAM.  A pair should be listed only once; e.g., list (i,j) but not (j,i).


#Q2-f Find those manufacturers of at least two different  computers (PC’s or laptops) with speeds of at least 3.0.
select maker, count(model)>=2 from product where model=any( select model from pc where speed>=3.0 
union all select model from laptop where speed>=3.0 ) INTO OUTFILE 'e:/ass3tab/assign.3.2.f.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Part-3
#Q3-a Find the makers of PC’s with a speed of at least 3.0.
select distinct maker from product where model in (select model from pc where speed>=3.00) INTO OUTFILE 'e:/ass3tab/assign.3.3.a.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q3-b Find the printers with the highest price.
select pr.model, pr.price from  printer  pr
where pr.price = (select max(price) from printer) INTO OUTFILE 'e:/ass3tab/assign.3.3.b.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q3-c Find the laptops whose speed is slower than that of any PC.
select l.model from  laptop l  
where l.speed < any(select speed from pc) INTO OUTFILE 'e:/ass3tab/assign.3.3.c.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q3-d Find the model number of the item (PC, laptop, or printer) with the highest price.
select max(price), model from (select price, model from  printer pr 
union select price, model from  pc pc1 
union select price, model from  laptop l) p INTO OUTFILE 'e:/ass3tab/assign.3.3.d.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q3-e Find the maker of the color printer with the lowest price.
select p.maker from product p where model=(select p.model from  printer  p
Where p.color=true and p.price = (select min(price) from printer)) INTO OUTFILE 'e:/ass3tab/assign.3.3.e.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q3-f Find the maker(s) of the PC(s) with the fastest processor among all those PC’s that have the smallest amount of RAM
select p.maker from product p where model in (select model from pc where  speed=(select max(speed) from pc ) and ram=(select min(ram) from pc)) 
INTO OUTFILE 'e:/ass3tab/assign.3.3.f.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Part-4
#Q4-a Find average speed of PC's.
select avg(speed) from pc INTO OUTFILE 'e:/ass3tab/assign.3.4.a.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-b Find the average speed of laptops costing over $1000.00.
select avg(speed) from laptop where price>1000 INTO OUTFILE 'e:/ass3tab/assign.3.4.b.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-c Find the average price of PC’s make by manufacturer ‘A’.
select avg(pc1.price) from pc pc1 join product p on pc1.model=p.model and p.maker='A' INTO OUTFILE 'e:/ass3tab/assign.3.4.c.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-d Find the average price of PC’s and laptops made by manufacturer ‘B’.
select avg(price) from (select price from laptop l where model = any(select model from product p where maker ='B')union all 
select price from pc pc1 where model = any(select model from product p where maker='B')) D1 INTO OUTFILE 'e:/ass3tab/assign.3.4.d.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-e Find, for each different speed, the average price of a PC.
select avg(price) from pc where speed in (select distinct speed from  pc) group by speed INTO OUTFILE 'e:/ass3tab/assign.3.4.e.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-f Find for each manufacturer, the average screen size of its laptops.
select avg(screen), maker from laptop natural join product group by maker INTO OUTFILE 'e:/ass3tab/assign.3.4.f.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-g Find the manufacturers that make at least three different models of PC.
select product.maker, count(pc.model)>=3 from product, pc where pc.model=product.model group by product.maker INTO OUTFILE 'e:/ass3tab/assign.3.4.g.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-h Find for each manufacturer who sells PC’s the maximum price of a PC.
select p.maker, max(pc.price) from product p, pc where p.model=pc.model group by p.maker INTO OUTFILE 'e:/ass3tab/assign.3.4.h.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-i Find, for each speed of PC above 2.0, the average price.
select avg(price) from pc where speed>2.00 INTO OUTFILE 'e:/ass3tab/assign.3.4.i.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q4-j Find the average hard disk size of a PC for all those manufactures that make printers.
select avg(hd) from pc where model in ( select model from product where ctype='printer') INTO OUTFILE 'e:/ass3tab/assign.3.4.j.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Part-5
#Q5-a Using two INSERT statements, store in the database the fact that 
#PC model 1100 is made by manufacturer C, has a speed of 3.2, RAM 1024, hard disk 180, and sells for $2400.00.
insert into product values('C', 1100, 'PC');
insert into pc values(1100, 3.2, 1024, 180, 2400.00);
select * from pc INTO OUTFILE 'e:/ass3tab/assign.3.5.a.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q5-b Insert the facts that for every PC there is a laptop with the same 
#manufacturer, speed, RAM, and hard disk, a 17-inch screen, a model number 100 greater, and a price $500.00 more.

#Q5-c Delete all PC’s with less than 100 gigabytes of hard disk.
set sql_safe_updates=0;
delete  from pc where hd<100 ;
select * from pc INTO OUTFILE 'e:/ass3tab/assign.3.5.c.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'

#Q5-d Delete all laptops made by a manufacturer that doesn’t make printers.
delete from laptop where model = any(select model from product where maker in(select maker from product where ctype <>'printer'));
select * from laptop INTO OUTFILE 'e:/ass3tab/assign.3.5.d.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q5-e Manufacturer A buys manufacturer B.  Change all products made by B so they are now made by A.
update product set maker='A' where maker='B';
select * from product INTO OUTFILE 'e:/ass3tab/assign.3.5.e.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q5-f For each PC, double the amount of RAM and add 60 gigabytes to the amount of hard disk.  
update pc set ram=ram*2, hd=hd+60;
select * from pc INTO OUTFILE 'e:/ass3tab/assign.3.5.f1.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

#Q5-g For each laptop made by manufacturer B, add one inch to the screen size and subtract $100.00 from the price. 
update laptop set screen=screen+1, price=price-100 where model in(select model from product where maker='B');
select * from laptop INTO OUTFILE 'e:/ass3tab/assign.3.5.g.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';