--仓管3d数据展示

create or replace procedure refresh_3Dview_proc(
tablename in varchar2,--要同步的表名
is_all in number--1：同步所有的表，0：同步指定的表
) as

begin
    ----------------MATERIALSTYPE
    if is_all=1 or (upper(tablename)='T_BASE_DATA_DICTIONARY' and is_all=0) then
	        begin
            delete from MATERIALSTYPE;
            
            insert into MATERIALSTYPE(MATERIALSTYPECODE,CREATEDATE,MATERIALSTYPENAME,MATERIALSTYPEID) select t.system_id, t.up_system_id,t.chinese_name,MATERIALSTYPE_SEQUENCE.NEXTVAL  from T_BASE_DATA_DICTIONARY t start with t.up_system_id='06' connect by prior t.system_id=  t.up_system_id;
            
            update MATERIALSTYPE t set t.materialsparentid=(select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=t.createdate);
    
          exception
           when others then
              rollback;
              RAISE_APPLICATION_ERROR(-20000,'同步MATERIALSTYPE表数据失败！'||sqlerrm);
       end;
     end if;
   
    ---------------MATERIALS
    if is_all=1 or (upper(tablename)=upper('t_sys_materials') and is_all=0) then
          begin
            delete from MATERIALS;
            
            insert into MATERIALS(Materialsname,MATERIALSCODE,MATERIALSTYPEID,MATERIALSMODEL,MATERIALSBRAND,BENCHMARKPRICE,avgprice,Site,MATERIALSLEVEL,AFFIXPATH,MATERIALSID) 
            select m.materialsname,m.materialscode,(select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=m.materialstypeid ),m.materialsmodel,
            m.materialsbrand,m.benchmarkprice,m.avgprice,m.site,m.materialslevel,m.materialsid,MATERIALS_SEQUENCE.NEXTVAL 
            from t_sys_materials m where m.ext1 is null and m.isnewversion='YES';
    
         exception
           when others then
             rollback;
             RAISE_APPLICATION_ERROR(-20000,'同步MATERIALS表数据失败！'||sqlerrm);
         end;
    end if; 
   
    -----------------WAREHOUSINFO
   if is_all=1 or (upper(tablename)=upper('t_sys_depository') and is_all=0) then
        begin
           delete from WAREHOUSINFO;
           
           insert into WAREHOUSINFO(Depositoryid,Up_Depositoryid,WAREHOUSNAME,WAREHOUSLONG,WAREHOUSWIDTH,
           WAREHOUSHEIGHT,MAXINVENTORY,Mininventory,MATERIALSTYPEID,WAREHOUSINFOID)
           select d.depository_id,d.up_depository_id,d.depository_name,d.depository_long,d.depository_width,d.depository_height,d.max_inventory,d.min_inventory,
           (select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=d.materials_type_id ),WAREHOUSINFO_SEQUENCE.NEXTVAL from t_sys_depository d;
            
           update WAREHOUSINFO t set t.parentid=(select a.warehousinfoid from WAREHOUSINFO a where a.depositoryid=t.up_depositoryid);
          
          -- update t_sys_depository t set t.view3d_id=(select a.warehousinfoid from WAREHOUSINFO a where a.depositoryid=t.depository_id);
          
      
       exception
           when others then
             rollback;
             RAISE_APPLICATION_ERROR(-20000,'同步WAREHOUSINFO表数据失败！'||sqlerrm);
        
       end;
  end if;

  ---------------------------STORAGEINFO
   if is_all=1 or (upper(tablename)=upper('t_sys_in_depository_info') and is_all=0) then
      begin
          delete from STORAGEINFO;
          
          insert into STORAGEINFO
          select STORAGEINFO_SEQUENCE.Nextval,(select tw.warehousinfoid from WAREHOUSINFO tw where tw.depositoryid=i.depository_id) warehousinfoid,
          (select tm.materialsid from MATERIALS tm where tm.affixpath=i.materials_id ) materialsid,
          i.materials_code,i.count_numner,i.materials_name,'',i.in_depository_info_id from t_sys_in_depository_info i;
      
       exception
           when others then
              rollback;
              RAISE_APPLICATION_ERROR(-20000,'同步STORAGEINFO表数据失败！'||sqlerrm);
        
      end;
  end if;
  commit;
