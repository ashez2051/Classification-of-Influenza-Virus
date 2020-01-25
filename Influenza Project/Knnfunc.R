knn.function <- function (x.test, y.train, x.train, K) { 
  subset.table %>% 
    select(6:21) -> test.tbl
  x.train <- as.matrix(test.tbl[1:900,])
  x.test <-  as.matrix(test.tbl[901:5986,])
  y.train <- subset.table$N.Type
  y.test <- rep("", nrow(x.test))
  K<- 3
  for(i in 1:length(y.test)){
    d <- as.vector (rowSums(abs(t(log2 (as_vector (x.test [i,])/t(x.train))))))
    idx <- order(d)
    neighborhood.votes <- table(y.train[idx[1:K]])
    y.test[i] <- sample(names(which.max(neighborhood.votes)), size = 1)
    
  }
  return (as.character(y.test))
}