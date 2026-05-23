/*
Question: What are the most optiomal skills to learn (high in demand and high paying) for Data Analysts in remote jobs?
- Find the skill in high demand and associated with high average salary for data analyst jobs.
- Filter for remote jobs with specified salaries (No null values)
*/





WITH skills_in_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count

    FROM 
        job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 

    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id


),

average_salary AS (

    SELECT 
        skills_dim.skill_id,
        skills,
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
        skills_dim.skill_id

)


SELECT 
    skills_in_demand.skill_id,
    skills_in_demand.skills,
    demand_count,
    average_salary

FROM
    skills_in_demand
INNER JOIN average_salary ON skills_in_demand.skill_id = average_salary.skill_id

WHERE
    demand_count > 10 
ORDER BY 
    demand_count DESC,
    average_salary DESC

LIMIT 25;