pro zp_comb

dir='/home/ptroncos/verano2017/'
sps=['pegase','maraston','fsps','bc03']
pegase=FLTARR(230,149)
maraston=FLTARR(230,149)
fsps=FLTARR(230,149)
bc03=FLTARR(230,149)
ng=149


;Guardar posterioris

cgps_open,'phz_combined.ps'


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



for ig=0,ng-1 do begin
				
	contador=STRTRIM(ig, 2)
	cgplot,x,pegase[*,ig],title="Photometric redshift, Galaxy: "+contador,xtitle="Z",ytitle="Probability",color="black"
	cgplot,x,maraston[*,ig],title="Photometric redshift, Galaxy: "+contador,xtitle="Z",ytitle="Probability",color="red",/overplot
	cgplot,x,fsps[*,ig],title="Photometric redshift, Galaxy: "+contador,xtitle="Z",ytitle="Probability",color="blue",/overplot
	cgplot,x,bc03[*,ig],title="Photometric redshift, Galaxy: "+contador,xtitle="Z",ytitle="Probability",color="green",/overplot

	cgLegend, SymColors=['black', 'red','blue','green'],PSyms=[6,6,6,6], Location=[0.15, 0.9],Titles=['Pegase', 'Maraston','fsps','bc03'],length=0, VSpace=1.2,charsize=0.8
endfor


cgps_close, /pdf


end
