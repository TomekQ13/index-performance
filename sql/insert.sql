do $$
declare
    max_id integer;
begin

    select coalesce(max(id),0) into max_id
    from test2;

    insert into test2
    select *
    from test
    where id > max_id and id <= max_id + 10000;
end; $$