
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

> load("~/RPROG/.RData")
> head(my_data) - First 5 Rows
Error: unexpected numeric constant in "head(my_data) - First 5"

> head(my_data) - First 5 Rows
Error: unexpected numeric constant in "head(my_data) - First 5"

> head(my_data) - First 5 Rows
Error: unexpected numeric constant in "head(my_data) - First 5"

> head(job_title)
Job_Title Average_Salary Years_Experience Education_Level
1      Security Guard          45795               28        Master's
2  Research Scientist         133355               20             PhD
3 Construction Worker         146216                2     High School
4   Software Engineer         136530               13             PhD
5   Financial Analyst          70397               22     High School
6         AI Engineer          92592               11        Master's
AI_Exposure_Index Tech_Growth_Factor Automation_Probability_2030 Risk_Category
1              0.18               1.28                        0.85          High
2              0.62               1.11                        0.05           Low
3              0.86               1.18                        0.81          High
4              0.39               0.68                        0.60        Medium
5              0.52               1.46                        0.64        Medium
6              0.29               0.51                        0.10           Low
Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8 Skill_9 Skill_10
1    0.45    0.10    0.46    0.33    0.14    0.65    0.06    0.72    0.94     0.00
2    0.02    0.52    0.40    0.05    0.97    0.23    0.09    0.62    0.38     0.98
3    0.01    0.94    0.56    0.39    0.02    0.23    0.24    0.68    0.61     0.83
4    0.43    0.21    0.57    0.03    0.84    0.45    0.40    0.93    0.73     0.33
5    0.75    0.54    0.59    0.97    0.61    0.28    0.30    0.17    0.02     0.42
6    0.71    0.79    0.61    0.93    0.65    0.91    0.85    0.45    0.10     0.37
> tail(job_title)
Job_Title Average_Salary Years_Experience Education_Level
2995         Mechanic          86686               18     High School
2996           Doctor         111319                6      Bachelor's
2997    UX Researcher          44363               29             PhD
2998   Data Scientist          61325               23        Master's
2999 Graphic Designer         110296                7             PhD
3000 Graphic Designer         123909               25             PhD
AI_Exposure_Index Tech_Growth_Factor Automation_Probability_2030 Risk_Category
2995              0.91               0.83                        0.47        Medium
2996              0.24               1.18                        0.20           Low
2997              0.65               0.74                        0.35        Medium
2998              0.64               0.94                        0.39        Medium
2999              0.95               1.23                        0.46        Medium
3000              0.69               0.56                        0.49        Medium
Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8 Skill_9
2995    0.08    0.96    0.09    0.77    0.54    0.06    0.00    0.94    0.74
2996    0.73    0.37    0.99    0.07    0.08    0.92    0.65    0.33    0.76
2997    0.23    0.48    0.05    0.88    0.56    0.29    0.69    0.80    0.61
2998    0.28    0.62    0.73    0.21    0.96    0.01    0.70    0.29    0.48
2999    0.21    0.18    0.14    0.22    0.55    0.68    0.31    0.55    0.34
3000    0.77    0.54    0.95    0.05    0.29    0.22    0.77    0.52    0.14
Skill_10
2995     0.69
2996     0.45
2997     0.20
2998     0.57
2999     0.70
3000     0.29
> dim(job_title)
[1] 3000   18
> cat("Dimensions (Rows, Columns): ", dim(job_title), "\n")
Dimensions (Rows, Columns):  3000 18 
> str(job_title)
'data.frame':	3000 obs. of  18 variables:
  $ Job_Title                  : chr  "Security Guard" "Research Scientist" "Construction Worker" "Software Engineer" ...
