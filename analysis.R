# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Assignment: Data Science Salaries                                         ----
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(ggplot2)
library(dplyr)
library(KScorrect)
library(kSamples)
library(moments)
library(coin)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Introduction
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# This data set provides insights into data science job salaries from 2020 to
# 2024, including information on experience levels, employment types, company
# location, and company size. It serves as a valuable resource for understanding
# salary trends and factors influencing compensation in the data science field.

# The data set is made available by ai-jobs.net Salaries. It can be downloaded
# from kaggle.com:
# kaggle.com/datasets/saurabhbadole/latest-data-science-job-salaries-2024

# We first read the data
df <- read.csv(file.path("data", "salaries.csv"))
head(df)

# Variables:
# year:      The year of the data related to the job salary (2020 - 2024).
# exp_level: The level of experience of the employee
#            (entry-level, mid-level, senior-level, experienced).
# emp_type:  The type of employment
#            (e.g., full-time, part-time, contract).
# salary:    The salary converted to US dollars.
# comp_loc:  The location of the company.
# comp_size: The company size based on employee count or revenue.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Descriptive Statistics
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# A statistician starts every project by getting familiar with the data set. We
# want to extract some descriptive statistics and create some graphs.

# First we distinguish ordinal from nominal qualitative variables.

# We use the factor() command to turn the exp_level variable into an ordered
# factor (EN < MI < SE < EX).

df$exp_level <- factor(df$exp_level,
                       levels = c("EN", "MI", "SE", "EX", ordered = TRUE))
df$comp_size <- factor(df$comp_size, levels = c("S", "M", "L"), ordered = TRUE)
df$emp_type <- factor(df$emp_type)
df$comp_loc <- factor(df$comp_loc)

# The salary variable generally takes very large values. It would be wise to
# count in thousands of dollars instead of dollars (divide by 1000).
df$salary <- df$salary / 1e3

table(df$exp_level)
df$exp_level <- droplevels(df$exp_level)
table(df$emp_type)
table(df$comp_loc)
table(df$comp_size)

# We can see that most employees in the data set are senior level and work on
# a full-time schedule. Moreover, the majority of companies are located in US
# and are considered medium-sized. In fact, the percentage of observations
# from the US is substantially large. Hence, in order to reduce noise we
# restrict our graphical analysis to the full-time employees in the US.

ggplot(df[df$comp_loc == "US" & df$emp_type == "FT", ],
       aes(x = year, y = salary, group = year))+
  geom_boxplot()+
  facet_wrap(~exp_level)+
  labs(title = "Salary (in thousands of $) of FT data scientists in US, by experience level")
ggplot(df[df$comp_loc == "US" & df$emp_type == "FT", ],
       aes(x = year, y = salary, group = year))+
  geom_boxplot()+
  facet_wrap(~comp_size)+
  labs(title = "Salary (in thousands of $) of FT data scientists in US, by company size")





# We want to focus in a single year, 2023, to avoid having dependent
# observations in the data set (it would be bold to assume that John's salary
# for 2021 is independent from his salary in 2022, 2023, and 2024).

df23 <- df[df$year == 2023, ]

# We use the table() function to create a frequency table for the categorical
# variables experience level, employment type, company location and company
# size.
table(df23$exp_level)
table(df23$emp_type)
table(df23$comp_loc)
table(df23$comp_size)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Salaries in US and GB
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We can see that the data set contains many observations from the United States
# (US) and Great Britain (GB).

Fn_US <- ecdf(df23$salary[df23$comp_loc == "US"])
Fn_GB <- ecdf(df23$salary[df23$comp_loc == "GB"])
plot(Fn_US, xlab = "Thousands of USD", ylab = "ECDF",
     main = "ECDF of salary in US vs GB",
     col.points = "blue", col.hor = "blue4")
plot(Fn_GB, col.points = "red", col.hor = "red4", add = T)
text(x = 90, y = 0.8, "GB", col = "red")
text(x = 190, y = 0.5, "US", col = "blue")

