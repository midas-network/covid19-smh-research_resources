# COVID-19 Scenario Modeling Hub Research - Resources

The repository contains auxiliary data and code relevant to the modeling
effort for the [COVID-19 Scenario Modeling Hub Research rounds](https://github.com/midas-network/covid19-smh-research)


## Heterogeneities Rounds 

The repository contains a [heterogeneities](./heterogeneities/) folder regrouping
all the auxiliary code and data associated with the heterogeneities rounds.

The folder contains multiple sub-folders:

- [case_imputation](./heterogeneities/case_imputation/): imputed cases by 
  race/ethnicity at the state level to infer missing case demographic 
  information. A high proportion of COVID-19 cases are not reported with 
  demographic information such as race/ethnicity. Populations with reduced 
  access to quality healthcare and testing resources are more likely to 
  experience Covid-19 morbidity and mortality, and thus is it not appropriate 
  to omit or distribute missing case data randomly. We adapt methods described 
  in [Trangucci et al. 2022](https://arxiv.org/abs/2206.08161) to infer the 
  distribution of missing cases by race/ethnicity. Here, we solely consider 
  the cases that were reported without race/ethnicity and do not consider 
  underreporting issues. 

- [vaccination](./heterogeneities/vaccination/): weekly vaccination data by 
  key demographics for California and North Carolina. We provide the 
   number of individuals receiving at least 1 dose ("partial_vax") and 
  fully vaccinated ("full_vax") by age and by race/ethnicity

- [serology](./heterogeneities/serology/): monthly serology data was extracted 
   from the 
   [CDC COVID Data Tracker, 2020-2021 Nationwide COVID-19 Infection- and Vaccination-Induced Antibody Seroprevalence (Blood donations)](https://covid.cdc.gov/covid-data-tracker/#nationwide-blood-donor-seroprevalence).
   The nationwide blood donor seroprevalence survey estimates the percentage 
   of the U.S. population ages 16 and older that have developed antibodies 
   against SARS-CoV-2.

- [population_data](./heterogeneities/population_data/): state-level population 
  structure data by age and race/ethnicity both separately and jointly. 
  Age groups include ‘0-17’, ‘18-64’, and ‘65+’ years.  

- [hospitalization_data](./heterogeneities/hospitalization_data/): hospitalization data
  by race/ethnicity, in a rate per 100,000 people for California and 
  number of hospitalizations for North Carolina. 

- [contact_matrix](./heterogeneities/contact_matrix/): synthetic daily contact 
  matrices by race/ethnicity in the household, school, community, workplace 
  setting using methodology described in 
  [Mistry et al. 2021](https://www.nature.com/articles/s41467-020-20544-y) and 
  [Aleta et al. 2022](https://www.pnas.org/doi/10.1073/pnas.2112182119). 
  We produce two contact matrices reflecting the pre-pandemic and pandemic 
  periods and code and data to manually produce contact matrices.

- [mobility](./heterogeneities/mobility): weekly mobility data at the census tract level 
  from [Kang et al. 2021](https://www.nature.com/articles/s41597-020-00734-5)

For more information, please consult the associated [README](./heterogeneities/README.md)

More information about the heterogeneities rounds is available on the 
[COVID-19 Scenario Modeling Hub - Research](https://github.com/midas-network/covid19-smh-research)
GitHub repository. 

## License

All source code specific to the overall project is available under an 
open-source MIT license. Some items might be available under different terms 
and licenses. Please consult these licenses before using it to ensure that you 
follow the terms under which they were released.

## Contributing

Please feel free to open an issue if you identify any issue or would like to 
suggest an idea/improvement.

## Funding

Scenario modeling groups are supported through grants to the contributing 
investigators.

The Scenario Modeling Hub site is supported by the 
[MIDAS Coordination Center](https://midasnetwork.us/), 
NIGMS Grant U24GM132013 to the University of Pittsburgh.

