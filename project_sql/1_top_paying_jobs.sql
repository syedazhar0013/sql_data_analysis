/* 
Question: What are the top paying remote data analyst jobs?
- Indetify the top 10 highest paying data analyst jobs that are remote.
- Find the postings with a specified salary (No null values)
*/

SELECT 
    job_id,
    job_title,
    salary_year_avg AS average_yearly_salary,
    job_schedule_type,
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

LIMIT 10;