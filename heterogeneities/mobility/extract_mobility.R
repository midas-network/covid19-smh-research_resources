# System and Library
library(gh)
library(dplyr)
library(purrr)
library(tidyr)
library(arrow)

# Extract Mobility data
year <- c(2020, 2021)
all_files <- lapply(year, function(z) {
  folder_tree <- gh::gh(paste0("GET ",
                               "/repos/GeoDS/COVID19USFlows-WeeklyFlows-Ct", z,
                               "/contents/", "weekly_flows/ct2ct/"),
                        .limit = Inf)
  folder_name <- unlist(purrr::map(folder_tree, "name"))
  folder_name <- as.Date(folder_name, "%Y_%m_%d")
  if (z == 2020) folder_sel <- folder_name >= "2020-05-01"
  if (z == 2021) folder_sel <- folder_name <= "2021-04-05"
  folder_tree <- folder_tree[folder_sel]

  df_list_repo <- lapply(purrr::map(folder_tree, "path"), function(y) {
    file_tree <- gh::gh(paste0("GET ",
                               "/repos/GeoDS/COVID19USFlows-WeeklyFlows-Ct", z,
                               "/contents", y))
    df_list <- lapply(purrr::map(file_tree, "download_url"), function(x) {
      df <- read.csv(x, colClasses = c("geoid_o" = "character",
                                       "geoid_d" = "character"))
      df <- dplyr::select(df, -dplyr::starts_with("lng_"),
                          -dplyr::starts_with("lat_"))
      df <- dplyr::filter(df, grepl("^06|^37", geoid_o))
      if (nrow(df) > 0) {
        df <- tidyr::separate(df, date_range, c("start_date", "end_date"),
                              sep = " - ")
        df <- dplyr::mutate(df, start_date = as.Date(start_date, "%m/%d/%y"),
                            end_date = as.Date(end_date, "%m/%d/%y"),
                            location = stringr::str_extract(geoid_o, "^.{2}"))

      }
      return(df)
    })
    df_folder <- dplyr::bind_rows(df_list)
    df_folder <- dplyr::select(df_folder, -dplyr::contains("date_range"),
                               -dplyr::contains("census_block_group"))
    return(df_folder)
  })
  df_all <- dplyr::bind_rows(df_list_repo)
  df_all <- dplyr::mutate(df_all, folder_date = start_date, year = z)
  return(df_all)
})
df_all <- dplyr::bind_rows(all_files)

# Write output
files_dir <- "data/"
if (!dir.exists(files_dir)) dir.create(files_dir)

arrow::write_dataset(df_all, files_dir,
                     partitioning = c("year", "location", "folder_date"),
                     hive_style = FALSE)
