create table if not exists puppydb(
id varchar(20) not null,
name varchar(20) not null,
age varchar(10),
sex varchar(10),
birth varchar(20),
weight Integer,
walk Integer,
bath Integer,
sleep Integer,
feed varchar(20),
allergy varchar(20),
heart Integer,
fileName varchar(20),
primary key (id)



)default charset=utf8;
