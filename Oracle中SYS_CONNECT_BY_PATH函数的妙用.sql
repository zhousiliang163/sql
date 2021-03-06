select t.badmanageid ,t.managecode,t.badmanagetype,
(select dd.chinese_name from t_base_data_dictionary dd where dd.system_id=t.managestate) managestatename,
to_char(t.createdate,'yyyy-mm-dd hh24:mi:ss') createdate,t.dept,t.managestate,t.context,
(select dd.chinese_name from t_base_data_dictionary dd where dd.system_id=t.badmanagetype) badmanagetypename,
(
    select
   LTRIM(MAX(SYS_CONNECT_BY_PATH(gcompanycn, ',')), ',') supplieridcns
  from
   ( 
    SELECT ss.gcompanyid,ss.gcompanycn, br.managecode,ss.gcompanyjc,
    ROW_NUMBER() OVER(PARTITION BY br.managecode  ORDER BY ss.gcompanycn DESC) RN  
    FROM t_supplier_bad_ralation br,t_sys_supplier ss 
    where  br.supplierid=ss.gcompanyid 
   )
   where managecode =t.managecode
  START WITH RN = 1 
  CONNECT BY RN - 1 = PRIOR RN 
  and managecode= PRIOR managecode     
  GROUP BY managecode
) supplieridcns
 from t_supplier_bad_manage t where t.state=1;
 

---------------------------------
select managecode,LTRIM(MAX(SYS_CONNECT_BY_PATH(gcompanyid, ',')), ',') supplierids,
LTRIM(MAX(SYS_CONNECT_BY_PATH(gcompanycn, ',')), ',') supplieridcns
from
 ( 
  SELECT ss.gcompanyid,ss.gcompanycn, br.managecode,
  ROW_NUMBER() OVER(PARTITION BY br.managecode  ORDER BY ss.gcompanycn DESC) RN  
  FROM t_supplier_bad_ralation br,t_sys_supplier ss 
  where  br.supplierid=ss.gcompanyid 
  --and br.managecode='20140314044700014'
) where managecode in ('20140314044700014')
START WITH RN = 1 
CONNECT BY RN - 1 = PRIOR RN  
--and managecode= PRIOR managecode
GROUP BY managecode; 
------------------------------------


SELECT ss.gcompanyid,ss.gcompanycn, br.managecode
   
  FROM t_supplier_bad_ralation br,t_sys_supplier ss 
  where  br.supplierid=ss.gcompanyid 

