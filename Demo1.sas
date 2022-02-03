proc means data=sashelp.cars; 
var MPG_Highway; 
run; 

proc sql; 
select Age,
Height,
Name,
Sex
from sashelp.class; 
quit; 

data test; 
set SASHELP.CLASS;
where Age>15; 
run; 