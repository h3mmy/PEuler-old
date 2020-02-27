
---cat names.txt | tr ',' '\n' | tr -d '"' > /tmp/names2.txt



create table name_raw (name varchar(50));
create table name (name_id serial, name varchar(50));
copy name_raw from '/tmp/names2.txt';
insert into name (name) select name from name_raw order by 1;

select
  sum (
    name_id * (
      ascii(substring(rpad(name, 11, '@') from 1)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 2)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 3)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 4)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 5)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 6)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 7)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 8)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 9)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 10)) - 64 +
      ascii(substring(rpad(name, 11, '@') from 11)) - 64
    )
  )
from name;