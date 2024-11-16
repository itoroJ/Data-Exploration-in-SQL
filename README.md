# Data Exploration in SQL

This repository contains a collection of SQL scripts for exploring various datasets, providing insights through queries, and demonstrating best practices in SQL-based data analysis. The scripts include examples of data summarization, aggregation, filtering, and advanced operations like window functions and correlation analysis.

## Table of Contents

- [Dataset Descriptions](#dataset-descriptions)  
- [Query Examples](#query-examples)  
- [Learning Resources](#learning-resources)  
- [Contributing](#contributing)  
- [License](#license)

## Dataset Descriptions

The repository includes SQL scripts for the following datasets:

1. **Jamb Data Exploration.sql**  
   - **Description**: Analyzes students' performance in JAMB exams, focusing on scores, attendance, study hours, and the impact of extra tutorials.  
   - **Sample Analysis**:  
     - Average scores by gender.  
     - Correlation between study hours and exam performance.  

2. **Laptop Data Exploration.sql**  
   - **Description**: Explores trends in laptop sales, pricing, and customer preferences.  
   - **Sample Analysis**:  
     - Popular laptop brands and models.  
     - Price distribution and sales volume analysis.  

3. **Layoffs.sql**  
   - **Description**: Investigates employee layoffs across industries, identifying patterns and trends.  
   - **Sample Analysis**:  
     - Layoff trends by industry and year.  
     - Average employee retention periods.  

4. **Nigerian Housing Data Exploration.sql**  
   - **Description**: Analyzes housing data in Nigeria, focusing on pricing, locations, and features.  
   - **Sample Analysis**:  
     - Average housing prices by region.  
     - Correlation between house size and price.  

## Query Examples

### Basic Query
```sql
-- Count the total number of students in the JAMB dataset
SELECT COUNT(*) AS total_students
FROM jamb_exam_results_staging;
```

### Aggregation Query
```sql
-- Calculate the average JAMB score by school type and location
SELECT School_Type, School_Location, AVG(JAMB_Score) AS avg_score
FROM jamb_exam_results_staging
GROUP BY School_Type, School_Location;
```

### Advanced Query
```sql
-- Use a window function to calculate the running average of JAMB scores based on attendance rates
SELECT Student_ID, JAMB_Score, Attendance_Rate,
       AVG(JAMB_Score) OVER (ORDER BY Attendance_Rate) AS running_avg_score
FROM jamb_exam_results_staging;
```

## Learning Resources

If you're new to SQL or want to learn more about data exploration, check out these resources:

- [MySQL Documentation](https://dev.mysql.com/doc/) – Official MySQL documentation for syntax and best practices.  
- [Khan Academy SQL Course](https://www.khanacademy.org/computing/computer-programming/sql) – A beginner-friendly course on SQL basics.  
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/) – Hands-on examples and guides for writing efficient SQL queries.  

## Contributing

Contributions are welcome! Here’s how you can help:

- **Add New Queries**: If you have an interesting dataset and queries, feel free to contribute.  
- **Improve Existing Queries**: Suggest optimizations or alternative approaches for the current scripts.  
- **Report Issues**: If you find any errors in the queries or documentation, let us know.  

### How to Contribute

1. Fork the repository.  
2. Create a feature branch:  
   ```bash
   git checkout -b feature/new-query
   ```  
3. Commit your changes:  
   ```bash
   git commit -m "Add a new query for XYZ dataset"
   ```  
4. Push to the branch:  
   ```bash
   git push origin feature/new-query
   ```  
5. Open a pull request.  

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute this repository with proper attribution. See the [LICENSE](LICENSE) file for details.

## Repository Highlights

- **Clear Descriptions**: Each SQL file is well-documented to ensure ease of understanding.  
- **Reusable Queries**: The scripts are modular and can be adapted to various datasets.  
- **Beginner-Friendly**: Includes simple and advanced queries for learners at all levels.  
