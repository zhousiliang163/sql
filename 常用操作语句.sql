--查询某个表所有字段
select * from user_tab_columns t where t.TABLE_NAME=upper('t_sys_supplier');
--输出指定表的所有字段
declare
  v_tableName varchar2(30):='t_sys_supplier_linkman';
  v_return varchar2(4000):='';
  not_columns varchar2(4000):='';--不要输出的列
begin
  
   for row in (select * from user_tab_columns t where t.TABLE_NAME=upper(v_tableName)) 
   loop
       
       if row.column_name not in ('STATE','STATEDATE') then
	          v_return:=v_return||row.column_name||',';
      
       end if;
	    -- v_return:=v_return||row.column_name||',';
       
   end loop;
      v_return:=substr(v_return,1,length(v_return)-1);
     dbms_output.put_line(v_return);
  
end;
