/*
��SQL������ɾ���޸��ֶ� 
1.�����ֶ� 
alter table docdsp add dspcode char(200) 
2.ɾ���ֶ� 
ALTER TABLE table_NAME DROP COLUMN column_NAME 
3.�޸��ֶ����� 
ALTER TABLE table_name ALTER COLUMN column_name new_data_type 
4.sp_rename ���� 
���ĵ�ǰ���ݿ����û�������������л��û������������ͣ������ơ� 
�﷨ 
sp_rename [ @objname = ] 'object_name' , 
[ @newname = ] 'new_name' 
[ , [ @objtype = ] 'object_type' ] 
�磺EXEC sp_rename 'newname','PartStock' 
5.sp_help ��ʾ���һЩ������� 
sp_help 'object_name' �磺EXEC sp_help 'PartStock' 
6.�ж�ĳһ��PartStock���ֶ�PartVelocity�Ƿ���� 
if exists (select * from syscolumns where id=object_id('PartStock') and name='PartVelocity') 
print 'PartVelocity exists' 
else print 'PartVelocity not exists' 
���� 
�жϱ�Ĵ����ԣ� 
select count(*) from sysobjects where type='U' and name='��ı���' 
�ж��ֶεĴ����ԣ� 
select count(*) from syscolumns 
where id = (select id from sysobjects where type='U' and name='��ı���') 
and name = '��Ҫ�жϵ��ֶ���' 

һ��С���� 
--����Ҫ����ı���Ϊ: tb 
--�ж�Ҫ����еı����Ƿ������� 
if exists(select 1 from sysobjects where parent_obj=object_id('tb') and xtype='PK') 
begin 
print '�����Ѿ�������,��ֻ����Ϊ��ͨ�����' 
--���int���͵���,Ĭ��ֵΪ0 
alter table tb add ���� int default 0 
end 
else 
begin 
print '����������,���������' 
--���int���͵���,Ĭ��ֵΪ0 
alter table tb add ���� int primary key default 0 
end 

7.�����ȡ��������¼ 
Access�﷨��SELECT top 10 * From ���� ORDER BY Rnd(id) 
Sql server:select top n * from ���� order by newid() 
mysql select * From ���� Order By rand() Limit n 
8.˵�����ճ̰�����ǰ��������� 
SQL: select * from �ճ̰��� where datediff(minute,f��ʼʱ��,getdate())>5 

9.ǰ10����¼ 
select top 10 * form table1 where ��Χ 

10.���������� TableA �е����� TableB��TableC �е��в����������ظ��ж�������һ������� 
(select a from tableA ) except (select a from tableB) except (select a from tableC) 

11.˵�������ȡ��10������ 
select top 10 * from tablename order by newid() 

12.�г����ݿ������еı��� 
select name from sysobjects where type=U 
13.�г���������е��ֶ��� 
select name from syscolumns where id=object_id(TableName) 
14.˵������ʾtype��vender��pcs�ֶΣ���type�ֶ����У�case���Է����ʵ�ֶ���ѡ������select �е�case�� 
select type,sum(case vender when A then pcs else 0 end),sum(case vender when C then pcs else 0 end),sum(case vender when B then pcs else 0 end) FROM tablename group by type 
15.˵������ʼ����table1 
TRUNCATE TABLE table1 
16.˵���������߼���ѯ����� 
����A�� UNION ����� 
����UNION �����ͨ���������������������� TABLE1 �� TABLE2������ȥ�����κ��ظ��ж�������һ��������� ALL �� UNION һ��ʹ��ʱ���� UNION ALL�����������ظ��С���������£��������ÿһ�в������� TABLE1 �������� TABLE2�� 

����B�� EXCEPT ����� 
����EXCEPT �����ͨ������������ TABLE1 �е����� TABLE2 �е��в����������ظ��ж�������һ��������� ALL �� EXCEPT һ��ʹ��ʱ (EXCEPT ALL)���������ظ��С� 

����C�� INTERSECT ����� 
����INTERSECT �����ͨ��ֻ���� TABLE1 �� TABLE2 �ж��е��в����������ظ��ж�������һ��������� ALL �� INTERSECT һ��ʹ��ʱ (INTERSECT ALL)���������ظ��С� 
����ע��ʹ������ʵļ�����ѯ����б�����һ�µġ� 


17.˵����������ͼ��ѯ(����1��a ) 
select * from (SELECT a,b,c FROM a) T where t.a > 1; 

18.˵����between���÷�,between���Ʋ�ѯ���ݷ�Χʱ�����˱߽�ֵ,not between������ 
select * from table1 where time between time1 and time2 
select a,b,c, from table1 where a not between ��ֵ1 and ��ֵ2 

19.˵����in ��ʹ�÷��� 
select * from table1 where a [not] in (��ֵ1','ֵ2','ֵ4','ֵ6') 

20.˵�������Ź�����ɾ���������Ѿ��ڸ�����û�е���Ϣ 
delete from table1 where not exists ( select * from table2 where table1.field1=table2.field1 ) 
21.��˵�������Ʊ�(ֻ���ƽṹ,Դ������a �±�����b) (Access����) 
������һ��select * into b from a where 1<>1 
����������select top 0 * into b from a 

22.˵����������(��������,Դ������a Ŀ�������b) (Access����) 
insert into b(a, b, c) select d,e,f from b; 

23.˵���������ݿ�֮���Ŀ���(��������ʹ�þ���·��) (Access����) 
insert into b(a, b, c) select d,e,f from b in ���������ݿ�' where ���� 
�������ӣ�..from b in "&Server.MapPath(".")&"\data.mdb" &" where.. 
24.�������ݿ� 
CREATE DATABASE database-name 

25.˵����ɾ�����ݿ� 
drop database dbname 
26.˵��������sql server 
����--- ���� �������ݵ� device 
USE master 
EXEC sp_addumpdevice disk, testBack, c:\mssql7backup\MyNwind_1.dat 

����--- ��ʼ ���� 
BACKUP DATABASE pubs TO testBack 

27.˵���������±� 
create table tabname(col1 type1 [not null] [primary key],col2 type2 [not null],..) 
�����������еı����±� 
A��create table tab_new like tab_old (ʹ�þɱ����±�) 
B��create table tab_new as select col1,col2�� from tab_old definition only 

28.˵���� 
����ɾ���±�drop table tabname 

29.˵���� 
��������һ���У�Alter table tabname add column col type 
����ע�������Ӻ󽫲���ɾ����DB2���м��Ϻ���������Ҳ���ܸı䣬Ψһ�ܸı��������varchar���͵ĳ��ȡ� 

30.˵���� 
�������������Alter table tabname add primary key(col) 
����˵���� 
����ɾ��������Alter table tabname drop primary key(col) 

31.˵���� 
��������������create [unique] index idxname on tabname(col��.) 
����ɾ��������drop index idxname 
����ע�������ǲ��ɸ��ĵģ�����ı���ɾ�����½��� 

32.˵���� 
����������ͼ��create view viewname as select statement 
����ɾ����ͼ��drop view viewname 

33.˵���������򵥵Ļ�����sql��� 
����ѡ��select * from table1 where ��Χ 
�������룺insert into table1(field1,field2) values(value1,value2) 
����ɾ����delete from table1 where ��Χ 
�������£�update table1 set field1=value1 where ��Χ 
�������ң�select * from table1 where field1 like '%value1%' ---like���﷨�ܾ��������! 
��������select * from table1 order by field1,field2 [desc] 
����������select count * as totalcount from table1 
������ͣ�select sum(field1) as sumvalue from table1 
����ƽ����select avg(field1) as avgvalue from table1 
�������select max(field1) as maxvalue from table1 
������С��select min(field1) as minvalue from table1 

34.���ݿⱸ�ݣ� 
���ƴ��� ��������:
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
