#' @title Differences in Longitudinal Data Function
#' @description A function that returns the IDs of data in which a condition is met that indicates a positive difference in a variable across two timepoints, for use with longitudinal data in long format
#' @param data The name of your dataset
#' @param ID The variable name corresponding to individual record or subject IDs
#' @param timevar The variable corresponding to timepoint (year, month, etc) of your data
#' @param var The variable you are interested in looking at differences when compared to baseline
#' @param timeparam The timepoint you are interested in comparing to baseline (such as the year)
#' @param operator The comparison operator you would like to use to compare the difference to the cutoff, this can be "=", "<", ">", "<=", ">=" or "!="
#' @param cutoff The cutoff value (numerical) that you would like to set for your variable of interest
#' @return A vector listing all subject IDs that meet the cutoff criteria for your specified variable
#' @author Kayla Esser
#' @examples
#' library(dplyr)
#' list <- longdiff(diffdata, record_id, timepoint, test_score, 2002, ">", 0)
#' list
#' @export

longdiff <- function(data, ID, timevar, var, timeparam, operator, cutoff) {
  names(data)[names(data) == deparse(substitute(ID))] <- "ID"
  names(data)[names(data) == deparse(substitute(timevar))] <- "timevar"
  names(data)[names(data) == deparse(substitute(var))] <- "var"

  if (operator == ">")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) > cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  if (operator == "<")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) < cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  if (operator == "=")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & ((var - var[1L]) == cutoff)) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  if (operator == "<=")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) <= cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  if (operator == ">=")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) >= cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  if (operator == "!=")
    alldiff <- data |>
    dplyr::select(ID, timevar, var) |>
    dplyr::arrange(ID, timevar) |>
    dplyr::group_by(ID) |>
    dplyr::filter(timevar == timeparam & (var - var[1L]) != cutoff) |>
    dplyr::select(ID) |>
    dplyr::pull(ID)

  return(alldiff)
}
