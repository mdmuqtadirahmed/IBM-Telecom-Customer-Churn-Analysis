# Telecom Customer Churn Analysis

## Project overview
A SQL Server-based exploratory analysis of the IBM Telco Customer Churn dataset. The goal is to measure churn, compare customer segments, estimate the monthly charges associated with churned accounts, and translate observed patterns into retention hypotheses for the business to test.

- **Database:** `CustomerChurnAnalysis`
- **Table:** `dbo.telecom`
- **Primary tool:** Microsoft SQL Server (T-SQL)
- **Dataset file:** `telecom.csv`
- **Records:** 7,043
- **Unique customer IDs:** 7,043
- **Analysis type:** descriptive and diagnostic; not predictive or causal

## Business problem
Customer churn can reduce recurring revenue and increase the need to acquire replacement customers. The company needs to understand how churn differs across contract types, tenure, payment methods, internet service, optional services, and monthly charges so it can prioritize further investigation and retention experiments.

## Business questions
1. What is the overall churn and retention rate?
2. Which contract types have the highest churn?
3. How does churn vary by customer tenure?
4. Which payment methods are associated with higher churn?
5. How does churn vary by internet service type?
6. How do optional services such as tech support and online security relate to churn?
7. How do monthly and total charges differ by churn status?
8. What is the monthly-charge exposure associated with churned customers?
9. Which combinations of customer characteristics warrant further investigation?

## Data quality and assumptions
- The supplied CSV contains **7,043 rows and 22 columns**.
- `customerID` is unique in this file: **7,043 unique IDs**, with 0 duplicate IDs.
- `TotalCharges` is imported as text in the source file and has **11 blank or non-numeric values**. These rows have tenure 0 in this dataset. SQL uses `TRY_CONVERT` and `NULLIF` to safely convert the field without treating blanks as zero.
- The source fields `No phone service` and `No internet service` are valid category labels, not missing values.
- Churn rate is calculated using the customer count within each segment as the denominator.
- This is a static customer-level dataset. It does not supply cancellation dates or a full time series of monthly bills.

## Key findings from the supplied CSV
These metrics were calculated from the dataset `telecom.csv`.

| KPI | Result |
|---|---:|
| Total customers | 7,043 |
| Churned customers | 1,869 |
| Retained customers | 5,174 |
| Overall churn rate | 26.54% |
| Retention rate | 73.46% |
| Average tenure, churned customers | 17.98 months |
| Average tenure, retained customers | 37.57 months |
| Average monthly charges, churned | $74.44 |
| Average monthly charges, retained | $61.27 |
| Sum of monthly charges for churned accounts | $139,130.85 |



## Interpretation and recommendations
1. **Prioritize month-to-month customers for investigation.** Contract type is a useful segmentation variable. Review the segment churn rates and counts in SQL before setting campaign targets.
2. **Focus on early-tenure experience.** Compare the first 12 months with longer-tenure bands. Consider onboarding messages, setup assistance, and early check-ins as testable interventions rather than assuming tenure itself causes churn.
3. **Investigate payment-method differences.** Differences by payment method may reflect customer mix, billing experience, or other factors. Do not conclude the payment method causes churn from this dataset alone.
4. **Review support and security adoption.** Compare churn rates for customers with and without optional services. If customers without support show elevated churn, test whether support offers or clearer service education improve retention.
5. **Treat the monthly-charge sum as exposure, not confirmed lost revenue.** The $139,130.85 sum represents listed monthly charges for customers marked as churned. It is not verified revenue loss because the data does not establish future billing, discounts, margin, or cancellation timing.
6. **Validate segment size.** Always present customer counts with rates. Small groups can show volatile percentages.


## KPI definitions
- **Churn rate:** churned customers / all customers × 100.
- **Retention rate:** customers marked `Churn = 'No'` / all customers × 100.
- **Average tenure of churned customers:** average `tenure` where `Churn = 'Yes'`.
- **Monthly-charge exposure proxy:** sum of `MonthlyCharges` where `Churn = 'Yes'`. Do not label it actual lost revenue.
- **Segment churn rate:** churned customers within a segment / all customers in that segment × 100.

## How to run
1. Create the SQL Server database named `CustomerChurnAnalysis` if it does not already exist.
2. Import `telecom.csv` into a table named `dbo.telecom`.
3. Keep the original column names shown in the CSV. Ensure `TotalCharges` may remain text; the queries convert it safely.
4. Open `customer_churn_analysis.sql` in SQL Server Management Studio (SSMS).
5. Execute sections individually or run the whole script. Review the comments and result sets.

## Limitations
- The dataset is observational and does not prove causation.
- There are no cancellation timestamps or longitudinal monthly snapshots for cohort or survival analysis.
- The monthly-charge exposure proxy is not actual lost revenue or profit.
- No predictive model is included.
- Recommendations are hypotheses for business testing, not claims that an intervention will definitely reduce churn.

## Repository structure
- `customer_churn_analysis.sql` — data validation and business analysis queries in T-SQL.
- `README.md` — project background, methodology, key findings, and report plan.
- `business_requirements_document.md` — project BRD.
- `insights.md` — the insights drawn from the analysis
-  `telecom.csv` — dataset!!!