end;

create or replace trigger trigger_t_BASE_DATA_DICTIONARY

after  insert or delete or update on T_BASE_DATA_DICTIONARY
 REFERENCING OLD AS old_DICTIONARY NEW AS new_DICTIONARY
 for each row
when ((substr(new_DICTIONARY.system_id,1,2)='06') or (substr(old_DICTIONARY.system_id,1,2)='06'))
 
declare
    --pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。
    v_MATERIALSTYPEID number(10);
begin
      if INSERTING then
                          select MATERIALSTYPE_SEQUENCE.NEXTVAL into v_MATERIALSTYPEID from dual;
                          insert into MATERIALSTYPE(MATERIALSTYPECODE,CREATEDATE,MATERIALSTYPENAME,MATERIALSTYPEID) values(
                            :new_DICTIONARY.system_id, :new_DICTIONARY.up_system_id,:new_DICTIONARY.chinese_name,v_MATERIALSTYPEID ) ;
                          
                          update MATERIALSTYPE t set t.materialsparentid=(select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=t.createdate)where
                          t.materialstypeid=v_MATERIALSTYPEID;
      
      elsif deleting then
          
                    delete from MATERIALSTYPE t where t.MATERIALSTYPECODE=:old_DICTIONARY.system_id;
      
      elsif updating then
          
                    update MATERIALSTYPE t set t.materialstypename=:new_DICTIONARY.chinese_name where t.MATERIALSTYPECODE=:old_DICTIONARY.system_id;
            
      end if;
  exception
   when others then
      RAISE_APPLICATION_ERROR(-20000,'同步MATERIALSTYPE表数据失败！'||sqlerrm);

end;


create or replace trigger trigger_t_sys_materials
after insert or delete or update on t_sys_materials 
REFERENCING OLD AS old_DICTIONARY NEW AS new_DICTIONARY
for each row
when ((old_DICTIONARY.ext1 is null and old_DICTIONARY.isnewversion='YES') or 
 (new_DICTIONARY.ext1 is null and new_DICTIONARY.isnewversion='YES'))
 
declare   
   -- pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。

 
begin
    if INSERTING then
           insert into MATERIALS(Materialsname,MATERIALSCODE,MATERIALSTYPEID,MATERIALSMODEL,MATERIALSBRAND,BENCHMARKPRICE,avgprice,Site,MATERIALSLEVEL,AFFIXPATH,MATERIALSID)
            values( :new_DICTIONARY.materialsname,:new_DICTIONARY.materialscode,(select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=:new_DICTIONARY.materialstypeid ),:new_DICTIONARY.materialsmodel,
            :new_DICTIONARY.materialsbrand,:new_DICTIONARY.benchmarkprice,:new_DICTIONARY.avgprice,:new_DICTIONARY.site,:new_DICTIONARY.materialslevel,:new_DICTIONARY.materialsid,MATERIALS_SEQUENCE.NEXTVAL
            );
           
   elsif deleting then
          delete from MATERIALS t where t.affixpath=:old_DICTIONARY.materialsid;
              
   elsif updating then
        update MATERIALS t set t.materialsname=:new_DICTIONARY.materialsname,t.materialsmodel=:new_DICTIONARY.materialsmodel,
         t.materialsbrand=:new_DICTIONARY.materialsbrand,t.benchmarkprice=:new_DICTIONARY.benchmarkprice,
         t.avgprice=:new_DICTIONARY.avgprice,t.site=:new_DICTIONARY.site,t.materialslevel=:new_DICTIONARY.materialslevel
         where t.affixpath=:old_DICTIONARY.materialsid;
        
  end if;
  exception
   when others then 
      RAISE_APPLICATION_ERROR(-20000,'同步MATERIALS表数据失败！'||sqlerrm);

