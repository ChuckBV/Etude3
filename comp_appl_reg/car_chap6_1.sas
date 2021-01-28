/*===========================================================================
/* car_chap6_1.sas
/* 
/* glm binomial, Mroz data set
/*
/*==========================================================================*/



proc import out = mroz
  datafile = "mroz.csv"
  dbms = csv;
run;

proc print data = mroz (obs = 6);
run;

proc genmod data=mroz;
  class wc hc;
  model lfp = k5 k618 age wc hc lwg inc / dist=bin;
run;
