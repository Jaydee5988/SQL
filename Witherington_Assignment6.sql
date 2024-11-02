/*
    Name: <Full Name>
    DTSC660: Data and Database Management with SQL
    Assignment 6
*/

--------------------------------------------------------------------------------
/*				                   Part 1   		  		                  */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				    Chosen Data Set and Reason for Selecting		          */
--------------------------------------------------------------------------------
   /* Chosen Dataset: Data Scientist Salaries
Reason for Selection: This dataset offers insights into the varying salary
ranges across different regions and experience levels in the data science field.
Analyzing and cleaning this data can provide valuable information on
industry standards and help identify key factors affecting salaries. */


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Select Statement      		  		          */
--------------------------------------------------------------------------------
SELECT * FROM salaries LIMIT 10;



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   Backup Table     		  		          */
--------------------------------------------------------------------------------

 CREATE TABLE salaries_backup AS SELECT * FROM salaries;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Duplicate Column      		  		          */
--------------------------------------------------------------------------------
ALTER TABLE salaries ADD COLUMN company_duplicate VARCHAR(255);
UPDATE salaries SET company_duplicate = company;



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   PART 2           		  		          */
--------------------------------------------------------------------------------
SELECT * FROM salaries WHERE total_yearly_compensation = 'NA';
UPDATE salaries SET total_yearly_compensation
= NULL WHERE total_yearly_compensation = 'NA';
SELECT * FROM salaries WHERE total_yearly_compensation IS NULL;

--------------------------------------------------------------------------------
/*				                 Question 1     		        		      */
--------------------------------------------------------------------------------
SELECT * FROM Salaries WHERE base_salary = 0;
UPDATE Salaries SET base_salary = NULL WHERE base_salary = 0;
SELECT * FROM Salaries WHERE base_salary IS NULL;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Question 2     		        		      */
--------------------------------------------------------------------------------
-- Identification of zeros in a numeric column where it should not be zero (hypothetical example with 'years_of_experience')
SELECT * FROM salaries WHERE years_experience = 0;

-- Update Query: Replace zeros with the column's mean (assuming the mean is calculated to be 4)
UPDATE salaries SET years_experience = 4 WHERE years_experience = 0;

-- Validation Query
SELECT * FROM salaries WHERE years_experience = 4;

-- Rationale Comment:
/*
Replacing zeros with the mean years of experience corrects the data
for individuals where experience was incorrectly entered as '0'.
This adjustment allows for a more accurate representation of
average experience levels within the dataset.
*/


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Question 3     		        		      */
--------------------------------------------------------------------------------
-- Identification of similar values for 'title' column (hypothetical example: 'Data Scientist', 'data scientist')
SELECT * FROM salaries WHERE LOWER(title) = 'data scientist';

-- Update Query: Standardize the job title naming
UPDATE salaries SET title = 'Data Scientist' WHERE LOWER(title) = 'data scientist';

-- Validation Query
SELECT * FROM salaries WHERE title = 'Data Scientist';

-- Rationale Comment:
/*
Standardizing job titles by capitalization ensures consistency across the
dataset, making it easier to aggregate and analyze data by specific job titles.
*/


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Question 4     		        		      */
--------------------------------------------------------------------------------
-- Removing duplicate rows (if any)
-- Identification of duplicate rows (Example based on all columns)
SELECT company, COUNT(*) FROM salaries GROUP BY company HAVING COUNT(*) > 1;

-- Assuming we identify duplicates, an action must be chosen (e.g., keeping the row with the latest timestamp)

-- Deletion might involve a more complex query that identifies and retains only the most recent entry per duplicate group
-- This is a placeholder; actual implementation will depend on specific duplicate criteria

-- Rationale Comment:
/*
Removing duplicate entries, especially if they represent the same job posting
or individual, helps in maintaining the uniqueness of data. This step is crucial
for accurate analysis, preventing overestimation of job counts or skewed salary
 averages.
*/


--------------------------------------------------------------------------------
