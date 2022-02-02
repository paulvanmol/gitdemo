ods html close;
%let gpath=d:\workshop\git\output;
%let path=d:\workshop\git;
%let w=5in;
%let h=3in;
%let dpi=200;
ods html path="&path" gpath="&gpath" image_dpi=&dpi;

/*--To display mean line, we need to compute the mean value and display it using HighLow plot--*/
proc means data=sashelp.heart(where=(deathcause ne '')) noprint;
  class deathcause;
  var cholesterol;
  output out=heartMean(where=(_type_ eq 1) rename=(Deathcause=cause))
    mean=Mean;
run;

data combined;
  format Mean 5.1;
  set heartMean(keep=cause mean) sashelp.heart(where=(deathcause ne '') keep=deathcause cholesterol);
run;
/*
ods html;
proc print data=combined(obs=10);
run;
ods html close;
*/
/*--Scatter Mean Quick--*/
ods graphics / reset width=&w height=&h imagename='Scatter_Mean_Quick';
title 'Cholesterol by Death Cause with Mean';
proc sgplot data=sashelp.heart noborder noautolegend;
  vbox cholesterol / category=deathcause nofill nooutliers meanattrs=(size=9 color=red) 
       nomedian nocaps lineattrs=(color=white) whiskerattrs=(color=white);
  scatter x=deathcause y=cholesterol / jitter jitterwidth=0.8 markerattrs=(symbol=plus size=5) transparency=0.8;
  xaxis type=discrete labelattrs=(size=9) display=(noline noticks nolabel);
  yaxis labelattrs=(size=9) display=(noline noticks) grid label='Cholesterol';
run;

/*--Using HighLow plot--*/
ods graphics / reset width=&w height=&h imagename='Scatter_Mean';
title 'Cholesterol by Death Cause with Mean';
proc sgplot data=combined noborder noautolegend;
  scatter x=deathcause y=cholesterol / jitter jitterwidth=0.8 
          markerattrs=(symbol=plus size=5) transparency=0.8;
  highlow x=cause low=mean high=mean / nofill type=bar barwidth=0.4;
  xaxis type=discrete labelattrs=(size=9) display=(noline noticks nolabel);
  yaxis labelattrs=(size=9) display=(noline noticks) grid label='Cholesterol';
run;

/*--Using HighLow plot with Band--*/
ods graphics / reset width=&w height=&h imagename='Scatter_Mean_Band';
title 'Cholesterol by Death Cause with Mean';
proc sgplot data=combined noborder noautolegend;
  scatter x=deathcause y=cholesterol / jitter jitterwidth=0.8 markerattrs=(symbol=plus size=5) transparency=0.8;
  highlow x=cause low=mean high=mean / nofill type=bar barwidth=0.4 name='mean' legendlabel='Mean';
  xaxistable cause / nolabel location=inside;
  xaxis type=discrete labelattrs=(size=9) display=none colorbands=even colorbandsattrs=(transparency=0.2);
  yaxis labelattrs=(size=9) display=(noline noticks) grid label='Cholesterol';
run;

/*--Scatter Box with Band--*/
ods graphics / reset width=&w height=&h imagename='Scatter_Box_Band';
title 'Cholesterol by Death Cause with Statistics';
proc sgplot data=sashelp.heart noborder noautolegend;
  scatter x=deathcause y=cholesterol / jitter jitterwidth=0.8 
          markerattrs=(symbol=plus size=5) transparency=0.8;
  vbox cholesterol / category=deathcause nofill nooutliers nocap;
  xaxistable deathcause / nolabel location=inside;
  xaxis type=discrete labelattrs=(size=9) display=none 
        colorbands=even colorbandsattrs=(transparency=0.2);
  yaxis labelattrs=(size=9) display=(noline noticks) grid label='Cholesterol';
run;

/*--Icon--*/
ods listing image_dpi=&dpi;
ods graphics / reset width=&w height=&h imagename='Scatter_Mean_Icon';
title 'Cholesterol by Death Cause with Mean';
proc sgplot data=combined noborder noautolegend;
  scatter x=deathcause y=cholesterol / jitter jitterwidth=0.8 markerattrs=(symbol=plus size=5) transparency=0.8;
  highlow x=cause low=mean high=mean / nofill type=bar barwidth=0.4 lineattrs=(thickness=2 color=red);
  xaxistable cause / nolabel location=inside;
  xaxis type=discrete labelattrs=(size=9) display=none colorbands=even colorbandsattrs=(transparency=0.2);
  yaxis labelattrs=(size=9) display=(noline noticks) grid label='Cholesterol';
run;

title;