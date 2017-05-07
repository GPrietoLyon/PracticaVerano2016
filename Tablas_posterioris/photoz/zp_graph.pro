pro zp_graph

dir='/home/ptroncos/verano2017/'
sps=['fsps','bc03','pegase','maraston']
cd,dir+'fit_'+sps[2]+'/photoz_Frontierv6'
res=read_isedfit('zd_paramfile.par', isedfit_post=pd)
par=read_isedfit_paramfile('zd_paramfile.par')
x=par.redshift ;eje x de redshifts usados 

ng=149

;lo hare solo para bc03 por ahora

cgps_open,'phz.ps'

for ig=0, ng-1 do begin
	
	contador=STRTRIM(ig, 2)
	y=pd[ig].POFZ
	cgplot,x,y,title="Photometric redshift, Galaxy: "+contador,xtitle="Z",ytitle="Probability"
	print,ig

endfor

cgps_close, /pdf


end
