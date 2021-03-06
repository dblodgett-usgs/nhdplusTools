% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_network.R
\name{calculate_arbolate_sum}
\alias{calculate_arbolate_sum}
\title{Calculate Arbolate Sum}
\usage{
calculate_arbolate_sum(x)
}
\arguments{
\item{x}{data.frame with ID, toID, and length columns.}
}
\value{
numeric with arbolate sum.
}
\description{
Calculates arbolate sum given a dendritic
network and incremental lengths. Arbolate sum is the total length
of all upstream flowlines.
}
\examples{
library(dplyr)
source(system.file("extdata", "walker_data.R", package = "nhdplusTools"))
catchment_length <- select(walker_flowline, COMID, AreaSqKM) \%>\%
  right_join(prepare_nhdplus(walker_flowline, 0, 0,
                            purge_non_dendritic = FALSE, warn = FALSE), by = "COMID") \%>\%
  select(ID = COMID, toID = toCOMID, length = LENGTHKM)

arb_sum <- calculate_arbolate_sum(catchment_length)

catchment_length$arb_sum <- arb_sum
catchment_length$nhd_arb_sum <- walker_flowline$ArbolateSu

mean(abs(catchment_length$arb_sum - catchment_length$nhd_arb_sum))
max(abs(catchment_length$arb_sum - catchment_length$nhd_arb_sum))

}
