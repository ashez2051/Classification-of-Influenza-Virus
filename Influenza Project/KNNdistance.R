KNNdistance <- function(p,q){
  d <- rowSums(abs(log2(t(p/t(q)))))
  return(d)
}