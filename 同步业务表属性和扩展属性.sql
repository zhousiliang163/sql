select * from T_BUSINESSTYPE_PROPERTY t; 
 insert into T_BUSINESSTYPE_PROPERTY(BUSINESSTYPECODE,BUSINESSTYPE,Propertycode,Propertyname,Code01,Remark)
 
 with
 a as (select *
      from t_column_extend ce,t_column_extend_relation cer 
      where ce.column_code=cer.column_code
            and ce.state=1 and cer.state=1
      )
 select '01050401','供应商信息表扩展',sys_guid(), column_name,business_type,column_comments from a where column_name||BUSINESS_TYPE not in (
  select t.propertyname||t.CODE01 from T_BUSINESSTYPE_PROPERTY t where t.businesstypecode='01050401'
 )
 
 ;
 
 select t.*,rowid from T_BUSINESSTYPE_PROPERTY_detail t where t.state=1;
 insert into T_BUSINESSTYPE_PROPERTY_detail(Propertycode,Showname)
 select t.propertycode,t.remark from T_BUSINESSTYPE_PROPERTY t where t.propertycode not in 
 (select d.propertycode from T_BUSINESSTYPE_PROPERTY_detail d);
 
