/* %macro sortem(tables,byvar); */
/* %local i n table; */
/* %let n=%sysfunc(countw(&tables)); */
/* %do i=1 %to &n; */
/*    %let table=%scan(&tables,&i); */
/*    proc sort data=&table; */
/*    by &byvar; */
/*    run; */
/* %end; */
/* %mend; */

OPTIONS VALIDVARNAME=V7;

libname CANDEV '/home/u59381758/CANDEV_2022/DATA';

PROC IMPORT DATAFILE='/home/u59381758/CANDEV_2022/DATA/Covid_Combined.csv'
OUT = CANDEV.covid
DBMS = CSV
REPLACE;
DELIMITER= ',';
RUN;

PROC IMPORT DATAFILE='/home/u59381758/CANDEV_2022/DATA/crsb-tbl6-e.csv'
OUT = CANDEV.CRSB
DBMS = CSV
REPLACE;
DELIMITER= ',';
RUN;

PROC IMPORT DATAFILE='/home/u59381758/CANDEV_2022/DATA/GDP1.csv'
OUT = CANDEV.GDP
DBMS = CSV
REPLACE;
DELIMITER= ',';
RUN;

/* DATA CANDEV.GDP; */
/* SET CANDEV.GDP; */
/* RENAME All_industries___T001__3 = All_Industries; */
/* FORMAT Reference_period YYMMDD10.; */
/* RUN; */

DATA CANDEV.CRSB_C;
SET CANDEV.CRSB(RENAME=(Total_Gross_Amount___000_ = Total_Gross));
Total_Gross_Amount___000_ = INPUT(Total_Gross, BEST12.);
WHERE PROVINCE_TERRITORY = 'Total';
DROP Eligibility_Period Number_of_Applications PROVINCE_TERRITORY Total_Gross;
RENAME Total_Gross_Amount___000_  = Total_Gross;
RUN;

DATA CANDEV.CRSB_A;
MERGE CANDEV.covid CANDEV.CRSB_C (keep=Total_Gross);
RUN;

PROC CORR DATA = CANDEV.CRSB_A PLOTS=MATRIX;
VAR CRSB_number Invervention_number numconfweek numconf numdeaths numdeathweek numrecover numrecoverweek numtotal_fully numtotal_atleast1dose numtotal_partially proptotal_fully proptotal_atleast1dose proptotal_partially;
RUN;

PROC REG DATA= CANDEV.CRSB_A plots=(ResidualPlot Residualbypredicted QQPLOT);
Model CRSB_number = numconfweek numdeathweek numrecoverweek numtotal_fully numtotal_atleast1dose numtotal_partially /partial;
RUN;