end;


create or replace trigger trigger_t_sys_depository
after insert or delete or update of depository_name,depository_long,depository_width,
   depository_height,max_inventory,min_inventory on t_sys_depository 
REFERENCING OLD AS old_data NEW AS new_data
for each row
 declare   
   -- pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。
   v_WAREHOUSINFOID number(10);

begin
    if INSERTING then
            select WAREHOUSINFO_SEQUENCE.NEXTVAL into v_WAREHOUSINFOID from dual;
            insert into WAREHOUSINFO(Depositoryid,Up_Depositoryid,WAREHOUSNAME,WAREHOUSLONG,WAREHOUSWIDTH,
            WAREHOUSHEIGHT,MAXINVENTORY,Mininventory,MATERIALSTYPEID,WAREHOUSINFOID)values(
            :new_data.depository_id,:new_data.up_depository_id,:new_data.depository_name,:new_data.depository_long,:new_data.depository_width,:new_data.depository_height,:new_data.max_inventory,:new_data.min_inventory,
           (select a.materialstypeid from MATERIALSTYPE a where a.materialstypecode=:new_data.materials_type_id ),v_WAREHOUSINFOID
           );
           
            update WAREHOUSINFO t set t.parentid=(select a.warehousinfoid from WAREHOUSINFO a where a.depositoryid=t.up_depositoryid) where t.warehousinfoid=v_WAREHOUSINFOID;

   elsif deleting then
          delete from WAREHOUSINFO t where t.Depositoryid=:old_data.depository_id;
                 
   elsif updating then
        update WAREHOUSINFO t set t.warehousname=:new_data.depository_name,t.warehouslong=:new_data.depository_long,
        t.warehouswidth=:new_data.depository_width,t.warehousheight=:new_data.depository_height,t.maxinventory=:new_data.max_inventory,
        t.mininventory=:new_data.min_inventory
        where t.Depositoryid=:old_data.depository_id;
        
  end if;
  exception
   when others then
      
      RAISE_APPLICATION_ERROR(-20000,'同步WAREHOUSINFO表数据失败！'||sqlerrm);

 
end;



create or replace trigger trigger_depository_info
after insert or delete or update on t_sys_in_depository_info 
REFERENCING OLD AS old_data NEW AS new_data
for each row
 declare   
   -- pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。
begin
  
    if INSERTING then
              insert into STORAGEINFO values(
             STORAGEINFO_SEQUENCE.Nextval,(select tw.warehousinfoid from WAREHOUSINFO tw where tw.depositoryid=:new_data.depository_id),
            (select tm.materialsid from MATERIALS tm where tm.affixpath=:new_data.materials_id ),
            :new_data.materials_code,:new_data.count_numner,:new_data.materials_name,'',:new_data.in_depository_info_id );
      
   elsif deleting then
          delete from STORAGEINFO t where t.in_depository_info_id=:old_data.in_depository_info_id;
                
   elsif updating then
        update STORAGEINFO t set t.countnumber=:new_data.count_numner,t.materialsname=:new_data.materials_name
        where t.in_depository_info_id=:old_data.in_depository_info_id;
        
  end if;
  exception
   when others then
     
      RAISE_APPLICATION_ERROR(-20000,'同步STORAGEINFO表数据失败！'||sqlerrm);
end;





---------------------定时器

/*declare 
 jobId number:=25;  
begin   
    
     -- dbms_job.remove(jobId);
      -- select max(job.JOB)+1 into jobId from user_jobs job;
        dbms_job.submit(jobId,'refresh_3Dview_proc;',sysdate,'sysdate+1/1440');--每天1440分钟，即一分钟运行test过程一次  
        commit;
end; 
 
begin
--dbms_job.run(23);
dbms_job.broken(22,true);
commit;
end;

select t.*,rowid from user_jobs t ;
select * from dba_jobs;
select * from dba_jobs_running;
select job from sys.job$ j;*/

--------------------------------------------
