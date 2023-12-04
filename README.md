# longdiff
This r package includes a function (longdiff) that returns a vector of the IDs in a longitudinal data set in which there was a specific difference in a variable across two timepoints. 
It is designed for use with longitudinal data in long format, when comparing a continuous variable of interest.

## Rationale
The goal of this function is to facilitate the creation of a subset of your study population that meets your criteria, by allowing you to specify the time interval of interest, and magnitude and direction of change in a certain variable compared to baseline that you would like to investigate. 

## What the function does
longdiff will output a vector of all records in a longitudinal data set wherein there was a specific difference in a variable from time(n) compared to time(0)

## Example
For example, longdiff can be used to find all patients in a dataset where their test scores increased (i.e. had a positive difference) between year 2002 and the baseline visit (year 2000).
```{r}
longdiff(diffdata, record_id, timepoint, test_score, 2002, ">", 0)
```

## How to install longdiff in r
```{r}
install.packages("devtools")
library(devtools)
devtools::install_github("kayserena/longdiff")
library(longdiff)
```

## Presentation
A presentation explaining uses of the function, with examples: 
https://rpubs.com/kayserena/longdiffpres

## Credits
This function was created by Kayla Esser (https://github.com/kayserena) as part of the course CHL7001H: Statistical Programming and Computation for Health Data by Aya Mitani at the University of Toronto, in 2023.
\
Thank you to Aya for being a wonderful & supportive professor and to all my classmates for their encouragement!
