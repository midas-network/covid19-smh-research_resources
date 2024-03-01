library(dplyr)

#### total number of effective contacts
eff_contacts= 11.41 # set from Mistry et al. 2021

#### assortativity coefficient
assort_coeff= 0.0 # 1 indicates perfect assortativity (within-same race/ethnicity) mixing, while 0 indicates proportionate mixing

#### list of race/ethnicity
race_list <- c("asian", "white", "black", "latino", "other")

#### the number of 5-17 year old children in each race/ethnicity in each county's public school system
publicschool_data = read.csv("publicschool_ca.csv")

publicschool_data %>% group_by(geoid) %>%
  mutate(contact_asian = case_when(race_ethnicity == "asian" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "asian"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "asian"]*eff_contacts),
         contact_white = case_when(race_ethnicity == "white" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "white"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "white"]*eff_contacts),
         contact_black = case_when(race_ethnicity == "black" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "black"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "black"]*eff_contacts),
         contact_latino = case_when(race_ethnicity == "latino" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "latino"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "latino"]*eff_contacts),
         contact_other = case_when(race_ethnicity == "other" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "other"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "other"]*eff_contacts)) %>%
  ungroup() -> school_county_contacts

#### total number of children 5-17 yo by race/ethnicity in the state
children_n = publicschool_data %>%
  group_by(race_ethnicity)%>%
  summarize(across(children5_17, ~ sum(as.numeric(.x), na.rm = TRUE)))

contact_race_list <- list()

for(i in 1:length(race_list)){
  school_contacts = school_county_contacts %>%
    filter(race_ethnicity == race_list[i]) %>%
    mutate(asian_k = children5_17*contact_asian,
           white_k = children5_17*contact_white,
           black_k = children5_17*contact_black,
           latino_k = children5_17*contact_latino,
           other_k = children5_17*contact_other) %>%
    summarize(across(asian_k:other_k, ~ sum(as.numeric(.x), na.rm = TRUE)))

  contact_race_list[[i]] = school_contacts/children_n$children5_17[children_n$race_ethnicity == race_list[i]]
}

cbind(t(as.matrix(contact_race_list[[1]])), t(as.matrix(contact_race_list[[2]])),
      t(as.matrix(contact_race_list[[3]])), t(as.matrix(contact_race_list[[4]])),
      t(as.matrix(contact_race_list[[5]]))) %>% as.data.frame() -> contact_matrix
colnames(contact_matrix) <- c("asian", "white", "black", "latino", "other")
rownames(contact_matrix) <- colnames(contact_matrix)

contact_matrix  # column = race/ethnicity of indivdual, row = race/ethnicity of contact


