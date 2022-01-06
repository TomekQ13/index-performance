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
-- 1 min 9 s

insert into test2 select * from test;
-- Query returned successfully in 5 secs 396 msec.

truncate table test2;
create index id_idx on test2 (id);
insert into test2 select * from test;


-- do $$
-- begin

-- 	for loop_counter in 1..1000000 loop
-- 		call public.insert_test_row();
-- 	end loop;

-- end; $$
-- -- 1 min 16 s
-- -- 1 min 18 s

-- truncate table test;
-- create index id_idx_2 on test (id, col_char_3, col_date);

-- do $$
-- begin

-- 	for loop_counter in 1..1000000 loop
-- 		call public.insert_test_row();
-- 	end loop;

-- end; $$
-- -- 1 min 22 s
-- -- 1 min 20 s

-- truncate table test;
-- create index id_idx_3 on test (col_char_2);
-- create index id_idx_4 on test (col_char_3);
-- create index id_idx_5 on test (col_num_1);
-- create index id_idx_6 on test (col_num_2);

-- do $$
-- begin

-- 	for loop_counter in 1..1000000 loop
-- 		call public.insert_test_row();
-- 	end loop;

-- end; $$
-- -- 1 min 27 s
-- -- 1 min 25 s