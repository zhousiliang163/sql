select * from p_sys_processinstance t where   t.resouceid='f77c113d3b1d469181b7aa15ee4be53a'
and t.appid='01040a'
;
select * from p_sys_processinstance t where t.appid in ('010407','01040a','01040b');
select * from p_sys_activityinstance t where t.processinstanceid='4028814e451bf4da01451c2189d40037';
---��ѯĳ��ĳҵ��Ĵ�������
select * from p_sys_workitemo psw where 
psw.apptype='01040a' 
and psw.status='DB'
and (psw.ownerid='40288f8140adfe700140ae1036b80000' or 
     exists ( select 1  from p_sys_accredit psa where psa.ACCEPTORID='40288f8140adfe700140ae1036b80000' and psw.ownerid=psa.grantorid)
     )
;
--�����
select * from p_sys_workitemo psw
--��Ȩ�����
select psa.grantorid from p_sys_accredit psa where psa.ACCEPTORID='aaa';


--ɾ������ʵ��delete_process();
declare

v_appid varchar2(50):='11';
v_apptype varchar2(50):='11';
begin
    
 
end;

