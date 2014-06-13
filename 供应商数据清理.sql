

--供应商数据清理
begin
  
  begin
 --备份
 delete from t_sys_supplier_bak sb where exists(select 1 from t_sys_supplier ts where ts.gcompanyid=sb.gcompanyid);
 insert into t_sys_supplier_bak  select * from t_sys_supplier ts;
 
 delete from t_sys_supplier_linkman_bak lb where 
 exists (select 1 from t_sys_supplier_linkman tl where lb.linkmanid=tl.linkmanid );
  insert into t_sys_supplier_linkman_bak select * from t_sys_supplier_linkman tl ;
 commit;
end;

  delete from t_supplier_changetrace ;
  delete from t_supplier_changetrace_detail;
  delete from  t_supplier_bad_manage;
  delete from t_supplier_bad_ralation;
  delete from T_SYS_Supplier_Tinform;
  delete from t_Supplier_notice_relation;
  delete from t_sys_supplier_valua;
  delete from t_supplier_kaoping_relation;
  delete from t_sys_supplier_remind;
  delete from t_sys_supplier_agreement;
  commit;

end;

begin
  delete_process('','');
end;

begin
   
  for p in (
    select * from p_sys_processinstance t where t.appid in ('010407','01040a','01040b')
    and t.resouceid in ('20140606163316584760531','20140606163144677154303')
    )
 loop
	     delete_process(p.resouceid,p.appid);
  end loop;
end;
