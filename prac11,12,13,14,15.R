
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

> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union
> library(tidyr)
> #
> ==============================================================================
Error: unexpected '==' in "=="

> arxiv_ai <- read.csv("~/RPROG/arxiv_ai.csv")
>   View(arxiv_ai)
> # ==============================================================================
> # R Script: Reshaping Data with pivot_longer() and pivot_wider()
> # Dataset: arxiv_ai.csv
> # ==============================================================================
> 
> library(dplyr)
> library(tidyr)
> 
> # ==============================================================================
> # 1. SETUP: Create and Import Data
> # ==============================================================================
> 
> # Read data and add a PaperID (Essential for tracking rows during pivots)
> df <- read.csv("arxiv_ai.csv", na.strings = c("", "NA")) %>%
+     mutate(
+         PaperID = row_number(),                    # Unique ID
+         Category = categories,                     # Rename for convenience
+         Year = as.numeric(substr(published, 1, 4)),# Extract Year
+         TitleLength = nchar(title)                 # Numeric column for pivoting
+     ) %>%
+     select(PaperID, Category, Year, TitleLength) # Select fewer cols for clarity
> 
> print("--- 1. Original Wide Data ---")
[1] "--- 1. Original Wide Data ---"
> print(head(df))
  PaperID  Category Year TitleLength
1       1 ['cs.AI'] 1993          20
2       2 ['cs.AI'] 1993         105
3       3 ['cs.AI'] 1993          39
4       4 ['cs.AI'] 1993          52
5       5 ['cs.AI'] 1993          69
6       6 ['cs.AI'] 1993          70
> 
> # ==============================================================================
> # 2. PIVOT_LONGER (Wide to Long)
> # ==============================================================================
> 
> # Scenario: Combine 'Year' and 'TitleLength' into a single column called 'Value'
> # Useful for: Plotting multiple metrics like Year and TitleLength together.
> 
> long_df <- df %>%
+     pivot_longer(
+         cols = c(Year, TitleLength),   # Columns we want to stack
+         names_to = "Metric",           # Label for metric names
+         values_to = "Value"            # Values of numeric columns
+     )
> 
> print("--- 2. Long Format (pivot_longer) ---")
[1] "--- 2. Long Format (pivot_longer) ---"
> # Notice how PaperID 1 now appears TWICE (once for Year, once for TitleLength)
> print(head(long_df, 6))
# A tibble: 6 × 4
  PaperID Category  Metric      Value
    <int> <chr>     <chr>       <dbl>
1       1 ['cs.AI'] Year         1993
2       1 ['cs.AI'] TitleLength    20
3       2 ['cs.AI'] Year         1993
4       2 ['cs.AI'] TitleLength   105
5       3 ['cs.AI'] Year         1993
6       3 ['cs.AI'] TitleLength    39
> 
> # ==============================================================================
> # 3. PIVOT_WIDER (Long to Wide)
> # ==============================================================================
> 
> # Scenario: Spread the 'Metric' values back into separate columns again.
> 
> wide_df <- long_df %>%
+     pivot_wider(
+         names_from = Metric,  # New column headers
+         values_from = Value   # Values to fill cells
+     )
> 
> print("--- 3. Wide Format (Back to Original) ---")
[1] "--- 3. Wide Format (Back to Original) ---"
> print(head(wide_df))
# A tibble: 6 × 4
  PaperID Category   Year TitleLength
    <int> <chr>     <dbl>       <dbl>