$ Average_Salary             : int  45795 133355 146216 136530 70397 92592 107373 53419 139225 85016 ...
$ Years_Experience           : int  28 20 2 13 22 11 23 12 12 2 ...
$ Education_Level            : chr  "Master's" "PhD" "High School" "PhD" ...
$ AI_Exposure_Index          : num  0.18 0.62 0.86 0.39 0.52 0.29 0.67 0.2 0.3 0.01 ...
$ Tech_Growth_Factor         : num  1.28 1.11 1.18 0.68 1.46 0.51 1.09 1.4 0.61 1.01 ...
$ Automation_Probability_2030: num  0.85 0.05 0.81 0.6 0.64 0.1 0.41 0.17 0.48 0.8 ...
$ Risk_Category              : chr  "High" "Low" "High" "Medium" ...
$ Skill_1                    : num  0.45 0.02 0.01 0.43 0.75 0.71 0.56 0.56 0.22 0.22 ...
$ Skill_2                    : num  0.1 0.52 0.94 0.21 0.54 0.79 0.38 0.7 0.42 0.12 ...
$ Skill_3                    : num  0.46 0.4 0.56 0.57 0.59 0.61 0.97 0.14 0.88 0.34 ...
$ Skill_4                    : num  0.33 0.05 0.39 0.03 0.97 0.93 0.85 0.6 0.32 0.94 ...
$ Skill_5                    : num  0.14 0.97 0.02 0.84 0.61 0.65 0.72 0.54 0.12 0.32 ...
$ Skill_6                    : num  0.65 0.23 0.23 0.45 0.28 0.91 0.24 0.2 0.36 0.52 ...
$ Skill_7                    : num  0.06 0.09 0.24 0.4 0.3 0.85 0.26 0.94 0.91 0.7 ...
$ Skill_8                    : num  0.72 0.62 0.68 0.93 0.17 0.45 0.04 0.6 0.27 0.36 ...
$ Skill_9                    : num  0.94 0.38 0.61 0.73 0.02 0.1 0.71 0.69 0.65 0.97 ...
$ Skill_10                   : num  0 0.98 0.83 0.33 0.42 0.37 0.11 0.88 0 0.96 ...
> summary(job_title)
Job_Title         Average_Salary   Years_Experience Education_Level   
Length:3000        Min.   : 30030   Min.   : 0.00    Length:3000       
Class :character   1st Qu.: 58640   1st Qu.: 7.00    Class :character  
Mode  :character   Median : 89318   Median :15.00    Mode  :character  
Mean   : 89372   Mean   :14.68                      
3rd Qu.:119087   3rd Qu.:22.00                      
Max.   :149798   Max.   :29.00                      
AI_Exposure_Index Tech_Growth_Factor Automation_Probability_2030
Min.   :0.0000    Min.   :0.5000     Min.   :0.0500             
1st Qu.:0.2600    1st Qu.:0.7400     1st Qu.:0.3100             
Median :0.5000    Median :1.0000     Median :0.5000             
Mean   :0.5013    Mean   :0.9953     Mean   :0.5015             
3rd Qu.:0.7400    3rd Qu.:1.2400     3rd Qu.:0.7000             
Max.   :1.0000    Max.   :1.5000     Max.   :0.9500             
Risk_Category         Skill_1         Skill_2          Skill_3      
Length:3000        Min.   :0.000   Min.   :0.0000   Min.   :0.0000  
Class :character   1st Qu.:0.240   1st Qu.:0.2500   1st Qu.:0.2500  
Mode  :character   Median :0.505   Median :0.5000   Median :0.5000  
Mean   :0.497   Mean   :0.4972   Mean   :0.4993  
3rd Qu.:0.740   3rd Qu.:0.7400   3rd Qu.:0.7500  
Max.   :1.000   Max.   :1.0000   Max.   :1.0000  
Skill_4          Skill_5          Skill_6          Skill_7      
Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
1st Qu.:0.2600   1st Qu.:0.2400   1st Qu.:0.2600   1st Qu.:0.2500  
Median :0.5100   Median :0.4900   Median :0.5000   Median :0.4900  
Mean   :0.5037   Mean   :0.4903   Mean   :0.4998   Mean   :0.4992  
3rd Qu.:0.7500   3rd Qu.:0.7300   3rd Qu.:0.7400   3rd Qu.:0.7500  
Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
Skill_8          Skill_9          Skill_10     
Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
1st Qu.:0.2500   1st Qu.:0.2600   1st Qu.:0.2500  
Median :0.5000   Median :0.5000   Median :0.4900  
Mean   :0.5028   Mean   :0.5014   Mean   :0.4936  
3rd Qu.:0.7500   3rd Qu.:0.7400   3rd Qu.:0.7400  
Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
> names(job_title)
[1] "Job_Title"                   "Average_Salary"             
[3] "Years_Experience"            "Education_Level"            
[5] "AI_Exposure_Index"           "Tech_Growth_Factor"         
[7] "Automation_Probability_2030" "Risk_Category"              
[9] "Skill_1"                     "Skill_2"                    
[11] "Skill_3"                     "Skill_4"                    
[13] "Skill_5"                     "Skill_6"                    
[15] "Skill_7"                     "Skill_8"                    
[17] "Skill_9"                     "Skill_10"                   
> cat("Column Names: ", names(job_title), "\n")
Column Names:  Job_Title Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor Automation_Probability_2030 Risk_Category Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8 Skill_9 Skill_10 
> describe(job_title)
Error in describe(job_title) : could not find function "describe"

> library(psych)
> 
  > describe(job_title)
vars    n     mean       sd   median  trimmed      mad
Job_Title*                     1 3000    10.72     5.82    11.00    10.75     7.41
Average_Salary                 2 3000 89372.28 34608.09 89318.00 89284.71 44853.10
Years_Experience               3 3000    14.68     8.74    15.00    14.70    11.86
Education_Level*               4 3000     2.47     1.11     2.00     2.46     1.48
AI_Exposure_Index              5 3000     0.50     0.28     0.50     0.50     0.36
Tech_Growth_Factor             6 3000     1.00     0.29     1.00     1.00     0.37
Automation_Probability_2030    7 3000     0.50     0.25     0.50     0.50     0.30
Risk_Category*                 8 3000     2.26     0.83     3.00     2.33     0.00
Skill_1                        9 3000     0.50     0.29     0.50     0.50     0.36
Skill_2                       10 3000     0.50     0.29     0.50     0.50     0.36
Skill_3                       11 3000     0.50     0.29     0.50     0.50     0.37
Skill_4                       12 3000     0.50     0.29     0.51     0.50     0.36
Skill_5                       13 3000     0.49     0.29     0.49     0.49     0.36
Skill_6                       14 3000     0.50     0.29     0.50     0.50     0.36
Skill_7                       15 3000     0.50     0.29     0.49     0.50     0.37
Skill_8                       16 3000     0.50     0.29     0.50     0.50     0.37
Skill_9                       17 3000     0.50     0.29     0.50     0.50     0.36
Skill_10                      18 3000     0.49     0.29     0.49     0.49     0.36
min       max    range  skew kurtosis     se
Job_Title*                      1.00     20.00     19.0 -0.04    -1.24   0.11
Average_Salary              30030.00 149798.00 119768.0  0.01    -1.22 631.85
Years_Experience                0.00     29.00     29.0 -0.01    -1.22   0.16
Education_Level*                1.00      4.00      3.0  0.05    -1.34   0.02
AI_Exposure_Index               0.00      1.00      1.0 -0.02    -1.15   0.01
Tech_Growth_Factor              0.50      1.50      1.0 -0.01    -1.19   0.01
Automation_Probability_2030     0.05      0.95      0.9  0.01    -1.05   0.00
Risk_Category*                  1.00      3.00      2.0 -0.52    -1.35   0.02
Skill_1                         0.00      1.00      1.0  0.01    -1.19   0.01
Skill_2                         0.00      1.00      1.0  0.00    -1.18   0.01
Skill_3                         0.00      1.00      1.0  0.01    -1.20   0.01
Skill_4                         0.00      1.00      1.0 -0.02    -1.19   0.01
Skill_5                         0.00      1.00      1.0  0.05    -1.18   0.01
Skill_6                         0.00      1.00      1.0 -0.02    -1.18   0.01
Skill_7                         0.00      1.00      1.0  0.02    -1.21   0.01
Skill_8                         0.00      1.00      1.0  0.00    -1.19   0.01
Skill_9                         0.00      1.00      1.0  0.00    -1.18   0.01
Skill_10                        0.00      1.00      1.0  0.00    -1.18   0.01
> 'describe()' provides: n, mean, sd, median, trimmed mean, mad, min, max, range, skew, kurtosis, and se.
Error: unexpected symbol in "'describe()' provides"

