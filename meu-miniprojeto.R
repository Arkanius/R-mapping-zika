setwd("~/Documents/dsa/RFundamentos/miniprojeto5")
getwd()

# Reading files
files <- list.files(pattern = '.csv')
files

files <- lapply(files, read.csv)
head(files[1])


# Separating by regions
library(dplyr)
library(ggplot2)
df <- do.call(rbind, files)
class(df)
str(df)
head(df)
count(df, location)

# Data Munging - First part, organizing the first Graph -  Brazil occorrences of zika by regions
casesByRegions <- select(df, location_type, value, location) %>% 
  filter(location_type == "region") %>%
  group_by(location) %>%
  summarise(value = sum(value))

head(casesByRegions)
str(casesByRegions)
class(casesByRegions)

ggplot(data=casesByRegions, aes(x = casesByRegions$location, y = casesByRegions$value)) + 
geom_bar(stat = "identity") +
ylab("Número de Casos Reportados") +
xlab("Região") +
ggtitle("Casos de Zika Reportados no Brasil")

# Graph 2 - dispersion graph, relating the increased number of cases reported
# and the month

casesByDate <- select(df, report_date, value, location_type, location) %>% 
  filter(location_type == "region") %>%
  group_by(location) 

head(casesByDate, 10)


ggplot(data=casesByDate, aes(x = report_date, y = value,  colour = location, group = location)) +
  geom_point() +
  geom_line() +
  ylab("Número de Casos Reportados") +
  xlab("Mês") +
  ggtitle("Casos de Zika Reportados no Brasil - Mês a mês")