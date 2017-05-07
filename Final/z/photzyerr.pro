pro photzyerr

dir='/home/ptroncos/verano2017/'
sps=['pegase','maraston','fsps','bc03']

ng=149

zpe=FLTARR(5,ng)
zma=FLTARR(5,ng)
zfs=FLTARR(5,ng)
zbc=FLTARR(5,ng)

zpeerr=FLTARR(5,ng)
zmaerr=FLTARR(5,ng)
zfserr=FLTARR(5,ng)
zbcerr=FLTARR(5,ng)

cand=fltarr(1,110)

OPENR,1,"highz.txt"
readF,1,cand
close,1

cand=TRANSPOSE(cand)
print,cand

for isps=0,n_elements(sps)-1 do begin

	cd,dir+'fit_'+sps[isps]+'/photoz_Frontierv6';vamos al directorio de la sps [isps]
	res=read_isedfit('zd_paramfile.par', isedfit_post=pd) ;posteriori
	
	for ig=0, ng-1 do begin


			if (isps EQ 0) then begin
			
				zpe[*,ig]=res[ig].PHOTOZ
				zpeerr[*,ig]=res[ig].PHOTOZ_ERR
				print,ig,res[ig].PHOTOZ
				endif
			

			if (isps EQ 1) then begin
			
				zma[*,ig]=res[ig].PHOTOZ
				zmaerr[*,ig]=res[ig].PHOTOZ_ERR
				print,ig,res[ig].PHOTOZ
				endif	

			if (isps EQ 2) then begin
			
				zfs[*,ig]=res[ig].PHOTOZ
				zfserr[*,ig]=res[ig].PHOTOZ_ERR
				print,ig,res[ig].PHOTOZ
				endif

			if (isps EQ 3) then begin
			
				zbc[*,ig]=res[ig].PHOTOZ
				zbcerr[*,ig]=res[ig].PHOTOZ_ERR
				print,ig,res[ig].PHOTOZ
				endif
	endfor
endfor






dir="/home/ptroncos/verano2017/comparacion/photoz_Frontierv6/"

OPENW,1,dir+"z_pegase.txt",WIDTH=100000
PRINTF,1,zpe
close,1

OPENW,1,dir+"z_maraston.txt",WIDTH=100000
PRINTF,1,zma
close,1

OPENW,1,dir+"z_fsps.txt",WIDTH=100000
PRINTF,1,zfs
close,1

OPENW,1,dir+"z_bc03.txt",WIDTH=100000
PRINTF,1,zbc
close,1


OPENW,1,dir+"z_pegase_err.txt",WIDTH=100000
PRINTF,1,zpeerr
close,1

OPENW,1,dir+"z_maraston_err.txt",WIDTH=100000
PRINTF,1,zmaerr
close,1

OPENW,1,dir+"z_fsps_err.txt",WIDTH=100000
PRINTF,1,zfserr
close,1

OPENW,1,dir+"z_bc03_err.txt",WIDTH=100000
PRINTF,1,zbcerr
close,1





end
