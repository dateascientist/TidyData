## Getting and Cleaning Data
### Course Project for Data Science

The included run_analysis.r file completes the necessary steps required for this
project to provide a tidy data set in a text file using write.table(). I have chosen
to present the tidy data in **wide format** as opposed to narrow.

The following code will enable you to load the tidy data set as intended:
`address <- "https://s3.amazonaws.com/coursera-uploads/user-longmysteriouscode/asst-3/massivelongcode.csv"`<br>
`address <- sub("^https", "http", address)`<br>
`data <- read.table(url(address), header = TRUE)`<br>
`View(data)`<br>









