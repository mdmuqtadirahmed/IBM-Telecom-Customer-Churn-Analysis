# Business Requirements Document (BRD)
## Telecom Customer Churn Analysis

**Project name:** Telecom Customer Churn Analysis  
**Business domain:** Telecommunications  
**Database:** CustomerChurnAnalysis  
**Source table:** dbo.telecom  
**Primary tool:** Microsoft SQL Server  
**Dataset:** IBM Telco Customer Churn (`telecom.csv`)  
**Project type:** Business Intelligence and Exploratory Data Analysis

## 1. Business background
The company provides phone, internet, and related subscription services. Customer churn can reduce recurring revenue and increase replacement-acquisition costs. The analytics team will use the available customer snapshot to describe churn patterns and identify customer segments for further investigation.

## 2. Business problem
The business needs a clearer view of which customer segments have higher churn rates and how churn is associated with tenure, contract type, payment method, subscribed services, and monthly charges.

## 3. Objectives
1. Measure overall churn and retention.
2. Compare churn across customer segments using appropriate denominators.
3. Evaluate churn patterns by contract type, tenure, payment method, internet service, and optional services.
4. Compare monthly and total charges by churn status.
5. Quantify monthly charges associated with churned accounts as an exposure proxy.
6. Recommend evidence-led areas for further investigation and retention testing.

## 4. Stakeholders
- Head of Customer Experience: retention performance.
- Marketing: customer engagement and retention campaigns.
- Finance: recurring-charge exposure and financial assumptions.
- Customer Service: service/support patterns.
- Data Analytics: data validation, analysis, and reporting.
- Senior Management: prioritization and decision-making.

## 5. Dataset and scope
The supplied CSV contains 7,043 customer rows and 21 columns.

**In scope:** data-quality checks, SQL descriptive analysis, churn KPIs, segment comparisons, charge summaries, business recommendations, and a proposed Power BI report.

**Out of scope:** predictive machine learning, production churn-prevention automation, customer surveys, causal claims, and true customer lifetime value calculations.

## 6. Business questions
1. What percentage of customers churned?
2. How many customers churned versus remained?
3. Which contract types have the highest churn rates?
4. How does churn vary by tenure?
5. Which payment methods have higher observed churn?
6. How does churn vary by internet service?
7. How does churn vary with optional services?
8. How do monthly charges differ by churn status?
9. What are the total monthly charges associated with churned customers?
10. Which sufficiently sized segments should be investigated first?

## 7. KPIs
- **Churn rate:** churned customers / all customers × 100.
- **Retention rate:** customers with Churn = No / all customers × 100.
- **Churned customer count:** number of rows with Churn = Yes.
- **Average tenure of churned customers:** average tenure where Churn = Yes.
- **Average monthly charges by churn status:** average MonthlyCharges for each churn group.
- **Monthly-charge exposure proxy:** sum of MonthlyCharges where Churn = Yes; not confirmed lost revenue.
- **Segment churn rate:** churned customers within the segment / total customers within the segment × 100.

## 8. Analytical requirements
- Check row count, customer ID uniqueness, blanks, data types, and category values.
- Convert TotalCharges safely because blank strings may occur.
- Calculate overall KPIs and segment churn rates.
- Show counts alongside rates and use each segment's own count as denominator.
- Use T-SQL aggregation, CASE expressions, CTEs, and safe conversion where useful.
- Document assumptions and limitations.

## 9. Deliverables
1. T-SQL validation and analysis script.
2. README with method, findings, and limitations.
3. Segment-level churn summaries.
4. Power BI dashboard build guide.
5. Business recommendations grounded in the results.

## 10. Success criteria
- Metrics can be reproduced from SQL.
- Segment denominators are correct.
- Data quality issues are documented.
- Recommendations map to observed patterns.
- Correlation is not described as causation.
- Financial proxies are not represented as confirmed losses.

## 11. Assumptions and limitations
- This is a static customer-level snapshot.
- Churn is interpreted according to the supplied Churn field.
- TotalCharges blanks are treated as missing, not zero.
- Service labels such as No internet service are valid categories.
- There are no cancellation dates, full billing history, complaints, or service-quality records in the supplied file.
- Associations do not establish why a customer left.

## 12. Expected business outcome
Give management a reliable baseline of churn, identify customer groups worth investigating, and propose retention experiments that can be evaluated using future operational data.
