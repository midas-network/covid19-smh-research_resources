# Contact Matrix

The contact matric data are organized by state. Each state has it's
own folder.

### File descriptions

For each state, there are two subdirectories: 

1. `contact_matrix/`: contains built contact matrices. Note, these 
matrices are unweighted. If you are combing these matrices 
linearly, we suggest weighing in accordance with population age 
structure, i.e. all contacts have a household and community 
(weight = 1) but only a proportion of contacts have school and workplace 
contacts. We also note these contacts are not weighted by the duration
or intensity of contact but only by the expected number of 
daily contacts.

2. `build_contact_matrix/`: contains code and source data to build
your own contact matrix with the option to vary the number of 
effective contacts and assortativity. 

Within `build_contact_matrix/`, there are several data sources unique 
to CA and NC that were used to construct the matrices. 

### Build contact matrix - data

#### California

1. [publicschool_ca.csv](./california/build_contact_matrix/publicschool_ca.csv): 
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

3. [household_distribution_ca.csv](./california/build_contact_matrix/household_distribution_ca.csv): 
This gives the proportion of 1, 2, 3, 4, 5, 6+ size households for 
each race/ethnicity in California. Less than <5 of California 
families are multiracial, so we assume only single-race/ethnicity 
families. No data exists for `"Other"`` so we set household contacts to 
the average here. Data are coming from the 
[California Current Survey Population Report](https://dof.ca.gov/wp-content/uploads/sites/352/Reports/Demographic_Reports/documents/CACPS07_final.pdf). 


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
