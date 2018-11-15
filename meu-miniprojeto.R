setwd("~/Documents/dsa/RFundamentos/miniprojeto5")
getwd()

files <- list.files(pattern = '.csv')
files

# Reading files
files <- lapply(files, read.csv)
files
head(files[1])


# Separating by regions
library(dplyr)
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

# Histogram
hist(casesByRegions$value)

# Pie Graph
pie(casesByRegions$value, labels = casesByRegions$location,
    col = c("darksalmon", "gainsboro", "lemonchiffon4", "peachpuff1", "paleturquoise1"), 
    main ="Dsitribuição de Ocorrências")