/*
create  database link
　　dblink_206_01 connect to pms identified by pms using 'ORCL_206';

create public database link dblink_206
　　connect to pms identified by pms
　　using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.1.206)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
*/
select *  from purchases;--purchases_sequence
select purchases_sequence.nextval from dual;
--delete from purchases;

select * from user_db_links@dblink_206;

select * from user_tab_comments t where t.TABLE_NAME=upper('purchases');

select * from user_db_links t;
select * from dba_db_links;
select * from user_sys_privs t;
select * from user_role_privs;