1       1 ['cs.AI']  1993          20
2       2 ['cs.AI']  1993         105
3       3 ['cs.AI']  1993          39
4       4 ['cs.AI']  1993          52
5       5 ['cs.AI']  1993          69
6       6 ['cs.AI']  1993          70
> 
> # ==============================================================================
> # 4. ADVANCED EXAMPLE (Reshaping for Reporting)
> # ==============================================================================
> 
> # Create a table where columns are Categories and rows are PaperIDs
> # showing the 'Year' in the grid.
> 
> df_clean <- df %>%
+     mutate(Category = ifelse(is.na(Category), "Unknown", Category))
> 
> category_pivot <- df_clean %>%
+     select(PaperID, Category, Year) %>%
+     pivot_wider(
+         names_from = Category,  # Column headers become categories
+         values_from = Year      # Fill with publication year
+     )
> 
> print("--- 4. Category Pivot (Spreading Categories) ---")
[1] "--- 4. Category Pivot (Spreading Categories) ---"
> print(head(category_pivot))
# A tibble: 6 × 919
  PaperID `['cs.AI']` `['cs.AI', 'I.2.8']` `['cs.AI', 'I.1.2; I.2.2']` `['cs.AI', 'I.2.0']` ['cs.AI', 'I.2.8; I.…¹
    <int>       <dbl>                <dbl>                       <dbl>                <dbl>                  <dbl>
1       1        1993                   NA                          NA                   NA                     NA
2       2        1993                   NA                          NA                   NA                     NA
3       3        1993                   NA                          NA                   NA                     NA
4       4        1993                   NA                          NA                   NA                     NA
5       5        1993                   NA                          NA                   NA                     NA
6       6        1993                   NA                          NA                   NA                     NA
# ℹ abbreviated name: ¹​`['cs.AI', 'I.2.8; I.2.1; J.6; I.2.4; F.2.2']`
# ℹ 913 more variables: `['cs.AI', 'I.2']` <dbl>, `['cs.AI', 'D.1.6']` <dbl>, `['cs.AI', 'I.2.3; I.2.7']` <dbl>,
#   `['cs.AI', 'I.2.3; I.2.4']` <dbl>, `['cs.AI', 'A.m']` <dbl>, `['cs.AI', 'I.2.3']` <dbl>,
#   `['cs.AI', 'F.4.1']` <dbl>, `['cs.AI', 'I.2.4;F.4.1']` <dbl>, `['cs.AI', 'F.4.1;I.2.3;I.2.4']` <dbl>,
#   `['cs.AI', 'Artificial intelligence and nonmonotonic reasoning and belief\\n  revision']` <dbl>,
#   `['cs.AI', 'F.4.1;I.2.4;I.2.3']` <dbl>, `['cs.AI', 'I.2.3;I.2.8']` <dbl>, `['cs.AI', 'I.2.4; F.4.1']` <dbl>,
#   `['cs.AI', 'F.4.1; I.2.3']` <dbl>, `['cs.AI', 'I.2.4']` <dbl>, `['cs.AI', 'I.2.8; I.2.3; F.4.1']` <dbl>, …
# ℹ Use `colnames()` to see all variable names
> 
> 
> `colnames<-`()
Error in `colnames<-`() : argument "x" is missing, with no default

> # ==============================================================================
> # R Script: Vertical Concatenation using rbind()
> # Dataset: arxiv_ai.csv (Split into 2 parts)
> # ==============================================================================
> 
> library(dplyr)
> 
> # ==============================================================================
> # 1. SETUP: Import Data
> # ==============================================================================
> 
> df <- read.csv("arxiv_ai.csv", na.strings = c("", "NA"))
> 
> print("--- Data Structure Before Transformation ---")
[1] "--- Data Structure Before Transformation ---"
> print(names(df))   # Show original column names
 [1] "authors"          "categories"       "comment"          "doi"              "entry_id"        
 [6] "journal_ref"      "pdf_url"          "primary_category" "published"        "summary"         
[11] "title"            "updated"         
> 
> # We will use two numeric columns for demonstration:
> #   - Year (from 'published')
> #   - TitleLength (from 'title')
> 
> df <- df %>%
+     mutate(
+         Species = categories,                 # Using 'categories' as Species
+         Height = nchar(title),                # Using title length as Height
+         Year = as.numeric(substr(published, 1, 4))
+     )
> 
> # Print preview
> print("--- Preview of Updated Dataset ---")
[1] "--- Preview of Updated Dataset ---"
> print(head(df[, c("Species", "Height", "Year")]))
    Species Height Year
1 ['cs.AI']     20 1993
2 ['cs.AI']    105 1993
3 ['cs.AI']     39 1993
4 ['cs.AI']     52 1993
5 ['cs.AI']     69 1993
6 ['cs.AI']     70 1993
> 
> # ==============================================================================
> # 2. DATA PREPARATION (Creating Two Compatible Datasets)
> # ==============================================================================
> 
> # rbind() will FAIL if columns do not match.
> # We will create two subsets with identical column structure:
> # Common Columns: "Species" and "Height"
> 
> # 2.1 First half of the dataset
> df_part1 <- df[1:floor(nrow(df)/2), c("Species", "Height")]
> names(df_part1) <- c("Species", "Height")
> 
> # 2.2 Second half of the dataset
> df_part2 <- df[(floor(nrow(df)/2)+1):nrow(df), c("Species", "Height")]
> names(df_part2) <- c("Species", "Height")
> 
> # Ensure both Height columns are numeric
> df_part1$Height <- as.numeric(df_part1$Height)
> df_part2$Height <- as.numeric(df_part2$Height)
> 
> # ==============================================================================
> # 3. VERTICAL COMBINATION (rbind)
> # ==============================================================================
> 
> combined_data <- rbind(df_part1, df_part2)
> 
> print("--- Combined Data Summary ---")
[1] "--- Combined Data Summary ---"
> print(paste("Part 1 rows:", nrow(df_part1)))
[1] "Part 1 rows: 5000"
> print(paste("Part 2 rows:", nrow(df_part2)))
[1] "Part 2 rows: 5000"
> print(paste("Total rows (Expected):", nrow(df_part1) + nrow(df_part2)))
[1] "Total rows (Expected): 10000"
> print(paste("Total rows (Actual):", nrow(combined_data)))
[1] "Total rows (Actual): 10000"
> 
> print("--- Preview of Combined Data (Top and Bottom) ---")
[1] "--- Preview of Combined Data (Top and Bottom) ---"
> print(head(combined_data))   # First few rows from part 1
    Species Height
1 ['cs.AI']     20
2 ['cs.AI']    105
3 ['cs.AI']     39
4 ['cs.AI']     52
5 ['cs.AI']     69
6 ['cs.AI']     70
> print(tail(combined_data))   # Last few rows from part 2
                                                                                    Species Height
9995                                                                     ['cs.AI', 'cs.LG']    116
9996                                                                     ['cs.CL', 'cs.AI']    102
9997                                                                  ['q-fin.RM', 'cs.AI']     49
9998                                                                     ['cs.NI', 'cs.AI']     78
9999                                                                     ['cs.LO', 'cs.AI']     63
10000 ['cs.AI', 'cs.LO', '03B60, 03B15, 68T27, 68T30, 68T15', 'I.2.3; I.2.4; I.2.0; F.4.1']     50
> 
> prac 13..........................................................\\\\\\\\
Error: unexpected numeric constant in "prac 13."

> # ==============================================================================
> # R Script: Identifying and Handling Duplicates
> # Function: distinct() from the dplyr package
> # Dataset: arxiv_ai.csv (User Uploaded)
> # ==============================================================================
> 
> library(dplyr)
> 
> # ==============================================================================
> # 1. SETUP: Create a Dataset with Intentional Duplicates
> # ==============================================================================
> 
> # Load original dataset
> df <- read.csv("arxiv_ai.csv", na.strings = c("", "NA"))
> 
> # Create PaperID for easier tracking
> df <- df %>%
+     mutate(
+         PaperID = row_number(),
+         Title = title,
+         Category = categories
+     )
> 
> # Create intentional duplicates:
> # - Duplicate row 1 and 6
> # - Duplicate row 2 and 3
> # - Category may be same but titles different in some rows
> 
> duplicate_df <- df[c(1, 2, 3, 4, 5, 1, 2), c("PaperID", "Title", "Category")]
> 
> print("--- 1. Original Dataset With Intentional Duplicates (7 rows) ---")
[1] "--- 1. Original Dataset With Intentional Duplicates (7 rows) ---"
> print(duplicate_df)
    PaperID
1         1
2         2
3         3
4         4
5         5
1.1       1
2.1       2
                                                                                                        Title
1                                                                                        Dynamic Backtracking
2   A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems
3                                                                     An Empirical Analysis of Search in GSAT
4                                                        The Difficulties of Learning Logic Programs with Cut
5                                       Software Agents: Completing Patterns and Constructing User Interfaces
1.1                                                                                      Dynamic Backtracking
2.1 A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems
     Category
1   ['cs.AI']
2   ['cs.AI']
3   ['cs.AI']
4   ['cs.AI']
5   ['cs.AI']
1.1 ['cs.AI']
2.1 ['cs.AI']
> 
> # ==============================================================================
> # 2. IDENTIFYING DUPLICATES (Before Removing Them)
> # ==============================================================================
> 
> duplicates_report <- duplicate_df %>%
+     group_by(PaperID, Title, Category) %>%
+     count() %>%         # Count occurrences
+     filter(n > 1)       # Keep only duplicates
> 
> print("--- 2. Identification Report (Rows that appear more than once) ---")
[1] "--- 2. Identification Report (Rows that appear more than once) ---"
> print(duplicates_report)
# A tibble: 2 × 4
# Groups:   PaperID, Title, Category [2]
  PaperID Title                                                                                     Category     n
    <int> <chr>                                                                                     <chr>    <int>
1       1 Dynamic Backtracking                                                                      ['cs.AI…     2
2       2 A Market-Oriented Programming Environment and its Application to Distributed Multicommod… ['cs.AI…     2
> 
> # ==============================================================================
> # 3. HANDLING DUPLICATES: Exact Matches
> # ==============================================================================
> 
> # Remove rows where ALL columns are identical:
> clean_exact <- duplicate_df %>%
+     distinct()          # Removes exact row duplicates
> 
> print("--- 3. Removed Exact Duplicates (distinct) ---")
[1] "--- 3. Removed Exact Duplicates (distinct) ---"
> print(clean_exact)
  PaperID
1       1
2       2
3       3
4       4
5       5
                                                                                                      Title
1                                                                                      Dynamic Backtracking
2 A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems
3                                                                   An Empirical Analysis of Search in GSAT
4                                                      The Difficulties of Learning Logic Programs with Cut
5                                     Software Agents: Completing Patterns and Constructing User Interfaces
   Category
1 ['cs.AI']
2 ['cs.AI']
3 ['cs.AI']
4 ['cs.AI']
5 ['cs.AI']
> 
> # ==============================================================================
> # 4. HANDLING DUPLICATES: Specific Columns (.keep_all = TRUE)
> # ==============================================================================
> 
> # Scenario: Extract ONLY UNIQUE titles (keep first occurrence)
> unique_titles <- duplicate_df %>%
+     distinct(Title, .keep_all = TRUE)
> 
> print("--- 4. Unique Titles Only (Partial Duplicates Removed) ---")
[1] "--- 4. Unique Titles Only (Partial Duplicates Removed) ---"
> print(unique_titles)
  PaperID
1       1
2       2
3       3
4       4
5       5
                                                                                                      Title
1                                                                                      Dynamic Backtracking
2 A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems
3                                                                   An Empirical Analysis of Search in GSAT
4                                                      The Difficulties of Learning Logic Programs with Cut
5                                     Software Agents: Completing Patterns and Constructing User Interfaces
   Category
1 ['cs.AI']
2 ['cs.AI']
3 ['cs.AI']
4 ['cs.AI']
5 ['cs.AI']
> 
> prac 14---------------------------------------------------------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Error: unexpected numeric constant in "prac 14"

> # ==============================================================================
> # R Script: Extracting Date Components using lubridate
> # Dataset: arxiv_ai.csv
> # ==============================================================================
> 
> # Install (only first time) and Load
> # install.packages("lubridate")
> library(lubridate)
Error in library(lubridate) : there is no package called ‘lubridate’

> prac14||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Error: unexpected '||' in "prac14||||"

> # ==============================================================================
> # FULL R SCRIPT: Extracting Date Components using lubridate
> # Dataset: arxiv_ai.csv
> # ==============================================================================
> 
> # -----------------------------
> # INSTALL PACKAGES (Run Once)
> # -----------------------------
> # install.packages("lubridate")
> # install.packages("dplyr")
> # install.packages("readr")
> 
> # -----------------------------
> # LOAD LIBRARIES
> # -----------------------------
> library(lubridate)
Error in library(lubridate) : there is no package called ‘lubridate’

> install.packages("lubridate")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/Purvi/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
also installing the dependency ‘timechange’
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/timechange_0.3.0.zip'
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.5/lubridate_1.9.4.zip'
package ‘timechange’ successfully unpacked and MD5 sums checked
package ‘lubridate’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\Purvi\AppData\Local\Temp\RtmpIda8E2\downloaded_packages
> 
> # ==============================================================================
> # FULL R SCRIPT: Extracting Date Components using lubridate
> # Dataset: arxiv_ai.csv
> # ==============================================================================
> 
> # -----------------------------
> # INSTALL PACKAGES (Run Once)
> # -----------------------------
> # install.packages("lubridate")
> # install.packages("dplyr")
> # install.packages("readr")
> 
> # -----------------------------
> # LOAD LIBRARIES
> # -----------------------------
> library(lubridate)

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union
> library(dplyr)
> library(readr)
> 
> # ==============================================================================
> # 1. IMPORT DATASET AND CREATE DATE COLUMN
> # ==============================================================================
> 
> # Read CSV (readr is faster and cleaner)
> df <- read_csv("arxiv_ai.csv")
Rows: 10000 Columns: 12                                                                                           
── Column specification ──────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
chr  (10): authors, categories, comment, doi, entry_id, journal_ref, pdf_url, primary_category, summary, title
dttm  (2): published, updated

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
> 
> # Extract only the date portion from published column
> # Example published format: "2020-01-03T18:00:05Z"
> df <- df %>%
+     mutate(
+         Published_String = substr(published, 1, 10)  # Extract YYYY-MM-DD
+     )
> 
> print("--- Preview of Extracted Date Strings ---")
[1] "--- Preview of Extracted Date Strings ---"
> print(head(df$Published_String))
[1] "1993-08-01" "1993-08-01" "1993-09-01" "1993-11-01" "1993-11-01" "1993-12-01"
> 
> # ==============================================================================
> # 2. PARSE AND EXTRACT DATE COMPONENTS USING lubridate
> # ==============================================================================
> 
> processed_data <- df %>%
+     mutate(
+         # Convert string to proper Date format
+         Actual_Date = ymd(Published_String),
+         
+         # Extract components
+         Year_Num = year(Actual_Date),
+         Month_Num = month(Actual_Date),
+         Month_Name = month(Actual_Date, label = TRUE),
+         Day_Num = day(Actual_Date),
+         Weekday_Num = wday(Actual_Date),
+         Weekday_Name = wday(Actual_Date, label = TRUE, abbr = FALSE),
+         Quarter = quarter(Actual_Date),
+         Day_of_Year = yday(Actual_Date)
+     )
> 
> print("--- Processed Data with Date Components (Top Rows) ---")
[1] "--- Processed Data with Date Components (Top Rows) ---"
> print(head(processed_data))
# A tibble: 6 × 22
  authors categories comment doi   entry_id journal_ref pdf_url primary_category published           summary title
  <chr>   <chr>      <chr>   <chr> <chr>    <chr>       <chr>   <chr>            <dttm>              <chr>   <chr>
1 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-08-01 00:00:00 "Becau… Dyna…
2 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-08-01 00:00:00 "Marke… A Ma…
3 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-09-01 00:00:00 "We de… An E…
4 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-11-01 00:00:00 "As re… The …
5 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-11-01 00:00:00 "To su… Soft…
6 [arxiv… ['cs.AI']  "See h… NA    http://… "Journal o… http:/… cs.AI            1993-12-01 00:00:00 "Termi… Deci…
# ℹ 11 more variables: updated <dttm>, Published_String <chr>, Actual_Date <date>, Year_Num <dbl>,
#   Month_Num <dbl>, Month_Name <ord>, Day_Num <int>, Weekday_Num <dbl>, Weekday_Name <ord>, Quarter <int>,
#   Day_of_Year <dbl>
> 
> # ==============================================================================
> # 3. SYSTEM DATE & TIME EXTRACTION
> # ==============================================================================
> 
> current_time <- now()
> 
> print("--- Current System Time Details ---")
[1] "--- Current System Time Details ---"
> print(paste("Current Year:", year(current_time)))
[1] "Current Year: 2025"
> print(paste("Current Month:", month(current_time)))
[1] "Current Month: 12"
> print(paste("Current Day:", day(current_time)))
[1] "Current Day: 8"
> print(paste("Current Hour:", hour(current_time)))
[1] "Current Hour: 11"
> print(paste("Current Minute:", minute(current_time)))
[1] "Current Minute: 37"
> print(paste("Current Second:", second(current_time)))
[1] "Current Second: 9.6288321018219"
> 
> # ==============================================================================
> # END OF SCRIPT
> # ==============================================================================
> 
> prac 15----------------------------------------------------
Error: unexpected numeric constant in "prac 15"

> # ==============================================================================
> # R Script: Generating Basic Summaries
> # Functions: str() and summary()
> # Dataset: arxiv_ai.csv
> # ==============================================================================
> 
> # ==============================================================================
> # 1. SETUP: Import Dataset
> # ==============================================================================
> 
> df <- read.csv("arxiv_ai.csv", na.strings = c("", "NA"))
> 
> print("--- Data Loaded from arxiv_ai.csv ---")
[1] "--- Data Loaded from arxiv_ai.csv ---"
> head(df)
                                                                                                        authors
1                                                                       [arxiv.Result.Author('M. L. Ginsberg')]
2                                                                        [arxiv.Result.Author('M. P. Wellman')]
3                                          [arxiv.Result.Author('I. P. Gent'), arxiv.Result.Author('T. Walsh')]
4 [arxiv.Result.Author('F. Bergadano'), arxiv.Result.Author('D. Gunetti'), arxiv.Result.Author('U. Trinchero')]
5                                [arxiv.Result.Author('J. C. Schlimmer'), arxiv.Result.Author('L. A. Hermens')]
6  [arxiv.Result.Author('M. Buchheit'), arxiv.Result.Author('F. M. Donini'), arxiv.Result.Author('A. Schaerf')]
  categories                                                                                      comment  doi
1  ['cs.AI'] See http://www.jair.org/ for an online appendix and other files\n  accompanying this article <NA>
2  ['cs.AI']                                          See http://www.jair.org/ for any accompanying files <NA>
3  ['cs.AI']                                          See http://www.jair.org/ for any accompanying files <NA>
4  ['cs.AI']                                          See http://www.jair.org/ for any accompanying files <NA>
5  ['cs.AI'] See http://www.jair.org/ for an online appendix and other files\n  accompanying this article <NA>
6  ['cs.AI']                                          See http://www.jair.org/ for any accompanying files <NA>
                           entry_id                                                            journal_ref
1 http://arxiv.org/abs/cs/9308101v1      Journal of Artificial Intelligence Research, Vol 1, (1993), 25-46
2 http://arxiv.org/abs/cs/9308102v1       Journal of Artificial Intelligence Research, Vol 1, (1993), 1-23
3 http://arxiv.org/abs/cs/9309101v1      Journal of Artificial Intelligence Research, Vol 1, (1993), 47-59
4 http://arxiv.org/abs/cs/9311101v1     Journal of Artificial Intelligence Research, Vol 1, (1993), 91-107
5 http://arxiv.org/abs/cs/9311102v1      Journal of Artificial Intelligence Research, Vol 1, (1993), 61-89
6 http://arxiv.org/abs/cs/9312101v1 Journal of Artificial Intelligence Research, Vol 1, (1993),\n  109-138
                            pdf_url primary_category                 published
1 http://arxiv.org/pdf/cs/9308101v1            cs.AI 1993-08-01 00:00:00+00:00
2 http://arxiv.org/pdf/cs/9308102v1            cs.AI 1993-08-01 00:00:00+00:00
3 http://arxiv.org/pdf/cs/9309101v1            cs.AI 1993-09-01 00:00:00+00:00
4 http://arxiv.org/pdf/cs/9311101v1            cs.AI 1993-11-01 00:00:00+00:00
5 http://arxiv.org/pdf/cs/9311102v1            cs.AI 1993-11-01 00:00:00+00:00
6 http://arxiv.org/pdf/cs/9312101v1            cs.AI 1993-12-01 00:00:00+00:00
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     summary
1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Because of their occasional need to return to shallow points in a search\ntree, existing backtracking methods can sometimes erase meaningful progress\ntoward solving a search problem. In this paper, we present a method by which\nbacktrack points can be moved deeper in the search space, thereby avoiding this\ndifficulty. The technique developed is a variant of dependency-directed\nbacktracking that uses only polynomial space while still providing useful\ncontrol information and retaining the completeness guarantees provided by\nearlier approaches.
2                                                                                                                                                                                                                                                                                                                                                                                                                                    Market price systems constitute a well-understood class of mechanisms that\nunder certain conditions provide effective decentralization of decision making\nwith minimal communication overhead. In a market-oriented programming approach\nto distributed problem solving, we derive the activities and resource\nallocations for a set of computational agents by computing the competitive\nequilibrium of an artificial economy. WALRAS provides basic constructs for\ndefining computational market structures, and protocols for deriving their\ncorresponding price equilibria. In a particular realization of this approach\nfor a form of multicommodity flow problem, we see that careful construction of\nthe decision process according to economic principles can lead to efficient\ndistributed resource allocation, and that the behavior of the system can be\nmeaningfully analyzed in economic terms.
3                                                                                                                                                                                                                           We describe an extensive study of search in GSAT, an approximation procedure\nfor propositional satisfiability. GSAT performs greedy hill-climbing on the\nnumber of satisfied clauses in a truth assignment. Our experiments provide a\nmore complete picture of GSAT's search than previous accounts. We describe in\ndetail the two phases of search: rapid hill-climbing followed by a long plateau\nsearch. We demonstrate that when applied to randomly generated 3SAT problems,\nthere is a very simple scaling with problem size for both the mean number of\nsatisfied clauses and the mean branching rate. Our results allow us to make\ndetailed numerical conjectures about the length of the hill-climbing phase, the\naverage gradient of this phase, and to conjecture that both the average score\nand average branching rate decay exponentially during plateau search. We end by\nshowing how these results can be used to direct future theoretical analysis.\nThis work provides a case study of how computer experiments can be used to\nimprove understanding of the theoretical properties of algorithms.
4                                                                                                                                                                             As real logic programmers normally use cut (!), an effective learning\nprocedure for logic programs should be able to deal with it. Because the cut\npredicate has only a procedural meaning, clauses containing cut cannot be\nlearned using an extensional evaluation method, as is done in most learning\nsystems. On the other hand, searching a space of possible programs (instead of\na space of independent clauses) is unfeasible. An alternative solution is to\ngenerate first a candidate base program which covers the positive examples, and\nthen make it consistent by inserting cut where appropriate. The problem of\nlearning programs with cut has not been investigated before and this seems to\nbe a natural and reasonable approach. We generalize this scheme and investigate\nthe difficulties that arise. Some of the major shortcomings are actually\ncaused, in general, by the need for intensional evaluation. As a conclusion,\nthe analysis of this paper suggests, on precise and technical grounds, that\nlearning cut is difficult, and current induction techniques should probably be\nrestricted to purely declarative logic languages.
5 To support the goal of allowing users to record and retrieve information,\nthis paper describes an interactive note-taking system for pen-based computers\nwith two distinctive features. First, it actively predicts what the user is\ngoing to write. Second, it automatically constructs a custom, button-box user\ninterface on request. The system is an example of a learning-apprentice\nsoftware- agent. A machine learning component characterizes the syntax and\nsemantics of the user's information. A performance system uses this learned\ninformation to generate completion strings and construct a user interface.\nDescription of Online Appendix: People like to record information. Doing this\non paper is initially efficient, but lacks flexibility. Recording information\non a computer is less efficient but more powerful. In our new note taking\nsoftwre, the user records information directly on a computer. Behind the\ninterface, an agent acts for the user. To help, it provides defaults and\nconstructs a custom user interface. The demonstration is a QuickTime movie of\nthe note taking agent in action. The file is a binhexed self-extracting\narchive. Macintosh utilities for binhex are available from\nmac.archive.umich.edu. QuickTime is available from ftp.apple.com in the\ndts/mac/sys.soft/quicktime.
6                                                                                                                                                 Terminological knowledge representation systems (TKRSs) are tools for\ndesigning and using knowledge bases that make use of terminological languages\n(or concept languages). We analyze from a theoretical point of view a TKRS\nwhose capabilities go beyond the ones of presently available TKRSs. The new\nfeatures studied, often required in practical applications, can be summarized\nin three main points. First, we consider a highly expressive terminological\nlanguage, called ALCNR, including general complements of concepts, number\nrestrictions and role conjunction. Second, we allow to express inclusion\nstatements between general concepts, and terminological cycles as a particular\ncase. Third, we prove the decidability of a number of desirable TKRS-deduction\nservices (like satisfiability, subsumption and instance checking) through a\nsound, complete and terminating calculus for reasoning in ALCNR-knowledge\nbases. Our calculus extends the general technique of constraint systems. As a\nbyproduct of the proof, we get also the result that inclusion statements in\nALCNR can be simulated by terminological cycles, if descriptive semantics is\nadopted.
                                                                                                      title
1                                                                                      Dynamic Backtracking
2 A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems
3                                                                   An Empirical Analysis of Search in GSAT
4                                                      The Difficulties of Learning Logic Programs with Cut
5                                     Software Agents: Completing Patterns and Constructing User Interfaces
6                                    Decidable Reasoning in Terminological Knowledge Representation Systems
                    updated
1 1993-08-01 00:00:00+00:00
2 1993-08-01 00:00:00+00:00
3 1993-09-01 00:00:00+00:00
4 1993-11-01 00:00:00+00:00
5 1993-11-01 00:00:00+00:00
6 1993-12-01 00:00:00+00:00
> 
> 
> # ==============================================================================
> # 2. USING str() (Structure)
> # ==============================================================================
> 
> # Purpose:
> # - Shows internal structure of dataset
> # - Data types of columns
> # - Observations and variables
> 
> print("--- OUTPUT OF str() ---")
[1] "--- OUTPUT OF str() ---"
> str(df)
'data.frame':	10000 obs. of  12 variables:
 $ authors         : chr  "[arxiv.Result.Author('M. L. Ginsberg')]" "[arxiv.Result.Author('M. P. Wellman')]" "[arxiv.Result.Author('I. P. Gent'), arxiv.Result.Author('T. Walsh')]" "[arxiv.Result.Author('F. Bergadano'), arxiv.Result.Author('D. Gunetti'), arxiv.Result.Author('U. Trinchero')]" ...
 $ categories      : chr  "['cs.AI']" "['cs.AI']" "['cs.AI']" "['cs.AI']" ...
 $ comment         : chr  "See http://www.jair.org/ for an online appendix and other files\n  accompanying this article" "See http://www.jair.org/ for any accompanying files" "See http://www.jair.org/ for any accompanying files" "See http://www.jair.org/ for any accompanying files" ...
 $ doi             : chr  NA NA NA NA ...
 $ entry_id        : chr  "http://arxiv.org/abs/cs/9308101v1" "http://arxiv.org/abs/cs/9308102v1" "http://arxiv.org/abs/cs/9309101v1" "http://arxiv.org/abs/cs/9311101v1" ...
 $ journal_ref     : chr  "Journal of Artificial Intelligence Research, Vol 1, (1993), 25-46" "Journal of Artificial Intelligence Research, Vol 1, (1993), 1-23" "Journal of Artificial Intelligence Research, Vol 1, (1993), 47-59" "Journal of Artificial Intelligence Research, Vol 1, (1993), 91-107" ...
 $ pdf_url         : chr  "http://arxiv.org/pdf/cs/9308101v1" "http://arxiv.org/pdf/cs/9308102v1" "http://arxiv.org/pdf/cs/9309101v1" "http://arxiv.org/pdf/cs/9311101v1" ...
 $ primary_category: chr  "cs.AI" "cs.AI" "cs.AI" "cs.AI" ...
 $ published       : chr  "1993-08-01 00:00:00+00:00" "1993-08-01 00:00:00+00:00" "1993-09-01 00:00:00+00:00" "1993-11-01 00:00:00+00:00" ...
 $ summary         : chr  "Because of their occasional need to return to shallow points in a search\ntree, existing backtracking methods c"| __truncated__ "Market price systems constitute a well-understood class of mechanisms that\nunder certain conditions provide ef"| __truncated__ "We describe an extensive study of search in GSAT, an approximation procedure\nfor propositional satisfiability."| __truncated__ "As real logic programmers normally use cut (!), an effective learning\nprocedure for logic programs should be a"| __truncated__ ...
 $ title           : chr  "Dynamic Backtracking" "A Market-Oriented Programming Environment and its Application to Distributed Multicommodity Flow Problems" "An Empirical Analysis of Search in GSAT" "The Difficulties of Learning Logic Programs with Cut" ...
 $ updated         : chr  "1993-08-01 00:00:00+00:00" "1993-08-01 00:00:00+00:00" "1993-09-01 00:00:00+00:00" "1993-11-01 00:00:00+00:00" ...
> 
> 
> # ==============================================================================
> # 3. USING summary() (Statistical Summary)
> # ==============================================================================
> 
> print("--- OUTPUT OF summary() [Before Factor Conversion] ---")
[1] "--- OUTPUT OF summary() [Before Factor Conversion] ---"
> summary(df)
   authors           categories          comment              doi              entry_id        
 Length:10000       Length:10000       Length:10000       Length:10000       Length:10000      
 Class :character   Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character  
 journal_ref          pdf_url          primary_category    published           summary         
 Length:10000       Length:10000       Length:10000       Length:10000       Length:10000      
 Class :character   Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    title             updated         
 Length:10000       Length:10000      
 Class :character   Class :character  
 Mode  :character   Mode  :character  
> 
> 
> # ==============================================================================
> # 4. IMPROVING summary() WITH FACTORS
> # ==============================================================================
> # Some columns may be character but represent categories.
> # Common categorical columns in arxiv metadata:
> # - primary_category
> # - authors
> # - categories
> 
> # Convert selected character columns to factors
> factor_cols <- c("primary_category", "categories")
> 
> for(col in factor_cols) {
+     if(col %in% names(df)) {
+         df[[col]] <- as.factor(df[[col]])
+     }
+ }
> 
> print("--- OUTPUT OF summary() [After Factor Conversion] ---")
[1] "--- OUTPUT OF summary() [After Factor Conversion] ---"
> summary(df)
   authors                       categories     comment              doi              entry_id        
 Length:10000       ['cs.AI']         :7770   Length:10000       Length:10000       Length:10000      
 Class :character   ['cs.AI', 'I.2.4']:  87   Class :character   Class :character   Class :character  
 Mode  :character   ['cs.NE', 'cs.AI']:  75   Mode  :character   Mode  :character   Mode  :character  
                    ['cs.AI', 'cs.LO']:  67                                                           
                    ['cs.LG', 'cs.AI']:  63                                                           
                    ['cs.AI', 'I.2.3']:  52                                                           
                    (Other)           :1886                                                           
 journal_ref          pdf_url          primary_category  published           summary             title          
 Length:10000       Length:10000       cs.AI  :9280     Length:10000       Length:10000       Length:10000      
 Class :character   Class :character   cs.LO  : 104     Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   cs.NE  : 104     Mode  :character   Mode  :character   Mode  :character  
                                       cs.LG  :  86                                                             
                                       cs.CL  :  52                                                             
                                       cs.CV  :  52                                                             
                                       (Other): 322                                                             
   updated         
 Length:10000      
 Class :character  
 Mode  :character  
                   
                   
                   
                   
> 
> 
> # ==============================================================================
> # 5. Accessing Specific Summaries
> # ==============================================================================
> 
> # Example numerical summaries (if columns exist)
> 
> if("title" %in% names(df)) {
+     avg_title_length <- mean(nchar(df$title), na.rm = TRUE)
+     print(paste("Average Title Length:", avg_title_length))
+ }
[1] "Average Title Length: 67.3729"
> 
> if("published" %in% names(df)) {
+     total_records <- nrow(df)
+     print(paste("Total Records:", total_records))
+ }
[1] "Total Records: 10000"
> 
> # If there is a "comment" column (character)
> if("comment" %in% names(df)) {
+     avg_comment_length <- mean(nchar(df$comment), na.rm = TRUE)
+     print(paste("Average Comment Length:", avg_comment_length))
+ }
[1] "Average Comment Length: 73.618481095176"
