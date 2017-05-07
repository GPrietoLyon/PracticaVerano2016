pro isedfit_practica, write_paramfile=write_paramfile, build_grids=build_grids, $
  model_photometry=model_photometry, isedfit=isedfit, kcorrect=kcorrect, $
  build_oiiflux=build_oiiflux, qaplot_sed=qaplot_sed, thissfhgrid=thissfhgrid, $
  clobber=clobber
; Directorio estan todas las rutinas de iSEDfit 
; /home/ptroncos/IDL/libreries/impro/pro/isedfit
; Estan todos los filtros
;/home/ptroncos/IDL/libreries/kcorrect/data/filters
;Correr en bash para el ajuste
;idl < run_sedfit.pro > out_sedfit.txt 2> err_sedfit.txt &
;Correr en bash para generar grillas y ajustar
;idl < run_sedfit_0.pro > out_sedfit_0.txt 2> err_sedfit_0.txt &
; the prefix and ISEDFIT_DIR can be changed arbitrarily
;12:16 16969 


    prefix = 'zd'; prefijo que le damos al nombre de los archivos
    isedfit_dir = '/home/ptroncos/practica_lupe/'
    montegrids_dir = isedfit_dir+'montegrids/'
    isedfit_paramfile = isedfit_dir+prefix+'_paramfile.par'



; read the catalog and convert to maggies
    cat = rsex(isedfit_dir+'isedfit_t1_2.dat') ;leer el catalogo (formato .sextractor)
;solo para determinar redshift fotométrico
;    cat = struct_selecttags(cat, except_tags=["z","zminx","zmaxy"])		;Para el /photoz
;por ejemplo cat.z -> nos dara redshifts, dependera del titulo dado en sextractor.


    ngal = n_elements(cat)

;Archivos que dependen del sistema de filtros
    upperlimits_lupe = upperlimits_lupe(cat) ; nos ayuda a tomar los limites amximos de un dato (los 90's que hay en los catalogos),tambien 
;define los filtros que usaremos


    lupe_to_maggies, cat, maggies, ivarmaggies, filterlist=filterlist

; --------------------------------------------------
; write the parameter file (Definir parametros, ajustar solo esto)
    if keyword_set(write_paramfile) then begin
       write_isedfit_paramfile, params=params, isedfit_dir=isedfit_dir, $
         prefix=prefix, filterlist=filterlist, spsmodels='pegase', $
         imf='salp', redcurve='charlot', igm=1, zminmax=[0.5,2.5], nzz=100, $
         nmodel=20000L, age=[0.01,2.65], tau=[0.01,1.], Zmetal=[0.0001,0.05], $
         pburst=0.5, /nebular, /delayed, clobber=clobber,nminphot=1
    endif

; --------------------------------------------------
; build the Monte Carlo grids (Modelos teoricos)
    if keyword_set(build_grids) then begin
       isedfit_montegrids, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, clobber=clobber
    endif

; --------------------------------------------------
; calculate the model photometry (Convolucion de modelos teoricos con transmitancia de los filtros)
    if keyword_set(model_photometry) then begin
       isedfit_models, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, $
         clobber=clobber
    endif

; --------------------------------------------------
; fit!
    if keyword_set(isedfit) then begin
       isedfit, isedfit_paramfile, maggies, ivarmaggies, isedfit_dir=isedfit_dir, $
         thissfhgrid=thissfhgrid, clobber=clobber, index=index, $
         outprefix=outprefix, upperlimits=upperlimits, /photoz
    endif

; --------------------------------------------------
; compute K-corrections; specifiy ABSMAG_FILTERLIST() as desired
    if keyword_set(kcorrect) then begin
       isedfit_kcorrect, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, $
         absmag_filterlist=lupe_filterlist(), band_shift=0.0, $
         clobber=clobber, index=index, outprefix=outprefix
    endif

; --------------------------------------------------
; generate spectral energy distribution (SED) QAplots
    if keyword_set(qaplot_sed) then begin
       galaxy = strtrim(cat.id)
       isedfit_qaplot_sed, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, $
         clobber=clobber, /xlog, galaxy=galaxy ;, index=index
    endif

return
end
