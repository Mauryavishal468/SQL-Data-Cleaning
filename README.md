# SQL Data Cleaning Project

This project demonstrates a complete data cleaning process using SQL on a real-world layoff dataset.

## 🧹 Steps Performed

1. Removed duplicates using `ROW_NUMBER()` with `PARTITION BY`
2. Standardized data entries like company names, industries, and countries
3. Handled null or blank values by updating or deleting rows
4. Converted `date` columns to proper SQL `DATE` datatype
5. Created staging tables to separate raw and cleaned data

## 📂 Files

- `DATA CLEANING PROJECT.sql`: Full SQL script with all cleaning steps

## 🛠 Tech Stack

- MySQL / SQL
- Window Functions
- CTEs
- Data Wrangling

## 💡 What I Learned

- Real-world data is messy — consistent formats are rare
- SQL has powerful built-in tools for cleaning and transformation
- Cleaning before analysis is critical for accurate insights

