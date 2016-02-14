---
  title: "PA1_template"
author: "DanLarson"
date: "February 13, 2016"
output: html_document
---
  
  ## Part 1
  
  Load the data and the required packages. For this assignment I used ggplot2, dplyr, and tidyr. ggplot2 is for the figure development whil dplyr and tidyr are used for data wrangling. 

```{r,echo=FALSE}

# load required packages
require(ggplot2)
require(dplyr)
require(tidyr)

activity <- tbl_df(read.csv("activity.csv",header=TRUE))


```

##Part 2

Develop a histogram that shows the distribution of total steps per day. 

```{r}

activity$date <- as.Date(activity$date)
activity <- subset(activity,!is.na(steps))
activityDay <- group_by(activity,date) %>% summarise(total_steps = sum(steps))
ggplot(data=activityDay,aes(x=total_steps))+geom_histogram(bins = 10,col="red")+
  ggtitle("Distribution of Total Steps per Day")
```

The mean for steps is 37.38 and the median is 0. Below is the full summary statistics for the variable. 

```{r}
summary(activity$steps)
```


