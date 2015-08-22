# Getting and Cleaning Data Course Project

This project contains one R script, `run_analysis.R`, which will calculate means per activity, per subject of the mean and Standard deviation of the Human Activity Recognition Using Smartphones Dataset Version 1.0 [1]. This dataset should be [downloaded](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extracted directly into the data directory.

Once executed, the resulting dataset maybe found at `./data/tidy_data.txt`

For futher details, refer to [CookBook.md](CookBook.md)

## References

[1] Human Activity Recognition Using Smartphones Dataset
Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universitа degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

## Required R Packages

The R packages `reshape2`, `data.table`, `plyr` is required to run this script. This maybe installed with,

```{r}
install.package("reshape2")
install.package("data.table")
install.package("plyr")
```