> library(psych)
> 'describe()' provides: n, mean, sd, median, trimmed mean, mad, min, max, range, skew, kurtosis, and se.
Error: unexpected symbol in "'describe()' provides"

> describe(job_title)
vars    n     mean       sd   median  trimmed      mad
Job_Title*                     1 3000    10.72     5.82    11.00    10.75     7.41
Average_Salary                 2 3000 89372.28 34608.09 89318.00 89284.71 44853.10
Years_Experience               3 3000    14.68     8.74    15.00    14.70    11.86
Education_Level*               4 3000     2.47     1.11     2.00     2.46     1.48
AI_Exposure_Index              5 3000     0.50     0.28     0.50     0.50     0.36
Tech_Growth_Factor             6 3000     1.00     0.29     1.00     1.00     0.37
Automation_Probability_2030    7 3000     0.50     0.25     0.50     0.50     0.30
Risk_Category*                 8 3000     2.26     0.83     3.00     2.33     0.00
Skill_1                        9 3000     0.50     0.29     0.50     0.50     0.36
Skill_2                       10 3000     0.50     0.29     0.50     0.50     0.36
Skill_3                       11 3000     0.50     0.29     0.50     0.50     0.37
Skill_4                       12 3000     0.50     0.29     0.51     0.50     0.36
Skill_5                       13 3000     0.49     0.29     0.49     0.49     0.36
Skill_6                       14 3000     0.50     0.29     0.50     0.50     0.36
Skill_7                       15 3000     0.50     0.29     0.49     0.50     0.37
Skill_8                       16 3000     0.50     0.29     0.50     0.50     0.37
Skill_9                       17 3000     0.50     0.29     0.50     0.50     0.36
Skill_10                      18 3000     0.49     0.29     0.49     0.49     0.36
min       max    range  skew kurtosis     se
Job_Title*                      1.00     20.00     19.0 -0.04    -1.24   0.11
Average_Salary              30030.00 149798.00 119768.0  0.01    -1.22 631.85
Years_Experience                0.00     29.00     29.0 -0.01    -1.22   0.16
Education_Level*                1.00      4.00      3.0  0.05    -1.34   0.02
AI_Exposure_Index               0.00      1.00      1.0 -0.02    -1.15   0.01
Tech_Growth_Factor              0.50      1.50      1.0 -0.01    -1.19   0.01
Automation_Probability_2030     0.05      0.95      0.9  0.01    -1.05   0.00
Risk_Category*                  1.00      3.00      2.0 -0.52    -1.35   0.02
Skill_1                         0.00      1.00      1.0  0.01    -1.19   0.01
Skill_2                         0.00      1.00      1.0  0.00    -1.18   0.01
Skill_3                         0.00      1.00      1.0  0.01    -1.20   0.01
Skill_4                         0.00      1.00      1.0 -0.02    -1.19   0.01
Skill_5                         0.00      1.00      1.0  0.05    -1.18   0.01
Skill_6                         0.00      1.00      1.0 -0.02    -1.18   0.01
Skill_7                         0.00      1.00      1.0  0.02    -1.21   0.01
Skill_8                         0.00      1.00      1.0  0.00    -1.19   0.01
Skill_9                         0.00      1.00      1.0  0.00    -1.18   0.01
Skill_10                        0.00      1.00      1.0  0.00    -1.18   0.01
> install.packages("dplyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
  
  https://cran.rstudio.com/bin/windows/Rtools/
  Installing package into ‘C:/Users/Purvi/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
also installing the dependency ‘generics’
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/generics_0.1.4.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/dplyr_1.1.4.zip'
package ‘generics’ successfully unpacked and MD5 sums checked
package ‘dplyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
C:\Users\Purvi\AppData\Local\Temp\Rtmp8YgrlI\downloaded_packages
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:
  
  filter, lag

The following objects are masked from ‘package:base’:
  
  intersect, setdiff, setequal, union
> library(readr)
> job_title <- read_csv("AI_Impact_on_Jobs_2030.csv")
Rows: 3000 Columns: 18                                                                                            
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (3): Job_Title, Education_Level, Risk_Category
dbl (15): Average_Salary, Years_Experience, AI_Exposure_Index, Tech_Growth_Factor, Automation_Probability_2030...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> head(job_title)
# A tibble: 6 × 18
Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
<chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
  1 Security Guard               45795               28 Master's                     0.18               1.28
2 Research Scientist          133355               20 PhD                          0.62               1.11
3 Construction Worker         146216                2 High School                  0.86               1.18
4 Software Engineer           136530               13 PhD                          0.39               0.68
5 Financial Analyst            70397               22 High School                  0.52               1.46
6 AI Engineer                  92592               11 Master's                     0.29               0.51
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> # Example 1: High Salary (> 100,000)
  > high_salary_subset <- subset(job_title, Average_Salary > 100000)
> cat("Number of high-salary jobs (> 100,000):", nrow(high_salary_subset), "\n")
Number of high-salary jobs (> 100,000): 1247 
> summary(high_salary_subset$Average_Salary)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
100014  112144  124845  124456  136712  149798 
> # Example 2: High Salary (> 100,000) AND Senior Experience (> 20 years)
  > low_crime_high_value_subset <- subset(job_title, Average_Salary > 100000 & Years_Experience > 20)
> cat("Number of high-salary, senior jobs:", nrow(low_crime_high_value_subset), "\n")
Number of high-salary, senior jobs: 400 
> head(low_crime_high_value_subset)
# A tibble: 6 × 18
Job_Title         Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
<chr>                      <dbl>            <dbl> <chr>                       <dbl>              <dbl>
  1 Mechanic                  107373               23 PhD                          0.67               1.09
2 Financial Analyst         117455               22 High School                  0.67               1.26
3 Graphic Designer          111317               27 PhD                          0.98               1.11
4 Doctor                    144825               23 Bachelor's                   0.84               1.27
5 Customer Support          109714               28 PhD                          0.99               1.04
6 Financial Analyst         132547               21 PhD                          0.86               1.04
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> # Example 3: High Risk OR Low Experience (< 5 years)
> special_jobs_subset <- subset(job_title, Risk_Category == "High" | Years_Experience < 5)
> cat("Number of high-risk or low-experience jobs:", nrow(special_jobs_subset), "\n")
Number of high-risk or low-experience jobs: 1109 
> head(special_jobs_subset)
# A tibble: 6 × 18
  Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 Security Guard               45795               28 Master's                     0.18               1.28
2 Construction Worker         146216                2 High School                  0.86               1.18
3 Customer Support             85016                2 High School                  0.01               1.01
4 Graphic Designer             32869                2 High School                  0.65               0.72
5 Retail Worker               148015                2 PhD                          0.17               1.06
6 AI Engineer                  43403                1 High School                  0.09               1.08
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> # dplyr filter() examples
  > # Example 1: Low Automation Risk (< 0.2)
  > low_automation_filter <- job_title |>
  +     filter(Automation_Probability_2030 < 0.2)
> cat("Number of jobs with low automation risk (< 0.2):", nrow(low_automation_filter), "\n")
Number of jobs with low automation risk (< 0.2): 432 
> summary(low_automation_filter$Automation_Probability_2030)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.0500  0.0900  0.1200  0.1237  0.1600  0.1900 
> # Example 2: Not Low Risk AND High AI Exposure (> 0.8)
  > high_aiexp_not_lowrisk_filter <- job_title |>
  +     filter(Risk_Category != "Low", AI_Exposure_Index > 0.8)
> 
  > cat("Number of non-Low Risk, high AI exposure jobs:", nrow(high_aiexp_not_lowrisk_filter), "\n")
Number of non-Low Risk, high AI exposure jobs: 417 
> head(high_aiexp_not_lowrisk_filter)
# A tibble: 6 × 18
Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
<chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
  1 Construction Worker         146216                2 High School                  0.86               1.18
2 Mechanic                     68304                7 Master's                     0.91               0.7 
3 HR Specialist                89031               22 Master's                     0.93               1.36
4 Retail Worker                69081                8 High School                  0.82               1.21
5 Mechanic                     64349                2 Bachelor's                   0.82               1.45
6 Chef                         53524               20 PhD                          0.94               1.35
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> # Example 3: Specific Experience Years (10, 15, or 20 years)
> rad_10_15_20_filter <- job_title |>
+     filter(Years_Experience %in% c(10, 15, 20))
> 
> cat("Number of jobs with 10, 15, or 20 years experience:", nrow(rad_10_15_20_filter), "\n")
Number of jobs with 10, 15, or 20 years experience: 290 
> table(rad_10_15_20_filter$Years_Experience)

 10  15  20 
102  98  90 
> # View the first few rows
> head(job_title)
# A tibble: 6 × 18
  Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 Security Guard               45795               28 Master's                     0.18               1.28
2 Research Scientist          133355               20 PhD                          0.62               1.11
3 Construction Worker         146216                2 High School                  0.86               1.18
4 Software Engineer           136530               13 PhD                          0.39               0.68
5 Financial Analyst            70397               22 High School                  0.52               1.46
6 AI Engineer                  92592               11 Master's                     0.29               0.51
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # View the last few rows
> tail(job_title)
# A tibble: 6 × 18
  Job_Title        Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                     <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 Mechanic                  86686               18 High School                  0.91               0.83
2 Doctor                   111319                6 Bachelor's                   0.24               1.18
3 UX Researcher             44363               29 PhD                          0.65               0.74
4 Data Scientist            61325               23 Master's                     0.64               0.94
5 Graphic Designer         110296                7 PhD                          0.95               1.23
6 Graphic Designer         123909               25 PhD                          0.69               0.56
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Get the dimensions (rows and columns)
> dim(job_title)
[1] 3000   18
> 
> # Get the structure (variable types and number of observations)
> str(job_title)
spc_tbl_ [3,000 × 18] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ Job_Title                  : chr [1:3000] "Security Guard" "Research Scientist" "Construction Worker" "Software Engineer" ...
 $ Average_Salary             : num [1:3000] 45795 133355 146216 136530 70397 ...
 $ Years_Experience           : num [1:3000] 28 20 2 13 22 11 23 12 12 2 ...
 $ Education_Level            : chr [1:3000] "Master's" "PhD" "High School" "PhD" ...
 $ AI_Exposure_Index          : num [1:3000] 0.18 0.62 0.86 0.39 0.52 0.29 0.67 0.2 0.3 0.01 ...
 $ Tech_Growth_Factor         : num [1:3000] 1.28 1.11 1.18 0.68 1.46 0.51 1.09 1.4 0.61 1.01 ...
 $ Automation_Probability_2030: num [1:3000] 0.85 0.05 0.81 0.6 0.64 0.1 0.41 0.17 0.48 0.8 ...
 $ Risk_Category              : chr [1:3000] "High" "Low" "High" "Medium" ...
 $ Skill_1                    : num [1:3000] 0.45 0.02 0.01 0.43 0.75 0.71 0.56 0.56 0.22 0.22 ...
 $ Skill_2                    : num [1:3000] 0.1 0.52 0.94 0.21 0.54 0.79 0.38 0.7 0.42 0.12 ...
 $ Skill_3                    : num [1:3000] 0.46 0.4 0.56 0.57 0.59 0.61 0.97 0.14 0.88 0.34 ...
 $ Skill_4                    : num [1:3000] 0.33 0.05 0.39 0.03 0.97 0.93 0.85 0.6 0.32 0.94 ...
 $ Skill_5                    : num [1:3000] 0.14 0.97 0.02 0.84 0.61 0.65 0.72 0.54 0.12 0.32 ...
 $ Skill_6                    : num [1:3000] 0.65 0.23 0.23 0.45 0.28 0.91 0.24 0.2 0.36 0.52 ...
 $ Skill_7                    : num [1:3000] 0.06 0.09 0.24 0.4 0.3 0.85 0.26 0.94 0.91 0.7 ...
 $ Skill_8                    : num [1:3000] 0.72 0.62 0.68 0.93 0.17 0.45 0.04 0.6 0.27 0.36 ...
 $ Skill_9                    : num [1:3000] 0.94 0.38 0.61 0.73 0.02 0.1 0.71 0.69 0.65 0.97 ...
 $ Skill_10                   : num [1:3000] 0 0.98 0.83 0.33 0.42 0.37 0.11 0.88 0 0.96 ...
 - attr(*, "spec")=
  .. cols(
  ..   Job_Title = col_character(),
  ..   Average_Salary = col_double(),
  ..   Years_Experience = col_double(),
  ..   Education_Level = col_character(),
  ..   AI_Exposure_Index = col_double(),
  ..   Tech_Growth_Factor = col_double(),
  ..   Automation_Probability_2030 = col_double(),
  ..   Risk_Category = col_character(),
  ..   Skill_1 = col_double(),
  ..   Skill_2 = col_double(),
  ..   Skill_3 = col_double(),
  ..   Skill_4 = col_double(),
  ..   Skill_5 = col_double(),
  ..   Skill_6 = col_double(),
  ..   Skill_7 = col_double(),
  ..   Skill_8 = col_double(),
  ..   Skill_9 = col_double(),
  ..   Skill_10 = col_double()
  .. )
 - attr(*, "problems")=<externalptr> 
> 
> # See a summary of the dataset
> summary(job_title)
  Job_Title         Average_Salary   Years_Experience Education_Level    AI_Exposure_Index Tech_Growth_Factor
 Length:3000        Min.   : 30030   Min.   : 0.00    Length:3000        Min.   :0.0000    Min.   :0.5000    
 Class :character   1st Qu.: 58640   1st Qu.: 7.00    Class :character   1st Qu.:0.2600    1st Qu.:0.7400    
 Mode  :character   Median : 89318   Median :15.00    Mode  :character   Median :0.5000    Median :1.0000    
                    Mean   : 89372   Mean   :14.68                       Mean   :0.5013    Mean   :0.9953    
                    3rd Qu.:119087   3rd Qu.:22.00                       3rd Qu.:0.7400    3rd Qu.:1.2400    
                    Max.   :149798   Max.   :29.00                       Max.   :1.0000    Max.   :1.5000    
 Automation_Probability_2030 Risk_Category         Skill_1         Skill_2          Skill_3      
 Min.   :0.0500              Length:3000        Min.   :0.000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.3100              Class :character   1st Qu.:0.240   1st Qu.:0.2500   1st Qu.:0.2500  
 Median :0.5000              Mode  :character   Median :0.505   Median :0.5000   Median :0.5000  
 Mean   :0.5015                                 Mean   :0.497   Mean   :0.4972   Mean   :0.4993  
 3rd Qu.:0.7000                                 3rd Qu.:0.740   3rd Qu.:0.7400   3rd Qu.:0.7500  
 Max.   :0.9500                                 Max.   :1.000   Max.   :1.0000   Max.   :1.0000  
    Skill_4          Skill_5          Skill_6          Skill_7          Skill_8          Skill_9      
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.2600   1st Qu.:0.2400   1st Qu.:0.2600   1st Qu.:0.2500   1st Qu.:0.2500   1st Qu.:0.2600  
 Median :0.5100   Median :0.4900   Median :0.5000   Median :0.4900   Median :0.5000   Median :0.5000  
 Mean   :0.5037   Mean   :0.4903   Mean   :0.4998   Mean   :0.4992   Mean   :0.5028   Mean   :0.5014  
 3rd Qu.:0.7500   3rd Qu.:0.7300   3rd Qu.:0.7400   3rd Qu.:0.7500   3rd Qu.:0.7500   3rd Qu.:0.7400  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
    Skill_10     
 Min.   :0.0000  
 1st Qu.:0.2500  
 Median :0.4900  
 Mean   :0.4936  
 3rd Qu.:0.7400  
 Max.   :1.0000  
> 
> # Get the column names
> names(job_title)
 [1] "Job_Title"                   "Average_Salary"              "Years_Experience"           
 [4] "Education_Level"             "AI_Exposure_Index"           "Tech_Growth_Factor"         
 [7] "Automation_Probability_2030" "Risk_Category"               "Skill_1"                    
[10] "Skill_2"                     "Skill_3"                     "Skill_4"                    
[13] "Skill_5"                     "Skill_6"                     "Skill_7"                    
[16] "Skill_8"                     "Skill_9"                     "Skill_10"                   
> 
> # Use the 'psych' package for more detailed descriptive statistics
> describe(job_title)
                            vars    n     mean       sd   median  trimmed      mad      min       max    range
Job_Title*                     1 3000    10.72     5.82    11.00    10.75     7.41     1.00     20.00     19.0
Average_Salary                 2 3000 89372.28 34608.09 89318.00 89284.71 44853.10 30030.00 149798.00 119768.0
Years_Experience               3 3000    14.68     8.74    15.00    14.70    11.86     0.00     29.00     29.0
Education_Level*               4 3000     2.47     1.11     2.00     2.46     1.48     1.00      4.00      3.0
AI_Exposure_Index              5 3000     0.50     0.28     0.50     0.50     0.36     0.00      1.00      1.0
Tech_Growth_Factor             6 3000     1.00     0.29     1.00     1.00     0.37     0.50      1.50      1.0
Automation_Probability_2030    7 3000     0.50     0.25     0.50     0.50     0.30     0.05      0.95      0.9
Risk_Category*                 8 3000     2.26     0.83     3.00     2.33     0.00     1.00      3.00      2.0
Skill_1                        9 3000     0.50     0.29     0.50     0.50     0.36     0.00      1.00      1.0
Skill_2                       10 3000     0.50     0.29     0.50     0.50     0.36     0.00      1.00      1.0
Skill_3                       11 3000     0.50     0.29     0.50     0.50     0.37     0.00      1.00      1.0
Skill_4                       12 3000     0.50     0.29     0.51     0.50     0.36     0.00      1.00      1.0
Skill_5                       13 3000     0.49     0.29     0.49     0.49     0.36     0.00      1.00      1.0
Skill_6                       14 3000     0.50     0.29     0.50     0.50     0.36     0.00      1.00      1.0
Skill_7                       15 3000     0.50     0.29     0.49     0.50     0.37     0.00      1.00      1.0
Skill_8                       16 3000     0.50     0.29     0.50     0.50     0.37     0.00      1.00      1.0
Skill_9                       17 3000     0.50     0.29     0.50     0.50     0.36     0.00      1.00      1.0
Skill_10                      18 3000     0.49     0.29     0.49     0.49     0.36     0.00      1.00      1.0
                             skew kurtosis     se
Job_Title*                  -0.04    -1.24   0.11
Average_Salary               0.01    -1.22 631.85
Years_Experience            -0.01    -1.22   0.16
Education_Level*             0.05    -1.34   0.02
AI_Exposure_Index           -0.02    -1.15   0.01
Tech_Growth_Factor          -0.01    -1.19   0.01
Automation_Probability_2030  0.01    -1.05   0.00
Risk_Category*              -0.52    -1.35   0.02
Skill_1                      0.01    -1.19   0.01
Skill_2                      0.00    -1.18   0.01
Skill_3                      0.01    -1.20   0.01
Skill_4                     -0.02    -1.19   0.01
Skill_5                      0.05    -1.18   0.01
Skill_6                     -0.02    -1.18   0.01
Skill_7                      0.02    -1.21   0.01
Skill_8                      0.00    -1.19   0.01
Skill_9                      0.00    -1.18   0.01
Skill_10                     0.00    -1.18   0.01
> # Load the dplyr package
> library(dplyr)
> library(readr)
> # We need the 'dplyr' package for the 'arrange' function!
> library(dplyr)
> library(readr) 
> 
> # Just making sure we're using our AI Jobs data!
> job_title <- read_csv("AI_Impact_on_Jobs_2030.csv")
Rows: 3000 Columns: 18                                                                                            
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (3): Job_Title, Education_Level, Risk_Category
dbl (15): Average_Salary, Years_Experience, AI_Exposure_Index, Tech_Growth_Factor, Automation_Probability_2030...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> 
> # Remember, 'arrange' sorts smallest-to-largest by default.
> 
> # Example 1: Find the lowest paying jobs by sorting salary.
> # Sort salary from lowest to highest (ascending).
> job_title_sorted_salary <- job_title |>
+     arrange(Average_Salary)
> 
> # Check the top 5 to see the lowest salaries.
> head(job_title_sorted_salary, 5)
# A tibble: 5 × 18
  Job_Title         Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                      <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 AI Engineer                30030                0 Master's                     0.44               1.45
2 HR Specialist              30030                9 Bachelor's                   0.25               0.88
3 Marketing Manager          30060               10 PhD                          0.6                0.96
4 AI Engineer                30077               25 High School                  0.91               0.82
5 Chef                       30125               14 PhD                          0.8                1.27
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 2: Which jobs face the highest automation risk?
> # Sort automation probability from highest to lowest using desc().
> job_title_sorted_auto_desc <- job_title |>
+     arrange(desc(Automation_Probability_2030))
> 
> # The top 5 should show the highest automation probabilities.
> head(job_title_sorted_auto_desc, 5)
# A tibble: 5 × 18
  Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 Retail Worker                58602               19 High School                  0.4                0.77
2 Security Guard              109557               24 Bachelor's                   0.28               0.9 
3 Security Guard              103251                9 PhD                          0.08               0.96
4 Construction Worker          47013               16 High School                  0.7                0.63
5 Customer Support             50746               12 Master's                     0.95               0.87
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 3: Combine two criteria for a detailed sort.
> # 1. Primary Sort: Alphabetical Risk Category (High, Low, Medium).
> # 2. Secondary Sort: Highest salary first within each risk category.
> job_title_multi_sort <- job_title |>
+     arrange(Risk_Category, desc(Average_Salary))
> 
> # Check the top 10 rows to see the mixed results.
> head(job_title_multi_sort, 10)
# A tibble: 10 × 18
   Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
   <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
 1 Customer Support            149798                7 PhD                          0.89               1.15
 2 Security Guard              149554                3 High School                  0.26               1.29
 3 Construction Worker         149107               24 Master's                     0.34               0.61
 4 Security Guard              149052                1 Bachelor's                   0.17               1.38
 5 Construction Worker         148821               24 Master's                     0.62               1.26
 6 Customer Support            148764                1 High School                  0.93               0.62
 7 Truck Driver                148623               11 Bachelor's                   0.35               0.94
 8 Retail Worker               148360                1 High School                  0.18               0.84
 9 Retail Worker               148015                2 PhD                          0.17               1.06
10 Security Guard              147600                8 Master's                     0.19               0.92
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 4: The power move - filter THEN sort!
> # Find senior employees (> 25 yrs) and sort them by the lowest Tech Growth Factor.
> high_exp_by_tech_growth <- job_title |>
+     filter(Years_Experience > 25) |>
+     arrange(Tech_Growth_Factor)
> 
> cat("Here are the Top 5 senior jobs with the lowest tech growth impact:\n")
Here are the Top 5 senior jobs with the lowest tech growth impact:
> # Select just the relevant columns to confirm the sort order.
> print(high_exp_by_tech_growth |> select(Years_Experience, Tech_Growth_Factor, Average_Salary) |> head(5))
# A tibble: 5 × 3
  Years_Experience Tech_Growth_Factor Average_Salary
             <dbl>              <dbl>          <dbl>
1               27               0.5           43785
2               28               0.51         117527
3               27               0.51          72875
4               28               0.51          68842
5               29               0.51         146585
> # We need the 'dplyr' package for the 'arrange' function!
> library(dplyr)
> library(readr) 
> 
> # Just making sure we're using our AI Jobs data!
> job_title <- read_csv("AI_Impact_on_Jobs_2030.csv")
Rows: 3000 Columns: 18                                                                                            
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (3): Job_Title, Education_Level, Risk_Category
dbl (15): Average_Salary, Years_Experience, AI_Exposure_Index, Tech_Growth_Factor, Automation_Probability_2030...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> 
> # Remember, 'arrange' sorts smallest-to-largest by default.
> 
> # Example 1: Find the lowest paying jobs by sorting salary.
> # Sort salary from lowest to highest (ascending).
> job_title_sorted_salary <- job_title |>
+     arrange(Average_Salary)
> 
> # Check the top 5 to see the lowest salaries.
> head(job_title_sorted_salary, 5)
# A tibble: 5 × 18
  Job_Title         Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                      <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 AI Engineer                30030                0 Master's                     0.44               1.45
2 HR Specialist              30030                9 Bachelor's                   0.25               0.88
3 Marketing Manager          30060               10 PhD                          0.6                0.96
4 AI Engineer                30077               25 High School                  0.91               0.82
5 Chef                       30125               14 PhD                          0.8                1.27
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 2: Which jobs face the highest automation risk?
> # Sort automation probability from highest to lowest using desc().
> job_title_sorted_auto_desc <- job_title |>
+     arrange(desc(Automation_Probability_2030))
> 
> # The top 5 should show the highest automation probabilities.
> head(job_title_sorted_auto_desc, 5)
# A tibble: 5 × 18
  Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
  <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
1 Retail Worker                58602               19 High School                  0.4                0.77
2 Security Guard              109557               24 Bachelor's                   0.28               0.9 
3 Security Guard              103251                9 PhD                          0.08               0.96
4 Construction Worker          47013               16 High School                  0.7                0.63
5 Customer Support             50746               12 Master's                     0.95               0.87
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 3: Combine two criteria for a detailed sort.
> # 1. Primary Sort: Alphabetical Risk Category (High, Low, Medium).
> # 2. Secondary Sort: Highest salary first within each risk category.
> job_title_multi_sort <- job_title |>
+     arrange(Risk_Category, desc(Average_Salary))
> 
> # Check the top 10 rows to see the mixed results.
> head(job_title_multi_sort, 10)
# A tibble: 10 × 18
   Job_Title           Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
   <chr>                        <dbl>            <dbl> <chr>                       <dbl>              <dbl>
 1 Customer Support            149798                7 PhD                          0.89               1.15
 2 Security Guard              149554                3 High School                  0.26               1.29
 3 Construction Worker         149107               24 Master's                     0.34               0.61
 4 Security Guard              149052                1 Bachelor's                   0.17               1.38
 5 Construction Worker         148821               24 Master's                     0.62               1.26
 6 Customer Support            148764                1 High School                  0.93               0.62
 7 Truck Driver                148623               11 Bachelor's                   0.35               0.94
 8 Retail Worker               148360                1 High School                  0.18               0.84
 9 Retail Worker               148015                2 PhD                          0.17               1.06
10 Security Guard              147600                8 Master's                     0.19               0.92
# ℹ 12 more variables: Automation_Probability_2030 <dbl>, Risk_Category <chr>, Skill_1 <dbl>, Skill_2 <dbl>,
#   Skill_3 <dbl>, Skill_4 <dbl>, Skill_5 <dbl>, Skill_6 <dbl>, Skill_7 <dbl>, Skill_8 <dbl>, Skill_9 <dbl>,
#   Skill_10 <dbl>
> 
> # Example 4: The power move - filter THEN sort!
> # Find senior employees (> 25 yrs) and sort them by the lowest Tech Growth Factor.
> high_exp_by_tech_growth <- job_title |>
+     filter(Years_Experience > 25) |>
+     arrange(Tech_Growth_Factor)
> 
> cat("Here are the Top 5 senior jobs with the lowest tech growth impact:\n")
Here are the Top 5 senior jobs with the lowest tech growth impact:
> # Select just the relevant columns to confirm the sort order.
> print(high_exp_by_tech_growth |> select(Years_Experience, Tech_Growth_Factor, Average_Salary) |> head(5))
# A tibble: 5 × 3
  Years_Experience Tech_Growth_Factor Average_Salary
             <dbl>              <dbl>          <dbl>
1               27               0.5           43785
2               28               0.51         117527
3               27               0.51          72875
4               28               0.51          68842
5               29               0.51         146585
> fdsports <- read.table("~/fdsports.txt", header=TRUE, quote="\"")
Error in read.table("~/fdsports.txt", header = TRUE, quote = "\"") : 
  more columns than column names
In addition: Warning messages:
  1: In grep("^[^#].*", lines, value = TRUE) :
  unable to translate '"6 In the FITT principle, <93>F<94> stands for: a) Flexibility b) Frequency c) Force d) Fitness b) Frequency CO2"' to a wide string
2: In grep("^[^#].*", lines, value = TRUE) : input string 7 is invalid
3: In grep("^[^#].*", lines, value = TRUE) :
  unable to translate '7 <93>Tedium<94> in sports training refers to: a) Overtraining b) Monotony or boredom c) Fatigue d) Injury b) Monotony or boredom CO2' to a wide string
4: In grep("^[^#].*", lines, value = TRUE) : input string 8 is invalid
5: In grep("^[^#].*", lines, value = TRUE) :
  unable to translate '"13 Reversibility principle is also called: a) <93>Use it or lose it<94> principle b) <93>Train hard, rest easy<94> principle c) <93>Specificity<94> principle d) <93>Progression<94> principle a) <93>Use it or lose it<94> principle CO2"' to a wide string
6: In grep("^[^#].*", lines, value = TRUE) : input string 14 is invalid

> library(readr)
> fdsports <- read_csv("~/fdsports.txt")
Rows: 113 Columns: 1                                                                                              
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr (1): Q. No Question Options Answer CO

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(fdsports)
> library(readr)
> AI_Impact_on_Jobs_2030 <- read_csv("AI_Impact_on_Jobs_2030.csv")
Rows: 3000 Columns: 18                                                                                            
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (3): Job_Title, Education_Level, Risk_Category
dbl (15): Average_Salary, Years_Experience, AI_Exposure_Index, Tech_Growth_Factor, Automation_Probability_2030...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(AI_Impact_on_Jobs_2030)
> library(readr)
> AI_Impact_on_Jobs_2030 <- read_csv("C:/AI_Impact_on_Jobs_2030.xls")
Rows: 3000 Columns: 18                                                                                            
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (3): Job_Title, Education_Level, Risk_Category
dbl (15): Average_Salary, Years_Experience, AI_Exposure_Index, Tech_Growth_Factor, Automation_Probability_2030...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(AI_Impact_on_Jobs_2030)
> git init
Error: unexpected symbol in "git init"

> git remote add  origin https://github.com/karkerapurvics05/MyRProgramming-
  Error: unexpected symbol in "git remote"

> 
  > git init
Error: unexpected symbol in "git init"
