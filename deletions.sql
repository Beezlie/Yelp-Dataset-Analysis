use yelp_db;
                
create temporary table usersToRemove( id varchar(22) );
create temporary table businessesToRemove( id varchar(22) );

insert into usersToRemove
select distinct(u.id)
from user as u join review as r on u.id = r.id
group by u.id, u.review_count
having u.review_count < count(r.id);

insert into usersToRemove
select distinct(u.id)
from elite_years e join user u on e.user_id = u.id
where year(u.yelping_since) > e.year or e.year < 2004 or e.year > 2017;

insert into businessesToRemove
select distinct(b.id)
from business as b join review as r on b.id = r.business_id
group by b.id, b.review_count
having b.review_count < count(r.business_id);

SET SQL_SAFE_UPDATES = 0;
delete u, r
from user as u join review as r on u.id = r.id
where u.id in (select * from usersToRemove);
delete b, r
from business as b join review as r on b.id = r.business_id
where b.id in (select * from businessesToRemove);
SET SQL_SAFE_UPDATES = 1;

