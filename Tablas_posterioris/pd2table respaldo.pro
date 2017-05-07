pro pd2table

param=read_isedfit("zd_paramfile.par",isedfit_post=pd);leemos archivos de parametro y posteriori

;Stellar Mass keyword -> MSTAR
elem0=n_elements(pd[0].MSTAR)
elemtot=n_elements(pd[*].MSTAR)

nf=elemtot/elem0
perc=fltarr(3,nf)
for i=0,nf-1 do begin
	perc[*,i]=cgPercentiles(pd[i].MSTAR,Percentiles=[0.5,0.841,0.159])
endfor

header=["Mean Mass","+ Err (1sig)","-Err (1sig)"]

OPENW,1,"mass.txt"
PRINTF,1,header
PRINTF,1,perc
close,1


end
