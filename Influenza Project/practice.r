library(tidyverse)
library(stringr)

# Load the data

lines <- readLines("Data/Neuraminidase.fasta")
view(lines)

#Now, we separate Sequences and Headers
# Method-1  Loop

logicals<- str_detect(lines, pattern=">")  #returns boolean values
idx <- which(logicals)  #actual index positions of headers

#Store results in a tibble

fasta.table <- tibble(Header =lines[idx] ,
                      Sequence = rep("",
                                     times = length(idx))) # store the headers but the 
                                                            #sequence is empty

N.rows <- nrow(fasta.table) #total number of rows in the fasta table

for(row in 1:N.rows){
  
  l1 <- idx[row] +1  # first line of the chunk, just after the first header
  
  if( row == N.rows){
    l2 <- length(lines) 
  }else {
    l2 <- idx[row+1] -1  # last line of the chunk, before the subsequent header
  }

seq.lines <- lines[l1:l2]
sequence <- str_c(seq.lines, collapse="")
fasta.table$Sequence[row] <- sequence 
}


# Method -2

lines <- readLines("data/Neuraminidase.fasta")
header.idx <- which(str_detect(lines, pattern =">"))

fasta.table <- tibble(Header = str_remove(lines[header.idx], "^>"),
                      Sequence = rep("", length(header.idx)))

# Now, we need to fill in the fasta column

header.idx <- c(header.idx, length(lines)+1) #increasing the value of final header index
                                #assuming as if it exists

for(i in 1:length(header.idx)-1){
  
  chunk <- lines[header.idx[i+1]: header.idx[i+1]-1]
  
  fasta.table$Sequence[i] <- str_c(chunk, collapse="")
}








