%macro classprint (gender=F); 
proc print data=sashelp.class; 
var name height weight; 
where sex="&gender"; 
title "gender is &gender"; 
run; 
%mend classprint; 
%classprint(gender=M);
%classprint(gender=F);