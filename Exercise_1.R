#Exercise 1: Clean the data set to make it easier to visualize and analyze.

#TASK 0: Load the data
org_df <- read.csv("refine_original.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

#TASK 1: Clean up brand names
org_df$company <- tolower(org_df$company)

#Correct the mispelling of companies name
matched_indexes <- agrep(pattern = "phillips", x = org_df$company, ignore.case = FALSE, value = FALSE, max.distance = 3)
org_df[matched_indexes, "company"] <- "phillips"

matched_indexes <- agrep(pattern = "unilever", x = org_df$company, ignore.case = FALSE, value = FALSE, max.distance = 3)
org_df[matched_indexes, "company"] <- "unilever"

matched_indexes <- agrep(pattern = "van houten", x = org_df$company, ignore.case = FALSE, value = FALSE, max.distance = 3)
org_df[matched_indexes, "company"] <- "van houten"

matched_indexes <- agrep(pattern = "akzo", x = org_df$company, ignore.case = FALSE, value = FALSE, max.distance = 2)
org_df[matched_indexes, "company"] <- "akzo"

#TASK 2: Separate product code and number
library(tidyr)
org_df <- separate(data = org_df, col = Product.code...number, into = c("Product_code", "Product_number"), sep = "-")

#TASK 3: Add product categories
org_df$Product_code[org_df$Product_code == "p"] <- "Smartphone"
org_df$Product_code[org_df$Product_code == "x"] <- "Laptop"
org_df$Product_code[org_df$Product_code == "v"] <- "TV"
org_df$Product_code[org_df$Product_code == "q"] <- "Tablet"

#TASK 4: Add full address for geocoding
org_df$full_address <- paste(org_df$address, org_df$city, org_df$country, sep = ",")

#TASK 5: Create dummy variables for company and product category
org_df$company_philips <- ifelse(org_df$company == "phillips", 1, 0)
org_df$company_unilever <- ifelse(org_df$company == "unilever", 1, 0)
org_df$company_van_houten <- ifelse(org_df$company == "van houten", 1, 0)
org_df$company_akzo <- ifelse(org_df$company == "akzo", 1, 0)

org_df$product_smartphone <- ifelse(org_df$Product_code == "Smartphone", 1, 0)
org_df$product_tv <- ifelse(org_df$Product_code == "TV", 1, 0)
org_df$product_laptop <- ifelse(org_df$Product_code == "Laptop", 1, 0)
org_df$product_tablet <- ifelse(org_df$Product_code == "Tablet", 1, 0)

#Create final clean dataset
write.csv(org_df, file = "refine_clean.csv", row.names = FALSE)
