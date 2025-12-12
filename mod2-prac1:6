
R version 4.5.2 (2025-10-31 ucrt) -- "[Not] Part in a Rumble"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/RPROG/.RData]

> AI_Impact_on_Jobs_2030 <- read.csv("~/RPROG/AI_Impact_on_Jobs_2030.csv", header=FALSE)
>   View(AI_Impact_on_Jobs_2030)
> # 0. Load necessary packages and install if needed
> install.packages("dplyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/Purvi/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/dplyr_1.1.4.zip'
Content type 'application/zip' length 1593482 bytes (1.5 MB)
downloaded 1.5 MB

package ‘dplyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\Purvi\AppData\Local\Temp\RtmpScLUOA\downloaded_packages
> 
> install.packages("psych")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/Purvi/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/psych_2.5.6.zip'
Content type 'application/zip' length 3594552 bytes (3.4 MB)
downloaded 3.4 MB

package ‘psych’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\Purvi\AppData\Local\Temp\RtmpScLUOA\downloaded_packages
> 
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union
> 
> library(psych) # Required for describe()
> 
> # 0. LOAD DATA
> # We assume the file is in your working directory
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create a grouping variable for later questions (e.g., t-tests)
> # We classify jobs with Automation_Probability_2030 > 0.5 as "HighRisk", others as "LowRisk"
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> # 1 Practical: Generating descriptive statistics using summary() or describe()
> print("--- 1. Descriptive Statistics ---")
[1] "--- 1. Descriptive Statistics ---"
> 
> # A. Using Base R summary()
> # Good for: Quick overview (Min, Median, Mean, Max)
> print("Summary of Average_Salary:")
[1] "Summary of Average_Salary:"
> summary(df$Average_Salary)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  30030   58640   89318   89372  119087  149798 
> 
> # B. Using psych::describe()
> # Good for: Detailed stats (Skew, Kurtosis, Standard Error)
> print("Detailed Description of Years_Experience:")
[1] "Detailed Description of Years_Experience:"
> describe(df$Years_Experience)
   vars    n  mean   sd median trimmed   mad min max range  skew kurtosis   se
X1    1 3000 14.68 8.74     15    14.7 11.86   0  29    29 -0.01    -1.22 0.16
> PRACTICAL 2||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Error: unexpected numeric constant in "PRACTICAL 2"

> # 0. Dependencies Setup (Repeat for completeness if running this section standalone)
> install.packages("dplyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Warning: package ‘dplyr’ is in use and will not be installed

> # 0. LOAD DATA and PRE-PROCESSING (Repeat from Practical 1 to ensure variables exist)
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> # Create the grouping variable used in Practical 1 and 2B
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 2 Practical: Generating frequency tables using table() or count()
> print("--- 2. Frequency Tables (Risk Category and Automation Group) ---")
[1] "--- 2. Frequency Tables (Risk Category and Automation Group) ---"
> 
> # A. Using Base R table()
> # Good for: Simple counts of an existing categorical variable (Risk_Category)
> print("Counts of Risk_Category:")
[1] "Counts of Risk_Category:"
> risk_counts <- table(df$Risk_Category)
> print(risk_counts)

  High    Low Medium 
   740    739   1521 
> 
> # B. Using dplyr::count()
> # Good for: Dataframe output (easier to use in plots later) of the new grouping variable (Automation_Risk_Group)
> print("Counts of Automation_Risk_Group:")
[1] "Counts of Automation_Risk_Group:"
> automation_group_df <- df %>% 
+     count(Automation_Risk_Group, name = "Frequency")
> print(automation_group_df)
  Automation_Risk_Group Frequency
1              HighRisk      1479
2               LowRisk      1521
> 
> 
> PRACTICAL 3|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Error: unexpected numeric constant in "PRACTICAL 3"

> # 0. LOAD DATA
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create the grouping variable (from Practical 1)
> # We classify jobs with Automation_Probability_2030 > 0.5 as "HighRisk", others as "LowRisk"
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 3 Practical: Creating cross-tabulations and two-way tables using table()
> print("--- 3. Cross-Tabulation (Education Level vs. Automation Risk Group) ---")
[1] "--- 3. Cross-Tabulation (Education Level vs. Automation Risk Group) ---"
> 
> # Question: How many jobs at each Education_Level fall into the HighRisk vs LowRisk Automation Group?
> # Rows: Education_Level, Columns: Automation_Risk_Group
> 
> cross_tab <- table(df$Education_Level, df$Automation_Risk_Group)
> 
> print(cross_tab)
             
              HighRisk LowRisk
  Bachelor's       372     393
  High School      402     382
  Master's         362     373
  PhD              343     373
> 
> PRACTICAL||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Error: unexpected '||' in "PRACTICAL||||"

> # 0. Dependencies Setup (Repeat for completeness if running this section standalone)
> install.packages("dplyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Warning: package ‘dplyr’ is in use and will not be installed

> # 0. LOAD DATA
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create the grouping variable (from Practical 1)
> # We classify jobs with Automation_Probability_2030 > 0.5 as "HighRisk", others as "LowRisk"
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 4 Practical: Performing one-sample t-tests using t.test()
> print("--- 4. One-Sample t-test ---")
[1] "--- 4. One-Sample t-test ---"
> 
> # Question: Is the average salary significantly different from $100,000?
> # H0 (Null Hypothesis): The true mean average salary is $100,000 (mu = 100000).
> 
> t_test_one <- t.test(df$Average_Salary, mu = 100000)
> 
> print(t_test_one)

	One Sample t-test

data:  df$Average_Salary
t = -16.82, df = 2999, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 1e+05
95 percent confidence interval:
 88133.37 90611.19
sample estimates:
mean of x 
 89372.28 

> 
> # 0. LOAD DATA
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create the grouping variable (from Practical 1)
> # This step is included for completeness in a practical sequence, though not strictly needed for the one-sample t-test.
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 4 Practical: Performing one-sample t-tests using t.test()
> print("--- 4. One-Sample t-test ---")
[1] "--- 4. One-Sample t-test ---"
> 
> # Question: Is the average salary significantly different from $100,000?
> # H0 (Null Hypothesis): The true mean average salary is $100,000 (mu = 100000).
> 
> t_test_one <- t.test(df$Average_Salary, mu = 100000)
> 
> print(t_test_one)

	One Sample t-test

data:  df$Average_Salary
t = -16.82, df = 2999, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 1e+05
95 percent confidence interval:
 88133.37 90611.19
sample estimates:
mean of x 
 89372.28 

> 
> PRACTICAL 5||||||||||||||||||||||||||||||||||||||||||||||||
Error: unexpected numeric constant in "PRACTICAL 5"

> # 0. LOAD DATA
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create the grouping variable (from Practical 1)
> # We classify jobs with Automation_Probability_2030 > 0.5 as "HighRisk", others as "LowRisk"
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 5 Practical: Performing independent two-sample t-tests using t.test() with grouping
> print("--- 5. Independent Two-Sample t-test ---")
[1] "--- 5. Independent Two-Sample t-test ---"
> 
> # Question: Is there a significant difference in the Average Salary between High-Risk and Low-Risk automation groups?
> # H0 (Null Hypothesis): The mean Average Salary is the same in both groups (mean_HighRisk = mean_LowRisk).
> 
> # Syntax: numeric_variable ~ grouping_variable
> t_test_two <- t.test(df$Average_Salary ~ df$Automation_Risk_Group, data = df)
> 
> print(t_test_two)

	Welch Two Sample t-test

data:  df$Average_Salary by df$Automation_Risk_Group
t = 0.05429, df = 2994.4, p-value = 0.9567
alternative hypothesis: true difference in means between group HighRisk and group LowRisk is not equal to 0
95 percent confidence interval:
 -2410.081  2547.343
sample estimates:
mean in group HighRisk  mean in group LowRisk 
              89407.08               89338.44 

> 
> PRACTICAL 666|||||||||||||||||||||||||
Error: unexpected numeric constant in "PRACTICAL 666"

> # 0. LOAD DATA
> df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # PRE-PROCESSING: Create the grouping variable (from Practical 1)
> df$Automation_Risk_Group <- ifelse(df$Automation_Probability_2030 > 0.5, "HighRisk", "LowRisk")
> 
> 
> # 6 Practical: Performing paired t-tests using t.test(paired=TRUE)
> print("--- 6. Paired t-test ---")
[1] "--- 6. Paired t-test ---"
> 
> # Context: We will test if there is a significant difference between the average score of Skill_1 and Skill_10, 
> # treating them as paired measures (two different skills for the SAME job).
> 
> # Question: Is the mean score for Skill_1 significantly different from the mean score for Skill_10 across the same jobs?
> # H0 (Null Hypothesis): The true mean difference between Skill_1 and Skill_10 is zero.
> 
> t_test_paired <- t.test(df$Skill_1, df$Skill_10, paired = TRUE)
> 
> print(t_test_paired)

	Paired t-test

data:  df$Skill_1 and df$Skill_10
t = 0.44811, df = 2999, p-value = 0.6541
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -0.01129694  0.01799028
sample estimates:
mean difference 
    0.003346667 
