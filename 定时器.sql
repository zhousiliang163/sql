/*create or replace procedure proce_remote_51_purchases is

begin
   
  insert into purchases select * from wds.purchases@dblink_206 wp where wp.state=1 and wp.stockid not in 
  (select p.stockid from purchases p) ;
  commit;   

end;
*/

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


select * from user_jobs;--查看调度任务
select * from dba_jobs_running;--查看正在执行的调度任务
select * from dba_jobs;--查看执行完的调度任务
