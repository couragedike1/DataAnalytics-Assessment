# DataAnalytics-Assessment

## Overview

This repository contains my solutions to a SQL assessment focused on extracting insights and solving business problems from a relational database using SQL.

## Solutions

### Q1: High-Value Customers with Multiple Products
- **Goal**: Find users with both a savings plan and an investment plan.
- **Approach**: Joined users, savings, and plans tables. Applied filters to select only funded savings (confirmed_amount > 0) and confirmed investment plans.
- **Challenges**: Ensuring correct join logic and filtering only confirmed records; converting from kobo to naira.

### Q2: Transaction Frequency Analysis
- **Goal**: Classify customers into frequency categories.
- **Approach**: Aggregated monthly transaction counts, averaged per user, categorized into tiers (High, Medium, Low).
- **Challenges**: Ensuring accurate grouping and rounding of results for clarity.

### Q3: Account Inactivity Alert
- **Goal**: Identify accounts with no inflow in the last year.
- **Approach**: Computed last transaction dates from both savings and investment plans; selected those inactive for over 365 days.
- **Challenges**: Handling union of different plan types while maintaining column consistency.

### Q4: Customer Lifetime Value (CLV) Estimation
- **Goal**: Estimate CLV from tenure and profit per transaction.
- **Approach**: Calculated total transactions, average transaction value, and used the formula to compute CLV.
- **Challenges**: Handling division-by-zero cases and converting units from kobo to naira.

## Repository Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

## Notes

- All queries are optimized for readability and accuracy.
- Monetary values are converted from kobo to naira where required.
