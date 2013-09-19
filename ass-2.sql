create database ass2;
use ass2;
create table R1(K int, A int, B int, C int);
select * from R1;
alter table R1 add primary key (K);
show columns from R1;

insert into R1 values(4,2,0,6),(5,2,0,5),(1,1,3,8),(2,1,3,7),(3,2,3,3);

create table R2(K int primary key, D int, E int);
insert into R2 values(4,1,6),(5,1,5),(1,1,8),(2,1,7),(3,1,3);

create table R3(A int primary key, A1 int, A2 int, A3 int);
insert into R3 values(2,4,6,8),(1,2,3,4);

create table R4(B int primary key, B1 int, B2 int);
insert into R4 values(0,0,0),(3,9,27);
select * from R4;
create table R5(C int primary key, C1 int, C2 int, C3 int, C4 int, C5 int);
insert into R5 values(4,2,0,6,1,6),(5,2,0,5,1,5),(1,1,3,8,1,8),(2,1,3,7,1,7),(3,2,3,3,1,3);
select * from R5;
