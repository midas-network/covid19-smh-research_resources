# setwd("C:/Users/bentssj/OneDrive - National Institutes of Health/Year_2024/equity/contacts")

# Prerequisite -----
# load in census tract data
censustract_ca <- read.csv("censustract_ca.csv")

#### set total number of effective contacts
# set from Mistry et al. 2021
eff_contacts <- 2.79

#### assortativity coefficient
# 1 indicates perfect assortativity (within-same race/ethnicity) mixing, while 0 indicates proportionate mixing
assort_coeff <- 0.0

#### list of race/ethnicity groups
race_list <- c("asian", "white", "black", "latino", "other")

# Workflow -----
census_tract_contacts <- censustract_ca %>%
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


# calculate total number of individuals by race/ethnicity at the state level
state_n <- censustract_ca %>%
  dplyr::group_by(race_ethnicity) %>%
  dplyr::summarize(dplyr::across(pop_size, ~ sum(as.numeric(.x), na.rm = TRUE)))


contact_race_list <- list()

for (i in seq_along(race_list)) {
  community_contacts <- census_tract_contacts %>%
    dplyr::filter(race_ethnicity == race_list[i]) %>%
    dplyr::mutate(asian_k = pop_size * contact_asian,
                  white_k = pop_size * contact_white,
                  black_k = pop_size * contact_black,
                  latino_k = pop_size * contact_latino,
                  other_k = pop_size * contact_other) %>%
    dplyr::summarize(dplyr::across(asian_k:other_k,
                                   ~ sum(as.numeric(.x), na.rm = TRUE)))
  contact_race_list[[i]] <- community_contacts /
    state_n$pop_size[state_n$race_ethnicity == race_list[i]]
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

