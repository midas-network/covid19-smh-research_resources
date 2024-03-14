# Contact Matrix

The contact matric data are organized by state. Each state has it's
own folder.

## File descriptions

We produced synthetic daily contact matrices by race/ethnicity 
in the household, school, community, workplace setting using 
methodology described in 
[Mistry et al. 2021](https://www.nature.com/articles/s41467-020-20544-y) and 
[Aleta et al. 2022](https://www.pnas.org/doi/full/10.1073/pnas.211218211).

For each state, there are two subdirectories: 

1. `contact_matrix/`: contains full contact matrices and
setting-specific matrices in the workplace, school, household, and
community layers for each state. Matrices provide the average number
of daily contacts that individuals of each major racial/ethnic group
have with individuals from other groups. Note, these contacts are not
weighted by the duration or intensity of contact.

2. `build_contact_matrix/`: contains code and source data to build
your own contact matrix with the option to vary the number of 
effective contacts and assortativity. 

Within `build_contact_matrix/`, there are several data sources unique 
to CA and NC that were used to construct the matrices. 

### Contact Matrix Information

Contact matrices should be interpeted as the column representing the 
race/ethnicity of the individual and the row representing the 
race/ethnicity of the contact. Each column sums to the average daily
 number of contacts for 
an individual of a given racial/ethnic group. 

Full matrices are weighted linear combinations of the four 
setting-specific layers. 
Here 
`pre-pandemic matrix = p1*school + p2*workplace_prepandemic + community + household`.
`Pandemic matrix = p2*workplace_prepandemic + community + household`, 
where `p1` = the proportion of the population between 5-17 years of age 
and `p2` = the proportion of the population that participates in the 
workforce according to census data. 
`p1 = .633` and `.614` and `p2 = .163` and ``.158` in California and 
North Carolina respectively. We assume that all individuals experience contacts 
in the household and community setting. Setting-specific matrices are unweighted 
and teams are welcome to aggregate matrices using their own methodologies. 


Within `contact_matrix/` folder you will find the following files for each state: 

1. household_state
2. school_state
3. community_state
4. workplace_pandemic_state
5. workplace_prepandemic_state
6. full_matrix_pandemic_state
7. full_matrix_prepandemic_state

### Build Contact Matrix - Data

Within build_contact_matrix, there are several data sources unique 
to CA and NC that were used to construct the matrices. 

#### California

1. [censustract_ca.csv](./california/build_contact_matrix/censustract_ca.csv): 
This gives the number and proportion of 
individuals that belong to each major racial/ethnic group in 
each census tract. Data is sourced from the American Community 
Survey 2016-2020 5-year estimates (table DP05) using the 
tidycensus API. 

2. [publicschool_ca.csv](./california/build_contact_matrix/publicschool_ca.csv): 
This gives the number and proportion of 
children in each county's public school district sourced from the 
[2021 Public School Enrollment, by Race/Ethnicity](https://www.kidsdata.org/topic/36/school-enrollment-race/table). 
Data indicates 91% of children in California are enrolled in public 
school, so we make the assumption that this racial/ethnic distribution
applies to the entire county. To determine the number of school-aged
children in each county, we use the American Community Survey 
2017-2021 5-year estimates and apply the school district 
race/ethnicity distribution to this. 

3. [household_empirical_ca.csv](./california/build_contact_matrix/household_empirical_ca.csv): 
This gives the proportion of 1, 2, 3, 4, 5, 6+ size households for 
each race/ethnicity in California. Less than <5 of California 
families are multiracial, so we assume only single-race/ethnicity 
families. No data exists for `"Other"`` so we set household contacts to 
the average here. Data are coming from the 
[California Current Survey Population Report](https://dof.ca.gov/wp-content/uploads/sites/352/Reports/Demographic_Reports/documents/CACPS07_final.pdf).
Due to a lack of similar data available in North Carolina, we assume 
California is a nationally representative sample of household size by 
race/ethnicity and we maintain these parameters. In North Carolina, 
we produce the "Other" household size estimate by weighing in 
accordance with the proportion of "Other" that is "Latino/Hispanic" and 
"Other" according to census data.

4. [essential_workers.csv](./california/build_contact_matrix/essential_workers.csv): 
This provides the full list of occupations and occupational groups 
deemed essential during the pandemic using the 
[U.S. Bureau of Labor Statistics Occupation Profile](https://www.bls.gov/oes/current/oes_stru.htm#49-0000), 
which was generated to align with 
[government definitions of the essential workforce](https://covid19.ca.gov/essential-workforce/#:~:text=Health%20care%20providers%20and%20caregivers,social%20workers%20and%20providers%20serving). 
In the production of the workplace contact matrices, we assume that 
only individuals deemed essential workers maintained contacts during 
the pandemic while others reduced contacts to 0. We use the UK/European 
COVID job exposure matrix (Oude Hengel et al., 2022) to infer the number 
of contacts by occupation, where an occupation can be associated 
with (0,0), (1,9), (10, 29), or (30, 50) contacts. We sample from these 
distributions uniformly to produce expected number of contacts for each 
working individual in a given state in line with the proportion of 
individuals in every occupation as published by the Standard Occupational 
Classification (SOC) system. To infer the likely racial/ethnic distribution
of contacts, we first use the COVID job exposure matrix survey data to 
determine whether an individual is more likely to interact with the general 
public or with other workers within their given industry while at work. If 
contacts are primarily within the industry, we assume the racial/ethnic 
distribution of contacts mirrors the racial/ethnic makeup of the major SOC 
group they belong to. If contacts are primarily with the general public, we 
assume the racial/ethnic distribution of contacts mirrors the racial/ethnic
makeup of California. We simulate the entire working population 100 times 
using Monte Carlo simulation and then take the average of these simulations 
to generate the final workplace contact matrices. 


#### North Carolina

1. [censustract_nc.csv](./north_carolina/build_contact_matrix/censustract_nc.csv): 
This gives the number and proportion of 
individuals that belong to each major racial/ethnic group in 
each census tract. Data is sourced from the American Community 
Survey 2016-2020 5-year estimates (table DP05) using the 
tidycensus API. 

2. [publicschool_nc.csv](./north_carolina/build_contact_matrix/publicschool_nc.csv): 
This gives the number and proportion of 
children in each public school district for both public and 
charter schools. Data is sourced from the 
[2018 Student Demographic Report](https://www.ncforum.org/wp-content/uploads/2018/08/Student-Demographics_2018.pdf). 

3. [essential_workers.csv](./north_carolina/build_contact_matrix/essential_workers.csv): 
This provides the full list of occupations and occupational groups deemed 
essential during the pandemic using the 
[U.S. Bureau of Labor Statistics Occupation Profile](https://www.bls.gov/oes/current/oes_stru.htm#49-0000), 
which was generated to align with 
[government definitions of the essential workforce](https://www.cisa.gov/sites/default/files/publications/ECIW_4.0_Guidance_on_Essential_Critical_Infrastructure_Workers_Final3_508_0.pdf). 
In the production of the workplace contact matrices, we assume that only 
individuals deemed essential workers maintained contacts during the pandemic 
while others reduced contacts to 0. We use the UK/European COVID job exposure 
matrix (Oude Hengel et al., 2022) to infer the number of contacts by occupation, 
where an occupation can be associated with (0,0), (1,9), (10, 29), or (30, 50) 
contacts. We sample from these distributions uniformly to produce expected 
number of contacts for each working individual in a given state in line with 
the proportion of individuals in every occupation as published by the Standard 
Occupational Classification (SOC) system. To infer the likely racial/ethnic 
distribution of contacts, we first use the COVID job exposure matrix survey 
data to determine whether an individual is more likely to interact with the 
general public or with other workers within their given industry while at work. 
If contacts are primarily within the industry, we assume the racial/ethnic 
distribution of contacts mirrors the racial/ethnic makeup of the major SOC 
group they belong to. If contacts are primarily with the general public, we 
assume the racial/ethnic distribution of contacts mirrors the racial/ethnic 
makeup of North Carolina. We simulate the entire working population 100 times 
using Monte Carlo simulation and then take the average of these simulations to 
generate the final workplace contact matrices. 

