/* 
Question: What are the top skills based on Salary?
- Find the average salary associated with each skill for data analyst jobs.
- Filter for remote jobs with specified salaries (No null values)
- Identify the top 25 highest paying skills for data analyst jobs that are remote.
*/


SELECT 
    skills_dim.skills,
    ROUND(AVG(salary_year_avg),0) AS average_salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 

WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

GROUP BY 
    skills

ORDER BY 
    average_salary DESC

LIMIT 25;