pro comp_sps

dir='/home/ptroncos/verano2017/'
cd,dir

sps=['bc03','fsps','pegase','maraston']
ngal=100

mass=DBLARR(ngal,4,3)
r_mass=[8,12]


    cgps_open,'comp_sps.ps'

	for isps=0,n_elements(sps)-1 do begin

	dir_sps=dir+'fit_'+sps[isps]
	cd,dir_sps

	ar=read_isedfit("zd_paramfile.par", isedfit_post=pd)
		
		for ig=0,ngal-1 do begin
	
		 mass(ig,isps,0)=pce(pd[ig].MSTAR,50.)
		 mass(ig,isps,1)=pce(pd[ig].MSTAR,50.)-pce(pd[ig].MSTAR,16.)
		 mass(ig,isps,2)=pce(pd[ig].MSTAR,84.)-pce(pd[ig].MSTAR,50.)
		endfor

	endfor

	cgplot, mass(*,1,0), mass(*,0,0), xtitle="Masa(BC03)", ytitle="BC03(B),PEGASE(G),MARASTON(R)", title="Comparacion SPS", /nodata,xr=r_mass,yr=r_mass
   
        cgplot, mass(*,1,0), mass(*,0,0), color='blue', ps=2, /overplot

        oploterror, mass(*,1,0), mass(*,0,0), mass(*,0,1), ps=2, color='blue', errcolor='blue', /lobar
        oploterror, mass(*,1,0), mass(*,0,0), mass(*,0,2), ps=2, color='blue', errcolor='blue', /hibar


        cgplot, mass(*,1,0), mass(*,2,0), ps=4,color='green', /overplot
        cgplot, mass(*,1,0), mass(*,3,0), ps=5, color='red', /overplot
	

	cgps_close, /pdf

m_fsps_bc03=pce(mass(*,1,0)- mass(*,0,0),50.)

end 
