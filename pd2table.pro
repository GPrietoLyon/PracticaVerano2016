pro pd2table

param=read_isedfit("zd_paramfile.par",isedfit_post=pd);leemos archivos de parametro y posteriori

;Stellar Mass keyword -> MSTAR
elem0=n_elements(pd[0].MSTAR)
elemtot=n_elements(pd[*].MSTAR)

nf=elemtot/elem0
percm=fltarr(3,nf)

percchi=fltarr(1,nf)
percage=fltarr(3,nf)
percz=fltarr(3,nf)

for i=0,nf-1 do begin
	percm[*,i]=cgPercentiles(pd[i].MSTAR,Percentiles=[0.5,0.841,0.159])
	percchi[*,i]=pd[i].CHI2
	percage[*,i]=cgPercentiles(pd[i].AGE,Percentiles=[0.5,0.841,0.159])
	percz[*,i]=cgPercentiles(pd[i].ZMETAL,Percentiles=[0.5,0.841,0.159])
endfor

headerm=["Mean Mass","+ Err (1sig)","-Err (1sig)"]
headerchi=["Chi Square"]
headerage=["Mean Age","+ Err (1sig)","-Err (1sig)"]
headerzmetal=["Mean Zmetal","+ Err (1sig)","-Err (1sig)"]

dir="pdtxt/"

OPENW,1,dir+"mass.txt"
PRINTF,1,headerm
PRINTF,1,percm
close,1

OPENW,1,dir+"chi2.txt"
PRINTF,1,headerchi
PRINTF,1,percchi
close,1

OPENW,1,dir+"age.txt"
PRINTF,1,headerage
PRINTF,1,percage
close,1

OPENW,1,dir+"Zmetal.txt"
PRINTF,1,headerzmetal
PRINTF,1,percz
close,1

end
