pro pd2table

param=read_isedfit("zd_paramfile.par",isedfit_post=pd);leemos archivos de parametro y posteriori

;Stellar Mass keyword -> MSTAR
elem0=n_elements(pd[0].MSTAR)
elemtot=n_elements(pd[*].MSTAR)

nf=elemtot/elem0

percm=fltarr(3,nf)
percage=fltarr(3,nf)
percz=fltarr(3,nf)
perctau=fltarr(3,nf)
percsfr=fltarr(3,nf)
percav=fltarr(3,nf)
for i=0,nf-1 do begin

	percm[*,i]=cgPercentiles(pd[i].MSTAR,Percentiles=[0.5,0.841,0.159])
	percage[*,i]=cgPercentiles(pd[i].AGE,Percentiles=[0.5,0.841,0.159])
	percz[*,i]=cgPercentiles(pd[i].ZMETAL,Percentiles=[0.5,0.841,0.159])
	percsfr[*,i]=cgPercentiles(pd[i].SFR,Percentiles=[0.5,0.841,0.159])
	percav[*,i]=cgPercentiles(pd[i].AV,Percentiles=[0.5,0.841,0.159])

endfor

headerm=["Mean Mass","p(84)","p(16)"]

headerage=["Mean Age","p(84)","p(16)"]
headerzmetal=["Mean Zmetal","p(84)","p(16)"]

headersfr=["SFR","p(84)","p(16)"]

headerav=["AV","p(84)","p(16)"]

dir="pdtxt/"

OPENW,1,dir+"mass.txt"
PRINTF,1,headerm
PRINTF,1,percm
close,1


OPENW,1,dir+"age.txt"
PRINTF,1,headerage
PRINTF,1,percage
close,1

OPENW,1,dir+"Zmetal.txt"
PRINTF,1,headerzmetal
PRINTF,1,percz
close,1


OPENW,1,dir+"sfr.txt"
PRINTF,1,headersfr
PRINTF,1,percsfr
close,1

OPENW,1,dir+"av.txt"
PRINTF,1,headerav
PRINTF,1,percav
close,1


end
