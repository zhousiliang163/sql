
--供应商有联系人，但联系人没有邮箱
select t.* from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode  not    in
(
select tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null and tl.lemil is null
);

--供应商编码、类别为空的供应商
select * from t_sys_supplier_temp t where t.gcompanycode is null;

--供应商没有联系人
select t.*,rowid from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode not in 
(select  tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null );
--供应商联系人的邮箱不规范
select t.* from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode    in(
select tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null and  tl.lemil is not null
and (length(tl.lemil) - length(replace(tl.lemil,'@')))/length('@')>1
)
--供应商编码重复
select * from t_sys_supplier_temp a where a.gcompanycode in (
select gcompanycode from t_sys_supplier_temp t group by t.gcompanycode having count(1)>1
)


select SYS_guid(),t.*,rowid from t_sys_supplier_temp t where t.gmail is not null and rownum<20;


 select * from t_sys_supplier t;

select t.*,rowid from t_sys_supplier_temp t where t.gcompanycode='DHEC-08-C0047';

select * from t_sys_supplier_linkman_temp t where t.lcompanyid='DHEC-07-C0009';

select * from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null and  tl.lemil is not null;

select * from t_sys_supplier_linkman_temp t where t.lcompanyid not in (select a.gcompanycode from t_sys_supplier_temp a);

--delete from  t_sys_supplier_temp t ;
--delete from t_sys_supplier_linkman_temp t;

/*
第一步：往供应商临时表导入供应商资料基本数据
*/
--1
select 
t.runtype "经营类别",t.gcompanycn "公司名",t.gcompanyen "中文名",
t.gcompanyjc "简称",t.GLEGELRE "法人代表",GADDRESS "地址",GMAIL "邮箱",
GPOSTCODE "邮编",GTEL "电话",t.gyear "年度",t.goperatype "供应商类别",t.suppliertype "供应商类",
GFAX "传真",--t.LINKMANPHONE,
t.gcompanycode "供应商编码",t.GCOUNTRY "国家",t.GWEBSITE "网站",t.gbank "开户银行",
t.gbankaccount "银行帐号",t.gtaxnumber "税号",t.gtaxrate "开票及税率",t.GCOMPANYJJ "公司简介",
t.gsalesadd "营业部地址",t.gfactoryname "工厂名称",t.gfactoryadd "工厂地址",
GOPERAGOODS "经营产品",remark "备注",t.gstate "状态",t.operator "操作人"
from t_sys_supplier_temp t where t.gcompanyid is null for update;
 
select 
t.suppliertype ,
t.operator ,
t.gstate ,
t.gcompanycn ,t.gcompanyen ,
t.gcompanyjc ,t.gyear ,t.goperatype ,t.gcompanycode ,
t.GCOUNTRY ,GADDRESS ,GPOSTCODE ,GTEL ,GFAX ,
t.GLEGELRE ,t.GWEBSITE ,GMAIL ,t.gbank ,
t.gbankaccount ,t.gtaxnumber ,t.gtaxrate ,
t.runtype ,t.GCOMPANYJJ ,GOPERAGOODS ,t.gsalesadd ,
t.gfactoryname ,t.gfactoryadd 
from    t_sys_supplier_temp t where t.gcompanyid is null for update;

begin
update t_sys_supplier_temp t set t.gcompanyid=sys_guid(), t.ggrade='0g0b02',t.operator='',t.gstate='0g0407',
t.goperatype=decode(t.goperatype,'Q.其他供应商','0g0205','M.中间商','0g0201','S.生产厂家','0g0202','0g0203')
where t.gcompanyid is null
;


update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'普通发票','0g0c01');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'3%的增值税','0g0c02');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'4%的增值税','0g0c03');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'6%的增值税','0g0c04');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'17%的增值税','0g0c05');
end;


 --2

   
   /*
第二步：修改供应商临时表导入的数据
*/
   

/*insert into t_sys_supplier(gcompanyid,gcompanycn,GLEGELRE,GADDRESS,GMAIL,GPOSTCODE,GTEL,
GFAX,GOPERAGOODS,gstate,GOPERATYPE,ext1,gcompanycode) select 
gcompanyid,gcompanycn,GLEGELRE,GADDRESS,GMAIL,GPOSTCODE,GTEL,
GFAX,GOPERAGOODS,gstate,GOPERATYPE,ext1,t.gcompanycode
 from t_sys_supplier_temp t where t.gcompanyid is not null;*/
 
 
    /*
第三步：导入联系人
*/

select t.lcompanyid,
t.lname,t.lsex,t.lunit,t.ldept,t.ljob,t.ltel,t.lfax,'',t.lphone,t.lemil,t.lremark
from t_sys_supplier_linkman_temp t for update;

 select t.*,(select sst.gcompanyid from  t_sys_supplier_temp sst where sst.gcompanycode=t.lcompanyid) from  t_sys_supplier_linkman_temp t for update;

select sst.gcompanycode,count(1) from  t_sys_supplier_temp sst group by sst.gcompanycode having count(1)>1;
--update t_sys_supplier_linkman_temp t set t.lcompanyid=(select sst.gcompanyid from  t_sys_supplier_temp sst where sst.gcompanycn=t.lunit);



select * from t_sys_supplier_linkman_temp t;



