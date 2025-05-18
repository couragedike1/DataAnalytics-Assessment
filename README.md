# DataAnalytics-Assessment

## Overview

This repository contains solutions to a SQL proficiency assessment aimed at evaluating a candidate’s ability to work with relational databases to solve business problems.

## Questions & Approaches

### Q1: High-Value Customers with Multiple Products
**Objective:** Identify customers with at least one funded savings account and one funded investment plan.
- Used joins between `users_customuser`, `savings_savingsaccount`, and `plans_plan`.
- Filtered only confirmed savings and investment plans.
- Aggregated by customer, counted savings and investments, summed deposits.

### Q2: Transaction Frequency Analysis
**Objective:** Classify customers based on monthly transaction activity.
- Calculated monthly transactions using `DATE_TRUNC`.
- Averaged transaction count per customer.
- Categorized into High, Medium, Low frequency.

### Q3: Account Inactivity Alert
**Objective:** Flag accounts with no transactions in the past year.
- Combined last transaction dates from both savings and investment accounts.
- Filtered accounts with inactivity over 365 days.

### Q4: Customer Lifetime Value (CLV) Estimation
**Objective:** Estimate CLV using account tenure and transaction value.
- Calculated tenure using `AGE`.
- Assumed profit as 0.1% of average transaction value.
- CLV formula applied as:  
  `CLV = (total_txn / tenure_months) * 12 * avg_profit_per_txn`.

## Challenges Faced
- Handling data in Kobo units and converting to Naira correctly.
- Ensuring zero-division errors were handled in CLV calculations.
- Interpreting which fields defined “confirmed” or “active” required cross-checking schema.

## Repository Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```
