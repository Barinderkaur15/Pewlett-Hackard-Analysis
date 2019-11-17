----creating new title table 
select * from current_emp;
select * from titles

--verfying total rocord value 
select count(*) from current_emp;

---- This is retuning duplicate as person has more tiles

select ce.*,title.title
Into duplicate_tile 
from 
current_emp as ce
right join titles as title 
on (ce.emp_no= title.emp_no)

--checking the result 
select count (*) from (select ce.*,title.title from 
current_emp as ce
right join titles as title 
on (ce.emp_no= title.emp_no)) a



--- creating unique titles 

select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as row_num
from titles ) x where row_num=1 


/* Query to get the current row from the code */

select ce.* ,title_ref.title 
from current_emp as ce
inner join 
(select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as row_num
from titles ) x where row_num=1 ) as  title_ref
on ce.emp_no=title_ref.emp_no


--- checking the results ----
select count(*) from current_emp; -- total Count (33118)

select count (*) as total_count from (select ce.* ,title_ref.title 
from current_emp as ce
inner join 
(select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as row_num
from titles ) x where row_num=1 ) as  title_ref
on ce.emp_no=title_ref.emp_no) results
-- Total Count (33118)


--- creating the new table with unique and recent title 
select ce.* ,title_ref.title 
INTO Ret_current_title 
from current_emp as ce
inner join 
(select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as row_num
from titles ) x where row_num=1 ) as  title_ref
on ce.emp_no=title_ref.emp_no


---Counting the frequency
select * from duplicate_tile;

select title,to_date,count(distinct emp_no)  into count_emp_per_dept from duplicate_tile group by title,to_date order by to_date desc

-- checking number of people who has two titles 
select * from (select *,count(*) over (partition by first_name,last_name order by to_date desc)  as count from duplicate_tile) frequency where frequency.count>1

---Creating new table for mentor 

select * from employees;
select * from Dept_emp;
select * from titles;

select emp.emp_no, emp.first_name,emp.last_name,title.title ,dept.from_date,dept.to_date
--adding into new table
into new_mentor
from 
employees as emp 
inner join dept_emp as dept 
on emp.emp_no=dept.emp_no
inner join titles as title 
on emp.emp_no=title.emp_no
--to select only current employees 
where dept.to_date='9999-01-01'
--to select the people who can mentor 
and emp.birth_date between '1965-01-01' and '1965-12-31'

--------counting number of mentor ---------
select count(*) from (select emp.emp_no, emp.first_name,emp.last_name,title.title ,dept.from_date,dept.to_date
from 
employees as emp 
inner join dept_emp as dept 
on emp.emp_no=dept.emp_no
inner join titles as title 
on emp.emp_no=title.emp_no
--to select only current employees 
where dept.to_date='9999-01-01'
--to select the people who can mentor 
and emp.birth_date between '1965-01-01' and '1965-12-31') results
