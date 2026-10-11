USE CustomerChurnAnalysis;
GO

/*
Project: Telecom Customer Churn Analysis
Dataset table: dbo.telecom
Database: CustomerChurnAnalysis
SQL dialect: Microsoft SQL Server (T-SQL)

Assumption:
The CSV has been imported into dbo.telecom with the original IBM Telco
column names. 
*/

-- =========================================================
-- 1. DATASET OVERVIEW
-- =========================================================
select
    COUNT(*) as total_customers,
    COUNT(DISTINCT customerID) as unique_customers
from
    dbo.telecom;


-- =========================================================
-- 2. CUSTOMER ID DUPLICATES
-- =========================================================
select
    customerID,
    COUNT(*) as record_count
from
    dbo.telecom
group by
    customerID
having
    COUNT(*) > 1;


-- =========================================================
-- 3. MISSING / BLANK VALUES IN IMPORTANT COLUMNS
-- TotalCharges is often imported as text and may contain blanks.
-- =========================================================
select
    SUM(case when customerID is null or LTRIM(RTRIM(customerID)) = '' then 1 else 0 end) as missing_customerID,
    SUM(case when Churn is null or LTRIM(RTRIM(Churn)) = '' then 1 else 0 end) as missing_churn,
    SUM(case when TotalCharges is null or LTRIM(RTRIM(CONVERT(varchar(50), TotalCharges))) = '' then 1 else 0 end) as blank_totalcharges,
    SUM(case when TRY_CONVERT(decimal(10,2), NULLIF(LTRIM(RTRIM(CONVERT(varchar(50), TotalCharges))), '')) is null then 1 else 0 end) as totalcharges_not_numeric
from
    dbo.telecom;


-- =========================================================
-- 4. CHECK DISTINCT VALUES FOR CHURN
-- =========================================================
select
    Churn,
    COUNT(*) as customer_count
from
    dbo.telecom
group by
    Churn
order by
    customer_count desc;


-- =========================================================
-- 5. OVERALL CHURN RATE AND RETENTION RATE
-- =========================================================
select
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'No' then 1 else 0 end) as retained_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct,
    SUM(case when Churn = 'No' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as retention_rate_pct
from
    dbo.telecom;


-- =========================================================
-- 6. CHURN COUNT AND RATE BY CONTRACT TYPE
-- Use each contract segment's customer count as the denominator.
-- =========================================================
select
    Contract,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    Contract
order by
    churn_rate_pct desc;


-- =========================================================
-- 7. CHURN BY TENURE GROUP
-- =========================================================
with tenure_groups as (
    select
        customerID,
        Churn,
        case
            when tenure <= 12 then '0-12 months'
            when tenure <= 24 then '13-24 months'
            when tenure <= 48 then '25-48 months'
            else '49+ months'
        end as tenure_group
    from
        dbo.telecom
)
select
    tenure_group,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    tenure_groups
group by
    tenure_group
order by
     tenure_group
       
-- =========================================================
-- 8. CHURN BY PAYMENT METHOD
-- =========================================================
select
    PaymentMethod,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    PaymentMethod
order by
    churn_rate_pct desc;


-- =========================================================
-- 9. CHURN BY INTERNET SERVICE
-- =========================================================
select
    InternetService,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    InternetService
order by
    churn_rate_pct desc;


-- =========================================================
-- 10. OPTIONAL SERVICE COMPARISON: TECH SUPPORT
-- 'No internet service' is a valid category, not a missing value.
-- =========================================================
select
    TechSupport,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    TechSupport
order by
    churn_rate_pct desc;


-- =========================================================
-- 11. CHURN BY ONLINE SECURITY
-- =========================================================
select
    OnlineSecurity,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    OnlineSecurity
order by
    churn_rate_pct desc;


-- =========================================================
-- 12. MONTHLY CHARGES BY CHURN STATUS
-- =========================================================
select
    Churn,
    COUNT(*) as customer_count,
    AVG(MonthlyCharges) as avg_monthly_charges,
    MIN(MonthlyCharges) as min_monthly_charges,
    MAX(MonthlyCharges) as max_monthly_charges
from
    dbo.telecom
group by
    Churn
order by
    Churn;


-- =========================================================
-- 13. MONTHLY CHARGES ASSOCIATED WITH CHURNED CUSTOMERS
-- This is a monthly-charge exposure proxy, not confirmed lost revenue.
-- =========================================================
select
    COUNT(*) as churned_customers,
    SUM(MonthlyCharges) as monthly_charges_associated_with_churn,
    AVG(MonthlyCharges) as avg_monthly_charges_per_churned_customer
from
    dbo.telecom
where
    Churn = 'Yes';


-- =========================================================
-- 14. TOTAL CHARGES BY CHURN STATUS
-- Safely convert TotalCharges because the CSV can contain blanks.
-- Blank / invalid values are excluded from the average and sum.
-- =========================================================
with cleaned_charges as (
    select
        Churn,
        TRY_CONVERT(decimal(10,2), NULLIF(LTRIM(RTRIM(CONVERT(varchar(50), TotalCharges))), '')) as total_charges_numeric
    from
        dbo.telecom
)
select
    Churn,
    COUNT(*) as customer_count,
    SUM(case when total_charges_numeric is null then 1 else 0 end) as rows_without_numeric_totalcharges,
    AVG(total_charges_numeric) as avg_total_charges,
    SUM(total_charges_numeric) as sum_total_charges
from
    cleaned_charges
group by
    Churn
order by
    Churn;


-- =========================================================
-- 15. CHURN RATE BY MULTIPLE CUSTOMER CHARACTERISTICS
-- Example: senior-citizen status and partner status.
-- =========================================================
select
    SeniorCitizen,
    Partner,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    dbo.telecom
group by
    SeniorCitizen,
    Partner
order by
    churn_rate_pct desc;


-- =========================================================
-- 16. CUSTOMER SEGMENTS TO INVESTIGATE FIRST
-- Combine contract, tenure band, and payment method.
-- Keep segment size visible to avoid overreacting to tiny groups.
-- =========================================================
with customer_segments as (
    select
        Contract,
        PaymentMethod,
        case
            when tenure <= 12 then '0-12 months'
            when tenure <= 24 then '13-24 months'
            when tenure <= 48 then '25-48 months'
            else '49+ months'
        end as tenure_group,
        Churn
    from
        dbo.telecom
)
select
    Contract,
    tenure_group,
    PaymentMethod,
    COUNT(*) as total_customers,
    SUM(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
    SUM(case when Churn = 'Yes' then 1.0 else 0 end) * 100.0
        / NULLIF(COUNT(*), 0) as churn_rate_pct
from
    customer_segments
group by
    Contract,
    tenure_group,
    PaymentMethod
having
    COUNT(*) >= 30
order by
    churn_rate_pct desc,
    total_customers desc;


-- =========================================================
-- 17. CUSTOMER-LEVEL REVIEW LIST FOR CHURNED CUSTOMERS
-- Useful for exploration; do not expose customer IDs in a public
-- dashboard or report unless there is a legitimate business need.
-- =========================================================
select
    customerID,
    tenure,
    Contract,
    InternetService,
    PaymentMethod,
    MonthlyCharges,
    Churn
from
    dbo.telecom
where
    Churn = 'Yes'
order by
    tenure asc,
    MonthlyCharges desc;



