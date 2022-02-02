data asia usa europe;
	set sashelp.cars;

	if Origin='Asia' then
		output asia;
	else if Origin='USA' then
		output usa;
	else output europe;
	format MSRP Invoice dollar10.;
	format model $50. ; 
run;

proc print data=asia;
	var Make Model Type msrp Invoice;
run;
