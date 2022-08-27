select * from employee;

select bdate as birth_date,supervisor_ssn as super_ssn from employee;

select * from employee
where salary >= 40000;

select *
from dependent
where essn = 333445555;

select * from employee
where sex = 'F' and salary >= 40000;

select * from employee
where sex = 'F' or salary >= 40000;

select * from employee
where sex = 'M' and salary > 40000
or sex = 'F' and salary < 40000;

select * from project
where plocation = 'Houston' or plocation = 'Stafford';

select essn,hours
from works_on
where hours between 25 and 50;

SELECT * FROM employee WHERE fname LIKE 'A%';

select fname,address
from employee
where address like '%Houston%';

select concat(fname,' ',minit,' ',lname) as name
from employee;

select sum(salary) from employee;
select avg(salary) from employee;
select min(salary) from employee;
select max(salary) from employee;

select count(ssn) from employee;

select count(distinct essn)
from dependent;

select * from employee
where supervisor_ssn is null;

select mgr_ssn,year(mgr_start_date) as start_date
from department;

select fname,ssn,salary
from employee
order by salary desc;

select * 
from works_on
order by pno,hours;

select avg(salary) as avg_salary,dno
from employee 
group by dno
order by avg_salary desc;

select count(ssn) as no_of_males,dno
from employee
where sex = 'M'
group by dno;

select avg(salary),sex 
from employee
where salary <= 30000
group by sex;

select essn,sum(hours) as total_hrs
from works_on
group by essn
having total_hrs between 25 and 50;

# Q26 Display the Dno of those departments those have atleast 3 employees.

select dno,count(ssn) as no_of_emps 
from employee
group by dno
having no_of_emps >=3;

# Q27 Display the fname and salary of employees
# whose salary is more than average salary of all employees.

select fname,salary
from employee
where salary >= (select avg(salary) from employee);

select fname
from employee
where dno = 5;

select fname,dname
from employee join department on employee.dno = department.dno 
where dname = 'Research';

select count(*) as no_of_emp from employee
group by dno;

select dno,no_of_emp
from (select count(*) as no_of_emp from employee
	  group by dno) as abc
where no_of_emp = (select max(no_of_emp) from (select count(*) as no_of_emp from employee
	  group by dno) as abc) ;
      
select dno,count(*) as num_emp
from employee
group by dno
order by num_emp desc
limit 1;

select concat(fname,' ',minit,' ',lname) as name,pname
from employee join project on employee.dno = project.dnum
where pname = 'ProductZ';

select concat(fname,' ',minit,' ',lname) as emp_name,
dependent_name,relationship
from employee as e join dependent as d on e.ssn = d.essn;

select concat(fname,' ',minit,' ',lname) as emp_name,
dependent_name,relationship
from dependent as d right join employee as e on e.ssn = d.essn;

select e1.fname as emp_name,e2.fname as sup_name
from employee as e1 join employee as e2 on e1.supervisor_ssn = e2.ssn;

select e.ssn, avg(salary)
from employee as e right join dependent as d on e.ssn = d.essn
group by e.ssn;

select round(avg(salary), 2) as avg_sal_emp_with_dep
from
(select avg(e.salary) as salary, d.essn as employee
from employee e right join dependent d on d.essn = e.ssn
group by d.essn) as ABC ;

select max(salary) as salary,sex from employee where sex = 'F'
union
select min(salary),sex from employee where sex ='M';

create view emp_view as select * from employee;

select avg(salary) from emp_view;

create view dep_view as select count(*) as no_of_employees,dno
from employee group by dno;

select no_of_employees,dno
from dep_view
where no_of_employees = (select max(no_of_employees) from dep_view);

select pname,hours
from project join works_on on project.pnumber = works_on.pno;

create view project_hrs as 
select pname,sum(hours)
from works_on as w join project as p 
on w.pno = p.pnumber
group by p.pnumber;

alter table dependent add unique index sl_no (essn,dependent_name);

update employee set supervisor_ssn = 'MD' where supervisor_ssn is null;














