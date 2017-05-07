PRO plot_z_distributions,path=path,cat=cat,prefix=prefix,skip=skip,bpzinfo=bpzinfo,hyperzinfo=hyperzinfo
;CUIDADO QUE photoz_chi2[0] NE CHI2!!
;Av= Av_ISM+Av_BC ; ambos valores corresponden al del mejor ajuste.

;25.10.2016 agregamos la opcion de calcular ratio=high/lowz_z solutions
;Lee de un archivo aparte el rango que queremos integrar

path0='/home/ptroncos/'
if not keyword_set(path)  then path='hff/final_fit/ALMA/pp_alma2/photoz/'
if not keyword_set(cat)  then cat='hff/final_fit/ALMA/pp_alma2/FF_ALMA2.cat'
if not keyword_set(prefix)  then prefix='zd'
if not keyword_set(skip)  then skip=30
if not keyword_set(bpzinfo)  then bpzinfo='yes'
if not keyword_set(hyperzinfo)  then hyperzinfo='yes'

;plot_z_distributions,path='uvas',cat='uvas.cat',prefix='tz',skip=21
;plot_z_distributions,path='hff/final_fit/legacy/lasttwo/photoz/',cat='../../wei_isf.cat',prefix='zd',skip=30
;plot_z_distributions,path='hff/final_fit/ALMA/dan_astrodeep/Khst2/',cat='Khst2.cat',prefix='zd',skip=29
;plot_z_distributions,path='hff/final_fit/ALMA/dan_astrodeep/hst/',cat='hst.cat',prefix='zd',skip=29
;plot_z_distributions,path='hff/final_fit/legacy/lasttwo/photoz/',cat='../../wei_isf.cat',prefix='zd',skip=30
;plot_z_distributions,path='hff/final_fit/legacy/lasttwo/photoz/dep_err/try1/',cat='../../../../wei_isf.cat',prefix='zd',skip=30


path=path0+path

cd,path

	readcol,cat,IDGAL,xyz,xyz2,FORMAT='A,I,A',skip=skip;,/silent
	print,n_elements(IDGAL)

	print,IDGAL

	res=read_isedfit(prefix+'_paramfile.par', isedfit_post=post)	;y
	par=read_isedfit_paramfile(prefix+'_paramfile.par')         ; x

	ngal=n_elements(res)
	ratio_lh=DBLARR(ngal)
	peak_ratio=DBLARR(ngal)

	openw,u1,path+'/photoz.info',/get_lun
	openw,u0,path+'/photozv0.info',/get_lun

	printf,u0,'ID BEST PHOTOZ 	chi2	Av	1sigma 		Second best photoz chi2'
