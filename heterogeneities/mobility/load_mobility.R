library(arrow)
library(dplyr)

# Connect to dataset
file_schema <- arrow::schema(arrow::field("location", arrow::string()),
                             arrow::field("year", arrow::int32()),
                             arrow::field("geoid_o", arrow::string()),
                             arrow::field("geoid_d", arrow::string()),
                             arrow::field("start_date", arrow::date32()),
                             arrow::field("end_date", arrow::date32()),
                             arrow::field("visitor_flows", arrow::float()),
                             arrow::field("pop_flows", arrow::float()))
dc <- arrow::open_dataset("data/",
                          partitioning = c("year", "location", "start_date"),
                          schema = file_schema)

# Load all the files
df <- dplyr::collect(dc)

# Example of filter(s) before loading
df_ca20  <- dplyr::filter(dc, year == 2020, location == "06") %>%
  dplyr::collect()
