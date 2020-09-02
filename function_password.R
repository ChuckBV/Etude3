# Kicks out a secure but managable 16 char password
mk_psswrd <- function(){
  #pick one each capital, lowercase, symbol, and numeral
  LTR <- sample(LETTERS, 1)
  ltr <- sample(letters, 1)
  sym <- sample(c("#","$","%","^","&","*"),1)
  num <- sample(2:9,1)
  #scramble their order and make them into a string
  quad <- sample(c(LTR,ltr,sym,num),4)
  quad <- paste(quad, sep = "", collapse = "")
  #concatenate the string forward and backward twice
  rev <- stringi::stri_reverse(quad)
  new <- paste(c(quad,rev,quad,rev), sep = "", collapse = "")
  return(new)
}