# Based on the graphs, the salaries seem to be greater in the US. We can see
# that the ECDF of the salary in GB is above that of the US. In other words, it
# seems that the random variable of the salary in the US is stochastically
# greater than that of GB.

# To assess the validity of the previous claim, we perfom the Kolmogorov-Smirnov
# test.

USvsGB <- filter(df23, comp_loc == "US" | comp_loc == "GB")
ks.test(salary ~ comp_loc, alternative = "greater", data = USvsGB)

# The results suggest that the null hypothesis that the two random variables
# share the same CDF is rejected in favor of the alternative that the CDF of
# the salary in GB lies above that of the US.

# The test examines the maximum positive difference
# between the ECDF of the salary in GB and that of the US and suggests that
# this difference is too big to ignore (since the p-value is approximately zero).




# What is the (estimated) probability to be paid between 50k and 80k in an entry
# level (EN) data science job in US?
salary_US_EN <- df23$salary[df23$comp_loc == "US" & df23$exp_level == "EN"]
Fn_US_EN <- ecdf(salary_US_EN)
prob50to80 <- Fn_US_EN(80) - Fn_US_EN(50) # P(50 <= X <= 80) = F(80) - F(50)



# Is it more or less probable that a person's salary in GB exceeds 60k,
# compared to a person in the US?

# Based on the graphs and the KS-test that was performed on the two
# random variables, we have come to the conclusion that the ecdf of the salary
# in the US is below that of GB. Equivalently, the survival function of the
# salary in the US is above that of GB. Hence, the probability of someone
# exceeding a salary of 60k in the US is greater than that of someone in GB.
1 - Fn_US(60)
1 - Fn_GB(60)


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Salary Distribution
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# We now examine whether the distribution of the salary of entry (EN) experience
# level data scientists in the US and GB resemble a known distribution or not.
# We check whether the distribution is part of the Gamma or Log-Normal families.

salary_US_GB_EN <- USvsGB$salary[USvsGB$exp_level == "EN"]
hist(salary_US_GB_EN, freq = F,
     main = "Histogram of entry-level data scientists' salary in the US and GB",
     xlab = "Thousands of $")

Lillie_gamma <- LcKS(salary_US_GB_EN, "pgamma", parallel = T)
Lillie_lnorm <- LcKS(salary_US_GB_EN, "plnorm", parallel = T)
Lillie_gamma$p.value
Lillie_lnorm$p.value

# 1st test's result: The null hypothesis that the distribution is part of the
# Gamma distribution family is rejected in the 0.01 level of significance, since
# the p-value is less than 0.01.

# 2nd test's result: The p-value of the test is greater than 0.05. Hence, we
# cannot reject the null hypothesis that the distribution is part of the
# Log-Normal family of distributions, in the 0.05 level of significance.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Experience Level
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Do US and GB companies distribute their employees by experience level in the
# same manner?

US <- table(df23$exp_level[df23$comp_loc == "US"])
GB <- table(df23$exp_level[df23$comp_loc == "GB"])
O <- rbind(US, GB)
chisq.test(O)

# The p-value is approximately zero, hence the null hypothesis of homogeneous
# experience-level distributions between the US and GB is rejected.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Company Size
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Are mid-level (MI) data scientists worldwide paid the same no matter the
# company size, for the year 2023?

df23_MIlvl <- df23[df23$exp_level == "MI", ]
kSamples::ad.test(salary ~ comp_size, method = "asymptotic", data = df23_MIlvl)

# The p-value is extremely small, suggesting that the distributions
# of mid-level data scientists' salaries do differ depending on the company
# size.

# We now perform appropriate tests to find out what is the size of the
# companies whose employees are paid more.

ggplot(df23_MIlvl, aes(comp_size, salary))+
  geom_boxplot()+
  labs(title = "Salaries of mid-level data scientists by company size",
       x = "company size")

