
# Part 1 Load Data and turn it into a tbl_df

activity <- tbl_df(read.csv("activity.csv",header=TRUE))

# load required packages
require(ggplot2)
require(dplyr)
require(tidyr)

# Part 2
activity$date <- as.Date(activity$date)
activity <- subset(activity,!is.na(steps))
activityDay <- group_by(activity,date) %>% summarise(total_steps = sum(steps))
a<-ggplot(data=activityDay,aes(x=total_steps))+geom_histogram(bins = 10,col="red")+
    ggtitle("Distribution of Steps by 5 Minute Intervals")
ggsave(a,file="Figures/stepHistogram.png",height = 6,width = 6)


# Part 3
summary(activityDay$total_steps) 

#Part 4
activityInt <- group_by(activity,interval) %>% summarise(total_steps = mean(steps))
b<-ggplot(data=activityInt,aes(x=interval,y=total_steps))+geom_line()+
  ggtitle("Mean Steps per 5 Minute Interval")
ggsave(b,file="Figures/stepInterval.png",height = 6,width = 6)

# Part 5
summary(activityInt$total_steps)
arrange(activityInt,desc(total_steps))


# Part 6: Recode the NAs
nas <- is.na(activity$steps)
avg_interval <- tapply(activity$steps, activity$interval, mean, na.rm=TRUE, simplify=TRUE)
activityNew$steps[nas] <- avg_interval[as.character(activity$interval[nas])]

# Part 7
activityNew <- subset(activityNew,!is.na(steps))
activityDay <- group_by(activityNew,date) %>% summarise(total_steps = sum(steps))
c<-ggplot(data=activityDay,aes(x=total_steps))+geom_histogram(bins = 10,col="red")+
  ggtitle("Distribution of Steps by 5 Minute Intervals")
ggsave(c,file="Figures/stepHistogramReplacedMissing.png",height = 6,width = 6)

# Part 8
#Identify Weekday
activityNew$dow<-format(activityNew$date,
                     format = "%A")
#Identify Weekend/Weekday feature
activityNew$weekEnd <- ifelse(activityNew$dow=="Saturday","Weekend",
                              ifelse(activityNew$dow=="Sunday","Weekend","Weekday"))

#Panel Plot
activityIntWeekend <- group_by(activityNew,weekEnd,interval) %>% summarise(total_steps = mean(steps))
d<-ggplot(data=activityIntWeekend,aes(x=interval,y=total_steps,color=weekEnd))+
            geom_line()+
            facet_wrap(~weekEnd,nrow = 2,ncol = 1)+
            ggtitle("Mean Steps per 5 Minute Interval")
ggsave(d,file="Figures/stepIntervalWeekend.png",height = 6,width = 6)
