proc means data=sashelp.cars;
var mpg_city mpg_highway;
class origin;
run;

proc sgplot data=sashelp.cars; 
vbox  MPG_City/group=origin ;

run; 
quit; 

proc univariate data=sashelp.cars ; 
var MPG_City MPG_Highway; 
class origin; 
run; 
