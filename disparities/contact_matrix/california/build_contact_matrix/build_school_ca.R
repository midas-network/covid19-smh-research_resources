library(dplyr)

# Prerequisite -----
#### the racial/ethnic distribution of 5-17 year old children in each county's public school system
publicschool_data_ca = read.csv("publicschool_ca.csv")

#### set total number of effective contacts
# set from Mistry et al. 2021
eff_contacts <- 11.41

#### assortativity coefficient
# 1 indicates perfect assortativity (within-same race/ethnicity) mixing, while 0 indicates proportionate mixing
assort_coeff <- 0.0

#### list of race/ethnicity groups
race_list <- c("asian", "white", "black", "latino", "other")

# Workflow -----
school_county_contacts <- publicschool_data_ca %>%
  dplyr::group_by(geoid) %>%
  dplyr::mutate(contact_asian = eff_contacts * (assort_coeff * (race_ethnicity == "asian") + 
                                                  (1 - assort_coeff) * (percent[race_ethnicity == "asian"])),
                
                contact_white = eff_contacts * (assort_coeff * (race_ethnicity == "white") + 
                                                  (1 - assort_coeff) * (percent[race_ethnicity == "white"])),
                
                contact_black = eff_contacts * (assort_coeff * (race_ethnicity == "black") + 
                                                  (1 - assort_coeff) * (percent[race_ethnicity == "black"])),
                
                contact_latino = eff_contacts * (assort_coeff * (race_ethnicity == "latino") + 
                                                   (1 - assort_coeff) * (percent[race_ethnicity == "latino"])),
                
                contact_other = eff_contacts * (assort_coeff * (race_ethnicity == "other") + 
                                                  (1 - assort_coeff) * (percent[race_ethnicity == "other"]))) %>% 
  dplyr::ungroup()


#### total number of children 5-17 yo by race/ethnicity in the state
children_n = publicschool_data_ca %>%
  group_by(race_ethnicity)%>%
  summarize(across(children5_17, ~ sum(as.numeric(.x), na.rm = TRUE)))


contact_race_list <- list()

for (i in seq_along(race_list)) {
  school_contacts <- school_county_contacts %>%
    dplyr::filter(race_ethnicity == race_list[i]) %>%
    dplyr::mutate(asian_k = children5_17 * contact_asian,
                  white_k = children5_17 * contact_white,
                  black_k = children5_17 * contact_black,
                  latino_k = children5_17 * contact_latino,
                  other_k = children5_17 * contact_other) %>%
    dplyr::summarize(dplyr::across(asian_k:other_k,
                                   ~ sum(as.numeric(.x), na.rm = TRUE)))
  contact_race_list[[i]] <- school_contacts /
    children_n$children5_17[children_n$race_ethnicity == race_list[i]]
}

contact_matrix <-
  cbind(t(as.matrix(contact_race_list[[1]])),
        t(as.matrix(contact_race_list[[2]])),
        t(as.matrix(contact_race_list[[3]])),
        t(as.matrix(contact_race_list[[4]])),
        t(as.matrix(contact_race_list[[5]]))) %>%
  as.data.frame()
colnames(contact_matrix) <- c("asian", "white", "black", "latino", "other")
rownames(contact_matrix) <- colnames(contact_matrix)

contact_matrix
