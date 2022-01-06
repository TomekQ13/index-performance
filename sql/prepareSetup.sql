drop table if exists test;
create table test (
	id integer,
	col_char_1 varchar(32),
	col_char_2 varchar(64),
	col_char_3 char(1),
	col_num_1 integer,
	col_num_2 integer,
	col_date date,
	col_timestamp timestamp	

);

drop table if exists test2;
create table test2 as
select * from test
where 1=0;

drop sequence if exists test_id_seq;
create sequence test_id_seq;

CREATE OR REPLACE PROCEDURE public.insert_test_row()
LANGUAGE 'sql'
AS $BODY$
insert into test(id, col_char_1, col_char_2, col_char_3, col_num_1, col_num_2, col_date, col_timestamp)
values (nextval('test_id_seq'), 'a', 'b', 'a', (select random()*100),(select random()*1000),(select NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days'), (select timestamp '2014-01-10 20:00:00' +
       random() * (timestamp '2014-01-20 20:00:00' -
                   timestamp '2014-01-10 10:00:00')))
;
$BODY$;

do $$
begin

	for loop_counter in 1..1000000 loop
		call public.insert_test_row();
	end loop;

end; $$;