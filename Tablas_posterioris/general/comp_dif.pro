pro comp_dif

dir='/home/ptroncos/verano2017/'
cd,dir
sps=['fsps','bc03','pegase','maraston']
ngal=110
mass=DBLARR(4,ngal);0-> fsps , 1->bc03 , 2-> pegase , 3-> maraston 
age=DBLARR(4,ngal)
zm=DBLARR(4,ngal)
tau=DBLARR(4,ngal)
sfr=DBLARR(4,ngal)
av=DBLARR(4,ngal)

for isps=0,n_elements(sps)-1 do begin

	
	dir_sps=dir+'fit_'+sps[isps]+'/Frontierv6'
	cd,dir_sps
	param=read_isedfit("zd_paramfile.par",isedfit_post=pd)
	
	for ig=0,ngal-1 do begin
	
		 mass(isps,ig)=cgPercentiles(pd[ig].MSTAR,Percentiles=0.5);media

		 age(isps,ig)=cgPercentiles(pd[ig].AGE,Percentiles=0.5);media

		 zm(isps,ig)=cgPercentiles(pd[ig].ZMETAL,Percentiles=0.5);media

		 tau(isps,ig)=cgPercentiles(pd[ig].TAU,Percentiles=0.5);media

		 sfr(isps,ig)=cgPercentiles(pd[ig].SFR,Percentiles=0.5);media

		 av(isps,ig)=cgPercentiles(pd[ig].AV,Percentiles=0.5);media

		
endfor
endfor

;fsps-all

mfsbc=mass[0,*]-mass[1,*]
mfspe=mass[0,*]-mass[2,*]
mfsma=mass[0,*]-mass[3,*]

afsbc=age[0,*]-age[1,*]
afspe=age[0,*]-age[2,*]
afsma=age[0,*]-age[3,*]

zmfsbc=zm[0,*]-zm[1,*]
zmfspe=zm[0,*]-zm[2,*]
zmfsma=zm[0,*]-zm[3,*]

tfsbc=tau[0,*]-tau[1,*]
tfspe=tau[0,*]-tau[2,*]
tfsma=tau[0,*]-tau[3,*]

sfsbc=sfr[0,*]-sfr[1,*]
sfspe=sfr[0,*]-sfr[2,*]
sfsma=sfr[0,*]-sfr[3,*]

avfsbc=av[0,*]-av[1,*]
avfspe=av[0,*]-av[2,*]
avfsma=av[0,*]-av[3,*]

y=[0,0]
x=[0,100]

cd,"/home/ptroncos/verano2017/comparacion/Frontierv6"
cgps_open,'diff.ps'
r=[-1,1]
;plots

cgplot,mass(0,*), mfsbc,xtitle="mass(FSPS)", ytitle="Diff mass BC03(blue),PEGASE(green),MARASTON(red)",title="Mass difference",/nodata,ps=4,xr=[8.2,10],yr=[-0.3,0.3]

        cgplot, mass(0,*), mfsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, mass(0,*), mfspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, mass(0,*), mfsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgplot,age(0,*), afsbc,xtitle="age(FSPS)", ytitle="Diff age BC03(blue),PEGASE(green),MARASTON(red)",title="age difference",/nodata,ps=4,xr=[0.2,0.45],yr=[-0.1,0.1]

        cgplot, age(0,*), afsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, age(0,*), afspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, age(0,*), afsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgplot,zm(0,*), zmfsbc,xtitle="zm(FSPS)", ytitle="Diff zm BC03(blue),PEGASE(green),MARASTON(red)",title="zm difference",/nodata,ps=4,xr=[0,0.02],yr=[-0.02,0.02]

        cgplot, zm(0,*), zmfsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, zm(0,*), zmfspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, zm(0,*), zmfsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgplot,tau(0,*), tfsbc,xtitle="t(FSPS)", ytitle="Diff t BC03(blue),PEGASE(green),MARASTON(red)",title="t difference",/nodata,ps=4,xr=[6,10],yr=[-5,5]

        cgplot, tau(0,*), tfsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, tau(0,*), tfspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, tau(0,*), tfsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgplot,sfr(0,*), sfsbc,xtitle="sfr(FSPS)", ytitle="Diff sfr BC03(blue),PEGASE(green),MARASTON(red)",title="sfr difference",/nodata,ps=4,xr=[0.4,1.7],yr=[-0.2,0.2]

        cgplot, sfr(0,*), sfsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, sfr(0,*), sfspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, sfr(0,*), sfsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgplot,av(0,*), avfsbc,xtitle="av(FSPS)", ytitle="Diff av BC03(blue),PEGASE(green),MARASTON(red)",title="av difference",/nodata,ps=4,xr=[0,0.7],yr=[-0.15,0.15]

        cgplot, av(0,*), avfsbc, ps=4,symsize=s, color='blue',/overplot;fsps-bc03

        cgplot, av(0,*), avfspe, ps=4,symsize=s, color='green',/overplot;fsps-pegase

        cgplot, av(0,*), avfsma, ps=4,symsize=s, color='red',/overplot;fsps-maraston

	cgplot,x,y,/overplot

cgps_close, /pdf


end