;	for i=0,ngal-1 do printf,u1,res[i].isedfit_id,res[i].z,res[i].photoz_err[0],res[i].chi2[0],res[i].z_95


	for i=0,ngal-1 do begin	;		readcol,'info_range.dat',l_z1,l_z2,h_z1,h_z2

		ilow  = -1
		ihigh = -1

		iz0=where( (par.redshift le res[i].photoz[0]+0.03) AND (par.redshift ge res[i].photoz[0]-0.03) )
		iz1=where( (par.redshift le res[i].photoz[1]+0.03) AND (par.redshift ge res[i].photoz[1]-0.03) )
		iz2=where( (par.redshift le res[i].photoz[2]+0.03) AND (par.redshift ge res[i].photoz[2]-0.03) )
		print,n_elements(par.redshift),n_elements(post[i].pofz)
		print,'iz0',iz0
		print,'iz1',iz1
		print,'iz2',iz2

		if ( (res[i].photoz[0] gt 5) AND (res[i].photoz[1] le 5) ) then begin
		 h_z=res[i].photoz[0]+[-1.,+1.]
		 l_z=res[i].photoz[1]+[-1.,+1.]		
		peak_ratio[i]=post[i].pofz[iz0]/post[i].pofz[iz1]
		endif

		if ( (res[i].photoz[0] gt 5) AND (res[i].photoz[1] gt 5) AND (res[i].photoz[2] le 5) ) then begin
		 h_z=res[i].photoz[0]+[-1.,+1.]
		 l_z=res[i].photoz[2]+[-1.,+1.]		
		peak_ratio[i]=post[i].pofz[iz0]/post[i].pofz[iz2]
		endif

		if ( (res[i].photoz[0] le 5) AND (res[i].photoz[1] le 5) AND (res[i].photoz[2] gt 5) ) then begin
		 h_z=res[i].photoz[2]+[-1,+1]
		 l_z=res[i].photoz[0]+[-1,+1]
		peak_ratio[i]=post[i].pofz[iz2]/post[i].pofz[iz0]
		endif

		if ( (res[i].photoz[0] le 5) AND (res[i].photoz[1] le 5) AND (res[i].photoz[2] le 5) AND (res[i].photoz[3] gt 5) ) then begin
		 h_z=res[i].photoz[3]+[-1,+1]
		 l_z=res[i].photoz[0]+[-1,+1]
		peak_ratio[i]=post[i].pofz[iz3]/post[i].pofz[iz0]
		endif

		ilow  = where( (par.redshift ge l_z[0]) AND (par.redshift le l_z[1]) )
		ihigh = where( (par.redshift ge h_z[0]) AND (par.redshift le h_z[1]) )


		if ( (ilow[0] ne -1) AND (ihigh[0] ne -1 ) ) then ratio_lh[i] = TOTAL(post[i].pofz[ihigh]*par.redshift[ihigh]) / TOTAL(post[i].pofz[ilow]*par.redshift[ilow])
		if ( (res[i].photoz[0] gt 5) AND (res[i].photoz[1] gt 5) ) then ratio_lh[i]=-1.
		if ( (res[i].photoz[0] gt 5) AND (res[i].photoz[1] gt 5) AND (res[i].photoz[2] gt 5) ) then peak_ratio[i]=1.e4
		if ( (res[i].photoz[0] gt 5) AND (res[i].photoz[1] gt 5) AND (res[i].photoz[2] eq 0)  AND (res[i].photoz[3] eq 0)  AND (res[i].photoz[4] eq 0) ) then peak_ratio[i]=1.e4

;			if (res[i].photoz[0] lt 5) then l_z=res[i].photoz[0]+[-0.5,+0.5]
;			if (res[i].photoz[0] lt 5) then	l_z=res[i].photoz[1]+[-0.5,+0.5]

		printf,u1,IDGAL(i),res[i].photoz[0],res[i].chi2,res[i].av,res[i].photoz[0]-res[i].z_95[1],$
		res[i].photoz[0]+res[i].z_95[0],res[i].photoz[1],res[i].photoz_chi2[1],ratio_lh[i],peak_ratio[i],FORMAT='(A15,F8.2,F12.1,F8.1,F7.2,F7.2,F8.2,F12.1,F10.1,D10.1)'

;#		printf,u1,IDGAL(i),res[i].photoz[0],res[i].chi2,res[i].av,res[i].photoz[0]-res[i].z_95[1],$
;#		'-',res[i].photoz[0]+res[i].z_95[0],'R=',ratio_lh[i],peak_ratio[i],FORMAT='(A15,F8.2,2F8.1,F7.2,A1,F4.2,A4,F7.1,D10.1)'

		if ( (res[i].z_95[0] lt 1.) AND (res[i].z_95[1] lt 1.) ) then begin

		printf,u0,IDGAL(i),res[i].photoz[0],res[i].chi2,res[i].av,res[i].photoz[0]-res[i].z_95[1],$
		'-',res[i].photoz[0]+res[i].z_95[0],'####',res[i].photoz,FORMAT='(A15,F8.2,2F8.1,F7.2,A1,F4.2,A4,5F7.1)'

		endif else begin

		printf,u0,IDGAL(i),res[i].photoz[0],res[i].chi2,res[i].av,res[i].photoz[0]-res[i].z_95[1],$
		'-',res[i].photoz[0]+res[i].z_95[0],res[i].photoz[1],res[i].photoz_chi2[1],'####',res[i].photoz,FORMAT='(A15,F8.2,2F8.1,F7.2,A1,F5.2,F8.2,F7.1,A4,5F7.1)'

