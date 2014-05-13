create or replace trigger my_trigger
after  delete or insert on test01
--REFERENCING old AS old_data new AS new_data
--for each row
declare   
    --pragma autonomous_transaction; --这里是关键的地方，在变量申明的地方，指定自定义事务处理。
    v_str varchar2(50);
begin
       if INSERTING then
            --dbms_output.put_line('insert trigger is chufa le .....'||:new_data.id||:new_data.name);
           -- insert into test03 values(:new_data.id,:new_data.name);
           --commit;
           select to_char(id) into v_str from test01 t where t.id=2 ;
           dbms_output.put_line('insert trigger is chufa le .....:'||v_str);
       end if;
     -- dbms_output.put_line('insert trigger is chufa le .....');

end;

select * from test03 t;
select * from test01 t;
select name from test03 where rownum<1;

begin
insert into test01 values(2, (select name from test03 where rownum<1));
--commit;
--RAISE_APPLICATION_ERROR(-20000,'aa');
end;
