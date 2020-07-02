# 1.Query the existence of 1 course
select * from student_course where courseId=1£»

# 2.Query the presence of both 1 and 2 courses
select * from 
(select * from student_course where courseId=1) as s1,
(select * from student_course where courseId=2) as s2
where s1.studentId=s2.studentId;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select student.id,student.name,s1.a_score from
student,(select studentId , avg(score) as a_score from student_score 
group by studentId
having avg(score)>=60) as s1
where s1.studentId=student.id;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * from student 
where not exists (select * from student_course where studentId=student.id);

# 5.Query all SQL with grades
select * from student 
where not exists (select * from student_course as sc where sc.studentId=student.id);

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select student.* from student
where id in((select studentId from student_score where courseId=1 ) as sc1 INNER JOIN 
(select studentId from student_score where courseId=1) as sc2 ON
sc1.studentId=sc2.studentId);

# 7.Retrieve 1 student score with less than 60 scores in descending order
select student.*£¬sc.score from student,(
select * from student_course 
where score<60  and courseId=1
) as sc
where student.id=sc.studentId
order by sc.score desc;

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select courseId,avg(score) from student_course 
group by courseId
order by avg(score) desc,courseId asc;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.name,sc.score from
student as s,student_course as sc,course as c
where s.id=sc.studentId and sc.courseId=c.id and c.name="Math" and sc.score<60 ;
