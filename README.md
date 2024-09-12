# Retail Order Data Analysis

This repository contains tools and scripts for analyzing retail order data. The analysis includes loading data into a database, performing exploratory data analysis, and executing SQL queries to derive insights from the data.

## Repository Contents

- **`Retail Order Data Analysis-checkpoint.ipynb`**: A Jupyter Notebook for data loading, cleaning, and analysis using Python and pandas. It also demonstrates how to load the data into a PostgreSQL database.
- **`sql-code.sql`**: An SQL script that runs queries on the retail order data stored in a PostgreSQL database to identify top-performing products by revenue and region.


## Analysis Overview

### Jupyter Notebook

The notebook performs the following steps:

- Loads and explores retail order data.
- Prepares the data by cleaning and structuring it for analysis.
- Loads the data into a PostgreSQL database.

### SQL Analysis

The SQL script includes:

- Querying all records from the `df_orders` table.
- Identifying the top 10 highest revenue-generating products.
- Finding the top 5 highest-selling products in each region.
- Finding month over month growth comparison.

