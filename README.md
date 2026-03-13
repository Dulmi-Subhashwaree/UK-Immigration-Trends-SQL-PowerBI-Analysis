# UK Immigration Trends Analysis using SQL Server and Power BI

## Project Overview
This project analyzes historical **UK study and work visa sponsorship trends** using data from the UK Home Office. The analysis combines **Microsoft SQL Server** for data storage, cleaning, and transformation with **Power BI** for data modeling, visualization, and dashboard creation.

The goal of the project is to explore migration patterns, identify trends in visa sponsorship applications, and provide insights through interactive data visualizations.

This project was completed as part of the **Advanced SQL and Cloud Databases assignment** for the **BSc in Applied Data Science Communication program at General Sir John Kotelawala Defence University (KDU).**

---

## Objectives
- Import and manage real-world migration datasets
- Clean and transform data using SQL Server
- Design a structured relational database
- Perform analytical queries
- Build interactive dashboards using Power BI
- Identify patterns in global study and work visa sponsorship applications

---

## Dataset Source
The datasets were obtained from the **UK Government Open Data Portal**.

Source:  
https://data.gov.uk

Datasets Used:
- Study Sponsorship – Historic Data
- Work Sponsorship – Historic Data

These datasets include information about:
- Application year
- Applicant nationality
- Visa type
- Total applications
- Approved applications
- Refused applications
- Withdrawn applications
- Visa extensions

---

## Technologies Used

### Database & Data Processing
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL for data cleaning and transformation

### Data Visualization
- Microsoft Power BI
- Power Query
- DAX (Data Analysis Expressions)

---

## Project Workflow

### 1. Data Collection
Historic migration datasets were downloaded from the UK Government open data portal.

### 2. Data Import
CSV datasets were imported into **SQL Server** using the Import and Export Wizard.

### 3. Data Cleaning and Transformation
Several SQL scripts were used to:
- Remove unnecessary characters
- Extract numeric values
- Convert incorrect data types
- Structure raw data into clean analytical tables

A custom SQL function (`dbo.ExtractNumbers`) was created to clean numeric data stored as text.

### 4. Database Design
Separate tables were created for:
- Study sponsorship by institution
- Study sponsorship by geography
- Work sponsorship by industry
- Work sponsorship by geography

Primary keys and structured columns were added for efficient analysis.

### 5. Power BI Integration
The SQL Server database was connected to **Power BI Desktop using Import Mode** to optimize performance.

### 6. Data Modeling
Relationships between tables were created and several **DAX measures** were implemented including:
- Total Applications
- Study Applications
- Work Applications
- Year-over-Year Growth
- Top Applicant Nationalities
- Industry Distribution

### 7. Dashboard Development
Interactive dashboards were built to visualize migration trends.

---

## Dashboard Visualizations

The Power BI dashboard includes:

- Study vs Work Applications Over Time
- Top 10 Applicant Nationalities
- Top Work Industries
- Visa Application Type Distribution
- Study Institution Distribution
- Geographic Application Distribution
- KPI Indicators (Total Applications and Growth Rate)

These visuals allow users to explore trends dynamically using filters and slicers.

---

## Key Insights

- Study visa applications show higher volatility over time.
- Work visa applications demonstrate steady growth in recent years.
- Migration flows are concentrated among specific regions and nationalities.
- Work visa sponsorships are distributed across multiple industries, particularly technology and healthcare sectors.

---

## Challenges Faced

- Inconsistent formatting in source datasets
- Numeric values stored as text
- Missing and irregular categorical data
- Balancing dashboard readability with analytical depth

These issues were resolved through SQL data cleaning and careful visualization design.

---

## Limitations

- The datasets contain aggregated historic data rather than individual records.
- Policy context variables were not available to explain changes in migration trends.
- Some datasets contained missing or inconsistent entries.

---

## Future Improvements

- Integrating policy change timelines for deeper analysis
- Including additional demographic variables
- Applying predictive analytics for migration trend forecasting
- Automating data updates for near real-time dashboards

---

## Conclusion
This project demonstrates how **SQL Server and Power BI can be integrated to perform scalable and effective data analytics on large real-world datasets**. The dashboard provides valuable insights into UK migration patterns and highlights the importance of data-driven decision making in policy analysis.

---

## Authors
Group: **Avengers Plus**

- WMD Subhashwaree  
- GGI Gamanayaka  
- JANI Jayawardhana  

BSc in Applied Data Science Communication  
General Sir John Kotelawala Defence University (KDU)

---

## License
This project is created for academic purposes.
