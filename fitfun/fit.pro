pro fit


restore,"data.sav"

expr="P[0] + GAUSS1(X,P[1:3])"

start=[950.D,2.5,1.,1000.]

result=MPFITEXPR(expr,t,r,rerr,start)

print,result

ploterr,t,r,rerr

oplot,t,result(0)+gauss1(t,result(1:3)),color=250,thick=4

end

