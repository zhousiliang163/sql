declare
 v_code varchar2(50):='DHEC-14-S0514';
 v_str clob:='';
begin
  for p in (select * from t_sys_supplier_other t where t.state=1 and t.supplier_code=v_code ) loop
	   v_str:=v_str||' MAX(decode(column_name, '''||p.column_name||''', column_value, NULL)) AS "'|| p.column_name||'",';
    
  end loop;
  
 
dbms_output.put_line(rtrim(v_str,','));

end;
