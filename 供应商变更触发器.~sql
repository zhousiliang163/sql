
create or replace trigger trigger_change_supplier

after  update  of VERSION,OPERATOR,EXT1,EXT2,GCOMPANYCN,GCOMPANYEN,GCOMPANYJC,GYEAR,GCOUNTRY,GADDRESS,GPOSTCODE,GTEL,GFAX,GWEBSITE,GMAIL,GBANK,GBANKACCOUNT,GTAXNUMBER,GTAXRATE,GOPERATYPE,GCOMPANYJJ,GOPERAGOODS,GSALESADD,GFACTORYNAME,GFACTORYADD,GEMPLOYEES,GYEARSALE,GGRADE,GCHANGE,GSTATE,GFFIXID,ISSUPPLIER,GLEGELRE
on t_sys_supplier
 REFERENCING OLD AS old_DICTIONARY NEW AS new_DICTIONARY
 for each row
when (old_DICTIONARY.gstate  not in ('0g0101','0g0102','0g0103','0g0105','0g0106'))--潜在供应商不需要记录

declare
    --pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。
    v_sql varchar2(4000):='';
begin
      if updating then
                            
               for row in (select * from user_tab_columns t where t.TABLE_NAME=upper('t_sys_supplier')) 
               loop
                   
                    v_sql:=' if 1=:2 then ';
                    v_sql:=v_sql||'insert into t_supplier_changelog_temp value(LOGID,OPERATEITEM) values('||'SYS_guid(),'''||row.column_name||''');';

                   
                     v_sql:=v_sql||'end if;';
                     -- dbms_output.put_line(v_sql);
                   execute immediate v_sql  using 1,1;
                    v_sql:='';
                 

                   
               end loop;         
      end if;
  exception
   when others then
      RAISE_APPLICATION_ERROR(-20000,'同步MATERIALSTYPE表数据失败！'||sqlerrm||v_sql);

end;