/*begin
insert into t_sys_supplier_linkman
 select * from t_sys_supplier_linkman_temp t;

insert into t_sys_supplier(
GCOMPANYCODE,VERSION,OPERATOR,EXT1,EXT2,UPDATEDATE,RUNTYPE,SUPPLIERTYPE,GCOMPANYID,GCOMPANYCN,GCOMPANYEN,GCOMPANYJC,GPASSWORD,GYEAR,GCOUNTRY,GADDRESS,GPOSTCODE,GTEL,GFAX,GWEBSITE,GMAIL,GBANK,GBANKACCOUNT,GTAXNUMBER,GTAXRATE,GOPERATYPE,GCOMPANYJJ,GOPERAGOODS,GSALESADD,GFACTORYNAME,GFACTORYADD,GEMPLOYEES,GYEARSALE,GGRADE,GCHANGE,GSTATE,GFFIXID,ISSUPPLIER,GLEGELRE
)select GCOMPANYCODE,VERSION,OPERATOR,EXT1,EXT2,UPDATEDATE,RUNTYPE,SUPPLIERTYPE,GCOMPANYID,GCOMPANYCN,GCOMPANYEN,GCOMPANYJC,GPASSWORD,GYEAR,GCOUNTRY,GADDRESS,GPOSTCODE,GTEL,GFAX,GWEBSITE,GMAIL,GBANK,GBANKACCOUNT,GTAXNUMBER,GTAXRATE,GOPERATYPE,GCOMPANYJJ,GOPERAGOODS,GSALESADD,GFACTORYNAME,GFACTORYADD,GEMPLOYEES,GYEARSALE,GGRADE,GCHANGE,GSTATE,GFFIXID,ISSUPPLIER,GLEGELRE
 from t_sys_supplier_temp t ;
end;
*/



 /*
第四步：前台同步数据
*/

/*
最后
*/
/*
declare
v_code varchar2(50);
begin
   for rowdata in (select st.gcompanyid from t_sys_supplier_temp st where st.gcompanyid is not null) loop
        -- v_code:=getsuppliercode('0g0206');
        update t_sys_supplier_temp t set t.gcompanycode=getsuppliercode('0g0206')
       where t.gcompanyid=rowdata.gcompanyid;
        
	       update t_sys_supplier t set t.gstate='0g0407',t.GOPERATYPE='0g0206',ext1='0g0f02',
         t.gcompanyjc=substr(t.gcompanycn,1,6),t.gcountry='china',t.gtaxrate='0g0c02',t.ggrade='0g0b02'
        ,t.gcompanycode=(select st.gcompanycode from t_sys_supplier_temp st where st.gcompanyid=t.gcompanyid)
        where t.gcompanyid=rowdata.gcompanyid;
   end loop;

end;


update t_sys_supplier_temp t set t.gstate='0g0407',t.GOPERATYPE='0g0206',ext1='0g0f02',
    t.gcompanyjc=substr(t.gcompanyjc,1,6),t.gcountry='china',t.gtaxrate='0g0c02',t.ggrade='0g0b02'
    ,t.gcompanycode=getsuppliercode('0g0206')
    where t.gcompanyid in (select st.gcompanyid from t_sys_supplier_temp st where st.gcompanyid is not null) ;
*/

--清理供应商和用户表数据
/*declare

begin 
   
  for p in (
    select * from t_sys_supplier t where t.gcompanyid in
    ('402881bd4336aa84014336b151890000','402881bd432d960501432db4dcd00004','402881bd433716e70143374129ab0001','40288193449501ed01449506bfa20000','3C720C2099CF471EA898B7C02C9ECF17','0F7CD32668554A6BAAB5D60DD430F3D5','4F6F38CED72E4FFDACAF3B59ED1372EF','8BF3863D842641B69C7ACA28B240F296','91D5C3A91CFB4E919B99AF31D6866E76','BC535102543D463C8F7B873A09EFC451','22608B16CBF246C493A733704FE7436E','644F2A00FEDB4773820C014BA96207DC','5F7C985E6A85457894554C004DE41E4C','0246308BDBE24DDFB50248FC96FE9E6D','06E18D5623FA467B9C158BE3E783BB54','879D235F0D304D81B27336B3C4B84C08','53D1F3374E444DBAA4746EFD2BA46875','22E60237708B47CA97E683E52192E284','8E1BD439501D4702A9DE8866E831DBF1','76AFC55872154034ABDD469B52288CAA','6B7D4902EFAC4F2B944B53B3B0EC89DB','E5AB3DE498DA4E0FB38D0BCE8E68A23C','40288141454f558e01454f6672e30009','402881bd44f1f06a0144f27cbe4b0009','4028814244f2eae60144f2ed440b0000','402881bd436623f5014366300ee40000','402881bd436623f501436630e2310004','402881bd436623f501436631af350008','402881bd431400fc01431424049c0000','402881bd44ae9aaf0144afb7b2f50006','40288141454acaff01454ad0ac4a0001','402881bd44e3ca0c0144e3dcabe40002','40288141454f558e01454f68a94a000d','402881bd432d960501432e0d836c000e','402881bd44ae9aaf0144af982c910001','402881424515946001451692c3210068','402881bd4328295701432886eb1b0007')
    ) loop
	  clear_supplier(p.gcompanyid);
    --删除流程实例
   -- delete_process('','');
end loop;

end;

*/
