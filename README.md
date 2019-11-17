# Pewlett-Hackard-Analysis

##### The Purpose of this Analysis is to see how many valuable human resources will PH be loosing over the time due to Retirement. </br>
##### The goal of this analysis to provide right information to the management, so that they can take right steps for hiring ,mentoring and trining people on right time . 

#### Summary About the Data 

**1.**  The Dataset contains information about 300,024 distint Employees </br>
**2.**  There are Nine different Departments in PH across in which 240,124 employees are currently working </BR>
**3.**  Total 41,380 employees will be retering from PH </br>
**4.**  PH have to hire nearly 41,380 number of employees to fill the positions which are held by these employees currently , </br>     although this number may vary depending upon the current scenerio wehen company will be hiring these people. 
**5.** 2,382 employees will be available for the mentorship role 


**Recommendation** </br>
**1.** To find the eligiable mentor it is alos importamt to take into consideraton hoe much time and experience a particular employee have in his respective depatment , it will be better to pertition the employees dept and experinece along the birthdate to  find the the right match .</br>
**2.** More information is required to find out how many new people PH need to hire in future.</br> 


### ERD Diagram  showing the relationship betwwen the primary Tables in this Analysis ####


![EmployeeDB](https://user-images.githubusercontent.com/55926650/69004983-14003880-08d0-11ea-9f0d-ffd8293803ca.png)



### Code Snippets with results ## 

**Unique employees with recent title who are retirirng** </br>

--- creating the new table with unique and recent title </br>
select ce.* ,title_ref.title </br>
INTO Ret_current_title </br>
from current_emp as ce</br>
inner join </br>
(select emp_no,title from (select Emp_no,title,to_date,row_number() over (Partition by (emp_no) order by to_date Desc) as</br> row_num</br>
from titles ) x where row_num=1 ) as  title_ref</br>
on ce.emp_no=title_ref.emp_no</br>

## Result </br>

![Annotation 2019-11-17 002512](https://user-images.githubusercontent.com/55926650/69005075-6a21ab80-08d1-11ea-91d0-d7c6e6b8835c.png)


**Looking for Mentor**</br>

select emp.emp_no, emp.first_name,emp.last_name,title.title ,dept.from_date,dept.to_date</br>
--adding into new table</br>
into new_mentor</br>
from </br>
employees as emp </br>
inner join dept_emp as dept </br>
on emp.emp_no=dept.emp_no</br>
inner join titles as title </br>
on emp.emp_no=title.emp_no</br>
--to select only current employees </br>
where dept.to_date='9999-01-01'</br>
--to select the people who can mentor </br>
and emp.birth_date between '1965-01-01' and '1965-12-31'</br>

![Capture](https://user-images.githubusercontent.com/55926650/69005076-6a21ab80-08d1-11ea-81a7-c4b606238e62.PNG)</br>



