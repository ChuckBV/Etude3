/****************************************************************************
/ script2_traps_rptd_measures.sas
/
/***************************************************************************/

proc import out=alm2
  datafile="alm_nomd2.csv"
  dbms=csv;
run;
  /* 234 rows created */

title "Alm2 data set 234 obs";
proc print data=Alm2 (obs = 6);
run;

title2 "PROC MIXED w three levels in fixed";
proc mixed data = Alm2;
  class TrtCode Rep EndDate;
  model Count = TrtCode Rep EndDate;
  lsmeans TrtCode / adjust=tukey;
run;

title2 "PROC MIXED w trt fixed, rep and date random";
proc mixed data = Alm2;
  class TrtCode Rep EndDate;
  model Count = TrtCode;
  random Rep EndDate;
  lsmeans TrtCode / adjust=tukey;
run;

title2 "PROC MIXED w trt fixed, rep and date random, KR df";
proc glimmix data = Alm2;
  class TrtCode Rep EndDate;
  model Count = TrtCode / dist=Gaussian ddfm = KR;
  random Rep EndDate;
  lsmeans TrtCode / adjust=tukey adjdfe=row lines;
run;

proc mixed data=Alm2;
    class TrtCode Rep EndDate;
	model Count = y0*time trt*time / SOLUTION DDFM=KenwardRoger;
	repeated time / subject=id type=UN;
	estimate 'visit 1 trt eff' trt*time -1 0 0
					    1 0 0 / cl;
	estimate 'visit 2 trt eff' trt*time 0 -1 0
					    0 1 0 / cl;
	estimate 'visit 3 trt eff' trt*time 0 0 -1
					    0 0 1 / cl;
run;

proc import out=alm3
  datafile="alm_nomd3.csv"
  dbms=csv;
run;

title2 "PROC MIXED w trt fixed, rep and date random, KR df";
proc glimmix data = Alm3;
  class TrtCode Rep;
  model Total = TrtCode / dist=gaussian ddfm = KR;
  random Rep;
  lsmeans TrtCode / adjust=tukey adjdfe=row lines;
run;