# The boxplots indicate that the median salary of mid-level data scientists
# increases as company size increases, as expected. To check if the difference
# in medians between each size is statistically significant, we perform
# one-sided Mann-Whitney tests for every pair of sizes.

wilcox.test(df23_MIlvl$salary[df23_MIlvl$comp_size == "S"],
            df23_MIlvl$salary[df23_MIlvl$comp_size == "M"],
            exact = F, paired = F, correct = T,
            alternative = "less")

# The p-value is very small, indicating that the median salary of mid-level
# data scientists in medium-sized companies is significantly higher than in
# small companies.

wilcox.test(df23_MIlvl$salary[df23_MIlvl$comp_size == "S"],
            df23_MIlvl$salary[df23_MIlvl$comp_size == "L"],
            exact = F, paired = F, correct = T,
            alternative = "less")
# The p-value here is bigger than that of the first test, despite the fact
# that the median salary in large companies is even higher than that of
# medium-sized companies. This happens because the salaries in large companies
# are more spread out (based on the boxplot). We cannot reject the null
# hypothesis at the level of significance 0.01, but we do reject it at the
# level 0.03 or higher (since the p-value is approximately 0.028 < 0.03).
wilcox.test(df23_MIlvl$salary[df23_MIlvl$comp_size == "M"],
            df23_MIlvl$salary[df23_MIlvl$comp_size == "L"],
            exact = F, paired = F, correct = T,
            alternative = "less")
# The p-value is extremely high, suggesting that the difference in salary
# between mid-level data scientists who work in medium-sized and large
# companies is not significant.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Economy and Year Dependence
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

# The following data set contains the average salary for 30 countries in 2023
# and 2024.

df2 <- read.csv(file.path("data", "salaries_by_country.csv"))
head(df2)

# Have the salaries changed in the last 2 years?

# We first check if the observations are in the right order:
all(df2$comp_loc[df2$year == 2023] == df2$comp_loc[df2$year == 2024]) #TRUE
salary2023 <- df2$mean_salary[df2$year == 2023]
salary2024 <- df2$mean_salary[df2$year == 2024]
salarydiff <- salary2023 - salary2024
hist(salarydiff, freq = F,
     main = "Distribution of differences in salary of corresponding countries",
     xlab = "differences in salary", breaks = 30)
skewness(salarydiff)

# The skewness of the distribution is high (by absolute value), hence we
# cannot assume that the distribution is symmetric and thus the Wilcoxon
# signed-rank test cannot be performed. We use the general sign test instead
# which is quite similar without the need of the symmetry assumption.

mean_salaries <- data.frame(salary2023, salary2024)
sign_test(salary2023 ~ salary2024, data = mean_salaries,
          distribution = "approximate", p = 0.5, alternative = "two.sided")
sign_test(salary2023 ~ salary2024, data = mean_salaries,
          distribution = "asymptotic", p = 0.5, alternative = "two.sided")
sign_test(salary2023 ~ salary2024, data = mean_salaries,
          distribution = "exact", p = 0.5, alternative = "two.sided")

# The p-value is exceptionally large for every single method used for its
# computation, suggesting that the mean salary of data scientists for each
# country, has not significantly changed from year 2023 to 2024.

# If there is some difference in the average salaries, have they risen or
# declined in 2024?

sign_test(salary2023 ~ salary2024, data = mean_salaries,
          distribution = "approximate", p = 0.5, alternative = "greater")
sign_test(salary2023 ~ salary2024, data = mean_salaries,
          distribution = "approximate", p = 0.5, alternative = "less")
# Since the p-value for the alternative that salaries in 2023 are higher than
# in 2024 is smaller than the p-value for the opposite alternative, the data
# provide relatively more evidence in favor of higher salaries in 2023 than in
# 2024, although the difference is not statistically significant.

# Now, we would like to measure the correlation between the salaries of 2023 and
# 2024 based on the observations from each country.

cor(salary2023, salary2024, method = "spearman")
# The correlation is quite high (closer to 1 than 0).

