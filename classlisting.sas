title "listing of &gender students in Class";
%let gender=F; 
proc print data=sashelp.class; 
where sex="&gender"; 
run; 