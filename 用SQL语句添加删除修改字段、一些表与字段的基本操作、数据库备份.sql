/*
用SQL语句添加删除修改字段 
1.增加字段 
alter table docdsp add dspcode char(200) 
2.删除字段 
ALTER TABLE table_NAME DROP COLUMN column_NAME 
3.修改字段类型 
ALTER TABLE table_name ALTER COLUMN column_name new_data_type 
4.sp_rename 改名 
更改当前数据库中用户创建对象（如表、列或用户定义数据类型）的名称。 
语法 
sp_rename [ @objname = ] 'object_name' , 
[ @newname = ] 'new_name' 
[ , [ @objtype = ] 'object_type' ] 
如：EXEC sp_rename 'newname','PartStock' 
5.sp_help 显示表的一些基本情况 
sp_help 'object_name' 如：EXEC sp_help 'PartStock' 
6.判断某一表PartStock中字段PartVelocity是否存在 
if exists (select * from syscolumns where id=object_id('PartStock') and name='PartVelocity') 
print 'PartVelocity exists' 
else print 'PartVelocity not exists' 
另法： 
判断表的存在性： 
select count(*) from sysobjects where type='U' and name='你的表名' 
判断字段的存在性： 
select count(*) from syscolumns 
where id = (select id from sysobjects where type='U' and name='你的表名') 
and name = '你要判断的字段名' 

一个小例子 
--假设要处理的表名为: tb 
--判断要添加列的表中是否有主键 
if exists(select 1 from sysobjects where parent_obj=object_id('tb') and xtype='PK') 
begin 
print '表中已经有主键,列只能做为普通列添加' 
--添加int类型的列,默认值为0 
alter table tb add 列名 int default 0 
end 
else 
begin 
print '表中无主键,添加主键列' 
--添加int类型的列,默认值为0 
alter table tb add 列名 int primary key default 0 
end 

7.随机读取若干条记录 
Access语法：SELECT top 10 * From 表名 ORDER BY Rnd(id) 
Sql server:select top n * from 表名 order by newid() 
mysql select * From 表名 Order By rand() Limit n 
8.说明：日程安排提前五分钟提醒 
SQL: select * from 日程安排 where datediff(minute,f开始时间,getdate())>5 

9.前10条记录 
select top 10 * form table1 where 范围 

10.包括所有在 TableA 中但不在 TableB和TableC 中的行并消除所有重复行而派生出一个结果表 
(select a from tableA ) except (select a from tableB) except (select a from tableC) 

11.说明：随机取出10条数据 
select top 10 * from tablename order by newid() 

12.列出数据库里所有的表名 
select name from sysobjects where type=U 
13.列出表里的所有的字段名 
select name from syscolumns where id=object_id(TableName) 
14.说明：列示type、vender、pcs字段，以type字段排列，case可以方便地实现多重选择，类似select 中的case。 
select type,sum(case vender when A then pcs else 0 end),sum(case vender when C then pcs else 0 end),sum(case vender when B then pcs else 0 end) FROM tablename group by type 
15.说明：初始化表table1 
TRUNCATE TABLE table1 
16.说明：几个高级查询运算词 
　　A： UNION 运算符 
　　UNION 运算符通过组合其他两个结果表（例如 TABLE1 和 TABLE2）并消去表中任何重复行而派生出一个结果表。当 ALL 随 UNION 一起使用时（即 UNION ALL），不消除重复行。两种情况下，派生表的每一行不是来自 TABLE1 就是来自 TABLE2。 

　　B： EXCEPT 运算符 
　　EXCEPT 运算符通过包括所有在 TABLE1 中但不在 TABLE2 中的行并消除所有重复行而派生出一个结果表。当 ALL 随 EXCEPT 一起使用时 (EXCEPT ALL)，不消除重复行。 

　　C： INTERSECT 运算符 
　　INTERSECT 运算符通过只包括 TABLE1 和 TABLE2 中都有的行并消除所有重复行而派生出一个结果表。当 ALL 随 INTERSECT 一起使用时 (INTERSECT ALL)，不消除重复行。 
　　注：使用运算词的几个查询结果行必须是一致的。 


17.说明：在线视图查询(表名1：a ) 
select * from (SELECT a,b,c FROM a) T where t.a > 1; 

18.说明：between的用法,between限制查询数据范围时包括了边界值,not between不包括 
select * from table1 where time between time1 and time2 
select a,b,c, from table1 where a not between 数值1 and 数值2 

19.说明：in 的使用方法 
select * from table1 where a [not] in (‘值1','值2','值4','值6') 

20.说明：两张关联表，删除主表中已经在副表中没有的信息 
delete from table1 where not exists ( select * from table2 where table1.field1=table2.field1 ) 
21.　说明：复制表(只复制结构,源表名：a 新表名：b) (Access可用) 
　　法一：select * into b from a where 1<>1 
　　法二：select top 0 * into b from a 

22.说明：拷贝表(拷贝数据,源表名：a 目标表名：b) (Access可用) 
insert into b(a, b, c) select d,e,f from b; 

23.说明：跨数据库之间表的拷贝(具体数据使用绝对路径) (Access可用) 
insert into b(a, b, c) select d,e,f from b in ‘具体数据库' where 条件 
　　例子：..from b in "&Server.MapPath(".")&"\data.mdb" &" where.. 
24.创建数据库 
CREATE DATABASE database-name 

25.说明：删除数据库 
drop database dbname 
26.说明：备份sql server 
　　--- 创建 备份数据的 device 
USE master 
EXEC sp_addumpdevice disk, testBack, c:\mssql7backup\MyNwind_1.dat 

　　--- 开始 备份 
BACKUP DATABASE pubs TO testBack 

27.说明：创建新表 
create table tabname(col1 type1 [not null] [primary key],col2 type2 [not null],..) 
　　根据已有的表创建新表： 
A：create table tab_new like tab_old (使用旧表创建新表) 
B：create table tab_new as select col1,col2… from tab_old definition only 

28.说明： 
　　删除新表：drop table tabname 

29.说明： 
　　增加一个列：Alter table tabname add column col type 
　　注：列增加后将不能删除。DB2中列加上后数据类型也不能改变，唯一能改变的是增加varchar类型的长度。 

30.说明： 
　　添加主键：Alter table tabname add primary key(col) 
　　说明： 
　　删除主键：Alter table tabname drop primary key(col) 

31.说明： 
　　创建索引：create [unique] index idxname on tabname(col….) 
　　删除索引：drop index idxname 
　　注：索引是不可更改的，想更改必须删除重新建。 

32.说明： 
　　创建视图：create view viewname as select statement 
　　删除视图：drop view viewname 

33.说明：几个简单的基本的sql语句 
　　选择：select * from table1 where 范围 
　　插入：insert into table1(field1,field2) values(value1,value2) 
　　删除：delete from table1 where 范围 
　　更新：update table1 set field1=value1 where 范围 
　　查找：select * from table1 where field1 like '%value1%' ---like的语法很精妙，查资料! 
　　排序：select * from table1 order by field1,field2 [desc] 
　　总数：select count * as totalcount from table1 
　　求和：select sum(field1) as sumvalue from table1 
　　平均：select avg(field1) as avgvalue from table1 
　　最大：select max(field1) as maxvalue from table1 
　　最小：select min(field1) as minvalue from table1 

34.数据库备份： 
复制代码 代码如下:
USE DB_ndmspmasterdb; 
GO 

declare @path varchar(500) 
set @path='D:\NDM_Data\DB_NDMSpMasterdb'+CONVERT(VARCHAR, GETDATE(), 105)+'.Bak' 
select @path 

BACKUP DATABASE DB_ndmspmasterdb 

TO DISK = @path 
WITH FORMAT, 
MEDIANAME = 'Z_SQLServerBackups', 
NAME = 'Full Backup of DB_ndmspmasterdb'; 
GO 
*/
