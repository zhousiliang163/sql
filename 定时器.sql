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
  dbms_job.submit(jobno,--��ʱ��ID��ϵͳ�Զ����
  'proce_remote_51_purchases;',--whatִ�еĹ�����
   sysdate,--next_date,��ʱ����ʼִ�е�ʱ�䣬����д��ʾ����ִ��
  'sysdate + 15/1440'--interval,���ö�ʱ��ִ�е�Ƶ�ʣ�����дÿ��15����ִ��һ��
);
commit;
end;


select * from user_jobs;--�鿴��������
select * from dba_jobs_running;--�鿴����ִ�еĵ�������
select * from dba_jobs;--�鿴ִ����ĵ�������
