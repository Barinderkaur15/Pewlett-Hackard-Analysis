# Pewlett-Hackard-Analysis

##### The Purpose of this Analysis is to see how many valuable human resources will PH be loosing over the time due to Retirement. </br>
##### The goal of this analysis to provide right information to the management, so that they can take right steps for hiring ,mentoring and trining people on right time . 

#### Summary About the Data 

**1.**  The Dataset contains information about 300,024 distint Employees </br>
**2.**  There are Nine different Departments in PH across in which 240,124 employees are currently working </BR>
**3.**  Total 41,380 employees will be retering from PH </br>
**4.**  PH have to hire nearly 41,380 number of employees to fill the positions which are held by these employees currently , </br>     although this number may vary depending upon the current scenerio wehen company will be hiring these people. 
**5.** 2,382 employees will be available for the mentorship role 


**Recommendation** 
**1.** To find the eligiable mentor it is alos importamt to take into consideraton hoe much time and experience a particular employee have in his respective depatment , it will be better to pertition the employees dept and experinece along the birthdate to  find the the right match 
**2.** More information is required to find out how many new people PH need to hire in future 


### ERD Diagram  showing the relationship betwwen the primary Tables in this Analysis ####


![EmployeeDB](https://user-images.githubusercontent.com/55926650/69004983-14003880-08d0-11ea-9f0d-ffd8293803ca.png)



### Code Snippets with resules ##

**Unique employees with recent title who are retirirng** 

--- creating the new table with unique and recent title 
select ce.* ,title_ref.title 
INTO Ret_current_title 
from current_emp as ce
inner join 
(select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as row_num
from titles ) x where row_num=1 ) as  title_ref
on ce.emp_no=title_ref.emp_no

## Result 

![Annotation 2019-11-17 002512](https://user-images.githubusercontent.com/55926650/69005075-6a21ab80-08d1-11ea-91d0-d7c6e6b8835c.png)


**Looking for Mentor**

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

![Capture](https://user-images.githubusercontent.com/55926650/69005076-6a21ab80-08d1-11ea-81a7-c4b606238e62.PNG)



