proc means data=sashelp.cars mean sum stddev; 
var MPG_Highway MPG_City; 
class make; 
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