;		printf,u1,IDGAL(i),res[i].photoz[0],res[i].chi2,res[i].z_95,res[i].photoz_chi2[0],FORMAT='(I5,3F8.2,F7.1,F8.2,F7.1)'
		endelse

	endfor
	printf,u1,'ID BEST PHOTOZ 	chi2	Av	1sigma 		Second best photoz chi2'


	print,'secure candidates, no lowz solution',n_elements(where(peak_ratio eq 1.e4))
	print,'ratio peak gt 2',n_elements(where(peak_ratio ge 2))
	print,'ratio peak gt 3',n_elements(where(peak_ratio ge 3))

	printf,u1,'secure candidates, no lowz solution',n_elements(where(peak_ratio eq 1.e4))
	printf,u1,'ratio peak gt 2',n_elements(where(peak_ratio ge 2))
	printf,u1,'ratio peak gt 3',n_elements(where(peak_ratio ge 3))

	;35 candidatos seguros con R>3 y sin peak a low-z son los mismos del Nico?

;	cgps_open,'redshift_distributions.ps'
	cgps_open,prefix+'_zpdf.ps'

	for igal=0,ngal-1 do begin
;	   if total(finite(post[igal].pofz)) then cgplot, par.redshift, post[igal].pofz/MAX(post[igal].pofz), ps=10, xtitle="Redshift", ytitle="Probability", title="Galaxy "+IDGAL(igal) $
	   if total(finite(post[igal].pofz)) then cgplot, par.redshift, post[igal].pofz, ps=10, xtitle="Redshift", ytitle="Probability", title="Galaxy "+IDGAL(igal) $
		else  cgplot, par.redshift, /nodata, xstyle=4, ystyle=4, title="Galaxy"+strtrim(igal+1,2)
	endfor

	cgps_close, /pdf

	FREE_LUN,U0
	FREE_LUN,U1



	if (bpzinfo eq 'yes' ) then begin

	dir='/home/ptroncos/hff/final_fit/legacy/lasttwo/photoz/'
	cd,dir
	am=rsex('wei_isf.bpz')
	cgps_open,prefix+'_bpz_isedfit.ps'

;#	readcol,'all.hyperz',ID_hyz,z_hyz,chi2_hyz,p_hyz,XXX,FORMAT='(I,F,F,D,A)'
       readcol,'hyperzv2.all',ID_hyz,z_hyz,chi2_hyz,p_hyz,XXX,FORMAT='(I,F,F,D,A)'

	np_hyz=n_elements(ID_hyz)
	print,np_hyz

		for igal=0,ngal-1 do begin

			if (am(igal).ID le 999) then begin
			SID=STRING(am(igal).ID,Format='(I3)')
			endif else begin
			SID=STRING(am(igal).ID,Format='(I4)')
			if (am(igal).ID gt 9999) then SID=STRING(am(igal).ID,Format='(I5)')
			endelse 

		readcol,dir+'amolino/wei_isf_ID'+SID+'_PDF.txt',z,zPDF,zPDFE,zPDFL,/SILENT
  
			cgplot, z, zPDF/MAX(zPDF), xtitle="Redshift", ytitle="Probability", title="Galaxy "+IDGAL(igal), /nodata

;		        cgplot, z, zPDF/MAX(zPDF), color='blue', psym=4, /overplot
;		        cgplot, par.redshift, post[igal].pofz/MAX(post[igal].pofz), psym=4,color='black', /overplot

		        cgplot, z, zPDF/MAX(zPDF), color='blue', ps=10, /overplot
		        cgplot, par.redshift, post[igal].pofz/MAX(post[igal].pofz), ps=10,color='black', /overplot
	
		ii=where(ID_hyz eq IDGAL(igal))
		print,IDGAL(igal);,ID_hyz(ii(0))

