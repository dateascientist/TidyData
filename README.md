## Getting and Cleaning Data - Project
### Instructions

The data for this project can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is expected that this data is extracted to the root of working directory, where the `run_analysis.r`
file should be run.

The script `run_analysis.r` does the following:<br>

* Read the necessary data files which makes up the dataset
* Add feature variable names to train/test datasets
* Add ID and Activity columns to train/test datasets
* Merge the test and train datasets
* Subset a second data set using only mean and std calculations.
  * This was done by only selecting variables names with std() or mean()
* Label activities as descriptions and tidy up variable names
* Compute the means of the second data set grouped by subject & activity
* Output new data set as `tidy.txt`


The following code will enable you to load the tidy data set as intended:<br>
`address <- "https://s3.amazonaws.com/coursera-uploads/user-418b40549a63cf3a61388ae7/973500/asst-3/fe581070ec5f11e493ae33c80ac90dd1.txt"`<br>
`address <- sub("^https", "http", address)`<br>
`data <- read.table(url(address), header = TRUE)`<br>
`View(data)`<br>











