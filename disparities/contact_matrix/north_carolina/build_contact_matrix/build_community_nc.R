library(dplyr)

# load in census tract data
censustract_nc = read.csv("censustract_nc.csv")

#### set total number of effective contacts
eff_contacts= 2.79 # set from Mistry et al. 2021

#### assortativity coefficient
assort_coeff= 0.0 # 1 indicates perfect assortativity (within-same race/ethnicity) mixing, while 0 indicates proportionate mixing

#### list of race/ethnicity
race_list <- c("asian", "white", "black", "other")


censustract_nc %>% group_by(geoid) %>%
  mutate(contact_asian = case_when(race_ethnicity == "asian" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "asian"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "asian"]*eff_contacts),
         contact_white = case_when(race_ethnicity == "white" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "white"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "white"]*eff_contacts),
         contact_black = case_when(race_ethnicity == "black" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "black"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "black"]*eff_contacts),
         contact_other = case_when(race_ethnicity == "other" ~
                                     eff_contacts*assort_coeff + (1-assort_coeff)*percent[race_ethnicity == "other"]*eff_contacts,
                                   TRUE ~ (1-assort_coeff)*percent[race_ethnicity == "other"]*eff_contacts)) %>%
  ungroup() -> census_tract_contacts

# calculate total number of children 5-17yo by race/ethnicity at the state level
state_n = censustract_nc %>%
  group_by(race_ethnicity)%>%
  summarize(across(pop_size, ~ sum(as.numeric(.x), na.rm = TRUE)))

contact_race_list <- list()

for(i in 1:length(race_list)){
  community_contacts = census_tract_contacts %>%
    filter(race_ethnicity == race_list[i]) %>%
    mutate(asian_k = pop_size*contact_asian,
           white_k = pop_size*contact_white,
           black_k = pop_size*contact_black,
           other_k = pop_size*contact_other) %>%
    summarize(across(asian_k:other_k, ~ sum(as.numeric(.x), na.rm = TRUE)))

  contact_race_list[[i]] = community_contacts/state_n$pop_size[state_n$race_ethnicity == race_list[i]]
}

cbind(t(as.matrix(contact_race_list[[1]])), t(as.matrix(contact_race_list[[2]])),
      t(as.matrix(contact_race_list[[3]])), t(as.matrix(contact_race_list[[4]]))) %>% as.data.frame() -> contact_matrix
colnames(contact_matrix) <- c("asian", "white", "black", "other")
rownames(contact_matrix) <- colnames(contact_matrix)


contact_matrix # column = race/ethnicity of indivdual, row = race/ethnicity of contact

