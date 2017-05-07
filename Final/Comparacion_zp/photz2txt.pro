pro photz2txt

dir='/home/ptroncos/verano2017/'
sps=['pegase','maraston','fsps','bc03']

ng=149

pegase=FLTARR(230,ng)
maraston=FLTARR(230,ng)
fsps=FLTARR(230,ng)
bc03=FLTARR(230,ng)

;Guardar posterioris photz


for isps=0,n_elements(sps)-1 do begin

	cd,dir+'fit_'+sps[isps]+'/photoz_Frontierv6';vamos al directorio de la sps [isps]
	res=read_isedfit('zd_paramfile.par', isedfit_post=pd) ;posteriori
	par=read_isedfit_paramfile('zd_paramfile.par')	;archivo de parametros

	x=par.redshift ;eje x de redshifts usados 

	for ig=0, ng-1 do begin
		
		if (isps EQ 0) then begin
			
			pegase[*,ig]=pd[ig].POFZ
			endif

		if (isps EQ 1) then begin
			
			maraston[*,ig]=pd[ig].POFZ
			endif	

		if (isps EQ 2) then begin
			
			fsps[*,ig]=pd[ig].POFZ
			endif

		if (isps EQ 3) then begin
			
			bc03[*,ig]=pd[ig].POFZ
			endif

	endfor
	endfor	

dir="/home/ptroncos/verano2017/comparacion/photoz_Frontierv6/"

print, pegase[*,0]
print,n_elements(pegase[*,0])


OPENW,1,dir+"photz_pegase.txt",WIDTH=100000
PRINTF,1,pegase
close,1

OPENW,1,dir+"photz_maraston.txt",WIDTH=100000
PRINTF,1,maraston
close,1

OPENW,1,dir+"photz_fsps.txt",WIDTH=100000
PRINTF,1,fsps
close,1

OPENW,1,dir+"photz_bc03.txt",WIDTH=100000
PRINTF,1,bc03
close,1


end
