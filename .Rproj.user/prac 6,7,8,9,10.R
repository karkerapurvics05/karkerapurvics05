
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

> library(readxl)
> AI_Impact_on_Jobs_2030 <- read_excel("AI_Impact_on_Jobs_2030.csv")
Error: Can't establish that the input is either xls or xlsx.

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
> library(dplyr) # Load the library for bind_rows and data manipulation

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union
> 
> # ------------------------------------------
> # 1. SETUP: Load and Prepare the Dataset
> # ------------------------------------------
> # Load the main dataset
> data_main <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # We will work with a sample of unique job titles for cleaner demonstration
> # Taking the first 5 unique jobs:
> data_unique_jobs <- data_main %>%
+     distinct(Job_Title, .keep_all = TRUE) %>%
+     slice(1:5) 
> 
> print("--- Base Data Sample (First 5 Unique Jobs) ---")
[1] "--- Base Data Sample (First 5 Unique Jobs) ---"
> print(data_unique_jobs)
            Job_Title Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
1      Security Guard          45795               28        Master's              0.18               1.28
2  Research Scientist         133355               20             PhD              0.62               1.11
3 Construction Worker         146216                2     High School              0.86               1.18
4   Software Engineer         136530               13             PhD              0.39               0.68
5   Financial Analyst          70397               22     High School              0.52               1.46
  Automation_Probability_2030 Risk_Category Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8
1                        0.85          High    0.45    0.10    0.46    0.33    0.14    0.65    0.06    0.72
2                        0.05           Low    0.02    0.52    0.40    0.05    0.97    0.23    0.09    0.62
3                        0.81          High    0.01    0.94    0.56    0.39    0.02    0.23    0.24    0.68
4                        0.60        Medium    0.43    0.21    0.57    0.03    0.84    0.45    0.40    0.93
5                        0.64        Medium    0.75    0.54    0.59    0.97    0.61    0.28    0.30    0.17
  Skill_9 Skill_10
1    0.94     0.00
2    0.38     0.98
3    0.61     0.83
4    0.73     0.33
5    0.02     0.42
> cat("\n") 

> 
> # ------------------------------------------
> # 2. MERGE (Joining Columns)
> # ------------------------------------------
> # Scenario: Split job attributes and AI risk metrics into separate data frames
> # and then merge them back using a common key, 'Job_Title'.
> 
> # Dataset A: Job Information (Columns on one side)
> data_job_info <- data_unique_jobs %>%
+     select(Job_Title, Average_Salary, Years_Experience, Education_Level)
> 
> # Dataset B: AI Risk Information (Columns on the other side)
> data_ai_risk <- data_unique_jobs %>%
+     select(Job_Title, AI_Exposure_Index, Automation_Probability_2030, Risk_Category)
> 
> print("--- Data A: Job Info (Columns for Merge) ---")
[1] "--- Data A: Job Info (Columns for Merge) ---"
> print(data_job_info)
            Job_Title Average_Salary Years_Experience Education_Level
1      Security Guard          45795               28        Master's
2  Research Scientist         133355               20             PhD
3 Construction Worker         146216                2     High School
4   Software Engineer         136530               13             PhD
5   Financial Analyst          70397               22     High School
> cat("\n")

> 
> print("--- Data B: AI Risk (Columns for Merge) ---")
[1] "--- Data B: AI Risk (Columns for Merge) ---"
> print(data_ai_risk)
            Job_Title AI_Exposure_Index Automation_Probability_2030 Risk_Category
1      Security Guard              0.18                        0.85          High
2  Research Scientist              0.62                        0.05           Low
3 Construction Worker              0.86                        0.81          High
4   Software Engineer              0.39                        0.60        Medium
5   Financial Analyst              0.52                        0.64        Medium
> cat("\n")

> 
> # Perform the MERGE (Inner Join) on "Job_Title"
> merged_data <- merge(data_job_info, data_ai_risk, by = "Job_Title")
> 
> print("--- Merged Data (Columns Added from Data A and Data B) ---")
[1] "--- Merged Data (Columns Added from Data A and Data B) ---"
> print(merged_data)
            Job_Title Average_Salary Years_Experience Education_Level AI_Exposure_Index
1 Construction Worker         146216                2     High School              0.86
2   Financial Analyst          70397               22     High School              0.52
3  Research Scientist         133355               20             PhD              0.62
4      Security Guard          45795               28        Master's              0.18
5   Software Engineer         136530               13             PhD              0.39
  Automation_Probability_2030 Risk_Category
1                        0.81          High
2                        0.64        Medium
3                        0.05           Low
4                        0.85          High
5                        0.60        Medium
> cat("\n")

> 
> 
> # ------------------------------------------
> # 3. APPEND (Stacking Rows)
> # ------------------------------------------
> # Scenario: Take a small subset of the list and add new, synthetic job entries to it.
> 
> # Base List: First 3 jobs from the original list (selecting only a few columns)
> data_base_list <- data_main %>%
+     select(Job_Title, Average_Salary, Risk_Category) %>%
+     slice(1:3)
> 
> # New Jobs: Synthetic data with the *same column structure*
> data_new_jobs <- data.frame(
+     Job_Title = c("AI Ethicist", "Drone Pilot"),
+     Average_Salary = c(150000, 75000),
+     Risk_Category = c("Low", "Medium")
+ )
> 
> print("--- Data Base List (First 3 entries) ---")
[1] "--- Data Base List (First 3 entries) ---"
> print(data_base_list)
            Job_Title Average_Salary Risk_Category
1      Security Guard          45795          High
2  Research Scientist         133355           Low
3 Construction Worker         146216          High
> cat("\n")

> 
> print("--- Data New Jobs (For Appending) ---")
[1] "--- Data New Jobs (For Appending) ---"
> print(data_new_jobs)
    Job_Title Average_Salary Risk_Category
1 AI Ethicist         150000           Low
2 Drone Pilot          75000        Medium
> cat("\n")

> 
> # Perform the APPEND (Stacking Rows) using bind_rows
> # Note: bind_rows automatically matches column names.
> final_list <- bind_rows(data_base_list, data_new_jobs)
> 
> print("--- Appended Data (New Rows Added) ---")
[1] "--- Appended Data (New Rows Added) ---"
> print(final_list)
            Job_Title Average_Salary Risk_Category
1      Security Guard          45795          High
2  Research Scientist         133355           Low
3 Construction Worker         146216          High
4         AI Ethicist         150000           Low
5         Drone Pilot          75000        Medium
> 
> prac 7
Error: unexpected numeric constant in "prac 7"

> library(dplyr) # select() is part of the dplyr package
> 
> # ------------------------------------------------------------------------------
> # 1. IMPORT DATASET
> # ------------------------------------------------------------------------------
> 
> # Import the CSV file
> ai_jobs <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> print("--- Original Dataset (First 3 rows) ---")
[1] "--- Original Dataset (First 3 rows) ---"
> print(head(ai_jobs, 3))
            Job_Title Average_Salary Years_Experience Education_Level AI_Exposure_Index Tech_Growth_Factor
1      Security Guard          45795               28        Master's              0.18               1.28
2  Research Scientist         133355               20             PhD              0.62               1.11
3 Construction Worker         146216                2     High School              0.86               1.18
  Automation_Probability_2030 Risk_Category Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8
1                        0.85          High    0.45    0.10    0.46    0.33    0.14    0.65    0.06    0.72
2                        0.05           Low    0.02    0.52    0.40    0.05    0.97    0.23    0.09    0.62
3                        0.81          High    0.01    0.94    0.56    0.39    0.02    0.23    0.24    0.68
  Skill_9 Skill_10
1    0.94     0.00
2    0.38     0.98
3    0.61     0.83
> 
> # ------------------------------------------------------------------------------
> # 2. SELECTING VARIABLES (Keeping Columns)
> # ------------------------------------------------------------------------------
> 
> # Method A: Select specific columns by name
> # Scenario: We only want the job title, salary, and final risk category
> selected_cols <- ai_jobs %>%
+     select(Job_Title, Average_Salary, Risk_Category)
> 
> print("--- Selected Specific Columns (Job_Title, Average_Salary, Risk_Category) ---")
[1] "--- Selected Specific Columns (Job_Title, Average_Salary, Risk_Category) ---"
> print(head(selected_cols, 3))
            Job_Title Average_Salary Risk_Category
1      Security Guard          45795          High
2  Research Scientist         133355           Low
3 Construction Worker         146216          High
> 
> # Method B: Select a range of adjacent columns
> # Scenario: Select everything from 'Years_Experience' to 'AI_Exposure_Index'
> range_cols <- ai_jobs %>%
+     select(Years_Experience:AI_Exposure_Index)
> 
> print("--- Selected Range of Columns (Years_Experience to AI_Exposure_Index) ---")
[1] "--- Selected Range of Columns (Years_Experience to AI_Exposure_Index) ---"
> print(head(range_cols, 3))
  Years_Experience Education_Level AI_Exposure_Index
1               28        Master's              0.18
2               20             PhD              0.62
3                2     High School              0.86
> 
> # Method C: Select using helper functions (e.g., starts_with)
> # Scenario: Select columns that start with "S" (Skill_1, Skill_2, etc.)
> starts_with_s <- ai_jobs %>%
+     select(starts_with("S"))
> 
> print("--- Selected columns starting with 'S' (The 10 Skill columns) ---")
[1] "--- Selected columns starting with 'S' (The 10 Skill columns) ---"
> print(head(starts_with_s, 3))
  Skill_1 Skill_2 Skill_3 Skill_4 Skill_5 Skill_6 Skill_7 Skill_8 Skill_9 Skill_10
1    0.45    0.10    0.46    0.33    0.14    0.65    0.06    0.72    0.94     0.00
2    0.02    0.52    0.40    0.05    0.97    0.23    0.09    0.62    0.38     0.98
3    0.01    0.94    0.56    0.39    0.02    0.23    0.24    0.68    0.61     0.83
> 
> # ------------------------------------------------------------------------------
> # 3. DROPPING VARIABLES (Removing Columns)
> # ------------------------------------------------------------------------------
> # We use the minus sign (-) to remove variables
> 
> # Method A: Drop a single specific column
> # Scenario: Remove the 'Tech_Growth_Factor'
> dropped_one <- ai_jobs %>%
+     select(-Tech_Growth_Factor)
> 
> print("--- Dataset with 'Tech_Growth_Factor' dropped (Names to verify) ---")
[1] "--- Dataset with 'Tech_Growth_Factor' dropped (Names to verify) ---"
> print(names(dropped_one))
 [1] "Job_Title"                   "Average_Salary"              "Years_Experience"           
 [4] "Education_Level"             "AI_Exposure_Index"           "Automation_Probability_2030"
 [7] "Risk_Category"               "Skill_1"                     "Skill_2"                    
[10] "Skill_3"                     "Skill_4"                     "Skill_5"                    
[13] "Skill_6"                     "Skill_7"                     "Skill_8"                    
[16] "Skill_9"                     "Skill_10"                   
> 
> # Method B: Drop multiple columns
> # Scenario: Remove 'Years_Experience' and 'Education_Level'
> dropped_multiple <- ai_jobs %>%
+     select(-Years_Experience, -Education_Level)
> 
> print("--- Dataset with 'Years_Experience' and 'Education_Level' dropped (Names to verify) ---")
[1] "--- Dataset with 'Years_Experience' and 'Education_Level' dropped (Names to verify) ---"
> print(names(dropped_multiple))
 [1] "Job_Title"                   "Average_Salary"              "AI_Exposure_Index"          
 [4] "Tech_Growth_Factor"          "Automation_Probability_2030" "Risk_Category"              
 [7] "Skill_1"                     "Skill_2"                     "Skill_3"                    
[10] "Skill_4"                     "Skill_5"                     "Skill_6"                    
[13] "Skill_7"                     "Skill_8"                     "Skill_9"                    
[16] "Skill_10"                   
> 
> # Method C: Drop a range of columns
> # Scenario: Remove all 10 Skill columns (from 'Skill_1' to 'Skill_10')
> dropped_range <- ai_jobs %>%
+     select(-(Skill_1:Skill_10))
> 
> print("--- Dataset with range 'Skill_1' to 'Skill_10' dropped (Names to verify) ---")
[1] "--- Dataset with range 'Skill_1' to 'Skill_10' dropped (Names to verify) ---"
> print(names(dropped_range))
[1] "Job_Title"                   "Average_Salary"              "Years_Experience"           
[4] "Education_Level"             "AI_Exposure_Index"           "Tech_Growth_Factor"         
[7] "Automation_Probability_2030" "Risk_Category"              
> prac 8 
Error: unexpected numeric constant in "prac 8"

> # Load necessary libraries
> library(dplyr)
> library(tidyr) # Contains replace_na()
Error in library(tidyr) : there is no package called ‘tidyr’

