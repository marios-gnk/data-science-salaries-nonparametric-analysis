# Data Science Salaries - Non-Parametric Statistical Analysis (R)
This repository contains an academic project completed as part of the course **Non-Parametric Statistics**.
## 📖 Overview
This project explores salary patterns in the data science job market using real-world data from 2020-2024 through the application of non-parametric statistical methods, including empirical cumulative distribution functions and non-parametric hypothesis tests.

The goal is to investigate how salaries vary across:

- countries (US vs Great Britain)
- experience level
- company size
- employment types
- years

---

## 🗂️ Dataset
The dataset is sourced from ai-jobs.net and can be downloaded from kaggle.com:
[Latest Data Science Job Salaries (2024) - Kaggle](https://www.kaggle.com/datasets/saurabhbadole/latest-data-science-job-salaries-2024)

It contains structured information on data science salaries including:

- experience level
- employment type
- company location
- company size
- annual salary (USD)
- time period (2020-2024)

Additionally, a secondary dataset is used for country-based average salaries (2023 vs 2024).

---

## 📋 Research Questions
This analysis addresses the following statistical questions:

- Do data science salaries differ significantly between the US and Great Britain?
- How do salaries vary accross experience levels and company sizes?
- Are salary distributions consistent with known parametric families (Gamma, Log-Normal)?
- Do mid-level salaries depend on company size?
- Have average salaries changed between 2023 and 2024?
- How strongly are salaries correlated across consecutive years?

---

## 📈 Statistical Methods Used
The project included applications of: 

- Empirical Cumulative Distribution Functions (ECDF)
- Kolmogorov-Smirnov Test
- Anderson-Darling k-sample Test
- Mann-Whitney Test
- Chi-Square Test of Homogeneity
- Sign Test
- Spearman Correlation
- goodness-of-fit tests
- Exploratory data visualization

---

## ⚙️ Tools and Technologies Used
- R
- RStudio
- ggplot2
- dplyr
- kSamples
- KScorrect
- coin
- moments

---

## 📊 Key Findings 
- Salaries in the US are stochastically greater than in Great Britain.

<img src="figures/US_vs_GB_salary.png" width="500">

- Company size significantly affects salaries, especially for mid-level data scientists.

<img src="figures/mid_level_salary_by_comp_size.png" width="500">

- Entry-level salaries in US/GB are better approximated by a Log-Normal distribution than a Gamma distribution

<img src="figures/entry_level_salary_distribution.png" width="500">

- No statistically significant change was detected in average salaries between 2023 and 2024.

<img src="figures/salary_difference.png" width="500">

- Salary distributions differ significantly across experience levels and company sizes.

---

## ▶️ How to Run

1. Clone or download this repository.

2. Open `DataSalaries.Rproj` in RStudio.

3. Install the required packages:

```r
install.packages(c("ggplot2", "dplyr", "KScorrect", "kSamples", "moments", "coin"))
```
4. Run the script:

```r
source("analysis.R") 
```

---

## ✍️ Notes 

- All analysis and interpretation are contained directly in the `analysis.R` script through detailed comments.
- No external report was produced. The script itself serves as a full analytical write-up.

---

## 👨‍💻 Author

**Marios Giannakopoulos**

Department of Mathematics 

National and Kapodistrian University of Athens



# Data Science Salaries: Nonparametric Statistical Analysis (R)

This repository contains an academic project completed as part of the course **Nonparametric Statistics**.

## 📖 Overview

This project explores salary patterns in the data science job market using real-world data from 2020-2024 through the application of non-parametric statistical methods, including empirical cumulative distribution functions and non-parametric hypothesis tests.

The emphasis is placed on various topics, including:

- salary differences between the United States and Great Britain
- salary distributions across experience levels and company sizes
- goodness-of-fit assessment for common parametric distributions
- the effect of company size on mid-level data scientist salaries
- changes in country-level average salaries between 2023 and 2024

---

## 🗂️ Dataset

The main dataset is sourced from **ai-jobs.net Salaries** and is available on Kaggle:

[Latest Data Science Job Salaries (2024) - Kaggle](https://www.kaggle.com/datasets/saurabhbadole/latest-data-science-job-salaries-2024)

It contains structured information on data science salaries, including:

- year
- experience level
- employment type
- company location
- company size
- annual salary converted to USD

A secondary dataset is also used to compare country-level average salaries between 2023 and 2024.

---

## 📈 Statistical Methods Used

- Empirical Cumulative Distribution Functions (ECDFs)
- Kolmogorov-Smirnov Test
- Lilliefors-corrected goodness-of-fit tests
- Anderson-Darling k-sample Test
- Mann-Whitney Test
- Chi-Square Test of Homogeneity
- Sign Test
- Spearman Rank Correlation
- Exploratory data visualization

---

## ⚙️ Tools and Technologies Used

- R
- RStudio
- ggplot2
- dplyr
- KScorrect
- kSamples
- coin
- moments

---

## 📊 Key Findings

### United States vs Great Britain Salaries

The ECDF comparison suggests that data science salaries in the United States are stochastically greater than salaries in Great Britain. This result is supported by a one-sided Kolmogorov-Smirnov test.

<img src="figures/US_vs_GB_salary.png" width="500">

### Salary Distribution of Entry-Level Roles

Entry-level salaries in the United States and Great Britain are better approximated by a Log-Normal distribution than by a Gamma distribution. The Gamma family is rejected at the 1% significance level, while the Log-Normal family is not rejected at the 5% level.

<img src="figures/entry_level_salary_distribution.png" width="500">

### Experience-Level Composition

The experience-level distributions of data science employees differ significantly between the United States and Great Britain, based on a Chi-Square test of homogeneity.

### Mid-Level Salaries by Company Size

Company size has a statistically significant effect on the salary distribution of mid-level data scientists. In particular, mid-level data scientists in medium-sized companies earn significantly more than those in small companies.

<img src="figures/mid_level_salary_by_comp_size.png" width="500">

### Country-Level Salary Changes

No statistically significant change was detected in country-level average salaries between 2023 and 2024 using the Sign Test.

<img src="figures/salary_difference.png" width="500">

---





