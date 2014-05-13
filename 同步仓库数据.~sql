--1.建dblink
create public database link dblink_206
　　connect to wds identified by wds
　　using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.1.206)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
  
--建存储过程
create or replace procedure proce_remote_51_purchases is
begin
   
  insert into purchases select * from wds.purchases@dblink_206 wp where wp.state=1 and wp.stockid not in 
  (select p.stockid from purchases p) ;
  commit;   

end;

--建定时器

declare
jobno number(2);
begin 
  dbms_job.submit(jobno,--定时器ID，系统自动获得
  'proce_remote_51_purchases;',--what执行的过程名
   sysdate,--next_date,定时器开始执行的时间，这样写表示立即执行
  'sysdate + 15/1440'--interval,设置定时器执行的频率，这样写每隔15分钟执行一次
);
commit;
end;
