rm(list=ls())
#Load the data 

library(readxl)
data <- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="info")
Info <- data.frame(data)
#load the data with no rain 
data0 <- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="sunny")
sunny <- data.frame(data0)
#load the data with all types rain 
data1 <- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="notsunny")
rain <- data.frame(data1)
#load the data with small rain 
data2 <- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="smallrain")
smallrain <- data.frame(data2)
#load the data with regular rain
data3<- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="regularrain")
regularrain <- data.frame(data3)
#load the data with big rain
data4<- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="bigrain")
bigrain <- data.frame(data4)
#load the data with heavy rain
data5<- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="heavyrain")
heavyrain <- data.frame(data5)
#load the data with storm rain
data6<- read_excel("Boston Crime (07_2015-02_2020).xlsx",sheet="stormrain")
stormrain <- data.frame(data6)

#First we used two sample t-test (unpaired) to check if the mean of # of crime is the same with or without raining 
#Set the null hypothesis be 
#H0: mean(# of crimes on sunny days) = mean(# of crimes on raining days)
#alpha = 0.05
t.test(sunny$X..of.crime,rain$X..of.crime,paired = F, var.equal = T) #The result p-value = 0.0198 < 0.05 rejected H0. 
#Looking at the sample means, the # of crime on sunny days is greater than the # of crime on raining days

#After knowing that the mean of # of crimes on sunny days and raining days are not the same 
#Next we are going to figure out what arrange of amount of precipitation is most significant
#Based on The standard United States National Weather Service, we sort our data into 3 different types 
# small rain: <0.025
# regular rain: 0.025~0.0499
# big rain: 0.05~0.0999
# heavy rain: 0.1~0.25
# storm rain: >0.25

#And then do the AVONA test (It's a one-way analysis since we only focus on one factor: Percipitation)
#First test H0 : mean(sunny)=mean(smallrain)=mean(regularrain)=mean(bigrain)=mean(heavyrain)=mean(catsanddogs)

combined_groups <-data.frame(cbind(sunny$X..of.crime,smallrain$X..of.crime,regularrain$X..of.crime,bigrain$X..of.crime,heavyrain$X..of.crime,stormrain$X..of.crime))
stacked_groups <- stack(combined_groups)
Anova_results <- aov(values~ind,data = stacked_groups)
summary(Anova_results) #The result shows p-value < 0.05 so reject the H0

#Now In order to figure out which percipitation is more significant we need to do the pairwise t test

#Use method Bonfeeroni to do the pairwise t test 
pairwise.t.test(stacked_groups$values,g=stacked_groups$ind, p.adj='bonferroni')
#alpha* = 0.05/(3 choose 2) = 0.0167
#The result above shows none is significant 

#Use fdr to do the pairwise t test 
pairwise.t.test(stacked_groups$values,g=stacked_groups$ind, p.adj='fdr')

# Tukey's HSD 
TukeyHSD(Anova_results, confidence.level = 0.95)



#1 and 2
t.test(sunny$X..of.crime,smallrain$X..of.crime,paired = F, var.equal = T, alternative = "greater")
#2 and 3
t.test(smallrain$X..of.crime,regularrain$X..of.crime,paired = F, var.equal = T,alternative = "less")
#1 and 3
t.test(sunny$X..of.crime,regularrain$X..of.crime,paired = F, var.equal = T)
#2 and 4
t.test(smallrain$X..of.crime,bigrain$X..of.crime,paired = F, var.equal = T)
#3 and 6
t.test(regularrain$X..of.crime,stormrain$X..of.crime,paired = F, var.equal = T,alternative = "greater")
#1 and 6 
t.test(sunny$X..of.crime,stormrain$X..of.crime,paired = F, var.equal = T,alternative = "greater")
#6 and 4
t.test(stormrain$X..of.crime,bigrain$X..of.crime,paired = F, var.equal = T)
#5 and 2
t.test(heavyrain$X..of.crime, smallrain$X..of.crime, paired = F, var.equal = T)



#PS: do the AVONA test except value sunny 
#second test H0 : mean(smallrain)=mean(regularrain)=mean(bigrain)=mean(heavyrain)=mean(stormrain)

combined_groups2 <-data.frame(cbind(smallrain$X..of.crime,regularrain$X..of.crime,bigrain$X..of.crime,heavyrain$X..of.crime,stormrain$X..of.crime))
stacked_groups2 <- stack(combined_groups2)
Anova_results2 <- aov(values~ind,data = stacked_groups2)
summary(Anova_results2) #The result shows p-value < 0.05 so reject the H0
pairwise.t.test(stacked_groups2$values,g=stacked_groups2$ind, p.adj='bonferroni')
pairwise.t.test(stacked_groups2$values,g=stacked_groups2$ind, p.adj='fdr')
TukeyHSD(Anova_results2, confidence.level = 0.95)
