function readtxt,name,col,fil,linehead
openr,1,name
header=STRARR(linehead)
readf,1,header
table=FLTARR(col,fil)
readf,1,table
close,1
return,table
end
