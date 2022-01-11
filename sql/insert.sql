insert into test2
select *
from test
where id > (select max(id) from test2) and id <= (select max(id) from test2) + 10000;