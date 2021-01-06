/*Lists tables and files in Public caslib*/
/*version2*/
cas casauto;

caslib _all_ assign;
proc casutil incaslib="PUBLIC";
list files; list tables;
quit;
cas casauto terminate;