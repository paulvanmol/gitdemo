/*Base SAS: ODS Graphics Procedure: SGPLOT*/

%let gpath=d:\workshop\odsgm6\output;
%let dpi=100;

ods html close;
ods html path="&path" file= "lipidgraph.html" style=htmlblue image_dpi=&dpi gpath="&gpath"; 

/*--Lipid Graph--*/
Data lipid;
label a_med="Drug A" b_med="Drug B" c_med="Drug C" p_med="Placebo";
input N Day $ 4-13 a_med a_lcl a_ucl b_med b_lcl b_ucl c_med c_lcl c_ucl p_med p_lcl p_ucl;
cards;
1  Baseline   5.21 5.04 5.52 5.17 4.94 5.47 5.24 4.97 5.33 5.08 4.81 5.35
2  Visit 1    4.90 4.60 5.79 6.65 4.81 7.51 5.74 5.51 6.78 4.49 4.03 4.94
3  Visit 2    5.30 5.04 6.44 4.77 4.15 7.84 4.40 3.34 6.13 4.94 4.81 5.11
4  Visit 3    6.05 4.91 6.84 5.15 3.91 6.83 5.81 5.17 6.65 5.09 4.29 5.90
5  Visit 4    5.20 5.07 5.39 5.28 5.15 5.38 5.35 5.22 5.52 5.10 4.94 5.23
6  End Point  5.24 4.97 5.48 5.15 5.09 5.42 5.34 5.15 5.53 5.04 4.94 5.22
;
run;
/*proc print; run;*/

data lipid_grp;
  set lipid;
  length trt $8;
  keep day trt median lcl ucl;
  Trt='Drug A'; Median=a_med; LCL=a_lcl; UCL=a_ucl; output;
  Trt='Drug B'; Median=b_med; LCL=b_lcl; UCL=b_ucl; output;
  Trt='Drug C'; Median=c_med; LCL=c_lcl; UCL=c_ucl; output;
  Trt='Placebo'; Median=p_med; LCL=p_lcl; UCL=p_ucl; output;
  run;

*ods listing style=htmlblue;
ods graphics / reset width=5in height=3in imagename='3L_Lipid_Profile_SG_V94';
title 'Median of Lipid Profile by Visit and Treatment';
proc sgplot data=lipid_grp;
  series  x=day y=median / lineattrs=(pattern=solid) group=trt 
          groupdisplay=cluster clusterwidth=0.5 lineattrs=(thickness=2) name='s';
  scatter x=day y=median / yerrorlower=lcl yerrorupper=ucl group=trt 
          groupdisplay=cluster clusterwidth=0.5 errorbarattrs=(thickness=1)
          filledoutlinedmarkers markerattrs=(symbol=circlefilled size=9) 
          markerfillattrs=(color=white);
  keylegend 's' / title='Treatment' linelength=20;
  yaxis label='Median with 95% CL' grid;
  xaxis display=(nolabel);
run;

title;