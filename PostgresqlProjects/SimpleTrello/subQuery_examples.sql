create table department
(
    id   serial primary key,
    name varchar(250) unique not null
);

select *
from employee;

create table employee
(
    id              serial primary key,
    name            varchar(250)                              not null,
    last_name       varchar(250)                              not null,
    age             smallint                                  not null,
    department_name varchar(250) references department (name) not null,
    role            varchar(250)                              not null,
    salary          float                                     not null
);

insert into department (name)
values ('PDP'),
       ('BOOM'),
       ('ASAXIY'),
       ('BEELAB'),
       ('BUXORO'),
       ('EXADEL'),
       ('FIDO'),
       ('EPAM');

insert into employee (name, last_name, age, department_name, role, salary)
values ('Asliddin', 'Xusanov', 20, 'FIDO', 'Software Engineer', 1500),
       ('Oyatjon', 'Oyatjon', 21, 'FIDO', 'Software Engineer', 1800),
       ('Najimmidin', 'Ibrohimov', 20, 'BUXORO', 'Software Engineer', 2200),
       ('Elyor', 'Ergashov', 20, 'BOOM', 'Software Engineer', 1900),
       ('Ahrorjon', 'Xusanov', 18, 'BOOM', 'Software Engineer', 1850),
       ('Ulugbek', 'Xusanov', 20, 'PDP', 'Software Engineer', 1700),
       ('Nurislom', 'Xasanov', 17, 'BOOM', 'Software Engineer', 2000),
       ('Akbar', 'Akbarov', 16, 'BOOM', 'Software Engineer', 2000),
       ('Daler', 'Badiyev', 19, 'PDP', 'Web Developer', 2500),
       ('Muslim', 'Uktamov', 24, 'EPAM', 'Software Engineer', 3000),
       ('Asliddin', 'Abdulayev', 16, 'PDP', 'Web Developer', 2200),
       ('Javohir', 'Elmurodov', 28, 'PDP', 'Software Engineer', 4000),
       ('Nodirbek', 'Abdukarimov', 23, 'FIDO', 'Software Engineer', 2600),
       ('Saidumar', 'saidumar', 20, 'PDP', 'Web Developer', 2950),
       ('Ozod', 'Oripjonov', 22, 'PDP', 'Web Developer', 3600),
       ('Sevinch', 'Umarova', 20, 'BOOM', 'Hr', 1600),
       ('Muhammadaziz', 'Yoldoshev', 17, 'PDP', 'Student', 0),
       ('Eliboy', 'Axmadjonov', 21, 'PDP', 'Student', 0),
       ('Isfandiyor', 'Ismoilov', 28, 'ASAXIY', 'Software Engineer', 1600),
       ('Nigina', 'Qurbanova', 27, 'BEELAB', 'Software Engineer', 2420),
       ('Ixtiyor', 'Qozoqboyev', 21, 'FIDO', 'Software Engineer', 2100);

-- har qanday tabledagi berilgan row ortachi hisobni chiqaradi.
select avg(salary)
from employee;
select avg(age)
from employee;

select *
from employee
where age > 20;


-- simple inner query
select *
from employee
where salary > (select avg(salary) from employee);


/**
  -- Scalary subquery
  it always return 1 row and column
 */
select *
from employee e
         join (select avg(salary) sal from employee) avg_sal on e.salary > avg_sal.sal;

-- multiple rows subquery
-- subquery which returns multiple column and multiple row
-- subquery which returns only 1 column and multiple rows

/*
 QUESTION: find the employees who earn the highest salary in each department
 SAVOL: har bir bo'limda eng yuqori maosh oladigan xodimlarni toping
 */

select department_name, max(salary)
from employee
group by department_name;

select *
from employee
where (department_name, salary) in (select department_name, max(salary)
                                    from employee
                                    group by department_name);

-- Correlated Subquery

select *
from employee
where salary > (select avg(salary) from employee)
  and age > 20;

select *
from employee as e1
where salary > (select avg(salary)
                from employee e2
                where e2.department_name = e1.department_name);

select *
from department d
where not exists(select 1 from employee e where e.department_name = d.name);

select e.department_name, e.salary
from employee as e
where (department_name, salary) in (select department_name, min(salary) from employee group by department_name)
group by e.department_name, e.salary;

select department_name, sum(salary) as total_salary
from employee
group by department_name
having sum(salary) > 5000
order by total_salary desc;

select max(all_salaries)
from (select department_name as name, sum(salary) as all_salaries from employee group by department_name) x;

select *
from (select department_name, sum(salary) as total_salary from employee group by department_name) departs
         join (select avg(total_salary) as salaries
               from (select department_name, sum(salary) as total_salary
                     from employee
                     group by department_name) x) avg_salary on departs.total_salary < avg_salary.salaries;

select *,
       (case
            when salary > (select avg(salary) from employee)
                then 'Higher than average'
            else null
           end) as remarks
from employee;

select *
from employee
where age < (select avg(age) from employee);

select *,
       (case
            when salary > avg_sal.sal
                then 'Higher than average'
            else null
           end) as remarks
from employee
         cross join (select avg(salary) sal from employee) avg_sal;


select role,
       count(employee),
       (
           case
               when count(employee) > 10
                   then 'High Team'
               else 'Team'
               end) as mark
from employee
group by role;


insert into employee
select e.id, e.name, e.age, e.role
from employee e
         join department d on d.name = e.department_name
where not exists(select 1 from employee eh where eh.id = e.id);


-- All Software Engineer Age 21 and 30 also Web Developer Age High Than 18
select *
from employee
where role = 'Software Engineer'
  and age between 21 and 30
union
select *
from employee
where role = 'Web Developer'
  and age > 18;
