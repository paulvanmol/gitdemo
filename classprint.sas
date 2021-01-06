proc print data=sashelp.class; 
var name height weigth; 
where sex="F"; 
title "gender is F"; 
run; 
