%let path=d:\workshop\mc1v2; 
libname mc1 "&path\data"; 
data utf8data;
length name $13;  
name="Bruno M�ller"; 
output; 
name="Alex Fu�ling";
output;  
name="�123";
len=length(name); 
klen=klength(name);
euro=substr(name,1,1); 
output; 
run; 

proc contents data=utf8data; 
run; 
proc print data=utf8data; 
run; 