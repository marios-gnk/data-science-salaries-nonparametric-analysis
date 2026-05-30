# Data Science Salaries: Nonparametric Statistical Analysis (R)

This repository contains an academic project completed as part of the course **Nonparametric Statistics**.

## 📖 Overview

This project explores salary patterns in the data science job market using real-world data from 2020–2024 through the application of nonparametric statistical methods, including empirical cumulative distribution functions and nonparametric hypothesis tests.

The emphasis is placed on the following topics:

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

Salary values are analyzed in thousands of USD for readability.

---

## 📈 Statistical Methods Used

The main statistical methods and techniques used include:

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

- The analysis and interpretation are contained directly in the `analysis.R` script through detailed comments.
- The script serves as a reproducible analytical write-up for the project.

---

## 👨‍💻 Author

**Marios Giannakopoulos**

Department of Mathematics 

National and Kapodistrian University of Athens
