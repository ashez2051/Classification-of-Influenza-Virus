elmers <- function(L, iter = 1, alphabet = c("A","C","G","T")){
  require(stringr)
  if(iter < L){
    w <- elmers(L, iter + 1, alphabet)
    w <- str_c(rep(w, each = length(alphabet)),
               rep(alphabet, times = length(alphabet)))
  } else {
    w <- alphabet
  }
  return(sort(w))
}
  
  