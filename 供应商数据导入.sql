
--��Ӧ������ϵ�ˣ�����ϵ��û������
select t.* from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode  not    in
(
select tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null and tl.lemil is null
);

--��Ӧ�̱��롢���Ϊ�յĹ�Ӧ��
select * from t_sys_supplier_temp t where t.gcompanycode is null;

--��Ӧ��û����ϵ��
select t.*,rowid from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode not in 
(select  tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null );
--��Ӧ����ϵ�˵����䲻�淶
select t.* from t_sys_supplier_temp t where t.gcompanycode is not null and  t.gcompanycode    in(
select tl.lcompanyid from t_sys_supplier_linkman_temp tl where tl.lcompanyid is not null and  tl.lemil is not null
and (length(tl.lemil) - length(replace(tl.lemil,'@')))/length('@')>1
)
--��Ӧ�̱����ظ�
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
��һ��������Ӧ����ʱ���빩Ӧ�����ϻ�������
*/
--1
select 
t.runtype "��Ӫ���",t.gcompanycn "��˾��",t.gcompanyen "������",
t.gcompanyjc "���",t.GLEGELRE "���˴���",GADDRESS "��ַ",GMAIL "����",
GPOSTCODE "�ʱ�",GTEL "�绰",t.gyear "���",t.goperatype "��Ӧ�����",t.suppliertype "��Ӧ����",
GFAX "����",--t.LINKMANPHONE,
t.gcompanycode "��Ӧ�̱���",t.GCOUNTRY "����",t.GWEBSITE "��վ",t.gbank "��������",
t.gbankaccount "�����ʺ�",t.gtaxnumber "˰��",t.gtaxrate "��Ʊ��˰��",t.GCOMPANYJJ "��˾���",
t.gsalesadd "Ӫҵ����ַ",t.gfactoryname "��������",t.gfactoryadd "������ַ",
GOPERAGOODS "��Ӫ��Ʒ",remark "��ע",t.gstate "״̬",t.operator "������"
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
t.goperatype=decode(t.goperatype,'Q.������Ӧ��','0g0205','M.�м���','0g0201','S.��������','0g0202','0g0203')
where t.gcompanyid is null
;


update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'��ͨ��Ʊ','0g0c01');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'3%����ֵ˰','0g0c02');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'4%����ֵ˰','0g0c03');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'6%����ֵ˰','0g0c04');
update t_sys_supplier_temp t set 
t.gtaxrate=replace(t.gtaxrate,'17%����ֵ˰','0g0c05');
end;


 --2

   
   /*
�ڶ������޸Ĺ�Ӧ����ʱ���������
*/
   

/*insert into t_sys_supplier(gcompanyid,gcompanycn,GLEGELRE,GADDRESS,GMAIL,GPOSTCODE,GTEL,
GFAX,GOPERAGOODS,gstate,GOPERATYPE,ext1,gcompanycode) select 
gcompanyid,gcompanycn,GLEGELRE,GADDRESS,GMAIL,GPOSTCODE,GTEL,
GFAX,GOPERAGOODS,gstate,GOPERATYPE,ext1,t.gcompanycode
 from t_sys_supplier_temp t where t.gcompanyid is not null;*/
 
 
    /*
��������������ϵ��
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
���Ĳ���ǰ̨ͬ������
*/

/*
���
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

--����Ӧ�̺��û�������
/*declare

begin 
   
  for p in (
    select * from t_sys_supplier t where t.gcompanyid in
    ('402881bd4336aa84014336b151890000','402881bd432d960501432db4dcd00004','402881bd433716e70143374129ab0001','40288193449501ed01449506bfa20000','3C720C2099CF471EA898B7C02C9ECF17','0F7CD32668554A6BAAB5D60DD430F3D5','4F6F38CED72E4FFDACAF3B59ED1372EF','8BF3863D842641B69C7ACA28B240F296','91D5C3A91CFB4E919B99AF31D6866E76','BC535102543D463C8F7B873A09EFC451','22608B16CBF246C493A733704FE7436E','644F2A00FEDB4773820C014BA96207DC','5F7C985E6A85457894554C004DE41E4C','0246308BDBE24DDFB50248FC96FE9E6D','06E18D5623FA467B9C158BE3E783BB54','879D235F0D304D81B27336B3C4B84C08','53D1F3374E444DBAA4746EFD2BA46875','22E60237708B47CA97E683E52192E284','8E1BD439501D4702A9DE8866E831DBF1','76AFC55872154034ABDD469B52288CAA','6B7D4902EFAC4F2B944B53B3B0EC89DB','E5AB3DE498DA4E0FB38D0BCE8E68A23C','40288141454f558e01454f6672e30009','402881bd44f1f06a0144f27cbe4b0009','4028814244f2eae60144f2ed440b0000','402881bd436623f5014366300ee40000','402881bd436623f501436630e2310004','402881bd436623f501436631af350008','402881bd431400fc01431424049c0000','402881bd44ae9aaf0144afb7b2f50006','40288141454acaff01454ad0ac4a0001','402881bd44e3ca0c0144e3dcabe40002','40288141454f558e01454f68a94a000d','402881bd432d960501432e0d836c000e','402881bd44ae9aaf0144af982c910001','402881424515946001451692c3210068','402881bd4328295701432886eb1b0007')
    ) loop
	  clear_supplier(p.gcompanyid);
    --ɾ������ʵ��
   -- delete_process('','');
end loop;

end;

*/
