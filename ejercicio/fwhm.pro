pro fwhm

;Primer filtro f555w

fit=READFITS("SC-F555.fits")

openr,1,"co.txt" ;Cargo texto
M=FLTARR(4,4419) ;Matriz a llenar
readf,1,M ;.txt a matriz


;Ahora solo me interesan las coordenadas x,y del .fit, luego guardo
;estas en listas.

x_im5=ROUND(M[1,*]) ;listas de x
y_im5=ROUND(M[2,*]) ;lista de y .... lo redondeo ya que mis posiciones tienen decimales
;pero las matriz M no.

;tomemos 4 estrellas con buena signal y plotiemos su perfil

g15=where(fit[x_im5[*],y_im5[*]] gt 15)

print,g15

print,fit[x_im5[g15],y_im5[g15]] ;tomamos la 0,1,4,6 de g15, es decir las numero 4,27,133,179 de x e y

index=[4,27,133,179]

px5=x_im5[index]
py5=y_im5[index]

print,px5,py5

;ploteando los perfiles:, le damos 20 pixeles de largo en eje X


perfiles=[fit[px5[0]]]










end
