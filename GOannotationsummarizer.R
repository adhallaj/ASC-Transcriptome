#set the working directory
setwd("C:/Users/azh0134/Desktop/Transcriptome/filteredresults")

#load the dplyr package
library(dplyr)

#initial
multiGOrows <- read.csv(file='annotation_table.csv',header = FALSE)

#get rid of everything but the first 8 columns (automatically assigned headers V1 - V9)
#"%>%" is the pipe operator, allows you to put the output of one function into another (operating from left to right)
#second part of pipe renames the headers
multiGOrows <- multiGOrows %>%
  select(V1,V2,V3,V4,V5,V6,V7,V8) %>%
  rename(
    seqID = V1,
    pident = V2,
    evalue = V3,
    bitscore = V4,
    qcovhsp = V5,
    genestableID = V6,
    genename = V7,
    GOtermaccession = V8,
  )

#original file has multiple lines per transcript, one for each GO term match.
#this summarizes the GO terms
summarizedGOterms <- multiGOrows %>%
  group_by(seqID,pident,evalue,bitscore,qcovhsp,genestableID,genename) %>%
  summarise(GOtermaccession = paste(GOtermaccession, collapse = ";"))

#write the "summarizedGOterms" data frame into a new .csv file
write.csv(summarizedGOterms, "C:\\Users\\azh0134\\Desktop\\Transcriptome\\filteredresults\\Routputs\\annotationtablefinal.csv", row.names = FALSE, quote = FALSE)