# CourseraDS_GetCleanData
Overview

This repository contains the raw data from UCI Machine Learning Repository - Human Activity Recognition Using Smartphones Data Set http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
An R script (run_analysis.R) has been included which takes the raw training and test data files and transforms them into one set of tidy data.
The R script generates tidy_data.csv as an output.

The codebook

Information about the variables and units 
The variables are recordings of accelerometer and gyroscope on a smartphone.

Accelerometer measures the linear acceleration, which is how fast an object is speeding up; the units are in metres per second per second (m/s^-2).
Gyroscope measures the angular velocity, which is how fast an object is turning; the units are in radians per second (s^-1).
Jerk is derived from the change in acceleration, with units of m/s^-3.
Magnitudes are in the same units as the original variables.

Measurements in the time domain have been prepocessed to filter out noise; the variables are prefixed with 'Time'.
Some variables have been transformed into the frequency domain using Fast Fourier Transform; these variables are prefixed with 'Frequency' with the same units.

More information on the variables can be found in the features_info.txt file inside UCI HAR Dataset folder

Transformations

The data set is a subject of the raw data and it contains only the mean and standard deviation of each variable.
The train data and test data have been merged together to form one data set.
The data set has been summarised by taking the mean of each variable within each subject doing each type of activity.

The instruction list

1. Open run_analysis.R in R
2. Press Source to run the analysis, you may need to change the working directory file paths.


