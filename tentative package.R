# repeated measurements in subjects
# looking at differences across a time interval
# how many improved over this interval
# inputs: ID, year, timepoint1, timepoint2, data set
# outputs could be >0 or <0 or >=0 depending on the context of the data
# shows increases or decreases over time
# could set the cutoff as something other than 0 ie clinically significant different
# similar to the week of data creation for figures when we were looking for those in which we had a positive difference from 2000 to 2007 in matmort
# would have to set the variable of interest

#notes to self
#set to compare to baseline now (all time points vs baseline)
#can it be set to any reference point? like, any positive difference between year and the year before?
#can the operator be customized? = or <
#this only works when longitudinal data is in long format (repeated ID rows)
#if it were in wide form, would need to specify multiple time point variables and score variables - possible? recommend pivot?

#libraries and data
library(dplyr)
data <- read.csv("diffdata.csv")

#checking data
class(data$test_score)

#create function
longdiff <- function(data, ID, timevar, var, timeparam, cutoff){
  data <- data %>% 
    dplyr::select(ID, timevar, var) %>%
    arrange(ID, timevar) %>%
    group_by(ID) %>%
    mutate(diffvar = var - var [1L])
  
  alldiff <- data %>%
    filter(timevar == timeparam & diffvar > cutoff) %>%
    select(ID) %>%
    pull(ID)
  
  return(alldiff)
}

#testing functions
longdiff(data, "record_id", "timepoint", "test_score","fu2",0)
#errors
#column ID not found

#adjusting function
longdiff1 <- function(data, ID, timevar, var, timeparam, cutoff) {
  data <- data %>% 
    dplyr::select(ID, timevar, var) %>%
    arrange(ID, timevar) %>%
    group_by(ID) %>%
    mutate(diffvar = !!sym(var) - first(!!sym(var)))
  
  alldiff <- data %>%
    filter({{timevar}} == timeparam & diffvar > cutoff) %>%
    select({{ID}}) %>%
    pull()
  
  return(alldiff)
}

#testing functions
longdiff1(data, "record_id", "timepoint", "test_score","fu2",0)
#errors


#adjusting function
longdiff2 <- function(data, ID, timevar, var, timeparam, cutoff) {
  data <- data %>% 
    dplyr::select({{ID}}, {{timevar}}, {{var}}) %>%
    arrange({{ID}}, {{timevar}}) %>%
    group_by({{ID}}) %>%
    mutate(diffvar = {{var}} - first({{var}}))
  
  alldiff <- data %>%
    filter({{timevar}} == timeparam & diffvar > cutoff) %>%
    select({{ID}}) %>%
    pull()
  
  return(alldiff)
}

#testing functions
longdiff2(data, "record_id", "timepoint", "test_score","fu2",0)
#errors
#non numeric argument to binary operator

#adjusting function
longdiff3 <- function(data, ID, timevar, var, timeparam, cutoff) {
  data <- data %>% 
    dplyr::select({{ID}}, {{timevar}}, {{var}}) %>%
    arrange({{ID}}, {{timevar}}) %>%
    group_by({{ID}}) %>%
    mutate(diffvar = as.numeric({{var}}) - first(as.numeric({{var}})))
  
  alldiff <- data %>%
    filter({{timevar}} == timeparam & diffvar > cutoff) %>%
    select({{ID}}) %>%
    pull()
  
  return(alldiff)
}

#testing functions
longdiff3(data, "record_id", "timepoint", "test_score","fu2",0)
#errors
#NAs introduced by coercion

#adjusting function
longdiff4 <- function(data, ID, timevar, var, timeparam, cutoff) {
  # Check unique values in var column
  print(unique(data[[var]]))
  
  data <- data %>% 
    dplyr::select({{ID}}, {{timevar}}, {{var}}) %>%
    arrange({{ID}}, {{timevar}}) %>%
    group_by({{ID}}) %>%
    mutate(diffvar = ifelse(!is.na(as.numeric({{var}})), 
                            as.numeric({{var}}) - first(as.numeric({{var}})), 
                            NA))
  
  alldiff <- data %>%
    filter({{timevar}} == timeparam & !is.na(diffvar) & diffvar > cutoff) %>%
    select({{ID}}) %>%
    pull()
  
  return(alldiff)
}

#testing functions
longdiff4(data, "record_id", "timepoint", "test_score","fu2",0)
#errors


