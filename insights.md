# Telecom Customer Churn Analysis — Key Insights

## Executive summary

The dataset contains **7,043 customers**, of whom **1,869 churned**. The overall churn rate is **26.54%**. The strongest observed patterns are associated with month-to-month contracts, early customer tenure, electronic-check payments, fiber-optic internet service, and customers without optional tech support or online security. These are associations, not proof of causation.

## 1. Overall churn

| Metric | Result |
|---|---:|
| Total customers | 7,043 |
| Churned customers | 1,869 |
| Retained customers | 5,174 |
| Churn rate | 26.54% |
| Retention rate | 73.46% |

**Insight:** A little over one in four customers is marked as churned, making segment-level investigation important.

## 2. Contract type

| Contract type | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| Month-to-month | 3,875 | 1,655 | 42.71% |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

**Insight:** Month-to-month customers have a much higher observed churn rate than customers on longer contracts.

**Recommended action:** Investigate why these customers leave and test suitable retention offers or contract options. Measure results before rolling out changes broadly.

## 3. Customer tenure

| Tenure group | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| 0–12 months | 2,186 | 1,037 | 47.44% |
| 13–24 months | 1,024 | 294 | 28.71% |
| 25–48 months | 1,594 | 325 | 20.39% |
| 49+ months | 2,239 | 213 | 9.51% |

**Insight:** The first-year tenure group has the highest churn rate, at 47.44%, while customers with 49+ months of tenure have a 9.51% rate.

**Recommended action:** Review onboarding and early customer experience. Test welcome communications, setup assistance, and proactive check-ins.

## 4. Payment method

| Payment method | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| Electronic check | 2,365 | 1,071 | 45.29% |
| Mailed check | 1,612 | 308 | 19.11% |
| Bank transfer (automatic) | 1,544 | 258 | 16.71% |
| Credit card (automatic) | 1,522 | 232 | 15.24% |

**Insight:** Electronic-check users have the highest observed churn rate among the listed payment groups.

**Recommended action:** Investigate billing experience and differences in customer profiles. Do not assume the payment method itself causes churn.

## 5. Internet service

| Internet service | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| Fiber optic | 3,096 | 1,297 | 41.89% |
| DSL | 2,421 | 459 | 18.96% |
| No internet service | 1,526 | 113 | 7.40% |

**Insight:** Fiber-optic customers have a higher observed churn rate than DSL customers. This should prompt further investigation, not an automatic conclusion about service quality.

**Recommended action:** Compare pricing, service issues, support interactions, and customer expectations across internet-service groups.

## 6. Optional services

### Tech support

| Tech support | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| No | 3,473 | 1,446 | 41.64% |
| Yes | 2,044 | 310 | 15.17% |
| No internet service | 1,526 | 113 | 7.40% |

### Online security

| Online security | Customers | Churned customers | Churn rate |
|---|---:|---:|---:|
| No | 3,498 | 1,461 | 41.77% |
| Yes | 2,019 | 295 | 14.61% |
| No internet service | 1,526 | 113 | 7.40% |

**Insight:** Customers without tech support or online security have higher observed churn rates than customers who have these services. This could reflect service adoption, customer mix, or other factors.

**Recommended action:** Explore whether clearer service education or relevant support/security offers improve retention. Treat this as a hypothesis to test, not a proven causal relationship.

## 7. Charges and tenure by churn status

| Metric | Churned customers | Retained customers |
|---|---:|---:|
| Average tenure | 17.98 months | 37.57 months |
| Average monthly charges | $74.44 | $61.27 |

**Insight:** Churned customers have shorter average tenure and higher average monthly charges than retained customers. Investigate whether price sensitivity, service mix, or early customer experience differs between the groups.

## 8. Monthly-charge exposure proxy

The sum of listed monthly charges for customers marked as churned is **$139,130.85**.

**Important:** This is a monthly-charge exposure proxy, not confirmed lost revenue or profit. The dataset does not establish cancellation timing, future billing, discounts, or margin.

## Recommended business priorities

1. Investigate early-tenure churn, especially during the first 12 months.
2. Prioritize month-to-month customers for deeper segmentation and carefully designed retention experiments.
3. Investigate the fiber-optic churn gap using service quality, pricing, and support information if available.
4. Review the electronic-check billing experience and customer-profile differences.
5. Evaluate tech support and online security adoption as potential retention opportunities.
6. Report both churn rate and segment customer count so percentages are interpreted in context.

## Suggested Power BI visuals

- KPI cards: total customers, churned customers, churn rate, retention rate.
- Bar chart: churn rate by contract type.
- Bar chart: churn rate by tenure group.
- Bar chart: churn rate by payment method.
- Bar chart: churn rate by internet service.
- Clustered bar chart: churn rate by tech support and online security.
- Comparison visual: average tenure and average monthly charges by churn status.
- Card for the **$139,130.85 monthly-charge exposure proxy**, clearly labeled as not confirmed lost revenue.

## Methodology and limitations

- Churn rate = customers marked `Churn = 'Yes'` divided by all customers in the relevant group.
- The dataset contains 7,043 rows and 7,043 unique customer IDs.
- `TotalCharges` has 11 blank or non-numeric values; these should not be treated as zero.
- This is descriptive, observational analysis. It identifies patterns and hypotheses but does not prove causation.
- The dataset is a static customer-level snapshot without cancellation dates or a monthly history of customer activity.