> install.packages("tidyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/Purvi/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
also installing the dependencies ‘stringi’, ‘purrr’, ‘stringr’
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/stringi_1.8.7.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/purrr_1.2.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/stringr_1.6.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/tidyr_1.3.1.zip'
package ‘stringi’ successfully unpacked and MD5 sums checked
package ‘purrr’ successfully unpacked and MD5 sums checked
package ‘stringr’ successfully unpacked and MD5 sums checked
package ‘tidyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\Purvi\AppData\Local\Temp\RtmpEfh8wZ\downloaded_packages
> library(tidyr)
> # Load necessary libraries
> library(dplyr)
> library(tidyr) # Contains replace_na()
> 
> # ==============================================================================
> # 1. CREATE AND IMPORT DATASET (Synthetic Data Used)
> # ==============================================================================
> 
> # Reading the synthetic dataset with strategically introduced NAs
> ai_jobs_df <- read.csv("AI_Jobs_with_NA.csv", na.strings = c("", "NA"))
Error in file(file, "rt") : cannot open the connection
In addition: Warning message:
In file(file, "rt") :
  cannot open file 'AI_Jobs_with_NA.csv': No such file or directory

> PRAC 8 
Error: unexpected numeric constant in "PRAC 8"

> # Load necessary libraries
> library(dplyr)
> library(tidyr) # Contains replace_na()
> 
> # ==============================================================================
> # 1. SETUP: Create a Sample Dataset with Missing Values (in R)
> # ==============================================================================
> 
> # Creating a small data frame with NA values, using column names from your file
> # to demonstrate the concepts without needing a separate CSV file.
> ai_jobs_sample <- data.frame(
+     Job_Title = c("Security Guard", "Research Scientist", "Data Scientist", "Software Engineer"),
+     Average_Salary = c(45795, 133355, NA, 136530),
+     Education_Level = c("Master's", NA, "Bachelor's", "PhD"),
+     AI_Exposure_Index = c(NA, 0.62, 0.91, 0.39)
+ )
> 
> print("--- 1. Sample Data with NAs (Created in R) ---")
[1] "--- 1. Sample Data with NAs (Created in R) ---"
> print(ai_jobs_sample)
           Job_Title Average_Salary Education_Level AI_Exposure_Index
1     Security Guard          45795        Master's                NA
2 Research Scientist         133355            <NA>              0.62
3     Data Scientist             NA      Bachelor's              0.91
4  Software Engineer         136530             PhD              0.39
> 
> # Check how many NAs are in each column
> print("--- Count of Missing Values per Column ---")
[1] "--- Count of Missing Values per Column ---"
> print(colSums(is.na(ai_jobs_sample)))
        Job_Title    Average_Salary   Education_Level AI_Exposure_Index 
                0                 1                 1                 1 
> 
> # ------------------------------------------------------------------------------
> # 2. METHOD A: REMOVE MISSING VALUES (na.omit)
> # ------------------------------------------------------------------------------
> # Deletes any row that has at least one missing value (NA).
> 
> clean_omit <- na.omit(ai_jobs_sample)
> 
> print("--- 2. Data after na.omit() ---")
[1] "--- 2. Data after na.omit() ---"
> print(paste("Original rows:", nrow(ai_jobs_sample)))
[1] "Original rows: 4"
> print(paste("Rows remaining:", nrow(clean_omit)))
[1] "Rows remaining: 1"
> print(clean_omit)
          Job_Title Average_Salary Education_Level AI_Exposure_Index
4 Software Engineer         136530             PhD              0.39
> 
> 
> # ------------------------------------------------------------------------------
> # 3. METHOD B: REPLACE MISSING VALUES (replace_na)
> # ------------------------------------------------------------------------------
> # This is the "surgical option". We fill missing values with logical defaults.
> # Strategy:
> # 1. Average_Salary: Fill with the Mean Salary
> # 2. Education_Level: Fill with "Not Reported"
> # 3. AI_Exposure_Index: Fill missing with 0
> 
> # Calculate average salary (ignoring NAs)
> avg_salary <- mean(ai_jobs_sample$Average_Salary, na.rm = TRUE)
> 
> clean_replace <- ai_jobs_sample %>%
+     replace_na(list(
+         Average_Salary = avg_salary,
+         Education_Level = "Not Reported",
+         AI_Exposure_Index = 0
+     ))
> 
> print("--- 3. Data after replace_na() ---")
[1] "--- 3. Data after replace_na() ---"
> print(clean_replace)
           Job_Title Average_Salary Education_Level AI_Exposure_Index
1     Security Guard        45795.0        Master's              0.00
2 Research Scientist       133355.0    Not Reported              0.62
3     Data Scientist       105226.7      Bachelor's              0.91
4  Software Engineer       136530.0             PhD              0.39
> 
> # Verify no NAs exist in the columns we cleaned
> print("--- Remaining NAs after replacement (Target columns only) ---")
[1] "--- Remaining NAs after replacement (Target columns only) ---"
> print(colSums(is.na(clean_replace)))
        Job_Title    Average_Salary   Education_Level AI_Exposure_Index 
                0                 0                 0                 0 
> prac9
Error: object 'prac9' not found

> library(stringr)
> library(tidyr) 
> library(dplyr)
> 
> # ------------------------------------------------------------------------------
> # 1. IMPORT AND SAMPLE DATASET
> # ------------------------------------------------------------------------------
> 
> # Import the CSV file
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> # Select a small sample of unique jobs for cleaner demonstration
> text_data <- ai_jobs_df %>%
+     distinct(Job_Title, .keep_all = TRUE) %>%
+     slice(1:5) %>%
+     select(Job_Title, Education_Level, Average_Salary)
> 
> print("--- Original Sample Dataset ---")
[1] "--- Original Sample Dataset ---"
> print(text_data)
            Job_Title Education_Level Average_Salary
1      Security Guard        Master's          45795
2  Research Scientist             PhD         133355
3 Construction Worker     High School         146216
4   Software Engineer             PhD         136530
5   Financial Analyst     High School          70397
> 
> # ------------------------------------------------------------------------------
> # 2. USING str_sub() (Substring)
> # ------------------------------------------------------------------------------
> # Scenario: Extract the first three characters of the job title and the degree level.
> 
> # Example A: Extract the first 3 characters of the Job Title as a prefix 
> # Syntax: str_sub(string, start, end)
> text_data$Job_Prefix <- str_sub(text_data$Job_Title, 1, 3)
> 
> # Example B: Extract the last 6 characters of the Education_Level (using negative indices)
> text_data$Degree_Suffix <- str_sub(text_data$Education_Level, -6, -1)
> 
> print("--- Data after str_sub() (Prefix and Suffix extracted) ---")
[1] "--- Data after str_sub() (Prefix and Suffix extracted) ---"
> print(text_data %>% select(Job_Title, Job_Prefix, Education_Level, Degree_Suffix))
            Job_Title Job_Prefix Education_Level Degree_Suffix
1      Security Guard        Sec        Master's        ster's
2  Research Scientist        Res             PhD           PhD
3 Construction Worker        Con     High School        School
4   Software Engineer        Sof             PhD           PhD
5   Financial Analyst        Fin     High School        School
> 
> # ------------------------------------------------------------------------------
> # 3. USING separate() (Split String)
> # ------------------------------------------------------------------------------
> # The `separate()` function automates the splitting of a column into multiple new columns.
> # We split 'Job_Title' by the space (" ").
> 
> tidy_data <- text_data %>%
+     separate(Job_Title, into = c("Role_Part1", "Role_Part2"), sep = " ", extra = "merge", fill = "right")
> 
> print("--- Data after 'separate' (Job_Title split by space) ---")
[1] "--- Data after 'separate' (Job_Title split by space) ---"
> print(tidy_data %>% select(Role_Part1, Role_Part2, Education_Level))
    Role_Part1 Role_Part2 Education_Level
1     Security      Guard        Master's
2     Research  Scientist             PhD
3 Construction     Worker     High School
4     Software   Engineer             PhD
5    Financial    Analyst     High School
> library(stringr)
> library(dplyr)
> library(tidyr) 
> 
> # ------------------------------------------------------------------------------
> # 1. RE-LOAD AND SAMPLE DATASET
> # ------------------------------------------------------------------------------
> # The code below re-loads the data and creates the same sample used previously 
> # for a self-contained demonstration.
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> text_data <- ai_jobs_df %>%
+     distinct(Job_Title, .keep_all = TRUE) %>%
+     slice(1:5) %>%
+     select(Job_Title, Education_Level) 
> 
> print("--- Data used for splitting demonstration (First 3 rows) ---")
[1] "--- Data used for splitting demonstration (First 3 rows) ---"
> print(head(text_data, 3))
            Job_Title Education_Level
1      Security Guard        Master's
2  Research Scientist             PhD
3 Construction Worker     High School
> print("---------------------------------------------")
[1] "---------------------------------------------"
> 
> # ==============================================================================
> # 2. USING str_split() (Split String) - The Missing Demonstrations
> # ==============================================================================
> # Scenario: Split 'Job_Title' by the space (" ") into multiple components.
> 
> # Method A: Basic Split (Result is a list)
> # This is the raw output, where each split string becomes an element in a list.
> split_list <- str_split(text_data$Job_Title, " ")
> print("--- Method A: Basic Split Output (List format) ---")
[1] "--- Method A: Basic Split Output (List format) ---"
> print(split_list[[1]]) # Viewing the split parts of the first job: "Security Guard"
[1] "Security" "Guard"   
> print(split_list[[2]]) # Viewing the split parts of the second job: "Research Scientist"
[1] "Research"  "Scientist"
> 
> # Method B: Split Fixed (Returns a matrix)
> # Using simplify = TRUE converts the output to a matrix, which is easy to assign 
> # back to new columns using standard R subsetting.
> split_matrix <- str_split(text_data$Job_Title, " ", simplify = TRUE)
> 
> # Assign the split parts to new columns
> manual_split_df <- data.frame(text_data$Job_Title)
> names(manual_split_df) <- "Job_Title"
> 
> manual_split_df$Primary_Role <- split_matrix[, 1] # First column of matrix
> manual_split_df$Qualifier <- split_matrix[, 2] # Second column of matrix (or empty string if single word title)
> 
> print("--- Method B: Data after str_split() (Matrix Assignment) ---")
[1] "--- Method B: Data after str_split() (Matrix Assignment) ---"
> print(manual_split_df)
            Job_Title Primary_Role Qualifier
1      Security Guard     Security     Guard
2  Research Scientist     Research Scientist
3 Construction Worker Construction    Worker
4   Software Engineer     Software  Engineer
5   Financial Analyst    Financial   Analyst
> prac 10
Error: unexpected numeric constant in "prac 10"

> # ==============================================================================
> # R Script: Creating New Variables (Transformations & Calculations)
> # Dataset: AI Job Impact Data
> # ==============================================================================
> 
> library(dplyr)
> library(tidyr) 
> library(stringr) 
> 
> # ------------------------------------------------------------------------------
> # 1. SETUP: Import the Dataset
> # ------------------------------------------------------------------------------
> 
> # Import data
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> print("--- Baseline Data Sample ---")
[1] "--- Baseline Data Sample ---"
> # Show key columns used for the upcoming calculations
> print(head(ai_jobs_df, 3) %>% select(Job_Title, Average_Salary, Years_Experience, AI_Exposure_Index))
            Job_Title Average_Salary Years_Experience AI_Exposure_Index
1      Security Guard          45795               28              0.18
2  Research Scientist         133355               20              0.62
3 Construction Worker         146216                2              0.86
> 
> # ==============================================================================
> # 2. METHOD A: ARITHMETIC CALCULATIONS
> # ==============================================================================
> # Scenario 1: Calculate Salary Efficiency (Salary per Year of Experience).
> # Formula: Average_Salary / Years_Experience
> 
> # Scenario 2: Create a composite "Future Readiness Score". (Higher score is better)
> # Formula: (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) / 2
> 
> df_calc <- ai_jobs_df %>%
+     mutate(
+         Salary_Per_Year = Average_Salary / Years_Experience,
+         Future_Readiness_Score = ( (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) ) / 2
+     )
> 
> print("--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---")
[1] "--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---"
> print(df_calc %>% select(Job_Title, Average_Salary, Years_Experience, Salary_Per_Year, Future_Readiness_Score))
              Job_Title Average_Salary Years_Experience Salary_Per_Year Future_Readiness_Score
1        Security Guard          45795               28        1635.536                  0.485
2    Research Scientist         133355               20        6667.750                  0.665
3   Construction Worker         146216                2       73108.000                  0.165
4     Software Engineer         136530               13       10502.308                  0.505
5     Financial Analyst          70397               22        3199.864                  0.420
6           AI Engineer          92592               11        8417.455                  0.805
7              Mechanic         107373               23        4668.391                  0.460
8               Teacher          53419               12        4451.583                  0.815
9         HR Specialist         139225               12       11602.083                  0.610
10     Customer Support          85016                2       42508.000                  0.595
11        UX Researcher          82733                6       13788.833                  0.545
12    Financial Analyst         117455               22        5338.864                  0.465
13               Lawyer          79811               27        2955.963                  0.410
14       Data Scientist         115981                9       12886.778                  0.555
15   Research Scientist          96690               19        5088.947                  0.450
16     Graphic Designer          32869                2       16434.500                  0.385
17              Teacher          36893               29        1272.172                  0.380
18              Teacher         103744               11        9431.273                  0.390
19        Retail Worker         148015                2       74007.500                  0.450
20               Doctor         108069               15        7204.600                  0.650
21          AI Engineer          43403                1       43403.000                  0.925
22        HR Specialist          49508               27        1833.630                  0.725
23              Teacher          58251               25        2330.040                  0.815
24    Financial Analyst          33343               28        1190.821                  0.360
25          AI Engineer         125435               15        8362.333                  0.865
26    Software Engineer          39540               12        3295.000                  0.640
27             Mechanic          68304                7        9757.714                  0.380
28     Customer Support          33267               25        1330.680                  0.190
29        HR Specialist          89031               22        4046.864                  0.300
30        HR Specialist         102936               18        5718.667                  0.615
31              Teacher         114076               20        5703.800                  0.660
32        Retail Worker          69081                8        8635.125                  0.230
33        Retail Worker         102124               11        9284.000                  0.255
34         Truck Driver          91629               24        3817.875                  0.355
35              Teacher          43843               24        1826.792                  0.630
36             Mechanic          59703               25        2388.120                  0.685
37             Mechanic          64349                2       32174.500                  0.295
38     Customer Support          92292               25        3691.680                  0.355
39                 Chef          53524               20        2676.200                  0.330
40        Retail Worker          88017               21        4191.286                  0.160
41     Graphic Designer         111317               27        4122.852                  0.235
42               Doctor         144825               23        6296.739                  0.545
43   Research Scientist          52415                7        7487.857                  0.835
44  Construction Worker         134680               11       12243.636                  0.480
45     Customer Support         109714               28        3918.357                  0.040
46       Data Scientist          97067               12        8088.917                  0.335
47  Construction Worker          37561                2       18780.500                  0.250
48              Teacher         142581                4       35645.250                  0.480
49        UX Researcher          39111                5        7822.200                  0.475
50        Retail Worker          72101                3       24033.667                  0.405
51       Security Guard         117958                9       13106.444                  0.055
52          AI Engineer          97444               23        4236.696                  0.435
53          AI Engineer          30077               25        1203.080                  0.445
54        UX Researcher         148721               13       11440.077                  0.705
55     Customer Support         127720                0             Inf                  0.275
56       Data Scientist          50103                4       12525.750                  0.450
57     Graphic Designer         145033               13       11156.385                  0.515
58               Doctor          95310               25        3812.400                  0.925
59             Mechanic          93374               20        4668.700                  0.620
60   Research Scientist          71914               11        6537.636                  0.450
61    Financial Analyst         132547               21        6311.762                  0.385
62        UX Researcher         119106               17        7006.235                  0.600
63        UX Researcher          82603                0             Inf                  0.690
64       Security Guard         131358                7       18765.429                  0.510
65       Security Guard          83394               15        5559.600                  0.505
66                Nurse          92516               11        8410.545                  0.770
67     Graphic Designer          53752               21        2559.619                  0.500
68          AI Engineer         108411               22        4927.773                  0.885
69                 Chef         116145               27        4301.667                  0.350
70       Data Scientist         124613                4       31153.250                  0.500
71    Marketing Manager          30060               10        3006.000                  0.535
72    Marketing Manager          87134               11        7921.273                  0.435
73  Construction Worker          67641               15        4509.400                  0.115
74   Research Scientist          67265               26        2587.115                  0.485
75     Customer Support         145608               12       12134.000                  0.260
76             Mechanic          59629               16        3726.812                  0.525
77       Data Scientist          85619               17        5036.412                  0.730
78    Software Engineer         136506               29        4707.103                  0.345
79   Research Scientist         148533                4       37133.250                  0.835
80    Financial Analyst         105758               24        4406.583                  0.535
81    Marketing Manager          55559               27        2057.741                  0.520
82    Financial Analyst          31591                7        4513.000                  0.455
83    Financial Analyst          32469               27        1202.556                  0.595
84    Marketing Manager         117263               12        9771.917                  0.415
85        Retail Worker         121357                4       30339.250                  0.515
86                Nurse          54860               11        4987.273                  0.505
87        Retail Worker          36540                8        4567.500                  0.485
88        Retail Worker          58602               19        3084.316                  0.325
89               Lawyer          69341               24        2889.208                  0.260
90               Doctor          41536               29        1432.276                  0.605
91    Marketing Manager         113309               14        8093.500                  0.410
92          AI Engineer          78787                0             Inf                  0.655
93     Graphic Designer          98577                9       10953.000                  0.640
94  Construction Worker          54826                6        9137.667                  0.245
95    Marketing Manager          61890               22        2813.182                  0.440
96        HR Specialist          75500               28        2696.429                  0.470
97         Truck Driver          95128                3       31709.333                  0.560
98        UX Researcher          49975                3       16658.333                  0.345
99                 Chef          75893               16        4743.312                  0.605
100       HR Specialist         106619               29        3676.517                  0.655
101       HR Specialist         113310               14        8093.571                  0.565
102         AI Engineer          55611                9        6179.000                  0.690
103        Truck Driver         108131               15        7208.733                  0.160
104  Research Scientist          58625               16        3664.062                  0.465
105              Lawyer          47087                5        9417.400                  0.490
106    Customer Support         143942               18        7996.778                  0.180
107            Mechanic         109973               25        4398.920                  0.425
108        Truck Driver          57598               11        5236.182                  0.340
109              Doctor          75379               20        3768.950                  0.715
110       HR Specialist         130441               24        5435.042                  0.420
111       UX Researcher          72668                9        8074.222                  0.665
112      Data Scientist         140641               23        6114.826                  0.305
113   Marketing Manager          46014                2       23007.000                  0.500
114      Data Scientist          92438               23        4019.043                  0.640
115              Doctor         102240               27        3786.667                  0.910
116        Truck Driver          39686               29        1368.483                  0.475
117            Mechanic          40754               15        2716.933                  0.465
118       Retail Worker          40699                5        8139.800                  0.555
119       HR Specialist         120373                2       60186.500                  0.340
120   Software Engineer          70461                8        8807.625                  0.660
121       HR Specialist         103965               28        3713.036                  0.525
122  Research Scientist          58179               17        3422.294                  0.835
123              Doctor         125694                8       15711.750                  0.750
124                Chef         128723               27        4767.519                  0.265
125   Financial Analyst          36548               21        1740.381                  0.320
126  Research Scientist          40634               20        2031.700                  0.495
127       HR Specialist          62784               23        2729.739                  0.600
128               Nurse          37099               22        1686.318                  0.625
129    Graphic Designer          74857               13        5758.231                  0.165
130      Data Scientist          91063                7       13009.000                  0.500
131      Security Guard          89765               12        7480.417                  0.260
132            Mechanic          32461               19        1708.474                  0.615
133             Teacher          53911               13        4147.000                  0.565
134   Financial Analyst          50567               11        4597.000                  0.365
135   Marketing Manager          52656               11        4786.909                  0.465
136  Research Scientist          77701                9        8633.444                  0.500
137    Graphic Designer         137539                9       15282.111                  0.325
138  Research Scientist          46087                4       11521.750                  0.615
139              Lawyer          67861               20        3393.050                  0.365
140 Construction Worker          89792                5       17958.400                  0.315
141                Chef          36397               21        1733.190                  0.655
142      Data Scientist          49715               29        1714.310                  0.400
143              Lawyer         122573               21        5836.810                  0.540
144    Graphic Designer         133864               20        6693.200                  0.515
145                Chef          48745               20        2437.250                  0.680
146              Doctor          49446                0             Inf                  0.605
147               Nurse          98673                9       10963.667                  0.665
148    Customer Support          93870                3       31290.000                  0.245
149   Financial Analyst          72951               11        6631.909                  0.560
150 Construction Worker          37239               22        1692.682                  0.220
151    Customer Support         149798                7       21399.714                  0.185
152      Security Guard         149052                1      149052.000                  0.510
153             Teacher          39587                5        7917.400                  0.665
154   Marketing Manager         120301                0             Inf                  0.660
155       HR Specialist         117969                1      117969.000                  0.560
156      Security Guard          39528               20        1976.400                  0.330
157             Teacher          95677                3       31892.333                  0.735
158       HR Specialist          51778                8        6472.250                  0.305
159              Lawyer          36816               23        1600.696                  0.695
160  Research Scientist          53567               28        1913.107                  0.500
161              Lawyer         121170               16        7573.125                  0.815
162         AI Engineer          91944               28        3283.714                  0.640
163      Security Guard         123905               16        7744.062                  0.515
164             Teacher          73056               13        5619.692                  0.845
165        Truck Driver          89156               18        4953.111                  0.205
166   Marketing Manager         102124               15        6808.267                  0.510
167              Doctor          54995               17        3235.000                  0.860
168            Mechanic         100194               21        4771.143                  0.755
169              Lawyer          97534               25        3901.360                  0.350
170       UX Researcher         123547                1      123547.000                  0.545
171         AI Engineer         111926                3       37308.667                  0.835
172       HR Specialist         107487               19        5657.211                  0.540
173       HR Specialist         107362               17        6315.412                  0.595
174   Financial Analyst          44973               19        2367.000                  0.680
175  Research Scientist          30340               13        2333.846                  0.530
176              Doctor         104965               24        4373.542                  0.490
177        Truck Driver          74789               10        7478.900                  0.290
178      Security Guard          88954                0             Inf                  0.295
179             Teacher          78456                7       11208.000                  0.445
180   Financial Analyst         116698                2       58349.000                  0.445
181                Chef          40886                2       20443.000                  0.330
182         AI Engineer          78511                3       26170.333                  0.725
183         AI Engineer         136127                5       27225.400                  0.900
184        Truck Driver          45592               29        1572.138                  0.115
185      Security Guard         134859               13       10373.769                  0.170
186               Nurse         119678               24        4986.583                  0.970
187       UX Researcher          62402                8        7800.250                  0.270
188            Mechanic          53478                9        5942.000                  0.605
189              Lawyer          52005               15        3467.000                  0.560
190      Security Guard          82389               10        8238.900                  0.185
191                Chef          84336                3       28112.000                  0.670
192   Financial Analyst         112594               24        4691.417                  0.300
193      Security Guard          85243               26        3278.577                  0.310
194       UX Researcher          85668                3       28556.000                  0.440
195   Software Engineer          82428               14        5887.714                  0.705
196      Data Scientist         107240               25        4289.600                  0.370
197       UX Researcher         120270                8       15033.750                  0.320
198         AI Engineer          74605               21        3552.619                  0.570
199       UX Researcher         140059                5       28011.800                  0.695
200            Mechanic          96155               18        5341.944                  0.345
 [ reached 'max' / getOption("max.print") -- omitted 2800 rows ]
> 
> # ==============================================================================
> # 3. METHOD B: CONDITIONAL LOGIC (case_when and ifelse)
> # ==============================================================================
> # Scenario 1: Create a categorical 'Experience_Level' based on Years_Experience.
> # We use the versatile case_when() function for multiple conditions.
> # Logic: 
> #   Years_Experience <= 5: "Junior"
> #   Years_Experience > 5 AND <= 15: "Mid-Level"
> #   Years_Experience > 15: "Senior/Expert"
> 
> df_logic <- ai_jobs_df %>%
+     mutate(
+         Experience_Level = case_when(
+             Years_Experience <= 5 ~ "Junior",
+             Years_Experience > 5 & Years_Experience <= 15 ~ "Mid-Level",
+             Years_Experience > 15 ~ "Senior/Expert",
+             TRUE ~ "Unknown" # Default catch-all
+         ),
+         # Scenario 2: Simple binary check for low automation risk
+         Is_Low_Automation = ifelse(Automation_Probability_2030 < 0.20, TRUE, FALSE)
+     )
> 
> print("--- Method B: Logic Results (Experience Level & Low Automation Flag) ---")
[1] "--- Method B: Logic Results (Experience Level & Low Automation Flag) ---"
> print(df_logic %>% select(Years_Experience, Experience_Level, Automation_Probability_2030, Is_Low_Automation))
    Years_Experience Experience_Level Automation_Probability_2030 Is_Low_Automation
1                 28    Senior/Expert                        0.85             FALSE
2                 20    Senior/Expert                        0.05              TRUE
3                  2           Junior                        0.81             FALSE
4                 13        Mid-Level                        0.60             FALSE
5                 22    Senior/Expert                        0.64             FALSE
6                 11        Mid-Level                        0.10              TRUE
7                 23    Senior/Expert                        0.41             FALSE
8                 12        Mid-Level                        0.17              TRUE
9                 12        Mid-Level                        0.48             FALSE
10                 2           Junior                        0.80             FALSE
11                 6        Mid-Level                        0.41             FALSE
12                22    Senior/Expert                        0.40             FALSE
13                27    Senior/Expert                        0.50             FALSE
14                 9        Mid-Level                        0.63             FALSE
15                19    Senior/Expert                        0.21             FALSE
16                 2           Junior                        0.58             FALSE
17                29    Senior/Expert                        0.27             FALSE
18                11        Mid-Level                        0.28             FALSE
19                 2           Junior                        0.93             FALSE
20                15        Mid-Level                        0.15              TRUE
21                 1           Junior                        0.06              TRUE
22                27    Senior/Expert                        0.33             FALSE
23                25    Senior/Expert                        0.29             FALSE
24                28    Senior/Expert                        0.54             FALSE
25                15        Mid-Level                        0.17              TRUE
26                12        Mid-Level                        0.56             FALSE
27                 7        Mid-Level                        0.33             FALSE
28                25    Senior/Expert                        0.92             FALSE
29                22    Senior/Expert                        0.47             FALSE
30                18    Senior/Expert                        0.68             FALSE
31                20    Senior/Expert                        0.19              TRUE
32                 8        Mid-Level                        0.72             FALSE
33                11        Mid-Level                        0.93             FALSE
34                24    Senior/Expert                        0.92             FALSE
35                24    Senior/Expert                        0.22             FALSE
36                25    Senior/Expert                        0.44             FALSE
37                 2           Junior                        0.59             FALSE
38                25    Senior/Expert                        0.91             FALSE
39                20    Senior/Expert                        0.40             FALSE
40                21    Senior/Expert                        0.91             FALSE
41                27    Senior/Expert                        0.55             FALSE
42                23    Senior/Expert                        0.07              TRUE
43                 7        Mid-Level                        0.15              TRUE
44                11        Mid-Level                        0.83             FALSE
45                28    Senior/Expert                        0.93             FALSE
46                12        Mid-Level                        0.46             FALSE
47                 2           Junior                        0.85             FALSE
48                 4           Junior                        0.11              TRUE
49                 5           Junior                        0.65             FALSE
50                 3           Junior                        0.76             FALSE
51                 9        Mid-Level                        0.90             FALSE
52                23    Senior/Expert                        0.14              TRUE
53                25    Senior/Expert                        0.20             FALSE
54                13        Mid-Level                        0.52             FALSE
55                 0           Junior                        0.74             FALSE
56                 4           Junior                        0.61             FALSE
57                13        Mid-Level                        0.36             FALSE
58                25    Senior/Expert                        0.08              TRUE
59                20    Senior/Expert                        0.38             FALSE
60                11        Mid-Level                        0.19              TRUE
61                21    Senior/Expert                        0.37             FALSE
62                17    Senior/Expert                        0.51             FALSE
63                 0           Junior                        0.59             FALSE
64                 7        Mid-Level                        0.88             FALSE
65                15        Mid-Level                        0.81             FALSE
66                11        Mid-Level                        0.24             FALSE
67                21    Senior/Expert                        0.35             FALSE
68                22    Senior/Expert                        0.12              TRUE
69                27    Senior/Expert                        0.34             FALSE
70                 4           Junior                        0.52             FALSE
71                10        Mid-Level                        0.33             FALSE
72                11        Mid-Level                        0.59             FALSE
73                15        Mid-Level                        0.84             FALSE
74                26    Senior/Expert                        0.20             FALSE
75                12        Mid-Level                        0.85             FALSE
76                16    Senior/Expert                        0.55             FALSE
77                17    Senior/Expert                        0.31             FALSE
78                29    Senior/Expert                        0.70             FALSE
79                 4           Junior                        0.27             FALSE
80                24    Senior/Expert                        0.34             FALSE
81                27    Senior/Expert                        0.59             FALSE
82                 7        Mid-Level                        0.41             FALSE
83                27    Senior/Expert                        0.65             FALSE
84                12        Mid-Level                        0.55             FALSE
85                 4           Junior                        0.87             FALSE
86                11        Mid-Level                        0.24             FALSE
87                 8        Mid-Level                        0.87             FALSE
88                19    Senior/Expert                        0.95             FALSE
89                24    Senior/Expert                        0.61             FALSE
90                29    Senior/Expert                        0.10              TRUE
91                14        Mid-Level                        0.58             FALSE
92                 0           Junior                        0.13              TRUE
93                 9        Mid-Level                        0.55             FALSE
94                 6        Mid-Level                        0.85             FALSE
95                22    Senior/Expert                        0.65             FALSE
96                28    Senior/Expert                        0.64             FALSE
97                 3           Junior                        0.85             FALSE
98                 3           Junior                        0.40             FALSE
99                16    Senior/Expert                        0.40             FALSE
100               29    Senior/Expert                        0.54             FALSE
101               14        Mid-Level                        0.31             FALSE
102                9        Mid-Level                        0.22             FALSE
103               15        Mid-Level                        0.74             FALSE
104               16    Senior/Expert                        0.24             FALSE
105                5           Junior                        0.70             FALSE
106               18    Senior/Expert                        0.77             FALSE
107               25    Senior/Expert                        0.56             FALSE
108               11        Mid-Level                        0.84             FALSE
109               20    Senior/Expert                        0.09              TRUE
110               24    Senior/Expert                        0.64             FALSE
111                9        Mid-Level                        0.56             FALSE
112               23    Senior/Expert                        0.57             FALSE
113                2           Junior                        0.39             FALSE
114               23    Senior/Expert                        0.59             FALSE
115               27    Senior/Expert                        0.11              TRUE
116               29    Senior/Expert                        0.72             FALSE
117               15        Mid-Level                        0.69             FALSE
118                5           Junior                        0.73             FALSE
119                2           Junior                        0.53             FALSE
120                8        Mid-Level                        0.36             FALSE
121               28    Senior/Expert                        0.63             FALSE
122               17    Senior/Expert                        0.05              TRUE
123                8        Mid-Level                        0.07              TRUE
124               27    Senior/Expert                        0.62             FALSE
125               21    Senior/Expert                        0.57             FALSE
126               20    Senior/Expert                        0.17              TRUE
127               23    Senior/Expert                        0.48             FALSE
128               22    Senior/Expert                        0.23             FALSE
129               13        Mid-Level                        0.68             FALSE
130                7        Mid-Level                        0.38             FALSE
131               12        Mid-Level                        0.90             FALSE
132               19    Senior/Expert                        0.65             FALSE
133               13        Mid-Level                        0.09              TRUE
134               11        Mid-Level                        0.54             FALSE
135               11        Mid-Level                        0.34             FALSE
136                9        Mid-Level                        0.24             FALSE
137                9        Mid-Level                        0.46             FALSE
138                4           Junior                        0.19              TRUE
139               20    Senior/Expert                        0.48             FALSE
140                5           Junior                        0.73             FALSE
141               21    Senior/Expert                        0.42             FALSE
142               29    Senior/Expert                        0.47             FALSE
143               21    Senior/Expert                        0.66             FALSE
144               20    Senior/Expert                        0.44             FALSE
145               20    Senior/Expert                        0.38             FALSE
146                0           Junior                        0.27             FALSE
147                9        Mid-Level                        0.21             FALSE
148                3           Junior                        0.75             FALSE
149               11        Mid-Level                        0.34             FALSE
150               22    Senior/Expert                        0.92             FALSE
151                7        Mid-Level                        0.74             FALSE
152                1           Junior                        0.81             FALSE
153                5           Junior                        0.13              TRUE
154                0           Junior                        0.44             FALSE
155                1           Junior                        0.57             FALSE
156               20    Senior/Expert                        0.93             FALSE
157                3           Junior                        0.15              TRUE
158                8        Mid-Level                        0.55             FALSE
159               23    Senior/Expert                        0.33             FALSE
160               28    Senior/Expert                        0.16              TRUE
161               16    Senior/Expert                        0.31             FALSE
162               28    Senior/Expert                        0.08              TRUE
163               16    Senior/Expert                        0.93             FALSE
164               13        Mid-Level                        0.26             FALSE
165               18    Senior/Expert                        0.71             FALSE
166               15        Mid-Level                        0.68             FALSE
167               17    Senior/Expert                        0.19              TRUE
168               21    Senior/Expert                        0.37             FALSE
169               25    Senior/Expert                        0.39             FALSE
170                1           Junior                        0.53             FALSE
171                3           Junior                        0.29             FALSE
172               19    Senior/Expert                        0.34             FALSE
173               17    Senior/Expert                        0.50             FALSE
174               19    Senior/Expert                        0.61             FALSE
175               13        Mid-Level                        0.26             FALSE
176               24    Senior/Expert                        0.23             FALSE
177               10        Mid-Level                        0.87             FALSE
178                0           Junior                        0.85             FALSE
179                7        Mid-Level                        0.26             FALSE
180                2           Junior                        0.42             FALSE
181                2           Junior                        0.60             FALSE
182                3           Junior                        0.14              TRUE
183                5           Junior                        0.15              TRUE
184               29    Senior/Expert                        0.79             FALSE
185               13        Mid-Level                        0.84             FALSE
186               24    Senior/Expert                        0.06              TRUE
187                8        Mid-Level                        0.62             FALSE
188                9        Mid-Level                        0.65             FALSE
189               15        Mid-Level                        0.49             FALSE
190               10        Mid-Level                        0.90             FALSE
191                3           Junior                        0.57             FALSE
192               24    Senior/Expert                        0.66             FALSE
193               26    Senior/Expert                        0.80             FALSE
194                3           Junior                        0.57             FALSE
195               14        Mid-Level                        0.53             FALSE
196               25    Senior/Expert                        0.41             FALSE
197                8        Mid-Level                        0.67             FALSE
198               21    Senior/Expert                        0.10              TRUE
199                5           Junior                        0.50             FALSE
200               18    Senior/Expert                        0.58             FALSE
201               23    Senior/Expert                        0.85             FALSE
202                4           Junior                        0.27             FALSE
203                2           Junior                        0.41             FALSE
204               10        Mid-Level                        0.68             FALSE
205               14        Mid-Level                        0.15              TRUE
206                3           Junior                        0.48             FALSE
207               22    Senior/Expert                        0.84             FALSE
208               14        Mid-Level                        0.59             FALSE
209               21    Senior/Expert                        0.60             FALSE
210               24    Senior/Expert                        0.21             FALSE
211                0           Junior                        0.91             FALSE
212               22    Senior/Expert                        0.17              TRUE
213               26    Senior/Expert                        0.83             FALSE
214               19    Senior/Expert                        0.78             FALSE
215               16    Senior/Expert                        0.38             FALSE
216               29    Senior/Expert                        0.56             FALSE
217               28    Senior/Expert                        0.52             FALSE
218               27    Senior/Expert                        0.36             FALSE
219                2           Junior                        0.16              TRUE
220               15        Mid-Level                        0.55             FALSE
221                5           Junior                        0.70             FALSE
222               10        Mid-Level                        0.23             FALSE
223               17    Senior/Expert                        0.57             FALSE
224               26    Senior/Expert                        0.14              TRUE
225               26    Senior/Expert                        0.48             FALSE
226               23    Senior/Expert                        0.89             FALSE
227               18    Senior/Expert                        0.42             FALSE
228               13        Mid-Level                        0.68             FALSE
229               29    Senior/Expert                        0.36             FALSE
230               21    Senior/Expert                        0.37             FALSE
231               21    Senior/Expert                        0.85             FALSE
232               28    Senior/Expert                        0.85             FALSE
233               29    Senior/Expert                        0.49             FALSE
234               11        Mid-Level                        0.81             FALSE
235                5           Junior                        0.69             FALSE
236               13        Mid-Level                        0.79             FALSE
237               23    Senior/Expert                        0.61             FALSE
238               27    Senior/Expert                        0.76             FALSE
239               26    Senior/Expert                        0.92             FALSE
240                5           Junior                        0.89             FALSE
241               22    Senior/Expert                        0.24             FALSE
242                5           Junior                        0.51             FALSE
243               26    Senior/Expert                        0.70             FALSE
244               21    Senior/Expert                        0.55             FALSE
245               18    Senior/Expert                        0.46             FALSE
246                9        Mid-Level                        0.06              TRUE
247               21    Senior/Expert                        0.54             FALSE
248                7        Mid-Level                        0.18              TRUE
249               28    Senior/Expert                        0.85             FALSE
250               18    Senior/Expert                        0.86             FALSE
 [ reached 'max' / getOption("max.print") -- omitted 2750 rows ]
> 
> # ==============================================================================
> # 4. METHOD C: TEXT TRANSFORMATION (paste)
> # ==============================================================================
> # Scenario: Create a 'Job_Summary' that combines the Job Title and its Risk Category.
> # Function: paste0() joins strings without a space by default.
> 
> df_text <- ai_jobs_df %>%
+     mutate(
+         Job_Summary = paste0(Job_Title, " - ", Risk_Category, " Risk")
+     )
> print("--- Method C: Text Transformation (Job Summary) ---")
[1] "--- Method C: Text Transformation (Job Summary) ---"
> print(head(df_text$Job_Summary))
[1] "Security Guard - High Risk"      "Research Scientist - Low Risk"   "Construction Worker - High Risk"
[4] "Software Engineer - Medium Risk" "Financial Analyst - Medium Risk" "AI Engineer - Low Risk"         
> 
> # ==============================================================================
> # 5. ALL TOGETHER (The Standard Workflow)
> # ==============================================================================
> 
> final_dataset <- ai_jobs_df %>%
+     mutate(
+         # Calculation 1: Adjusted Salary (Salary scaled by Tech Growth)
+         Adjusted_Salary = Average_Salary * Tech_Growth_Factor,
+         
+         # Calculation 2: Risk Flag (based on a combination of factors)
+         Is_High_Risk = ifelse(
+             Automation_Probability_2030 > 0.75 | Risk_Category == "High", 
+             "Flagged", 
+             "Safe"
+         ),
+         
+         # Text Combo: A brief report on the job's risk factors
+         Risk_Report = paste0(
+             "AI Exposure: ", round(AI_Exposure_Index, 2), 
+             " | Auto Prob: ", round(Automation_Probability_2030, 2),
+             " (", Risk_Category, ")"
+         )
+     )
> 
> print("--- Final Combined Dataset (Showing New Variables) ---")
[1] "--- Final Combined Dataset (Showing New Variables) ---"
> print(head(final_dataset %>% select(Job_Title, Adjusted_Salary, Is_High_Risk, Risk_Report)))
            Job_Title Adjusted_Salary Is_High_Risk                                  Risk_Report
1      Security Guard        58617.60      Flagged   AI Exposure: 0.18 | Auto Prob: 0.85 (High)
2  Research Scientist       148024.05         Safe    AI Exposure: 0.62 | Auto Prob: 0.05 (Low)
3 Construction Worker       172534.88      Flagged   AI Exposure: 0.86 | Auto Prob: 0.81 (High)
4   Software Engineer        92840.40         Safe  AI Exposure: 0.39 | Auto Prob: 0.6 (Medium)
5   Financial Analyst       102779.62         Safe AI Exposure: 0.52 | Auto Prob: 0.64 (Medium)
6         AI Engineer        47221.92         Safe     AI Exposure: 0.29 | Auto Prob: 0.1 (Low)
> # ==============================================================================
> # R Script: Creating New Variables (Transformations & Calculations)
> # Dataset: AI Job Impact Data
> # ==============================================================================
> 
> library(dplyr)
> library(tidyr) 
> library(stringr) 
> 
> # ------------------------------------------------------------------------------
> # 1. SETUP: Import the Dataset
> # ------------------------------------------------------------------------------
> 
> # Import data
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> print("--- Baseline Data Sample ---")
[1] "--- Baseline Data Sample ---"
> # Show key columns used for the upcoming calculations
> print(head(ai_jobs_df, 3) %>% select(Job_Title, Average_Salary, Years_Experience, AI_Exposure_Index))
            Job_Title Average_Salary Years_Experience AI_Exposure_Index
1      Security Guard          45795               28              0.18
2  Research Scientist         133355               20              0.62
3 Construction Worker         146216                2              0.86
> 
> # ==============================================================================
> # 2. METHOD A: ARITHMETIC CALCULATIONS
> # ==============================================================================
> # Scenario 1: Calculate Salary Efficiency (Salary per Year of Experience).
> # Formula: Average_Salary / Years_Experience
> 
> # Scenario 2: Create a composite "Future Readiness Score". (Higher score is better)
> # Formula: (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) / 2
> 
> df_calc <- ai_jobs_df %>%
+     mutate(
+         Salary_Per_Year = Average_Salary / Years_Experience,
+         Future_Readiness_Score = ( (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) ) / 2
+     )
> 
> print("--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---")
[1] "--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---"
> print(df_calc %>% select(Job_Title, Average_Salary, Years_Experience, Salary_Per_Year, Future_Readiness_Score))
              Job_Title Average_Salary Years_Experience Salary_Per_Year Future_Readiness_Score
1        Security Guard          45795               28        1635.536                  0.485
2    Research Scientist         133355               20        6667.750                  0.665
3   Construction Worker         146216                2       73108.000                  0.165
4     Software Engineer         136530               13       10502.308                  0.505
5     Financial Analyst          70397               22        3199.864                  0.420
6           AI Engineer          92592               11        8417.455                  0.805
7              Mechanic         107373               23        4668.391                  0.460
8               Teacher          53419               12        4451.583                  0.815
9         HR Specialist         139225               12       11602.083                  0.610
10     Customer Support          85016                2       42508.000                  0.595
11        UX Researcher          82733                6       13788.833                  0.545
12    Financial Analyst         117455               22        5338.864                  0.465
13               Lawyer          79811               27        2955.963                  0.410
14       Data Scientist         115981                9       12886.778                  0.555
15   Research Scientist          96690               19        5088.947                  0.450
16     Graphic Designer          32869                2       16434.500                  0.385
17              Teacher          36893               29        1272.172                  0.380
18              Teacher         103744               11        9431.273                  0.390
19        Retail Worker         148015                2       74007.500                  0.450
20               Doctor         108069               15        7204.600                  0.650
21          AI Engineer          43403                1       43403.000                  0.925
22        HR Specialist          49508               27        1833.630                  0.725
23              Teacher          58251               25        2330.040                  0.815
24    Financial Analyst          33343               28        1190.821                  0.360
25          AI Engineer         125435               15        8362.333                  0.865
26    Software Engineer          39540               12        3295.000                  0.640
27             Mechanic          68304                7        9757.714                  0.380
28     Customer Support          33267               25        1330.680                  0.190
29        HR Specialist          89031               22        4046.864                  0.300
30        HR Specialist         102936               18        5718.667                  0.615
31              Teacher         114076               20        5703.800                  0.660
32        Retail Worker          69081                8        8635.125                  0.230
33        Retail Worker         102124               11        9284.000                  0.255
34         Truck Driver          91629               24        3817.875                  0.355
35              Teacher          43843               24        1826.792                  0.630
36             Mechanic          59703               25        2388.120                  0.685
37             Mechanic          64349                2       32174.500                  0.295
38     Customer Support          92292               25        3691.680                  0.355
39                 Chef          53524               20        2676.200                  0.330
40        Retail Worker          88017               21        4191.286                  0.160
41     Graphic Designer         111317               27        4122.852                  0.235
42               Doctor         144825               23        6296.739                  0.545
43   Research Scientist          52415                7        7487.857                  0.835
44  Construction Worker         134680               11       12243.636                  0.480
45     Customer Support         109714               28        3918.357                  0.040
46       Data Scientist          97067               12        8088.917                  0.335
47  Construction Worker          37561                2       18780.500                  0.250
48              Teacher         142581                4       35645.250                  0.480
49        UX Researcher          39111                5        7822.200                  0.475
50        Retail Worker          72101                3       24033.667                  0.405
51       Security Guard         117958                9       13106.444                  0.055
52          AI Engineer          97444               23        4236.696                  0.435
53          AI Engineer          30077               25        1203.080                  0.445
54        UX Researcher         148721               13       11440.077                  0.705
55     Customer Support         127720                0             Inf                  0.275
56       Data Scientist          50103                4       12525.750                  0.450
57     Graphic Designer         145033               13       11156.385                  0.515
58               Doctor          95310               25        3812.400                  0.925
59             Mechanic          93374               20        4668.700                  0.620
60   Research Scientist          71914               11        6537.636                  0.450
61    Financial Analyst         132547               21        6311.762                  0.385
62        UX Researcher         119106               17        7006.235                  0.600
63        UX Researcher          82603                0             Inf                  0.690
64       Security Guard         131358                7       18765.429                  0.510
65       Security Guard          83394               15        5559.600                  0.505
66                Nurse          92516               11        8410.545                  0.770
67     Graphic Designer          53752               21        2559.619                  0.500
68          AI Engineer         108411               22        4927.773                  0.885
69                 Chef         116145               27        4301.667                  0.350
70       Data Scientist         124613                4       31153.250                  0.500
71    Marketing Manager          30060               10        3006.000                  0.535
72    Marketing Manager          87134               11        7921.273                  0.435
73  Construction Worker          67641               15        4509.400                  0.115
74   Research Scientist          67265               26        2587.115                  0.485
75     Customer Support         145608               12       12134.000                  0.260
76             Mechanic          59629               16        3726.812                  0.525
77       Data Scientist          85619               17        5036.412                  0.730
78    Software Engineer         136506               29        4707.103                  0.345
79   Research Scientist         148533                4       37133.250                  0.835
80    Financial Analyst         105758               24        4406.583                  0.535
81    Marketing Manager          55559               27        2057.741                  0.520
82    Financial Analyst          31591                7        4513.000                  0.455
83    Financial Analyst          32469               27        1202.556                  0.595
84    Marketing Manager         117263               12        9771.917                  0.415
85        Retail Worker         121357                4       30339.250                  0.515
86                Nurse          54860               11        4987.273                  0.505
87        Retail Worker          36540                8        4567.500                  0.485
88        Retail Worker          58602               19        3084.316                  0.325
89               Lawyer          69341               24        2889.208                  0.260
90               Doctor          41536               29        1432.276                  0.605
91    Marketing Manager         113309               14        8093.500                  0.410
92          AI Engineer          78787                0             Inf                  0.655
93     Graphic Designer          98577                9       10953.000                  0.640
94  Construction Worker          54826                6        9137.667                  0.245
95    Marketing Manager          61890               22        2813.182                  0.440
96        HR Specialist          75500               28        2696.429                  0.470
97         Truck Driver          95128                3       31709.333                  0.560
98        UX Researcher          49975                3       16658.333                  0.345
99                 Chef          75893               16        4743.312                  0.605
100       HR Specialist         106619               29        3676.517                  0.655
101       HR Specialist         113310               14        8093.571                  0.565
102         AI Engineer          55611                9        6179.000                  0.690
103        Truck Driver         108131               15        7208.733                  0.160
104  Research Scientist          58625               16        3664.062                  0.465
105              Lawyer          47087                5        9417.400                  0.490
106    Customer Support         143942               18        7996.778                  0.180
107            Mechanic         109973               25        4398.920                  0.425
108        Truck Driver          57598               11        5236.182                  0.340
109              Doctor          75379               20        3768.950                  0.715
110       HR Specialist         130441               24        5435.042                  0.420
111       UX Researcher          72668                9        8074.222                  0.665
112      Data Scientist         140641               23        6114.826                  0.305
113   Marketing Manager          46014                2       23007.000                  0.500
114      Data Scientist          92438               23        4019.043                  0.640
115              Doctor         102240               27        3786.667                  0.910
116        Truck Driver          39686               29        1368.483                  0.475
117            Mechanic          40754               15        2716.933                  0.465
118       Retail Worker          40699                5        8139.800                  0.555
119       HR Specialist         120373                2       60186.500                  0.340
120   Software Engineer          70461                8        8807.625                  0.660
121       HR Specialist         103965               28        3713.036                  0.525
122  Research Scientist          58179               17        3422.294                  0.835
123              Doctor         125694                8       15711.750                  0.750
124                Chef         128723               27        4767.519                  0.265
125   Financial Analyst          36548               21        1740.381                  0.320
126  Research Scientist          40634               20        2031.700                  0.495
127       HR Specialist          62784               23        2729.739                  0.600
128               Nurse          37099               22        1686.318                  0.625
129    Graphic Designer          74857               13        5758.231                  0.165
130      Data Scientist          91063                7       13009.000                  0.500
131      Security Guard          89765               12        7480.417                  0.260
132            Mechanic          32461               19        1708.474                  0.615
133             Teacher          53911               13        4147.000                  0.565
134   Financial Analyst          50567               11        4597.000                  0.365
135   Marketing Manager          52656               11        4786.909                  0.465
136  Research Scientist          77701                9        8633.444                  0.500
137    Graphic Designer         137539                9       15282.111                  0.325
138  Research Scientist          46087                4       11521.750                  0.615
139              Lawyer          67861               20        3393.050                  0.365
140 Construction Worker          89792                5       17958.400                  0.315
141                Chef          36397               21        1733.190                  0.655
142      Data Scientist          49715               29        1714.310                  0.400
143              Lawyer         122573               21        5836.810                  0.540
144    Graphic Designer         133864               20        6693.200                  0.515
145                Chef          48745               20        2437.250                  0.680
146              Doctor          49446                0             Inf                  0.605
147               Nurse          98673                9       10963.667                  0.665
148    Customer Support          93870                3       31290.000                  0.245
149   Financial Analyst          72951               11        6631.909                  0.560
150 Construction Worker          37239               22        1692.682                  0.220
151    Customer Support         149798                7       21399.714                  0.185
152      Security Guard         149052                1      149052.000                  0.510
153             Teacher          39587                5        7917.400                  0.665
154   Marketing Manager         120301                0             Inf                  0.660
155       HR Specialist         117969                1      117969.000                  0.560
156      Security Guard          39528               20        1976.400                  0.330
157             Teacher          95677                3       31892.333                  0.735
158       HR Specialist          51778                8        6472.250                  0.305
159              Lawyer          36816               23        1600.696                  0.695
160  Research Scientist          53567               28        1913.107                  0.500
161              Lawyer         121170               16        7573.125                  0.815
162         AI Engineer          91944               28        3283.714                  0.640
163      Security Guard         123905               16        7744.062                  0.515
164             Teacher          73056               13        5619.692                  0.845
165        Truck Driver          89156               18        4953.111                  0.205
166   Marketing Manager         102124               15        6808.267                  0.510
167              Doctor          54995               17        3235.000                  0.860
168            Mechanic         100194               21        4771.143                  0.755
169              Lawyer          97534               25        3901.360                  0.350
170       UX Researcher         123547                1      123547.000                  0.545
171         AI Engineer         111926                3       37308.667                  0.835
172       HR Specialist         107487               19        5657.211                  0.540
173       HR Specialist         107362               17        6315.412                  0.595
174   Financial Analyst          44973               19        2367.000                  0.680
175  Research Scientist          30340               13        2333.846                  0.530
176              Doctor         104965               24        4373.542                  0.490
177        Truck Driver          74789               10        7478.900                  0.290
178      Security Guard          88954                0             Inf                  0.295
179             Teacher          78456                7       11208.000                  0.445
180   Financial Analyst         116698                2       58349.000                  0.445
181                Chef          40886                2       20443.000                  0.330
182         AI Engineer          78511                3       26170.333                  0.725
183         AI Engineer         136127                5       27225.400                  0.900
184        Truck Driver          45592               29        1572.138                  0.115
185      Security Guard         134859               13       10373.769                  0.170
186               Nurse         119678               24        4986.583                  0.970
187       UX Researcher          62402                8        7800.250                  0.270
188            Mechanic          53478                9        5942.000                  0.605
189              Lawyer          52005               15        3467.000                  0.560
190      Security Guard          82389               10        8238.900                  0.185
191                Chef          84336                3       28112.000                  0.670
192   Financial Analyst         112594               24        4691.417                  0.300
193      Security Guard          85243               26        3278.577                  0.310
194       UX Researcher          85668                3       28556.000                  0.440
195   Software Engineer          82428               14        5887.714                  0.705
196      Data Scientist         107240               25        4289.600                  0.370
197       UX Researcher         120270                8       15033.750                  0.320
198         AI Engineer          74605               21        3552.619                  0.570
199       UX Researcher         140059                5       28011.800                  0.695
200            Mechanic          96155               18        5341.944                  0.345
 [ reached 'max' / getOption("max.print") -- omitted 2800 rows ]
> 
> # ==============================================================================
> # 3. METHOD B: CONDITIONAL LOGIC (case_when and ifelse)
> # ==============================================================================
> # Scenario 1: Create a categorical 'Experience_Level' based on Years_Experience.
> # We use the versatile case_when() function for multiple conditions.
> # Logic: 
> #   Years_Experience <= 5: "Junior"
> #   Years_Experience > 5 AND <= 15: "Mid-Level"
> #   Years_Experience > 15: "Senior/Expert"
> 
> df_logic <- ai_jobs_df %>%
+     mutate(
+         Experience_Level = case_when(
+             Years_Experience <= 5 ~ "Junior",
+             Years_Experience > 5 & Years_Experience <= 15 ~ "Mid-Level",
+             Years_Experience > 15 ~ "Senior/Expert",
+             TRUE ~ "Unknown" # Default catch-all
+         ),
+         # Scenario 2: Simple binary check for low automation risk
+         Is_Low_Automation = ifelse(Automation_Probability_2030 < 0.20, TRUE, FALSE)
+     )
> 
> print("--- Method B: Logic Results (Experience Level & Low Automation Flag) ---")
[1] "--- Method B: Logic Results (Experience Level & Low Automation Flag) ---"
> print(df_logic %>% select(Years_Experience, Experience_Level, Automation_Probability_2030, Is_Low_Automation))
    Years_Experience Experience_Level Automation_Probability_2030 Is_Low_Automation
1                 28    Senior/Expert                        0.85             FALSE
2                 20    Senior/Expert                        0.05              TRUE
3                  2           Junior                        0.81             FALSE
4                 13        Mid-Level                        0.60             FALSE
5                 22    Senior/Expert                        0.64             FALSE
6                 11        Mid-Level                        0.10              TRUE
7                 23    Senior/Expert                        0.41             FALSE
8                 12        Mid-Level                        0.17              TRUE
9                 12        Mid-Level                        0.48             FALSE
10                 2           Junior                        0.80             FALSE
11                 6        Mid-Level                        0.41             FALSE
12                22    Senior/Expert                        0.40             FALSE
13                27    Senior/Expert                        0.50             FALSE
14                 9        Mid-Level                        0.63             FALSE
15                19    Senior/Expert                        0.21             FALSE
16                 2           Junior                        0.58             FALSE
17                29    Senior/Expert                        0.27             FALSE
18                11        Mid-Level                        0.28             FALSE
19                 2           Junior                        0.93             FALSE
20                15        Mid-Level                        0.15              TRUE
21                 1           Junior                        0.06              TRUE
22                27    Senior/Expert                        0.33             FALSE
23                25    Senior/Expert                        0.29             FALSE
24                28    Senior/Expert                        0.54             FALSE
25                15        Mid-Level                        0.17              TRUE
26                12        Mid-Level                        0.56             FALSE
27                 7        Mid-Level                        0.33             FALSE
28                25    Senior/Expert                        0.92             FALSE
29                22    Senior/Expert                        0.47             FALSE
30                18    Senior/Expert                        0.68             FALSE
31                20    Senior/Expert                        0.19              TRUE
32                 8        Mid-Level                        0.72             FALSE
33                11        Mid-Level                        0.93             FALSE
34                24    Senior/Expert                        0.92             FALSE
35                24    Senior/Expert                        0.22             FALSE
36                25    Senior/Expert                        0.44             FALSE
37                 2           Junior                        0.59             FALSE
38                25    Senior/Expert                        0.91             FALSE
39                20    Senior/Expert                        0.40             FALSE
40                21    Senior/Expert                        0.91             FALSE
41                27    Senior/Expert                        0.55             FALSE
42                23    Senior/Expert                        0.07              TRUE
43                 7        Mid-Level                        0.15              TRUE
44                11        Mid-Level                        0.83             FALSE
45                28    Senior/Expert                        0.93             FALSE
46                12        Mid-Level                        0.46             FALSE
47                 2           Junior                        0.85             FALSE
48                 4           Junior                        0.11              TRUE
49                 5           Junior                        0.65             FALSE
50                 3           Junior                        0.76             FALSE
51                 9        Mid-Level                        0.90             FALSE
52                23    Senior/Expert                        0.14              TRUE
53                25    Senior/Expert                        0.20             FALSE
54                13        Mid-Level                        0.52             FALSE
55                 0           Junior                        0.74             FALSE
56                 4           Junior                        0.61             FALSE
57                13        Mid-Level                        0.36             FALSE
58                25    Senior/Expert                        0.08              TRUE
59                20    Senior/Expert                        0.38             FALSE
60                11        Mid-Level                        0.19              TRUE
61                21    Senior/Expert                        0.37             FALSE
62                17    Senior/Expert                        0.51             FALSE
63                 0           Junior                        0.59             FALSE
64                 7        Mid-Level                        0.88             FALSE
65                15        Mid-Level                        0.81             FALSE
66                11        Mid-Level                        0.24             FALSE
67                21    Senior/Expert                        0.35             FALSE
68                22    Senior/Expert                        0.12              TRUE
69                27    Senior/Expert                        0.34             FALSE
70                 4           Junior                        0.52             FALSE
71                10        Mid-Level                        0.33             FALSE
72                11        Mid-Level                        0.59             FALSE
73                15        Mid-Level                        0.84             FALSE
74                26    Senior/Expert                        0.20             FALSE
75                12        Mid-Level                        0.85             FALSE
76                16    Senior/Expert                        0.55             FALSE
77                17    Senior/Expert                        0.31             FALSE
78                29    Senior/Expert                        0.70             FALSE
79                 4           Junior                        0.27             FALSE
80                24    Senior/Expert                        0.34             FALSE
81                27    Senior/Expert                        0.59             FALSE
82                 7        Mid-Level                        0.41             FALSE
83                27    Senior/Expert                        0.65             FALSE
84                12        Mid-Level                        0.55             FALSE
85                 4           Junior                        0.87             FALSE
86                11        Mid-Level                        0.24             FALSE
87                 8        Mid-Level                        0.87             FALSE
88                19    Senior/Expert                        0.95             FALSE
89                24    Senior/Expert                        0.61             FALSE
90                29    Senior/Expert                        0.10              TRUE
91                14        Mid-Level                        0.58             FALSE
92                 0           Junior                        0.13              TRUE
93                 9        Mid-Level                        0.55             FALSE
94                 6        Mid-Level                        0.85             FALSE
95                22    Senior/Expert                        0.65             FALSE
96                28    Senior/Expert                        0.64             FALSE
97                 3           Junior                        0.85             FALSE
98                 3           Junior                        0.40             FALSE
99                16    Senior/Expert                        0.40             FALSE
100               29    Senior/Expert                        0.54             FALSE
101               14        Mid-Level                        0.31             FALSE
102                9        Mid-Level                        0.22             FALSE
103               15        Mid-Level                        0.74             FALSE
104               16    Senior/Expert                        0.24             FALSE
105                5           Junior                        0.70             FALSE
106               18    Senior/Expert                        0.77             FALSE
107               25    Senior/Expert                        0.56             FALSE
108               11        Mid-Level                        0.84             FALSE
109               20    Senior/Expert                        0.09              TRUE
110               24    Senior/Expert                        0.64             FALSE
111                9        Mid-Level                        0.56             FALSE
112               23    Senior/Expert                        0.57             FALSE
113                2           Junior                        0.39             FALSE
114               23    Senior/Expert                        0.59             FALSE
115               27    Senior/Expert                        0.11              TRUE
116               29    Senior/Expert                        0.72             FALSE
117               15        Mid-Level                        0.69             FALSE
118                5           Junior                        0.73             FALSE
119                2           Junior                        0.53             FALSE
120                8        Mid-Level                        0.36             FALSE
121               28    Senior/Expert                        0.63             FALSE
122               17    Senior/Expert                        0.05              TRUE
123                8        Mid-Level                        0.07              TRUE
124               27    Senior/Expert                        0.62             FALSE
125               21    Senior/Expert                        0.57             FALSE
126               20    Senior/Expert                        0.17              TRUE
127               23    Senior/Expert                        0.48             FALSE
128               22    Senior/Expert                        0.23             FALSE
129               13        Mid-Level                        0.68             FALSE
130                7        Mid-Level                        0.38             FALSE
131               12        Mid-Level                        0.90             FALSE
132               19    Senior/Expert                        0.65             FALSE
133               13        Mid-Level                        0.09              TRUE
134               11        Mid-Level                        0.54             FALSE
135               11        Mid-Level                        0.34             FALSE
136                9        Mid-Level                        0.24             FALSE
137                9        Mid-Level                        0.46             FALSE
138                4           Junior                        0.19              TRUE
139               20    Senior/Expert                        0.48             FALSE
140                5           Junior                        0.73             FALSE
141               21    Senior/Expert                        0.42             FALSE
142               29    Senior/Expert                        0.47             FALSE
143               21    Senior/Expert                        0.66             FALSE
144               20    Senior/Expert                        0.44             FALSE
145               20    Senior/Expert                        0.38             FALSE
146                0           Junior                        0.27             FALSE
147                9        Mid-Level                        0.21             FALSE
148                3           Junior                        0.75             FALSE
149               11        Mid-Level                        0.34             FALSE
150               22    Senior/Expert                        0.92             FALSE
151                7        Mid-Level                        0.74             FALSE
152                1           Junior                        0.81             FALSE
153                5           Junior                        0.13              TRUE
154                0           Junior                        0.44             FALSE
155                1           Junior                        0.57             FALSE
156               20    Senior/Expert                        0.93             FALSE
157                3           Junior                        0.15              TRUE
158                8        Mid-Level                        0.55             FALSE
159               23    Senior/Expert                        0.33             FALSE
160               28    Senior/Expert                        0.16              TRUE
161               16    Senior/Expert                        0.31             FALSE
162               28    Senior/Expert                        0.08              TRUE
163               16    Senior/Expert                        0.93             FALSE
164               13        Mid-Level                        0.26             FALSE
165               18    Senior/Expert                        0.71             FALSE
166               15        Mid-Level                        0.68             FALSE
167               17    Senior/Expert                        0.19              TRUE
168               21    Senior/Expert                        0.37             FALSE
169               25    Senior/Expert                        0.39             FALSE
170                1           Junior                        0.53             FALSE
171                3           Junior                        0.29             FALSE
172               19    Senior/Expert                        0.34             FALSE
173               17    Senior/Expert                        0.50             FALSE
174               19    Senior/Expert                        0.61             FALSE
175               13        Mid-Level                        0.26             FALSE
176               24    Senior/Expert                        0.23             FALSE
177               10        Mid-Level                        0.87             FALSE
178                0           Junior                        0.85             FALSE
179                7        Mid-Level                        0.26             FALSE
180                2           Junior                        0.42             FALSE
181                2           Junior                        0.60             FALSE
182                3           Junior                        0.14              TRUE
183                5           Junior                        0.15              TRUE
184               29    Senior/Expert                        0.79             FALSE
185               13        Mid-Level                        0.84             FALSE
186               24    Senior/Expert                        0.06              TRUE
187                8        Mid-Level                        0.62             FALSE
188                9        Mid-Level                        0.65             FALSE
189               15        Mid-Level                        0.49             FALSE
190               10        Mid-Level                        0.90             FALSE
191                3           Junior                        0.57             FALSE
192               24    Senior/Expert                        0.66             FALSE
193               26    Senior/Expert                        0.80             FALSE
194                3           Junior                        0.57             FALSE
195               14        Mid-Level                        0.53             FALSE
196               25    Senior/Expert                        0.41             FALSE
197                8        Mid-Level                        0.67             FALSE
198               21    Senior/Expert                        0.10              TRUE
199                5           Junior                        0.50             FALSE
200               18    Senior/Expert                        0.58             FALSE
201               23    Senior/Expert                        0.85             FALSE
202                4           Junior                        0.27             FALSE
203                2           Junior                        0.41             FALSE
204               10        Mid-Level                        0.68             FALSE
205               14        Mid-Level                        0.15              TRUE
206                3           Junior                        0.48             FALSE
207               22    Senior/Expert                        0.84             FALSE
208               14        Mid-Level                        0.59             FALSE
209               21    Senior/Expert                        0.60             FALSE
210               24    Senior/Expert                        0.21             FALSE
211                0           Junior                        0.91             FALSE
212               22    Senior/Expert                        0.17              TRUE
213               26    Senior/Expert                        0.83             FALSE
214               19    Senior/Expert                        0.78             FALSE
215               16    Senior/Expert                        0.38             FALSE
216               29    Senior/Expert                        0.56             FALSE
217               28    Senior/Expert                        0.52             FALSE
218               27    Senior/Expert                        0.36             FALSE
219                2           Junior                        0.16              TRUE
220               15        Mid-Level                        0.55             FALSE
221                5           Junior                        0.70             FALSE
222               10        Mid-Level                        0.23             FALSE
223               17    Senior/Expert                        0.57             FALSE
224               26    Senior/Expert                        0.14              TRUE
225               26    Senior/Expert                        0.48             FALSE
226               23    Senior/Expert                        0.89             FALSE
227               18    Senior/Expert                        0.42             FALSE
228               13        Mid-Level                        0.68             FALSE
229               29    Senior/Expert                        0.36             FALSE
230               21    Senior/Expert                        0.37             FALSE
231               21    Senior/Expert                        0.85             FALSE
232               28    Senior/Expert                        0.85             FALSE
233               29    Senior/Expert                        0.49             FALSE
234               11        Mid-Level                        0.81             FALSE
235                5           Junior                        0.69             FALSE
236               13        Mid-Level                        0.79             FALSE
237               23    Senior/Expert                        0.61             FALSE
238               27    Senior/Expert                        0.76             FALSE
239               26    Senior/Expert                        0.92             FALSE
240                5           Junior                        0.89             FALSE
241               22    Senior/Expert                        0.24             FALSE
242                5           Junior                        0.51             FALSE
243               26    Senior/Expert                        0.70             FALSE
244               21    Senior/Expert                        0.55             FALSE
245               18    Senior/Expert                        0.46             FALSE
246                9        Mid-Level                        0.06              TRUE
247               21    Senior/Expert                        0.54             FALSE
248                7        Mid-Level                        0.18              TRUE
249               28    Senior/Expert                        0.85             FALSE
250               18    Senior/Expert                        0.86             FALSE
 [ reached 'max' / getOption("max.print") -- omitted 2750 rows ]
> 
> # ==============================================================================
> # 4. METHOD C: TEXT TRANSFORMATION (paste)
> # ==============================================================================
> # Scenario: Create a 'Job_Summary' that combines the Job Title and its Risk Category.
> # Function: paste0() joins strings without a space by default.
> 
> df_text <- ai_jobs_df %>%
+     mutate(
+         Job_Summary = paste0(Job_Title, " - ", Risk_Category, " Risk")
+     )
> print("--- Method C: Text Transformation (Job Summary) ---")
[1] "--- Method C: Text Transformation (Job Summary) ---"
> print(head(df_text$Job_Summary))
[1] "Security Guard - High Risk"      "Research Scientist - Low Risk"   "Construction Worker - High Risk"
[4] "Software Engineer - Medium Risk" "Financial Analyst - Medium Risk" "AI Engineer - Low Risk"         
> 
> # ==============================================================================
> # 5. ALL TOGETHER (The Standard Workflow)
> # ==============================================================================
> 
> final_dataset <- ai_jobs_df %>%
+     mutate(
+         # Calculation 1: Adjusted Salary (Salary scaled by Tech Growth)
+         Adjusted_Salary = Average_Salary * Tech_Growth_Factor,
+         
+         # Calculation 2: Risk Flag (based on a combination of factors)
+         Is_High_Risk = ifelse(
+             Automation_Probability_2030 > 0.75 | Risk_Category == "High", 
+             "Flagged", 
+             "Safe"
+         ),
+         
+         # Text Combo: A brief report on the job's risk factors
+         Risk_Report = paste0(
+             "AI Exposure: ", round(AI_Exposure_Index, 2), 
+             " | Auto Prob: ", round(Automation_Probability_2030, 2),
+             " (", Risk_Category, ")"
+         )
+     )
> 
> print("--- Final Combined Dataset (Showing New Variables) ---")
[1] "--- Final Combined Dataset (Showing New Variables) ---"
> print(head(final_dataset %>% select(Job_Title, Adjusted_Salary, Is_High_Risk, Risk_Report)))
            Job_Title Adjusted_Salary Is_High_Risk                                  Risk_Report
1      Security Guard        58617.60      Flagged   AI Exposure: 0.18 | Auto Prob: 0.85 (High)
2  Research Scientist       148024.05         Safe    AI Exposure: 0.62 | Auto Prob: 0.05 (Low)
3 Construction Worker       172534.88      Flagged   AI Exposure: 0.86 | Auto Prob: 0.81 (High)
4   Software Engineer        92840.40         Safe  AI Exposure: 0.39 | Auto Prob: 0.6 (Medium)
5   Financial Analyst       102779.62         Safe AI Exposure: 0.52 | Auto Prob: 0.64 (Medium)
6         AI Engineer        47221.92         Safe     AI Exposure: 0.29 | Auto Prob: 0.1 (Low)
> prac 10 again
Error: unexpected numeric constant in "prac 10"

> # ==============================================================================
> # R Script: Creating New Variables (Transformations & Calculations)
> # Dataset: AI Job Impact Data
> # ==============================================================================
> 
> library(dplyr)
> library(tidyr) 
> library(stringr) 
> 
> # ------------------------------------------------------------------------------
> # 1. SETUP: Import the Dataset
> # ------------------------------------------------------------------------------
> 
> # Import data
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> print("--- Baseline Data Sample ---")
[1] "--- Baseline Data Sample ---"
> # Show key columns used for the upcoming calculations
> print(head(ai_jobs_df, 3) %>% select(Job_Title, Average_Salary, Years_Experience, AI_Exposure_Index))
            Job_Title Average_Salary Years_Experience AI_Exposure_Index
1      Security Guard          45795               28              0.18
2  Research Scientist         133355               20              0.62
3 Construction Worker         146216                2              0.86
> 
> # ==============================================================================
> # 2. METHOD A: ARITHMETIC CALCULATIONS
> # ==============================================================================
> # Scenario 1: Calculate Salary Efficiency (Salary per Year of Experience).
> # Formula: Average_Salary / Years_Experience
> 
> # Scenario 2: Create a composite "Future Readiness Score". (Higher score is better)
> # Formula: (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) / 2
> 
> df_calc <- ai_jobs_df %>%
+     mutate(
+         Salary_Per_Year = Average_Salary / Years_Experience,
+         Future_Readiness_Score = ( (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) ) / 2
+     )
> 
> print("--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---")
[1] "--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---"
> print(df_calc %>% select(Job_Title, Average_Salary, Years_Experience, Salary_Per_Year, Future_Readiness_Score))
              Job_Title Average_Salary Years_Experience Salary_Per_Year Future_Readiness_Score
1        Security Guard          45795               28        1635.536                  0.485
2    Research Scientist         133355               20        6667.750                  0.665
3   Construction Worker         146216                2       73108.000                  0.165
4     Software Engineer         136530               13       10502.308                  0.505
5     Financial Analyst          70397               22        3199.864                  0.420
6           AI Engineer          92592               11        8417.455                  0.805
7              Mechanic         107373               23        4668.391                  0.460
8               Teacher          53419               12        4451.583                  0.815
9         HR Specialist         139225               12       11602.083                  0.610
10     Customer Support          85016                2       42508.000                  0.595
11        UX Researcher          82733                6       13788.833                  0.545
12    Financial Analyst         117455               22        5338.864                  0.465
13               Lawyer          79811               27        2955.963                  0.410
14       Data Scientist         115981                9       12886.778                  0.555
15   Research Scientist          96690               19        5088.947                  0.450
16     Graphic Designer          32869                2       16434.500                  0.385
17              Teacher          36893               29        1272.172                  0.380
18              Teacher         103744               11        9431.273                  0.390
19        Retail Worker         148015                2       74007.500                  0.450
20               Doctor         108069               15        7204.600                  0.650
21          AI Engineer          43403                1       43403.000                  0.925
22        HR Specialist          49508               27        1833.630                  0.725
23              Teacher          58251               25        2330.040                  0.815
24    Financial Analyst          33343               28        1190.821                  0.360
25          AI Engineer         125435               15        8362.333                  0.865
26    Software Engineer          39540               12        3295.000                  0.640
27             Mechanic          68304                7        9757.714                  0.380
28     Customer Support          33267               25        1330.680                  0.190
29        HR Specialist          89031               22        4046.864                  0.300
30        HR Specialist         102936               18        5718.667                  0.615
31              Teacher         114076               20        5703.800                  0.660
32        Retail Worker          69081                8        8635.125                  0.230
33        Retail Worker         102124               11        9284.000                  0.255
34         Truck Driver          91629               24        3817.875                  0.355
35              Teacher          43843               24        1826.792                  0.630
36             Mechanic          59703               25        2388.120                  0.685
37             Mechanic          64349                2       32174.500                  0.295
38     Customer Support          92292               25        3691.680                  0.355
39                 Chef          53524               20        2676.200                  0.330
40        Retail Worker          88017               21        4191.286                  0.160
41     Graphic Designer         111317               27        4122.852                  0.235
42               Doctor         144825               23        6296.739                  0.545
43   Research Scientist          52415                7        7487.857                  0.835
44  Construction Worker         134680               11       12243.636                  0.480
45     Customer Support         109714               28        3918.357                  0.040
46       Data Scientist          97067               12        8088.917                  0.335
47  Construction Worker          37561                2       18780.500                  0.250
48              Teacher         142581                4       35645.250                  0.480
49        UX Researcher          39111                5        7822.200                  0.475
50        Retail Worker          72101                3       24033.667                  0.405
51       Security Guard         117958                9       13106.444                  0.055
52          AI Engineer          97444               23        4236.696                  0.435
53          AI Engineer          30077               25        1203.080                  0.445
54        UX Researcher         148721               13       11440.077                  0.705
55     Customer Support         127720                0             Inf                  0.275
56       Data Scientist          50103                4       12525.750                  0.450
57     Graphic Designer         145033               13       11156.385                  0.515
58               Doctor          95310               25        3812.400                  0.925
59             Mechanic          93374               20        4668.700                  0.620
60   Research Scientist          71914               11        6537.636                  0.450
61    Financial Analyst         132547               21        6311.762                  0.385
62        UX Researcher         119106               17        7006.235                  0.600
63        UX Researcher          82603                0             Inf                  0.690
64       Security Guard         131358                7       18765.429                  0.510
65       Security Guard          83394               15        5559.600                  0.505
66                Nurse          92516               11        8410.545                  0.770
67     Graphic Designer          53752               21        2559.619                  0.500
68          AI Engineer         108411               22        4927.773                  0.885
69                 Chef         116145               27        4301.667                  0.350
70       Data Scientist         124613                4       31153.250                  0.500
71    Marketing Manager          30060               10        3006.000                  0.535
72    Marketing Manager          87134               11        7921.273                  0.435
73  Construction Worker          67641               15        4509.400                  0.115
74   Research Scientist          67265               26        2587.115                  0.485
75     Customer Support         145608               12       12134.000                  0.260
76             Mechanic          59629               16        3726.812                  0.525
77       Data Scientist          85619               17        5036.412                  0.730
78    Software Engineer         136506               29        4707.103                  0.345
79   Research Scientist         148533                4       37133.250                  0.835
80    Financial Analyst         105758               24        4406.583                  0.535
81    Marketing Manager          55559               27        2057.741                  0.520
82    Financial Analyst          31591                7        4513.000                  0.455
83    Financial Analyst          32469               27        1202.556                  0.595
84    Marketing Manager         117263               12        9771.917                  0.415
85        Retail Worker         121357                4       30339.250                  0.515
86                Nurse          54860               11        4987.273                  0.505
87        Retail Worker          36540                8        4567.500                  0.485
88        Retail Worker          58602               19        3084.316                  0.325
89               Lawyer          69341               24        2889.208                  0.260
90               Doctor          41536               29        1432.276                  0.605
91    Marketing Manager         113309               14        8093.500                  0.410
92          AI Engineer          78787                0             Inf                  0.655
93     Graphic Designer          98577                9       10953.000                  0.640
94  Construction Worker          54826                6        9137.667                  0.245
95    Marketing Manager          61890               22        2813.182                  0.440
96        HR Specialist          75500               28        2696.429                  0.470
97         Truck Driver          95128                3       31709.333                  0.560
98        UX Researcher          49975                3       16658.333                  0.345
99                 Chef          75893               16        4743.312                  0.605
100       HR Specialist         106619               29        3676.517                  0.655
101       HR Specialist         113310               14        8093.571                  0.565
102         AI Engineer          55611                9        6179.000                  0.690
103        Truck Driver         108131               15        7208.733                  0.160
104  Research Scientist          58625               16        3664.062                  0.465
105              Lawyer          47087                5        9417.400                  0.490
106    Customer Support         143942               18        7996.778                  0.180
107            Mechanic         109973               25        4398.920                  0.425
108        Truck Driver          57598               11        5236.182                  0.340
109              Doctor          75379               20        3768.950                  0.715
110       HR Specialist         130441               24        5435.042                  0.420
111       UX Researcher          72668                9        8074.222                  0.665
112      Data Scientist         140641               23        6114.826                  0.305
113   Marketing Manager          46014                2       23007.000                  0.500
114      Data Scientist          92438               23        4019.043                  0.640
115              Doctor         102240               27        3786.667                  0.910
116        Truck Driver          39686               29        1368.483                  0.475
117            Mechanic          40754               15        2716.933                  0.465
118       Retail Worker          40699                5        8139.800                  0.555
119       HR Specialist         120373                2       60186.500                  0.340
120   Software Engineer          70461                8        8807.625                  0.660
121       HR Specialist         103965               28        3713.036                  0.525
122  Research Scientist          58179               17        3422.294                  0.835
123              Doctor         125694                8       15711.750                  0.750
124                Chef         128723               27        4767.519                  0.265
125   Financial Analyst          36548               21        1740.381                  0.320
126  Research Scientist          40634               20        2031.700                  0.495
127       HR Specialist          62784               23        2729.739                  0.600
128               Nurse          37099               22        1686.318                  0.625
129    Graphic Designer          74857               13        5758.231                  0.165
130      Data Scientist          91063                7       13009.000                  0.500
131      Security Guard          89765               12        7480.417                  0.260
132            Mechanic          32461               19        1708.474                  0.615
133             Teacher          53911               13        4147.000                  0.565
134   Financial Analyst          50567               11        4597.000                  0.365
135   Marketing Manager          52656               11        4786.909                  0.465
136  Research Scientist          77701                9        8633.444                  0.500
137    Graphic Designer         137539                9       15282.111                  0.325
138  Research Scientist          46087                4       11521.750                  0.615
139              Lawyer          67861               20        3393.050                  0.365
140 Construction Worker          89792                5       17958.400                  0.315
141                Chef          36397               21        1733.190                  0.655
142      Data Scientist          49715               29        1714.310                  0.400
143              Lawyer         122573               21        5836.810                  0.540
144    Graphic Designer         133864               20        6693.200                  0.515
145                Chef          48745               20        2437.250                  0.680
146              Doctor          49446                0             Inf                  0.605
147               Nurse          98673                9       10963.667                  0.665
148    Customer Support          93870                3       31290.000                  0.245
149   Financial Analyst          72951               11        6631.909                  0.560
150 Construction Worker          37239               22        1692.682                  0.220
151    Customer Support         149798                7       21399.714                  0.185
152      Security Guard         149052                1      149052.000                  0.510
153             Teacher          39587                5        7917.400                  0.665
154   Marketing Manager         120301                0             Inf                  0.660
155       HR Specialist         117969                1      117969.000                  0.560
156      Security Guard          39528               20        1976.400                  0.330
157             Teacher          95677                3       31892.333                  0.735
158       HR Specialist          51778                8        6472.250                  0.305
159              Lawyer          36816               23        1600.696                  0.695
160  Research Scientist          53567               28        1913.107                  0.500
161              Lawyer         121170               16        7573.125                  0.815
162         AI Engineer          91944               28        3283.714                  0.640
163      Security Guard         123905               16        7744.062                  0.515
164             Teacher          73056               13        5619.692                  0.845
165        Truck Driver          89156               18        4953.111                  0.205
166   Marketing Manager         102124               15        6808.267                  0.510
167              Doctor          54995               17        3235.000                  0.860
168            Mechanic         100194               21        4771.143                  0.755
169              Lawyer          97534               25        3901.360                  0.350
170       UX Researcher         123547                1      123547.000                  0.545
171         AI Engineer         111926                3       37308.667                  0.835
172       HR Specialist         107487               19        5657.211                  0.540
173       HR Specialist         107362               17        6315.412                  0.595
174   Financial Analyst          44973               19        2367.000                  0.680
175  Research Scientist          30340               13        2333.846                  0.530
176              Doctor         104965               24        4373.542                  0.490
177        Truck Driver          74789               10        7478.900                  0.290
178      Security Guard          88954                0             Inf                  0.295
179             Teacher          78456                7       11208.000                  0.445
180   Financial Analyst         116698                2       58349.000                  0.445
181                Chef          40886                2       20443.000                  0.330
182         AI Engineer          78511                3       26170.333                  0.725
183         AI Engineer         136127                5       27225.400                  0.900
184        Truck Driver          45592               29        1572.138                  0.115
185      Security Guard         134859               13       10373.769                  0.170
186               Nurse         119678               24        4986.583                  0.970
187       UX Researcher          62402                8        7800.250                  0.270
188            Mechanic          53478                9        5942.000                  0.605
189              Lawyer          52005               15        3467.000                  0.560
190      Security Guard          82389               10        8238.900                  0.185
191                Chef          84336                3       28112.000                  0.670
192   Financial Analyst         112594               24        4691.417                  0.300
193      Security Guard          85243               26        3278.577                  0.310
194       UX Researcher          85668                3       28556.000                  0.440
195   Software Engineer          82428               14        5887.714                  0.705
196      Data Scientist         107240               25        4289.600                  0.370
197       UX Researcher         120270                8       15033.750                  0.320
198         AI Engineer          74605               21        3552.619                  0.570
199       UX Researcher         140059                5       28011.800                  0.695
200            Mechanic          96155               18        5341.944                  0.345
 [ reached 'max' / getOption("max.print") -- omitted 2800 rows ]
> 
> # ==============================================================================
> # 3. METHOD B: CONDITIONAL LOGIC (case_when and ifelse)
> # ==============================================================================
> # Scenario 1: Create a categorical 'Experience_Level' based on Years_Experience.
> # We use the versatile case_when() function for multiple conditions.
> # Logic: 
> #   Years_Experience <= 5: "Junior"
> #   Years_Experience > 5 AND <= 15: "Mid-Level"
> #   Years_Experience > 15: "Senior/Expert"
> 
> df_logic <- ai_jobs_df %>%
+     mutate(
+         Experience_Level = case_when(
+             Years_Experience <= 5 ~ "Junior",
+             Years_Experience > 5 & Years_Experience <= 15 ~ "Mid-Level",
+             Years_Experience > 15 ~ "Senior/Expert",
+             TRUE ~ "Unknown" # Default catch-all
+         ),
+         # Scenario 2: Simple binary check for low automation risk
+         Is_Low_Automation = ifelse(Automation_Probability_2030 < 0.20, TRUE, FALSE)
+     )
> 
> print("--- Method B: Logic Results (Experience Level & Low Automation Flag) ---")
[1] "--- Method B: Logic Results (Experience Level & Low Automation Flag) ---"
> print(df_logic %>% select(Years_Experience, Experience_Level, Automation_Probability_2030, Is_Low_Automation))
    Years_Experience Experience_Level Automation_Probability_2030 Is_Low_Automation
1                 28    Senior/Expert                        0.85             FALSE
2                 20    Senior/Expert                        0.05              TRUE
3                  2           Junior                        0.81             FALSE
4                 13        Mid-Level                        0.60             FALSE
5                 22    Senior/Expert                        0.64             FALSE
6                 11        Mid-Level                        0.10              TRUE
7                 23    Senior/Expert                        0.41             FALSE
8                 12        Mid-Level                        0.17              TRUE
9                 12        Mid-Level                        0.48             FALSE
10                 2           Junior                        0.80             FALSE
11                 6        Mid-Level                        0.41             FALSE
12                22    Senior/Expert                        0.40             FALSE
13                27    Senior/Expert                        0.50             FALSE
14                 9        Mid-Level                        0.63             FALSE
15                19    Senior/Expert                        0.21             FALSE
16                 2           Junior                        0.58             FALSE
17                29    Senior/Expert                        0.27             FALSE
18                11        Mid-Level                        0.28             FALSE
19                 2           Junior                        0.93             FALSE
20                15        Mid-Level                        0.15              TRUE
21                 1           Junior                        0.06              TRUE
22                27    Senior/Expert                        0.33             FALSE
23                25    Senior/Expert                        0.29             FALSE
24                28    Senior/Expert                        0.54             FALSE
25                15        Mid-Level                        0.17              TRUE
26                12        Mid-Level                        0.56             FALSE
27                 7        Mid-Level                        0.33             FALSE
28                25    Senior/Expert                        0.92             FALSE
29                22    Senior/Expert                        0.47             FALSE
30                18    Senior/Expert                        0.68             FALSE
31                20    Senior/Expert                        0.19              TRUE
32                 8        Mid-Level                        0.72             FALSE
33                11        Mid-Level                        0.93             FALSE
34                24    Senior/Expert                        0.92             FALSE
35                24    Senior/Expert                        0.22             FALSE
36                25    Senior/Expert                        0.44             FALSE
37                 2           Junior                        0.59             FALSE
38                25    Senior/Expert                        0.91             FALSE
39                20    Senior/Expert                        0.40             FALSE
40                21    Senior/Expert                        0.91             FALSE
41                27    Senior/Expert                        0.55             FALSE
42                23    Senior/Expert                        0.07              TRUE
43                 7        Mid-Level                        0.15              TRUE
44                11        Mid-Level                        0.83             FALSE
45                28    Senior/Expert                        0.93             FALSE
46                12        Mid-Level                        0.46             FALSE
47                 2           Junior                        0.85             FALSE
48                 4           Junior                        0.11              TRUE
49                 5           Junior                        0.65             FALSE
50                 3           Junior                        0.76             FALSE
51                 9        Mid-Level                        0.90             FALSE
52                23    Senior/Expert                        0.14              TRUE
53                25    Senior/Expert                        0.20             FALSE
54                13        Mid-Level                        0.52             FALSE
55                 0           Junior                        0.74             FALSE
56                 4           Junior                        0.61             FALSE
57                13        Mid-Level                        0.36             FALSE
58                25    Senior/Expert                        0.08              TRUE
59                20    Senior/Expert                        0.38             FALSE
60                11        Mid-Level                        0.19              TRUE
61                21    Senior/Expert                        0.37             FALSE
62                17    Senior/Expert                        0.51             FALSE
63                 0           Junior                        0.59             FALSE
64                 7        Mid-Level                        0.88             FALSE
65                15        Mid-Level                        0.81             FALSE
66                11        Mid-Level                        0.24             FALSE
67                21    Senior/Expert                        0.35             FALSE
68                22    Senior/Expert                        0.12              TRUE
69                27    Senior/Expert                        0.34             FALSE
70                 4           Junior                        0.52             FALSE
71                10        Mid-Level                        0.33             FALSE
72                11        Mid-Level                        0.59             FALSE
73                15        Mid-Level                        0.84             FALSE
74                26    Senior/Expert                        0.20             FALSE
75                12        Mid-Level                        0.85             FALSE
76                16    Senior/Expert                        0.55             FALSE
77                17    Senior/Expert                        0.31             FALSE
78                29    Senior/Expert                        0.70             FALSE
79                 4           Junior                        0.27             FALSE
80                24    Senior/Expert                        0.34             FALSE
81                27    Senior/Expert                        0.59             FALSE
82                 7        Mid-Level                        0.41             FALSE
83                27    Senior/Expert                        0.65             FALSE
84                12        Mid-Level                        0.55             FALSE
85                 4           Junior                        0.87             FALSE
86                11        Mid-Level                        0.24             FALSE
87                 8        Mid-Level                        0.87             FALSE
88                19    Senior/Expert                        0.95             FALSE
89                24    Senior/Expert                        0.61             FALSE
90                29    Senior/Expert                        0.10              TRUE
91                14        Mid-Level                        0.58             FALSE
92                 0           Junior                        0.13              TRUE
93                 9        Mid-Level                        0.55             FALSE
94                 6        Mid-Level                        0.85             FALSE
95                22    Senior/Expert                        0.65             FALSE
96                28    Senior/Expert                        0.64             FALSE
97                 3           Junior                        0.85             FALSE
98                 3           Junior                        0.40             FALSE
99                16    Senior/Expert                        0.40             FALSE
100               29    Senior/Expert                        0.54             FALSE
101               14        Mid-Level                        0.31             FALSE
102                9        Mid-Level                        0.22             FALSE
103               15        Mid-Level                        0.74             FALSE
104               16    Senior/Expert                        0.24             FALSE
105                5           Junior                        0.70             FALSE
106               18    Senior/Expert                        0.77             FALSE
107               25    Senior/Expert                        0.56             FALSE
108               11        Mid-Level                        0.84             FALSE
109               20    Senior/Expert                        0.09              TRUE
110               24    Senior/Expert                        0.64             FALSE
111                9        Mid-Level                        0.56             FALSE
112               23    Senior/Expert                        0.57             FALSE
113                2           Junior                        0.39             FALSE
114               23    Senior/Expert                        0.59             FALSE
115               27    Senior/Expert                        0.11              TRUE
116               29    Senior/Expert                        0.72             FALSE
117               15        Mid-Level                        0.69             FALSE
118                5           Junior                        0.73             FALSE
119                2           Junior                        0.53             FALSE
120                8        Mid-Level                        0.36             FALSE
121               28    Senior/Expert                        0.63             FALSE
122               17    Senior/Expert                        0.05              TRUE
123                8        Mid-Level                        0.07              TRUE
124               27    Senior/Expert                        0.62             FALSE
125               21    Senior/Expert                        0.57             FALSE
126               20    Senior/Expert                        0.17              TRUE
127               23    Senior/Expert                        0.48             FALSE
128               22    Senior/Expert                        0.23             FALSE
129               13        Mid-Level                        0.68             FALSE
130                7        Mid-Level                        0.38             FALSE
131               12        Mid-Level                        0.90             FALSE
132               19    Senior/Expert                        0.65             FALSE
133               13        Mid-Level                        0.09              TRUE
134               11        Mid-Level                        0.54             FALSE
135               11        Mid-Level                        0.34             FALSE
136                9        Mid-Level                        0.24             FALSE
137                9        Mid-Level                        0.46             FALSE
138                4           Junior                        0.19              TRUE
139               20    Senior/Expert                        0.48             FALSE
140                5           Junior                        0.73             FALSE
141               21    Senior/Expert                        0.42             FALSE
142               29    Senior/Expert                        0.47             FALSE
143               21    Senior/Expert                        0.66             FALSE
144               20    Senior/Expert                        0.44             FALSE
145               20    Senior/Expert                        0.38             FALSE
146                0           Junior                        0.27             FALSE
147                9        Mid-Level                        0.21             FALSE
148                3           Junior                        0.75             FALSE
149               11        Mid-Level                        0.34             FALSE
150               22    Senior/Expert                        0.92             FALSE
151                7        Mid-Level                        0.74             FALSE
152                1           Junior                        0.81             FALSE
153                5           Junior                        0.13              TRUE
154                0           Junior                        0.44             FALSE
155                1           Junior                        0.57             FALSE
156               20    Senior/Expert                        0.93             FALSE
157                3           Junior                        0.15              TRUE
158                8        Mid-Level                        0.55             FALSE
159               23    Senior/Expert                        0.33             FALSE
160               28    Senior/Expert                        0.16              TRUE
161               16    Senior/Expert                        0.31             FALSE
162               28    Senior/Expert                        0.08              TRUE
163               16    Senior/Expert                        0.93             FALSE
164               13        Mid-Level                        0.26             FALSE
165               18    Senior/Expert                        0.71             FALSE
166               15        Mid-Level                        0.68             FALSE
167               17    Senior/Expert                        0.19              TRUE
168               21    Senior/Expert                        0.37             FALSE
169               25    Senior/Expert                        0.39             FALSE
170                1           Junior                        0.53             FALSE
171                3           Junior                        0.29             FALSE
172               19    Senior/Expert                        0.34             FALSE
173               17    Senior/Expert                        0.50             FALSE
174               19    Senior/Expert                        0.61             FALSE
175               13        Mid-Level                        0.26             FALSE
176               24    Senior/Expert                        0.23             FALSE
177               10        Mid-Level                        0.87             FALSE
178                0           Junior                        0.85             FALSE
179                7        Mid-Level                        0.26             FALSE
180                2           Junior                        0.42             FALSE
181                2           Junior                        0.60             FALSE
182                3           Junior                        0.14              TRUE
183                5           Junior                        0.15              TRUE
184               29    Senior/Expert                        0.79             FALSE
185               13        Mid-Level                        0.84             FALSE
186               24    Senior/Expert                        0.06              TRUE
187                8        Mid-Level                        0.62             FALSE
188                9        Mid-Level                        0.65             FALSE
189               15        Mid-Level                        0.49             FALSE
190               10        Mid-Level                        0.90             FALSE
191                3           Junior                        0.57             FALSE
192               24    Senior/Expert                        0.66             FALSE
193               26    Senior/Expert                        0.80             FALSE
194                3           Junior                        0.57             FALSE
195               14        Mid-Level                        0.53             FALSE
196               25    Senior/Expert                        0.41             FALSE
197                8        Mid-Level                        0.67             FALSE
198               21    Senior/Expert                        0.10              TRUE
199                5           Junior                        0.50             FALSE
200               18    Senior/Expert                        0.58             FALSE
201               23    Senior/Expert                        0.85             FALSE
202                4           Junior                        0.27             FALSE
203                2           Junior                        0.41             FALSE
204               10        Mid-Level                        0.68             FALSE
205               14        Mid-Level                        0.15              TRUE
206                3           Junior                        0.48             FALSE
207               22    Senior/Expert                        0.84             FALSE
208               14        Mid-Level                        0.59             FALSE
209               21    Senior/Expert                        0.60             FALSE
210               24    Senior/Expert                        0.21             FALSE
211                0           Junior                        0.91             FALSE
212               22    Senior/Expert                        0.17              TRUE
213               26    Senior/Expert                        0.83             FALSE
214               19    Senior/Expert                        0.78             FALSE
215               16    Senior/Expert                        0.38             FALSE
216               29    Senior/Expert                        0.56             FALSE
217               28    Senior/Expert                        0.52             FALSE
218               27    Senior/Expert                        0.36             FALSE
219                2           Junior                        0.16              TRUE
220               15        Mid-Level                        0.55             FALSE
221                5           Junior                        0.70             FALSE
222               10        Mid-Level                        0.23             FALSE
223               17    Senior/Expert                        0.57             FALSE
224               26    Senior/Expert                        0.14              TRUE
225               26    Senior/Expert                        0.48             FALSE
226               23    Senior/Expert                        0.89             FALSE
227               18    Senior/Expert                        0.42             FALSE
228               13        Mid-Level                        0.68             FALSE
229               29    Senior/Expert                        0.36             FALSE
230               21    Senior/Expert                        0.37             FALSE
231               21    Senior/Expert                        0.85             FALSE
232               28    Senior/Expert                        0.85             FALSE
233               29    Senior/Expert                        0.49             FALSE
234               11        Mid-Level                        0.81             FALSE
235                5           Junior                        0.69             FALSE
236               13        Mid-Level                        0.79             FALSE
237               23    Senior/Expert                        0.61             FALSE
238               27    Senior/Expert                        0.76             FALSE
239               26    Senior/Expert                        0.92             FALSE
240                5           Junior                        0.89             FALSE
241               22    Senior/Expert                        0.24             FALSE
242                5           Junior                        0.51             FALSE
243               26    Senior/Expert                        0.70             FALSE
244               21    Senior/Expert                        0.55             FALSE
245               18    Senior/Expert                        0.46             FALSE
246                9        Mid-Level                        0.06              TRUE
247               21    Senior/Expert                        0.54             FALSE
248                7        Mid-Level                        0.18              TRUE
249               28    Senior/Expert                        0.85             FALSE
250               18    Senior/Expert                        0.86             FALSE
 [ reached 'max' / getOption("max.print") -- omitted 2750 rows ]
> 
> # ==============================================================================
> # 4. METHOD C: TEXT TRANSFORMATION (paste)
> # ==============================================================================
> # Scenario: Create a 'Job_Summary' that combines the Job Title and its Risk Category.
> # Function: paste0() joins strings without a space by default.
> 
> df_text <- ai_jobs_df %>%
+     mutate(
+         Job_Summary = paste0(Job_Title, " - ", Risk_Category, " Risk")
+     )
> print("--- Method C: Text Transformation (Job Summary) ---")
[1] "--- Method C: Text Transformation (Job Summary) ---"
> print(head(df_text$Job_Summary))
[1] "Security Guard - High Risk"      "Research Scientist - Low Risk"   "Construction Worker - High Risk"
[4] "Software Engineer - Medium Risk" "Financial Analyst - Medium Risk" "AI Engineer - Low Risk"         
> 
> # ==============================================================================
> # 5. ALL TOGETHER (The Standard Workflow)
> # ==============================================================================
> 
> final_dataset <- ai_jobs_df %>%
+     mutate(
+         # Calculation 1: Adjusted Salary (Salary scaled by Tech Growth)
+         Adjusted_Salary = Average_Salary * Tech_Growth_Factor,
+         
+         # Calculation 2: Risk Flag (based on a combination of factors)
+         Is_High_Risk = ifelse(
+             Automation_Probability_2030 > 0.75 | Risk_Category == "High", 
+             "Flagged", 
+             "Safe"
+         ),
+         
+         # Text Combo: A brief report on the job's risk factors
+         Risk_Report = paste0(
+             "AI Exposure: ", round(AI_Exposure_Index, 2), 
+             " | Auto Prob: ", round(Automation_Probability_2030, 2),
+             " (", Risk_Category, ")"
+         )
+     )
> 
> print("--- Final Combined Dataset (Showing New Variables) ---")
[1] "--- Final Combined Dataset (Showing New Variables) ---"
> print(head(final_dataset %>% select(Job_Title, Adjusted_Salary, Is_High_Risk, Risk_Report)))
            Job_Title Adjusted_Salary Is_High_Risk                                  Risk_Report
1      Security Guard        58617.60      Flagged   AI Exposure: 0.18 | Auto Prob: 0.85 (High)
2  Research Scientist       148024.05         Safe    AI Exposure: 0.62 | Auto Prob: 0.05 (Low)
3 Construction Worker       172534.88      Flagged   AI Exposure: 0.86 | Auto Prob: 0.81 (High)
4   Software Engineer        92840.40         Safe  AI Exposure: 0.39 | Auto Prob: 0.6 (Medium)
5   Financial Analyst       102779.62         Safe AI Exposure: 0.52 | Auto Prob: 0.64 (Medium)
6         AI Engineer        47221.92         Safe     AI Exposure: 0.29 | Auto Prob: 0.1 (Low)
> prac 10 part again
Error: unexpected numeric constant in "prac 10"

> # ==============================================================================
> # R Script: Creating New Variables (Transformations & Calculations)
> # Dataset: AI Job Impact Data
> # ==============================================================================
> 
> library(dplyr)
> library(tidyr) 
> library(stringr) 
> 
> # ------------------------------------------------------------------------------
> # 1. SETUP: Import the Dataset
> # ------------------------------------------------------------------------------
> 
> # Import data
> ai_jobs_df <- read.csv("AI_Impact_on_Jobs_2030.csv")
> 
> print("--- Baseline Data Sample ---")
[1] "--- Baseline Data Sample ---"
> # Show key columns used for the upcoming calculations
> print(head(ai_jobs_df, 3) %>% select(Job_Title, Average_Salary, Years_Experience, AI_Exposure_Index))
            Job_Title Average_Salary Years_Experience AI_Exposure_Index
1      Security Guard          45795               28              0.18
2  Research Scientist         133355               20              0.62
3 Construction Worker         146216                2              0.86
> 
> # ==============================================================================
> # 2. METHOD A: ARITHMETIC CALCULATIONS
> # ==============================================================================
> # Scenario 1: Calculate Salary Efficiency (Salary per Year of Experience).
> # Formula: Average_Salary / Years_Experience
> 
> # Scenario 2: Create a composite "Future Readiness Score". (Higher score is better)
> # Formula: (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) / 2
> 
> df_calc <- ai_jobs_df %>%
+     mutate(
+         Salary_Per_Year = Average_Salary / Years_Experience,
+         Future_Readiness_Score = ( (1 - Automation_Probability_2030) + (1 - AI_Exposure_Index) ) / 2
+     )
> 
> print("--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---")
[1] "--- Method A: Arithmetic Results (Salary Efficiency & Readiness Score) ---"
> print(df_calc %>% select(Job_Title, Average_Salary, Years_Experience, Salary_Per_Year, Future_Readiness_Score))
              Job_Title Average_Salary Years_Experience Salary_Per_Year Future_Readiness_Score
1        Security Guard          45795               28        1635.536                  0.485
2    Research Scientist         133355               20        6667.750                  0.665
3   Construction Worker         146216                2       73108.000                  0.165
4     Software Engineer         136530               13       10502.308                  0.505
5     Financial Analyst          70397               22        3199.864                  0.420
6           AI Engineer          92592               11        8417.455                  0.805
7              Mechanic         107373               23        4668.391                  0.460
8               Teacher          53419               12        4451.583                  0.815
9         HR Specialist         139225               12       11602.083                  0.610
10     Customer Support          85016                2       42508.000                  0.595
11        UX Researcher          82733                6       13788.833                  0.545
12    Financial Analyst         117455               22        5338.864                  0.465
13               Lawyer          79811               27        2955.963                  0.410
14       Data Scientist         115981                9       12886.778                  0.555
15   Research Scientist          96690               19        5088.947                  0.450
16     Graphic Designer          32869                2       16434.500                  0.385
17              Teacher          36893               29        1272.172                  0.380
18              Teacher         103744               11        9431.273                  0.390
19        Retail Worker         148015                2       74007.500                  0.450
20               Doctor         108069               15        7204.600                  0.650
21          AI Engineer          43403                1       43403.000                  0.925
22        HR Specialist          49508               27        1833.630                  0.725
23              Teacher          58251               25        2330.040                  0.815
24    Financial Analyst          33343               28        1190.821                  0.360
25          AI Engineer         125435               15        8362.333                  0.865
26    Software Engineer          39540               12        3295.000                  0.640
27             Mechanic          68304                7        9757.714                  0.380
28     Customer Support          33267               25        1330.680                  0.190
29        HR Specialist          89031               22        4046.864                  0.300
30        HR Specialist         102936               18        5718.667                  0.615
31              Teacher         114076               20        5703.800                  0.660
32        Retail Worker          69081                8        8635.125                  0.230
33        Retail Worker         102124               11        9284.000                  0.255
34         Truck Driver          91629               24        3817.875                  0.355
35              Teacher          43843               24        1826.792                  0.630
36             Mechanic          59703               25        2388.120                  0.685
37             Mechanic          64349                2       32174.500                  0.295
38     Customer Support          92292               25        3691.680                  0.355
39                 Chef          53524               20        2676.200                  0.330
40        Retail Worker          88017               21        4191.286                  0.160
41     Graphic Designer         111317               27        4122.852                  0.235
42               Doctor         144825               23        6296.739                  0.545
43   Research Scientist          52415                7        7487.857                  0.835
44  Construction Worker         134680               11       12243.636                  0.480
45     Customer Support         109714               28        3918.357                  0.040
46       Data Scientist          97067               12        8088.917                  0.335
47  Construction Worker          37561                2       18780.500                  0.250
48              Teacher         142581                4       35645.250                  0.480
49        UX Researcher          39111                5        7822.200                  0.475
50        Retail Worker          72101                3       24033.667                  0.405
51       Security Guard         117958                9       13106.444                  0.055
52          AI Engineer          97444               23        4236.696                  0.435
53          AI Engineer          30077               25        1203.080                  0.445
54        UX Researcher         148721               13       11440.077                  0.705
55     Customer Support         127720                0             Inf                  0.275
56       Data Scientist          50103                4       12525.750                  0.450
57     Graphic Designer         145033               13       11156.385                  0.515
58               Doctor          95310               25        3812.400                  0.925
59             Mechanic          93374               20        4668.700                  0.620
60   Research Scientist          71914               11        6537.636                  0.450
61    Financial Analyst         132547               21        6311.762                  0.385
62        UX Researcher         119106               17        7006.235                  0.600
63        UX Researcher          82603                0             Inf                  0.690
64       Security Guard         131358                7       18765.429                  0.510
65       Security Guard          83394               15        5559.600                  0.505
66                Nurse          92516               11        8410.545                  0.770
67     Graphic Designer          53752               21        2559.619                  0.500
68          AI Engineer         108411               22        4927.773                  0.885
69                 Chef         116145               27        4301.667                  0.350
70       Data Scientist         124613                4       31153.250                  0.500
71    Marketing Manager          30060               10        3006.000                  0.535
72    Marketing Manager          87134               11        7921.273                  0.435
73  Construction Worker          67641               15        4509.400                  0.115
74   Research Scientist          67265               26        2587.115                  0.485
75     Customer Support         145608               12       12134.000                  0.260
76             Mechanic          59629               16        3726.812                  0.525
77       Data Scientist          85619               17        5036.412                  0.730
78    Software Engineer         136506               29        4707.103                  0.345
79   Research Scientist         148533                4       37133.250                  0.835
80    Financial Analyst         105758               24        4406.583                  0.535
81    Marketing Manager          55559               27        2057.741                  0.520
82    Financial Analyst          31591                7        4513.000                  0.455
83    Financial Analyst          32469               27        1202.556                  0.595
84    Marketing Manager         117263               12        9771.917                  0.415
85        Retail Worker         121357                4       30339.250                  0.515
86                Nurse          54860               11        4987.273                  0.505
87        Retail Worker          36540                8        4567.500                  0.485
88        Retail Worker          58602               19        3084.316                  0.325
89               Lawyer          69341               24        2889.208                  0.260
90               Doctor          41536               29        1432.276                  0.605
91    Marketing Manager         113309               14        8093.500                  0.410
92          AI Engineer          78787                0             Inf                  0.655
93     Graphic Designer          98577                9       10953.000                  0.640
94  Construction Worker          54826                6        9137.667                  0.245
95    Marketing Manager          61890               22        2813.182                  0.440
96        HR Specialist          75500               28        2696.429                  0.470
97         Truck Driver          95128                3       31709.333                  0.560
98        UX Researcher          49975                3       16658.333                  0.345
99                 Chef          75893               16        4743.312                  0.605
100       HR Specialist         106619               29        3676.517                  0.655
101       HR Specialist         113310               14        8093.571                  0.565
102         AI Engineer          55611                9        6179.000                  0.690
103        Truck Driver         108131               15        7208.733                  0.160
104  Research Scientist          58625               16        3664.062                  0.465
105              Lawyer          47087                5        9417.400                  0.490
106    Customer Support         143942               18        7996.778                  0.180
107            Mechanic         109973               25        4398.920                  0.425
108        Truck Driver          57598               11        5236.182                  0.340
109              Doctor          75379               20        3768.950                  0.715
110       HR Specialist         130441               24        5435.042                  0.420
111       UX Researcher          72668                9        8074.222                  0.665
112      Data Scientist         140641               23        6114.826                  0.305
113   Marketing Manager          46014                2       23007.000                  0.500
114      Data Scientist          92438               23        4019.043                  0.640
115              Doctor         102240               27        3786.667                  0.910
116        Truck Driver          39686               29        1368.483                  0.475
117            Mechanic          40754               15        2716.933                  0.465
118       Retail Worker          40699                5        8139.800                  0.555
119       HR Specialist         120373                2       60186.500                  0.340
120   Software Engineer          70461                8        8807.625                  0.660
121       HR Specialist         103965               28        3713.036                  0.525
122  Research Scientist          58179               17        3422.294                  0.835
123              Doctor         125694                8       15711.750                  0.750
124                Chef         128723               27        4767.519                  0.265
125   Financial Analyst          36548               21        1740.381                  0.320
126  Research Scientist          40634               20        2031.700                  0.495
127       HR Specialist          62784               23        2729.739                  0.600
128               Nurse          37099               22        1686.318                  0.625
129    Graphic Designer          74857               13        5758.231                  0.165
130      Data Scientist          91063                7       13009.000                  0.500
131      Security Guard          89765               12        7480.417                  0.260
132            Mechanic          32461               19        1708.474                  0.615
133             Teacher          53911               13        4147.000                  0.565
134   Financial Analyst          50567               11        4597.000                  0.365
135   Marketing Manager          52656               11        4786.909                  0.465
136  Research Scientist          77701                9        8633.444                  0.500
137    Graphic Designer         137539                9       15282.111                  0.325
138  Research Scientist          46087                4       11521.750                  0.615
139              Lawyer          67861               20        3393.050                  0.365
140 Construction Worker          89792                5       17958.400                  0.315
141                Chef          36397               21        1733.190                  0.655
142      Data Scientist          49715               29        1714.310                  0.400
143              Lawyer         122573               21        5836.810                  0.540
144    Graphic Designer         133864               20        6693.200                  0.515
145                Chef          48745               20        2437.250                  0.680
146              Doctor          49446                0             Inf                  0.605
147               Nurse          98673                9       10963.667                  0.665
148    Customer Support          93870                3       31290.000                  0.245
149   Financial Analyst          72951               11        6631.909                  0.560
150 Construction Worker          37239               22        1692.682                  0.220
151    Customer Support         149798                7       21399.714                  0.185
152      Security Guard         149052                1      149052.000                  0.510
153             Teacher          39587                5        7917.400                  0.665
154   Marketing Manager         120301                0             Inf                  0.660
155       HR Specialist         117969                1      117969.000                  0.560
156      Security Guard          39528               20        1976.400                  0.330
157             Teacher          95677                3       31892.333                  0.735
158       HR Specialist          51778                8        6472.250                  0.305
159              Lawyer          36816               23        1600.696                  0.695
160  Research Scientist          53567               28        1913.107                  0.500
161              Lawyer         121170               16        7573.125                  0.815
162         AI Engineer          91944               28        3283.714                  0.640
163      Security Guard         123905               16        7744.062                  0.515
164             Teacher          73056               13        5619.692                  0.845
165        Truck Driver          89156               18        4953.111                  0.205
166   Marketing Manager         102124               15        6808.267                  0.510
167              Doctor          54995               17        3235.000                  0.860
168            Mechanic         100194               21        4771.143                  0.755
169              Lawyer          97534               25        3901.360                  0.350
170       UX Researcher         123547                1      123547.000                  0.545
171         AI Engineer         111926                3       37308.667                  0.835
172       HR Specialist         107487               19        5657.211                  0.540
173       HR Specialist         107362               17        6315.412                  0.595
174   Financial Analyst          44973               19        2367.000                  0.680
175  Research Scientist          30340               13        2333.846                  0.530
176              Doctor         104965               24        4373.542                  0.490
177        Truck Driver          74789               10        7478.900                  0.290
178      Security Guard          88954                0             Inf                  0.295
179             Teacher          78456                7       11208.000                  0.445
180   Financial Analyst         116698                2       58349.000                  0.445
181                Chef          40886                2       20443.000                  0.330
182         AI Engineer          78511                3       26170.333                  0.725
183         AI Engineer         136127                5       27225.400                  0.900
184        Truck Driver          45592               29        1572.138                  0.115
185      Security Guard         134859               13       10373.769                  0.170
186               Nurse         119678               24        4986.583                  0.970
187       UX Researcher          62402                8        7800.250                  0.270
188            Mechanic          53478                9        5942.000                  0.605
189              Lawyer          52005               15        3467.000                  0.560
190      Security Guard          82389               10        8238.900                  0.185
191                Chef          84336                3       28112.000                  0.670
192   Financial Analyst         112594               24        4691.417                  0.300
193      Security Guard          85243               26        3278.577                  0.310
194       UX Researcher          85668                3       28556.000                  0.440
195   Software Engineer          82428               14        5887.714                  0.705
196      Data Scientist         107240               25        4289.600                  0.370
197       UX Researcher         120270                8       15033.750                  0.320
198         AI Engineer          74605               21        3552.619                  0.570
199       UX Researcher         140059                5       28011.800                  0.695
200            Mechanic          96155               18        5341.944                  0.345
 [ reached 'max' / getOption("max.print") -- omitted 2800 rows ]
> 
> # ==============================================================================
> # 3. METHOD B: CONDITIONAL LOGIC (case_when and ifelse)
> # ==============================================================================
> # Scenario 1: Create a categorical 'Experience_Level' based on Years_Experience.
> # We use the versatile case_when() function for multiple conditions.
> # Logic: 
> #   Years_Experience <= 5: "Junior"
> #   Years_Experience > 5 AND <= 15: "Mid-Level"
> #   Years_Experience > 15: "Senior/Expert"
> 
> df_logic <- ai_jobs_df %>%
+     mutate(
+         Experience_Level = case_when(
+             Years_Experience <= 5 ~ "Junior",
+             Years_Experience > 5 & Years_Experience <= 15 ~ "Mid-Level",
+             Years_Experience > 15 ~ "Senior/Expert",
+             TRUE ~ "Unknown" # Default catch-all
+         ),
+         # Scenario 2: Simple binary check for low automation risk
+         Is_Low_Automation = ifelse(Automation_Probability_2030 < 0.20, TRUE, FALSE)
+     )
> 
> print("--- Method B: Logic Results (Experience Level & Low Automation Flag) ---")
[1] "--- Method B: Logic Results (Experience Level & Low Automation Flag) ---"
> print(df_logic %>% select(Years_Experience, Experience_Level, Automation_Probability_2030, Is_Low_Automation))
    Years_Experience Experience_Level Automation_Probability_2030 Is_Low_Automation
1                 28    Senior/Expert                        0.85             FALSE
2                 20    Senior/Expert                        0.05              TRUE
3                  2           Junior                        0.81             FALSE
4                 13        Mid-Level                        0.60             FALSE
5                 22    Senior/Expert                        0.64             FALSE
6                 11        Mid-Level                        0.10              TRUE
7                 23    Senior/Expert                        0.41             FALSE
8                 12        Mid-Level                        0.17              TRUE
9                 12        Mid-Level                        0.48             FALSE
10                 2           Junior                        0.80             FALSE
11                 6        Mid-Level                        0.41             FALSE
12                22    Senior/Expert                        0.40             FALSE
13                27    Senior/Expert                        0.50             FALSE
14                 9        Mid-Level                        0.63             FALSE
15                19    Senior/Expert                        0.21             FALSE
16                 2           Junior                        0.58             FALSE
17                29    Senior/Expert                        0.27             FALSE
18                11        Mid-Level                        0.28             FALSE
19                 2           Junior                        0.93             FALSE
20                15        Mid-Level                        0.15              TRUE
21                 1           Junior                        0.06              TRUE
22                27    Senior/Expert                        0.33             FALSE
23                25    Senior/Expert                        0.29             FALSE
24                28    Senior/Expert                        0.54             FALSE
25                15        Mid-Level                        0.17              TRUE
26                12        Mid-Level                        0.56             FALSE
27                 7        Mid-Level                        0.33             FALSE
28                25    Senior/Expert                        0.92             FALSE
29                22    Senior/Expert                        0.47             FALSE
30                18    Senior/Expert                        0.68             FALSE
31                20    Senior/Expert                        0.19              TRUE
32                 8        Mid-Level                        0.72             FALSE
33                11        Mid-Level                        0.93             FALSE
34                24    Senior/Expert                        0.92             FALSE
35                24    Senior/Expert                        0.22             FALSE
36                25    Senior/Expert                        0.44             FALSE
37                 2           Junior                        0.59             FALSE
38                25    Senior/Expert                        0.91             FALSE
39                20    Senior/Expert                        0.40             FALSE
40                21    Senior/Expert                        0.91             FALSE
41                27    Senior/Expert                        0.55             FALSE
42                23    Senior/Expert                        0.07              TRUE
43                 7        Mid-Level                        0.15              TRUE
44                11        Mid-Level                        0.83             FALSE
45                28    Senior/Expert                        0.93             FALSE
46                12        Mid-Level                        0.46             FALSE
47                 2           Junior                        0.85             FALSE
48                 4           Junior                        0.11              TRUE
49                 5           Junior                        0.65             FALSE
50                 3           Junior                        0.76             FALSE
51                 9        Mid-Level                        0.90             FALSE
52                23    Senior/Expert                        0.14              TRUE
53                25    Senior/Expert                        0.20             FALSE
54                13        Mid-Level                        0.52             FALSE
55                 0           Junior                        0.74             FALSE
56                 4           Junior                        0.61             FALSE
57                13        Mid-Level                        0.36             FALSE
58                25    Senior/Expert                        0.08              TRUE
59                20    Senior/Expert                        0.38             FALSE
60                11        Mid-Level                        0.19              TRUE
61                21    Senior/Expert                        0.37             FALSE
62                17    Senior/Expert                        0.51             FALSE
63                 0           Junior                        0.59             FALSE
64                 7        Mid-Level                        0.88             FALSE
65                15        Mid-Level                        0.81             FALSE
66                11        Mid-Level                        0.24             FALSE
67                21    Senior/Expert                        0.35             FALSE
68                22    Senior/Expert                        0.12              TRUE
69                27    Senior/Expert                        0.34             FALSE
70                 4           Junior                        0.52             FALSE
71                10        Mid-Level                        0.33             FALSE
72                11        Mid-Level                        0.59             FALSE
73                15        Mid-Level                        0.84             FALSE
74                26    Senior/Expert                        0.20             FALSE
75                12        Mid-Level                        0.85             FALSE
76                16    Senior/Expert                        0.55             FALSE
77                17    Senior/Expert                        0.31             FALSE
78                29    Senior/Expert                        0.70             FALSE
79                 4           Junior                        0.27             FALSE
80                24    Senior/Expert                        0.34             FALSE
81                27    Senior/Expert                        0.59             FALSE
82                 7        Mid-Level                        0.41             FALSE
83                27    Senior/Expert                        0.65             FALSE
84                12        Mid-Level                        0.55             FALSE
85                 4           Junior                        0.87             FALSE
86                11        Mid-Level                        0.24             FALSE
87                 8        Mid-Level                        0.87             FALSE
88                19    Senior/Expert                        0.95             FALSE
89                24    Senior/Expert                        0.61             FALSE
90                29    Senior/Expert                        0.10              TRUE
91                14        Mid-Level                        0.58             FALSE
92                 0           Junior                        0.13              TRUE
93                 9        Mid-Level                        0.55             FALSE
94                 6        Mid-Level                        0.85             FALSE
95                22    Senior/Expert                        0.65             FALSE
96                28    Senior/Expert                        0.64             FALSE
97                 3           Junior                        0.85             FALSE
98                 3           Junior                        0.40             FALSE
99                16    Senior/Expert                        0.40             FALSE
100               29    Senior/Expert                        0.54             FALSE
101               14        Mid-Level                        0.31             FALSE
102                9        Mid-Level                        0.22             FALSE
103               15        Mid-Level                        0.74             FALSE
104               16    Senior/Expert                        0.24             FALSE
105                5           Junior                        0.70             FALSE
106               18    Senior/Expert                        0.77             FALSE
107               25    Senior/Expert                        0.56             FALSE
108               11        Mid-Level                        0.84             FALSE
109               20    Senior/Expert                        0.09              TRUE
110               24    Senior/Expert                        0.64             FALSE
111                9        Mid-Level                        0.56             FALSE
112               23    Senior/Expert                        0.57             FALSE
113                2           Junior                        0.39             FALSE
114               23    Senior/Expert                        0.59             FALSE
115               27    Senior/Expert                        0.11              TRUE
116               29    Senior/Expert                        0.72             FALSE
117               15        Mid-Level                        0.69             FALSE
118                5           Junior                        0.73             FALSE
119                2           Junior                        0.53             FALSE
120                8        Mid-Level                        0.36             FALSE
121               28    Senior/Expert                        0.63             FALSE
122               17    Senior/Expert                        0.05              TRUE
123                8        Mid-Level                        0.07              TRUE
124               27    Senior/Expert                        0.62             FALSE
125               21    Senior/Expert                        0.57             FALSE
126               20    Senior/Expert                        0.17              TRUE
127               23    Senior/Expert                        0.48             FALSE
128               22    Senior/Expert                        0.23             FALSE
129               13        Mid-Level                        0.68             FALSE
130                7        Mid-Level                        0.38             FALSE
131               12        Mid-Level                        0.90             FALSE
132               19    Senior/Expert                        0.65             FALSE
133               13        Mid-Level                        0.09              TRUE
134               11        Mid-Level                        0.54             FALSE
135               11        Mid-Level                        0.34             FALSE
136                9        Mid-Level                        0.24             FALSE
137                9        Mid-Level                        0.46             FALSE
138                4           Junior                        0.19              TRUE
139               20    Senior/Expert                        0.48             FALSE
140                5           Junior                        0.73             FALSE
141               21    Senior/Expert                        0.42             FALSE
142               29    Senior/Expert                        0.47             FALSE
143               21    Senior/Expert                        0.66             FALSE
144               20    Senior/Expert                        0.44             FALSE
145               20    Senior/Expert                        0.38             FALSE
146                0           Junior                        0.27             FALSE
147                9        Mid-Level                        0.21             FALSE
148                3           Junior                        0.75             FALSE
149               11        Mid-Level                        0.34             FALSE
150               22    Senior/Expert                        0.92             FALSE
151                7        Mid-Level                        0.74             FALSE
152                1           Junior                        0.81             FALSE
153                5           Junior                        0.13              TRUE
154                0           Junior                        0.44             FALSE
155                1           Junior                        0.57             FALSE
156               20    Senior/Expert                        0.93             FALSE
157                3           Junior                        0.15              TRUE
158                8        Mid-Level                        0.55             FALSE
159               23    Senior/Expert                        0.33             FALSE
160               28    Senior/Expert                        0.16              TRUE
161               16    Senior/Expert                        0.31             FALSE
162               28    Senior/Expert                        0.08              TRUE
163               16    Senior/Expert                        0.93             FALSE
164               13        Mid-Level                        0.26             FALSE
165               18    Senior/Expert                        0.71             FALSE
166               15        Mid-Level                        0.68             FALSE
167               17    Senior/Expert                        0.19              TRUE
168               21    Senior/Expert                        0.37             FALSE
169               25    Senior/Expert                        0.39             FALSE
170                1           Junior                        0.53             FALSE
171                3           Junior                        0.29             FALSE
172               19    Senior/Expert                        0.34             FALSE
173               17    Senior/Expert                        0.50             FALSE
174               19    Senior/Expert                        0.61             FALSE
175               13        Mid-Level                        0.26             FALSE
176               24    Senior/Expert                        0.23             FALSE
177               10        Mid-Level                        0.87             FALSE
178                0           Junior                        0.85             FALSE
179                7        Mid-Level                        0.26             FALSE
180                2           Junior                        0.42             FALSE
181                2           Junior                        0.60             FALSE
182                3           Junior                        0.14              TRUE
183                5           Junior                        0.15              TRUE
184               29    Senior/Expert                        0.79             FALSE
185               13        Mid-Level                        0.84             FALSE
186               24    Senior/Expert                        0.06              TRUE
187                8        Mid-Level                        0.62             FALSE
188                9        Mid-Level                        0.65             FALSE
189               15        Mid-Level                        0.49             FALSE
190               10        Mid-Level                        0.90             FALSE
191                3           Junior                        0.57             FALSE
192               24    Senior/Expert                        0.66             FALSE
193               26    Senior/Expert                        0.80             FALSE
194                3           Junior                        0.57             FALSE
195               14        Mid-Level                        0.53             FALSE
196               25    Senior/Expert                        0.41             FALSE
197                8        Mid-Level                        0.67             FALSE
198               21    Senior/Expert                        0.10              TRUE
199                5           Junior                        0.50             FALSE
200               18    Senior/Expert                        0.58             FALSE
201               23    Senior/Expert                        0.85             FALSE
202                4           Junior                        0.27             FALSE
203                2           Junior                        0.41             FALSE
204               10        Mid-Level                        0.68             FALSE
205               14        Mid-Level                        0.15              TRUE
206                3           Junior                        0.48             FALSE
207               22    Senior/Expert                        0.84             FALSE
208               14        Mid-Level                        0.59             FALSE
209               21    Senior/Expert                        0.60             FALSE
210               24    Senior/Expert                        0.21             FALSE
211                0           Junior                        0.91             FALSE
212               22    Senior/Expert                        0.17              TRUE
213               26    Senior/Expert                        0.83             FALSE
214               19    Senior/Expert                        0.78             FALSE
215               16    Senior/Expert                        0.38             FALSE
216               29    Senior/Expert                        0.56             FALSE
217               28    Senior/Expert                        0.52             FALSE
218               27    Senior/Expert                        0.36             FALSE
219                2           Junior                        0.16              TRUE
220               15        Mid-Level                        0.55             FALSE
221                5           Junior                        0.70             FALSE
222               10        Mid-Level                        0.23             FALSE
223               17    Senior/Expert                        0.57             FALSE
224               26    Senior/Expert                        0.14              TRUE
225               26    Senior/Expert                        0.48             FALSE
226               23    Senior/Expert                        0.89             FALSE
227               18    Senior/Expert                        0.42             FALSE
228               13        Mid-Level                        0.68             FALSE
229               29    Senior/Expert                        0.36             FALSE
230               21    Senior/Expert                        0.37             FALSE
231               21    Senior/Expert                        0.85             FALSE
232               28    Senior/Expert                        0.85             FALSE
233               29    Senior/Expert                        0.49             FALSE
234               11        Mid-Level                        0.81             FALSE
235                5           Junior                        0.69             FALSE
236               13        Mid-Level                        0.79             FALSE
237               23    Senior/Expert                        0.61             FALSE
238               27    Senior/Expert                        0.76             FALSE
239               26    Senior/Expert                        0.92             FALSE
240                5           Junior                        0.89             FALSE
241               22    Senior/Expert                        0.24             FALSE
242                5           Junior                        0.51             FALSE
243               26    Senior/Expert                        0.70             FALSE
244               21    Senior/Expert                        0.55             FALSE
245               18    Senior/Expert                        0.46             FALSE
246                9        Mid-Level                        0.06              TRUE
247               21    Senior/Expert                        0.54             FALSE
248                7        Mid-Level                        0.18              TRUE
249               28    Senior/Expert                        0.85             FALSE
250               18    Senior/Expert                        0.86             FALSE
 [ reached 'max' / getOption("max.print") -- omitted 2750 rows ]
> 
> # ==============================================================================
> # 4. METHOD C: TEXT TRANSFORMATION (paste)
> # ==============================================================================
> # Scenario: Create a 'Job_Summary' that combines the Job Title and its Risk Category.
> # Function: paste0() joins strings without a space by default.
> 
> df_text <- ai_jobs_df %>%
+     mutate(
+         Job_Summary = paste0(Job_Title, " - ", Risk_Category, " Risk")
+     )
> print("--- Method C: Text Transformation (Job Summary) ---")
[1] "--- Method C: Text Transformation (Job Summary) ---"
> print(head(df_text$Job_Summary))
[1] "Security Guard - High Risk"      "Research Scientist - Low Risk"   "Construction Worker - High Risk"
[4] "Software Engineer - Medium Risk" "Financial Analyst - Medium Risk" "AI Engineer - Low Risk"         
> 
> # ==============================================================================
> # 5. ALL TOGETHER (The Standard Workflow)
> # ==============================================================================
> 
> final_dataset <- ai_jobs_df %>%
+     mutate(
+         # Calculation 1: Adjusted Salary (Salary scaled by Tech Growth)
+         Adjusted_Salary = Average_Salary * Tech_Growth_Factor,
+         
+         # Calculation 2: Risk Flag (based on a combination of factors)
+         Is_High_Risk = ifelse(
+             Automation_Probability_2030 > 0.75 | Risk_Category == "High", 
+             "Flagged", 
+             "Safe"
+         ),
+         
+         # Text Combo: A brief report on the job's risk factors
+         Risk_Report = paste0(
+             "AI Exposure: ", round(AI_Exposure_Index, 2), 
+             " | Auto Prob: ", round(Automation_Probability_2030, 2),
+             " (", Risk_Category, ")"
+         )
+     )
> 
> print("--- Final Combined Dataset (Showing New Variables) ---")
[1] "--- Final Combined Dataset (Showing New Variables) ---"
> print(head(final_dataset %>% select(Job_Title, Adjusted_Salary, Is_High_Risk, Risk_Report)))
            Job_Title Adjusted_Salary Is_High_Risk                                  Risk_Report
1      Security Guard        58617.60      Flagged   AI Exposure: 0.18 | Auto Prob: 0.85 (High)
2  Research Scientist       148024.05         Safe    AI Exposure: 0.62 | Auto Prob: 0.05 (Low)
3 Construction Worker       172534.88      Flagged   AI Exposure: 0.86 | Auto Prob: 0.81 (High)
4   Software Engineer        92840.40         Safe  AI Exposure: 0.39 | Auto Prob: 0.6 (Medium)
5   Financial Analyst       102779.62         Safe AI Exposure: 0.52 | Auto Prob: 0.64 (Medium)
6         AI Engineer        47221.92         Safe     AI Exposure: 0.29 | Auto Prob: 0.1 (Low)
