# auxs-utils.R
#  -- M.Ponce


#################################################################################################
##	Auxiliary Utilities file for the Visualize.CRAN.Downloads package
#
#	Generic auxiliary functions
#
#################################################################################################


#########################################################################
####   Date fns
#########################################################################

### date's aux fns
today <- function() {
#' function that returns the current date 
#' @keywords internal
	t1 <- Sys.Date()
	# Will substract 1 to do not consider today, but yesterday
	# this matches the definition from cran_downloads too
	t1 <- t1 - 1 
	message("Ending date was not specifed, will assume today: ",t1)
	return(t1)
}

lastyear.date <- function() {
#' function that returns the date from one year ago
#' @keywords internal
	cur.date <- Sys.Date()-1

	cur.year <- substr(cur.date,1,4)
	cur.mnt <- substr(cur.date,6,7)
	cur.day <- substr(cur.date,9,10)

	# check whether this is a leap year...
	if (cur.mnt=="02" & cur.day=="29") {
		cur.day <- "28"
		cur.mnt <- "02"
	}

	lst.year <- as.integer(cur.year) - 1
	t0 <- paste(lst.year,cur.mnt,cur.day,sep="-")

	message("Starting date was not specified, will assume a year from now: ",t0)
	return(t0)
}

checkDates <- function(t0,t1) {
#' function to check dates, ie that t0<t1 and t0!=t1
#' @param  t0  initial date
#' @param  t1  final date
#' @return a list with t0 being [[1]] and t1 being [[2]]
#'
#' @keywords internal
	# check whether t0 is greater than t1
	if (as.Date(t0) > as.Date(t1)) {
		# flip dates, t0 will be set to the older date
		ttemp <- t0
		t0 <- t1
		t1 <- ttemp
	} else if (as.Date(t0) == as.Date(t1)) {
		# dates should be different
		stop(t0," and ", t1," should be different!")       
	}
	return(list(t0,t1))
}


#############################################


time.units <- function(tot.days) {
#' function to identify units of times based on the number of days
#' @param  tot.days  number of days
#' @return  a vector with the "time units" included in the total number of days
#'
#' @keywords internal
        
	# define a time unit vector, for
	# 	days / weeks / months / trimesters / semesters / years / 2-years / 5-years
	time.units <- c(1, 7, 30, 90, 180, 365, 365*2, 365*5)

	# identify time intervals in range of dates
	period.units <- tot.days/time.units

	periods    <- period.units > 1

	return(time.units[periods])
}



time.intervals <- function(tot.days){
#' function to identify units of times and time intervals for customizing axes of plots
#' @param  tot.days  number of days in time interval to consider
#' @return  a list with the unit of time and time interval
#'
#' @keywords internal

	# more than 5 years
        if (tot.days > 365*5) {
                T.unit <- "7 mon"
                everyT <- 3.5*30
	# more than 2 years
	} else if (tot.days > 365*2) {
		T.unit <- "7 mon"
		everyT <- 3.5*30
	# between a year and 2 years
	} else if (tot.days > 365) {
		T.unit <- "months"
		everyT <- 30
	# between a year and 3 months
	} else if (tot.days > (365/12)*3) {
		T.unit <- "2 weeks"
		everyT <- 15
	# less than 3 months
	} else {
		T.unit <- "weeks"
		everyT <- 7
	}

	# combine and return
	return(list(T.unit,everyT))
}


##########################################################################


# load and check needed packages/libraries...
loadLibrary <- function(lib) {
#' function to check and load an specific set of libraries
#' @param  lib  is a list of packages to be loaded
#' @keywords internal

	if (require(lib,character.only = TRUE) == FALSE) stop(lib, " is needed for this package to work but is not installed in your system!")
}


#########################################################################

