# Visualize.CRAN.Downloads


## Introduction
This package allows you to visualize the number of downloads for an specific
package in the CRAN repository.

The user can specify different ways to display the information: in a classic
(static) plot, an interactive representation, and/or a combined figure
comparing multiple packages.

### Usage
It is possible then to specify several packages at the same time, and indicate
the type of outcome to be produced.
By default the package will generate the static and interactive representations,
this can be turned off by indicating the "nostatic" and/or "nointeractive" as
options in the arguments of the main function.


## Features
### Automatic date specification and selection
The user can specify the range of dates to be processed, however the main
function of the package will run a couple of checks and adjustments on these:

1) if no dates are specified it will assume the current date as the end of the
period and a year before as the starting date, ie. a period of a year since today;

2) given a range of dates, it will reset the range to the first reported download
within the specified dates, so that dates previous to any reported download from
the CRAN logs are not shown, in this way the package can generate a cleaner and
more meaningful visualization 


### Implementation
It utilizes the `cranlogs` package for accessing the data of the downloads and
the `plotly` package for generating interactive visualizations.
The basic (static) plots are generated employing R basic capabilities.



## Examples
```
processPckg("ehelp")

processPckg(c("ehelp","plotly","ggplot"), "2001-01-01")

processPckg(c("ehelp","plotly","ggplot"), "2001-01-01", opts="nostatic")

processPckg(c("ehelp","plotly","ggplot"), "2001-01-01", opts=c("nostatic","nocombined","nointeractive"))
```
