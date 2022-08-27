create schema company;
use company;
CREATE TABLE EmPloYee (
 fname varchar(30),  #  varchar becoz - frees extra memory
 minit char(1),
 lname varchar(30),
 ssn char(9),  
 bdate date,
 address varchar(50),
 sex char(1),
 salary float(10, 2),
 super_ssn char(9),
 dno char(3) 
   ) ;

insert into employee values
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5), 
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,'888665555',5), 
('Alicia','J','Zelaya','999887777','1968-01-09','3321 Castle, Spring, TX','F',25000,'987654321',4), 
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F',43000,'888665555',4), 
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,'333445555',5), 
('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,'333445555',5), 
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,'987654321',4), 
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000, NULL,1) ;

create table department(
dname varchar(20),
dnumber varchar(2),
mgr_ssn char(9),
mgr_start_date date);


insert into department VALUES 
('Research',5,333445555,'1988-05-22'), 
('Administration',4,987654321,'1995-01-01'), 
('Headquarters',1,888665555,'1981-06-19');

create table dept_locations( 
dnumber int, 
dlocation varchar(20)); 


insert into dept_locations values 
(1, 'Houston'), 
(4, 'Stafford'), 
(5, 'Bellaire'), 
(5, 'Sugarland'), 
(5, 'Houston');

create table works_on( 
essn char(9), 
pno int, 
hours float(4,2));


insert into works_on (essn, pno, hours) values 
('123456789', 1, 32.5), 
('123456789', 2, 7.5), 
('666884444', 3, 40.0), 
('453453453', 1, 20.0), 
('453453453', 2, 20.0), 
('333445555', 2, 10.0), 
('333445555', 3, 10.0), 
('333445555', 10, 10.0), 
('333445555', 20, 10.0), 
('999887777', 30, 30.0), 
('999887777', 10, 10.0), 
('987987987', 10, 35.0), 
('987987987', 30, 5.0), 
('987654321', 30, 20.0), 
('987654321', 20, 15.0), 
('888665555', 20, NULL);

create table project( 
pname varchar(30), 
pnumber int, 
plocation varchar(30), 
dnum int); 


insert into project(pname,pnumber,plocation,dnum) values 
('ProductX', 1, 'Bellaire', 5), 
('ProductY', 2, 'Sugarland', 5), 
('ProductZ', 3, 'Houston', 5), 
('Computerization', 10, 'Stafford', 4), 
('Reorganization', 20, 'Houston', 1), 
('Newbenefits', 30, 'Stafford', 4);

create table dependent( 
essn char(9), 
dependent_name varchar(30), 
sex char(1), 
bdate date, 
relationship varchar(20)); 


insert into dependent(essn,dependent_name,sex,bdate,relationship) values 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'), 
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'), 
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'), 
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'), 
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'), 
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

# Q1 Find the no. of employees in Organization ?

select count(ssn) from employee;

select count(*) as no_of_employees from employee;

# Q2 Find the no. of employees who have dependents.

select count(distinct essn)
from dependent; 

# Q3 Display the employee details who does not have supervisor.

select *
from employee
where supervisor_ssn is null;

select * from employee;

ALTER TABLE employee
RENAME COLUMN super_ssn TO supervisor_ssn;

# Q4 Display the ssn of manager and the year in which the manager was appointed.

select mgr_ssn,year(mgr_start_date) as mgr_start_year
from department;

# Q5 Display the ssn,fname and salaries of employees sorted by their salary 
# in descending mode.

select ssn,fname,salary
from employee
order by salary desc;

# Q6 Sort the works_on table based on Pno and Hours.

select *
from works_on
order by pno,hours;

# Q7 Calculate average salary of employees department-wise.

select avg(salary),dno
from employee
group by dno;

# Q8 Display the number of male employees in each department.

select count(ssn) as no_of_males , dno
from employee
where sex = 'm'
group by dno ;

# Q9 Among the people who draw atleast 30k salary
# what is the gender-wise average?

select sex,avg(salary)
from employee
where salary >=30000
group by sex;

# Q10 Display the essn of employees who have worked between 25 and 50 hours.

select essn,sum(hours) as total_hrs
from works_on
group by essn
having total_hrs between 25 and 50;

# Q11 Display the dno of those departments who has atleast 3 employees.

select dno,count(ssn) as no_of_emps
from employee
group by dno
having no_of_emps <=3;

# Q12 Display the fname and salary of those employees whose salary is more than 
# the average salary of all the employees.

select fname,salary
from employee
where salary > (select avg(salary) from employee);

# Q13 Display the fname of employees working in the Research department.

ALTER TABLE department
RENAME COLUMN dnumber TO dno;

select dno from department
where dname = 'Research';

select fname 
from employee
where dno = (select dno from department where dname = 'Research');

# Q14 Which department has the most number of employees?

select dno,count(ssn) as no_of_emps
from employee
group by dno
order by no_of_emps desc
limit 1;

# Q15 Display the fname of employees working in the Research department.

select fname,dname
from employee join department on employee.dno = department.dno 
where dname = 'Research';
















