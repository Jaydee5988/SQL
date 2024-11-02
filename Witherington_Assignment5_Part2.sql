/*
    Name: James Witherington
    DTSC660: Data and Database Managment with SQL
    Assignment 5- PART 2
*/

--------------------------------------------------------------------------------
/*				                 Query 8            		  		          */
--------------------------------------------------------------------------------
SELECT dept_name FROM department
EXCEPT
SELECT d.dept_name
FROM department d
WHERE NOT EXISTS (
    SELECT * FROM instructor i WHERE i.dept_name = d.dept_name
)
ORDER BY dept_name;


--------------------------------------------------------------------------------
/*				                  Query 9           		  		          */
--------------------------------------------------------------------------------
SELECT course_id FROM course
EXCEPT
SELECT course_id FROM prereq
ORDER BY course_id;


--------------------------------------------------------------------------------
/*				                  Query 10           		  		          */
--------------------------------------------------------------------------------
-- Departments with a budget less than $50,000
SELECT dept_name FROM department
WHERE budget < 50000
UNION
-- Departments with an instructor earning more than $100,000
SELECT dept_name FROM department
WHERE dept_name IN (
    SELECT dept_name FROM instructor
    WHERE salary > 100000
)
UNION
-- Departments with a student having the max total credits
SELECT dept_name FROM department
WHERE dept_name IN (
    SELECT dept_name FROM student
    WHERE tot_cred = (
        SELECT MAX(tot_cred) FROM student
    )
)
ORDER BY dept_name;

   
--------------------------------------------------------------------------------
/*				                  Query 11           		  		          */
--------------------------------------------------------------------------------
SELECT c.course_id, c.title AS course_name, p.prereq_id, pc.title AS prereq_name
FROM course c
JOIN prereq p ON c.course_id = p.course_id
JOIN course pc ON p.prereq_id = pc.course_id
ORDER BY c.course_id;


--------------------------------------------------------------------------------
/*				                  Query 12           		  		          */
--------------------------------------------------------------------------------
SELECT s.id
FROM student s
LEFT OUTER JOIN takes t ON s.id = t.id
WHERE t.course_id IS NULL;

    



  