#' @title differences in longitudinal data function
#' @description a function that returns the IDs of data in which a condition is met that indicates a positive difference in a variable across two timepoints, for use with longitudinal data in long format
#' @param data the name of your dataset
#' @param ID the variable name corresponding to individual record or subject IDs
#' @param timevar the variable corresponding to timepoint (year, month, etc) of your data
#' @param var the variable you are interested in looking at differences within
#' @param timeparam the value of the timepoint you are interested in comparing to baseline (such as the year)
#' @param cutoff the cutoff value that you would like to set for your variable of interest
#' @return a vector listing all subject IDs that meet the cutoff criteria for your specified variable
#' @author Kayla Esser
#' @examples
#' library(dplyr)
#' list <- longdiff(diffdata, record_id, timepoint, test_score, 2002, 0)
#' list
#' @export

longdiff <- function(data, ID, timevar, var, timeparam, cutoff) {
  names(data)[names(data) == deparse(substitute(ID))] <- "ID"
  names(data)[names(data) == deparse(substitute(timevar))] <- "timevar"
  names(data)[names(data) == deparse(substitute(var))] <- "var"

  alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) > cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)
  return(alldiff)
}
