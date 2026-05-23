/* 
Question: What are the top 10 highest paying skills for Data Analysts in remote jobs?
- Identify the top 10 highest paying skills for data analyst jobs that are remote.  
- Find the postings with a specified salary (No null values)
- Add the specific skills required for those roles.
*/

WITH top_paying_jobs AS (

    SELECT 
        job_id,
        job_title,
        salary_year_avg AS average_yearly_salary,
        company_dim.name AS company_name

    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id

    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL

    ORDER BY
        salary_year_avg DESC 

    LIMIT 10

)


SELECT 
    top_paying_jobs.*,
    skills 
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 

ORDER BY 
    average_yearly_salary DESC;