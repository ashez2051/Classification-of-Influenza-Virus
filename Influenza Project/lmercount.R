lmercount <- function(DNA, L){
  starts <- 1:(str_length(DNA) - L + 1 ) # There are N-L+1 K-mers in a sequence
  ends <- L:str_length(DNA)
  lmers <- str_sub(DNA, start= starts, end = ends)  # extract text by start and end point
  lmers.sorted <- elmers(L) # using the elmers function to find all possible combinations
                            # of DNA sequence for a given L
  count.of.lmers <- table(factor(lmers, levels = lmers.sorted)) 
  # counting the number of occourances of same sequuences of L-mers
  
  return(count.of.lmers)
  
}






