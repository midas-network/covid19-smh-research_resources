# Disparities

The repository contains auxiliary data and code relevant to the modeling
effort for the COVID-19 Scenario Modeling Hub Research Disprities rounds

For any questions or issues please feel free to open an issue on the 
GitHub.

## Case Imputation

A high proportion of COVID-19 cases are not reported with 
demographic information such as race/ethnicity. Populations with
reduced access to quality healthcare and testing resources are 
more likely to experience Covid-19 morbidity and mortality,
and thus is it not appropriate to omit or distribute
missing case data randomly. We adapt methods described in 
Trangucci et al. 2023 to infer the distribution of missing cases
by race/ethnicity. Here, we solely consider the cases that 
were reported without race/ethnicity and do not consider 
infections that were not reported. 

Source: 
[Trangucci, Rob, Yang Chen, and Jon Zelner. "Modeling rates of disease with missing categorical data." arXiv preprint arXiv:2206.08161 (2022).](https://arxiv.org/abs/2206.08161)


## Contact Matrix

We produced synthetic daily contact matrices by race/ethnicity in 
the household, school, community, workplace setting using methodology 
described in 
[Mistry et al. 2021](https://www.nature.com/articles/s41467-020-20544-y) and 
[Aleta et al. 2022](https://www.pnas.org/doi/10.1073/pnas.2112182119).

For more information, please consult the associated [README.md](./contact_matrix/README.md)


## Hospitalization

The folder contains hospitalization by race/ethnicity, in a rate per 100,000 people 
for California and number of hospitalization for North Carolina. 

The data have been extracted from different
sources for each location:

- California hospitalization rates has been extracted from the 
[CDC COVID-NET Laboratory-confirmed COVID-19 hospitalizations](https://www.cdc.gov/coronavirus/2019-ncov/covidnetdashboard/de/powerbi/dashboard.html) dashbaord. 
Note that `"Other"` has been ommitted due to noise. 

- North Carolina hospitalizations is coming from 
[North Carolina Department of Health and Human Services Data Behind the Dashboards - Hospital Demographics](https://public.tableau.com/views/NCDHHS_COVID-19_DataDownload_Story_16220681778000/DataBehindtheDashboards?%3Aembed=y&%3AshowVizHome=no) 
Tableau Dashboard. Note that a portion of hospitalizations are reported 
without known race/ethnicity. 

## Mobility

*In development*

## Population data

The folder contains state population structure by age and race/ethnicity.

- [joint_population_data.csv](./population_data/joint_population_data.csv):
contains state population stucture by age and race/ethnicity jointly from
the 
[Public Policy Institue of California 2022 American Community Survey](https://www.ppic.org/publication/californias-population/) and from the 
North Carolina Department of Information Technology, Government Data 
Analytics Center, Center for Geographic Information and Analysis, 
[NC OneMap](https://www.nconemap.gov/documents/3e7321d33a0c4aee9d0bf6a22e9bd79f/explore)

- [population_data.csv](./population_data/population_data.csv): contains
state state population stucture by age and race/ethnicity separately from 
the [United States Census, 2020](https://www.census.gov/quickfacts/fact/table/NC,CA/PST045222)


## Serology

The serology data was extracted from the CDC COVID Data Tracker,
[2020-2021 Nationwide COVID-19 Infection- and Vaccination-Induced Antibody Seroprevalence (Blood donations)](https://covid.cdc.gov/covid-data-tracker/#nationwide-blood-donor-seroprevalence )

The nationwide blood donor seroprevalence survey estimates the
percentage of the U.S. population ages 16 and older that have
developed antibodies against SARS-CoV-2. The dataset includes 
seroprevalence from both infection and both vaccination (combined) 
and infection for three regions in California and one region in
North Carolina by major racial/ethnic groups. 


## Vaccination

This folder contains weekly vaccination data by key demographics for 
California and North Carolina. We provide the number of individuals 
receiving at least 1 dose (`"partial_vax"`) and fully vaccinated 
(`"full_vax"`) by age ('demographic_category' = 'age') and by 
race/ethnicity ('demographic_category' = 'race_ethnicity'). Age is 
broken down into '0-17', '18-49', '50-64', '65+', and 'unknown'
and race/ethnicity is broken down into 'asian','white','black',
'latino', 'other', and 'unknown', as denoted in 'demographic_value'.

Source data: 

- [California Department of Public Health COVID-19 Vaccine Progress Dashboard](https://data.ca.gov/dataset/covid-19-vaccine-progress-dashboard-data)
- [North Carolina Department of Health and Human Services COVID-19 Dashboard Data - Data Behind the Dashboards](https://covid19.ncdhhs.gov/dashboard/data-behind-dashboards)

For more detailed information on vaccine efficacy and vaccine rollout
schedule assumptions, please consult the Scenario Description associated with
the disparities SMH round, available on the 
[COVID-19 Scenario Modeling Hub - Research GitHub repository](https://github.com/midas-network/covid19-smh-research)




