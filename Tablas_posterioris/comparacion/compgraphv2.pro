pro compgraphv2,mass=mass,age=age,zmetal=zmetal

;.r compgraphv2
;compgraphv2,/mass,/age,/zmetal


if keyword_set(mass) then begin
peg=readtxt("masspegase.txt",3,100,1)
bc=readtxt("massbc03.txt",3,100,1)
;mar=readtxt("",3,100,1)
fsps=readtxt("",3,100,1)

masspeg=TRANSPOSE(peg[0,*])
massbc=TRANSPOSE(bc[0,*])
;massmar=TRANSPOSE(mar[0,*])
massfsps=TRANSPOSE(fsps[0,*])

x=FINDGEN(16)
y=FINDGEN(16)
cgwindow,"cgScatter2D",massfsps,massbc,Fit=0,grid=1,Title="Comparing the masses",Xtitle="Mass FSPS",Ytitle="Mass BC03/Pegase",color="blue", PSYM=6 ;Ejes y plot fsps vs BC03

cgwindow,"cgScatter2D",massfsps,masspegase,Fit=0,color="red",PSYM=5,/overplot,/addcmd ;Ejes y plot fsps vs Pegase

cgwindow,"cgoplot",x,y,/addcmd




endif






if keyword_set(age) then begin
peg=readtxt("agepegase.txt",3,100,1)
bc=readtxt("agebc03.txt",3,100,1)
;mar=readtxt("",3,100,1)
fsps=readtxt("",3,100,1)

agepeg=TRANSPOSE(peg[0,*])
agebc=TRANSPOSE(bc[0,*])
;agemar=TRANSPOSE(mar[0,*])
agefsps=TRANSPOSE(fsps[0,*])

x=FINDGEN(16)
y=FINDGEN(16)
cgwindow,"cgScatter2D",agepeg,agebc,Fit=0,grid=1,Xrange=[0,1],Yrange=[0,1],Title="Comparing ages",Xtitle="Age Pegase",Ytitle="Age BC03",color="blue", PSYM=6 ;Plot inicial entre Pegasus y BC03

cgwindow,"cgScatter2D",agefsps,agepegase,Fit=0,color="red",PSYM=5,/overplot,/addcmd ;Ejes y plot fsps vs Pegase

cgwindow,"cgoplot",x,y,/addcmd

endif


if keyword_set(zmetal) then begin
peg=readtxt("zmetalpegase.txt",3,100,1)
bc=readtxt("zmetalbc03.txt",3,100,1)
;mar=readtxt("",3,100,1)
fsps=readtxt("",3,100,1)

zmetalpeg=TRANSPOSE(peg[0,*])
zmetalbc=TRANSPOSE(bc[0,*])
;zmetalmar=TRANSPOSE(mar[0,*])
zmetalfsps=TRANSPOSE(fsps[0,*])

x=FINDGEN(16)
y=FINDGEN(16)
cgwindow,"cgScatter2D",zmetalpeg,zmetalbc,Fit=0,grid=1,Title="Comparing metallicities",Xrange=[0,0.05],Yrange=[0,0.05],Xtitle="Metallicity Pegase",Ytitle="Metallicity BC03",color="blue", PSYM=6 ;Plot inicial entre Pegasus y BC03

cgwindow,"cgScatter2D",zmetalfsps,zmetalpegase,Fit=0,color="red",PSYM=5,/overplot,/addcmd ;Ejes y plot fsps vs Pegase

cgwindow,"cgoplot",x,y,/addcmd
endif


end
