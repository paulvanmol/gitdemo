%let gender=F; 
proc print data=sashelp.class; 
var name height weight; 
where sex="&gender"; 
title "gender is &gender"; 
run; 