;		        cgplot, z_hyz(ii), p_hyz(ii)/MAX(p_hyz(ii)), psym=4, color='red', /overplot
		        cgplot, z_hyz(ii), p_hyz(ii)/MAX(p_hyz(ii)), ps=10, color='red', /overplot
		endfor
	
	cgps_close, /pdf

	endif

	iibest=where( (peak_ratio ge 3) );AND (res.photoz[0] gt 5) )

	cgps_open,prefix+'_bestcandidates.ps'

		for j=0,n_elements(iibest)-1 do begin
		igal=iibest(j)
			if (am(igal).ID le 999) then begin
			SID=STRING(am(igal).ID,Format='(I3)')
			endif else begin
			SID=STRING(am(igal).ID,Format='(I4)')
			if (am(igal).ID gt 9999) then SID=STRING(am(igal).ID,Format='(I5)')
			endelse 

		readcol,dir+'amolino/wei_isf_ID'+SID+'_PDF.txt',z,zPDF,zPDFE,zPDFL,/SILENT
  
			cgplot, z, zPDF/MAX(zPDF), ps=10, xtitle="Redshift", ytitle="Probability", title="Galaxy "+IDGAL(igal), /nodata
		        cgplot, z, zPDF/MAX(zPDF), color='blue', linestyle=2, /overplot
		        cgplot, par.redshift, post[igal].pofz/MAX(post[igal].pofz), color='black', /overplot	;dibujar zPDF
		  
		ii=where(ID_hyz eq IDGAL(igal))
		print,IDGAL(igal),ID_hyz(ii(0))

		        cgplot, z_hyz(ii), p_hyz(ii)/MAX(p_hyz(ii)), color='red', /overplot

		endfor

	cgps_close, /pdf


	iin=[0,8,17,23,25,32,33,36,39,40,48,54,56,63]
	cgps_open,prefix+'_nonoverlap.ps'


		for j=0,n_elements(iin)-1 do begin
		igal=iin(j)
			if (am(igal).ID le 999) then begin
			SID=STRING(am(igal).ID,Format='(I3)')
			endif else begin
			SID=STRING(am(igal).ID,Format='(I4)')
			if (am(igal).ID gt 9999) then SID=STRING(am(igal).ID,Format='(I5)')
			endelse 

		readcol,dir+'amolino/wei_isf_ID'+SID+'_PDF.txt',z,zPDF,zPDFE,zPDFL,/SILENT
  
			cgplot, z, zPDF/MAX(zPDF), ps=10, xtitle="Redshift", ytitle="Probability", title="Galaxy "+IDGAL(igal), /nodata
		        cgplot, z, zPDF/MAX(zPDF), color='blue', linestyle=2, /overplot
		        cgplot, par.redshift, post[igal].pofz/MAX(post[igal].pofz), color='black', /overplot
		  

		ii=where(ID_hyz eq IDGAL(igal))
		print,IDGAL(igal),ID_hyz(ii(0))

		        cgplot, z_hyz(ii), p_hyz(ii)/MAX(p_hyz(ii)), color='red', /overplot

		endfor

	cgps_close, /pdf

END



	if (hyperzinfo eq 'yes' ) then begin

;	readcol,'all.hyperz',ID_hyz,z_hyz,chi2_hyz,p_hyz,x1,x2,x3,x4,x5,x6,x7,x8,FORMAT='(I,F,F,D,F,I,I,F,F,D,D,D)'
	readcol,'all.hyperz',ID_hyz,z_hyz,chi2_hyz,p_hyz,XXX,FORMAT='(I,F,F,D,A)'
	np_hyz=n_elements(ID_hyz)
	print,np_hyz

		for i=0,n_elements(IDGAL)-1 do begin

		ii=where(ID_hyz eq IDGAL(i))
		print,IDGAL(i),ID_hyz(ii(0))

;		ratio_hyz(i)=MAX(p_hyz(ii))/MAX(p_hyz(ii))
		endfor

	endif


;ISEDFIT_ID
;CHI2
;   PHOTOZ          FLOAT     Array[5]                                               
;   PHOTOZ_ERR      FLOAT     Array[5]                                               
;   chi2     FLOAT     Array[5]                                               
;   Z               FLOAT           8.82543                                       
;   Z_95            FLOAT     Array[2]                                               
;   Z_ERR           FLOAT         -0.116899

;		printf,u1,res[i].isedfit_id,res[i].photoz[0],res[i].z_95,res[i].chi2[0],FORMAT='(I5,3F8.2,F7.1)'
;		endif else begin
;		printf,u1,res[i].isedfit_id,res[i].photoz[0],res[i].z_95,res[i].chi2[0],res[i].photoz[1],res[i].chi2[1],FORMAT='(I5,3F8.2,F7.1,F8.2,F7.1)'

