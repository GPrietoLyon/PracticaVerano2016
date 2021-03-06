pro global_pegase, write_paramfile=write_paramfile, build_grids=build_grids, $
  model_photometry=model_photometry, isedfit=isedfit, kcorrect=kcorrect, $
  build_oiiflux=build_oiiflux, qaplot_sed=qaplot_sed, thissfhgrid=thissfhgrid, $
  clobber=clobber

; En este directorio encuentran todas las rutinas de iSEDfit 
; /home/ptroncos/IDL/libreries/impro/pro/isedfit

; En este directorio encuentran todos los filtros
;/home/ptroncos/IDL/libreries/kcorrect/data/filters

; Para ejecutar
;#global, /write_param, /build_grids, /model_photometry,  /isedfit, /qaplot_sed, /clobber
;#global, /write_param, /isedfit, /qaplot_sed
;#o en bash
;idl < run_global.pro > out_global.txt 2> err_global.txt &
;idl < run_fit.pro > out_fit.txt 2> err_fit.txt &

;Paso 0, Definir informacion
    prefix = 'zd'
    isedfit_dir = '/home/ptroncos/verano2017/fit_pegase/'
    montegrids_dir = isedfit_dir+'montegrids/'
    isedfit_paramfile = isedfit_dir+prefix+'_paramfile.par'

; read the catalog and convert to maggies
;    cat = rsex('/home/ptroncos/verano2017/datos_dani/HST_abell2744_isedfit.dat')
    cat = rsex('/home/ptroncos/hff/final_fit/ffit_z/Frontier_isedfit_format_v5.checked')

; Solo para determinar redshift photometrico, Para el /photoz
;    cat = struct_selecttags(cat, except_tags=["z","zminx","zmaxy"])	

    ngal = n_elements(cat)

;Archivos que dependen del sistema de filtros
    upperlimits = upperlimits_hff(cat)
    hff_to_maggies, cat, maggies, ivarmaggies, filterlist=filterlist

; --------------------------------------------------
; write the parameter file (Definir parametros, ajustar solo esto)
    if keyword_set(write_paramfile) then begin
       write_isedfit_paramfile, params=params, isedfit_dir=isedfit_dir, $
         prefix=prefix, filterlist=filterlist, spsmodels='pegase', $
         imf='salp', redcurve='charlot', igm=1, zminmax=[0.001,11.5], nzz=230, $
         nmodel=40000L, age=[0.001,13.5], tau=[0.001,13.5], Zmetal=[0.0001,0.05], $
         pburst=0.2, interval_pburst=0.2,/nebular,/delayed, clobber=clobber,nminphot=1
    endif
;Parametros identicos a los de las grillas generadas en 
;/home/ptroncos/hff/final_fit/grids_100000_wzr (revisados con zd_paramfile.par)

; --------------------------------------------------
; build the Monte Carlo grids
    if keyword_set(build_grids) then begin
       isedfit_montegrids, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, clobber=clobber
    endif

; --------------------------------------------------
; calculate the model photometry
    if keyword_set(model_photometry) then begin
       isedfit_models, isedfit_paramfile, isedfit_dir=isedfit_dir, $
         montegrids_dir=montegrids_dir, thissfhgrid=thissfhgrid, $
         clobber=clobber
    endif

; --------------------------------------------------
; fit!
    if keyword_set(isedfit) then begin
       isedfit, isedfit_paramfile, maggies, ivarmaggies, $
        cat.z, ra=cat.ra, dec=cat.dec, $
	isedfit_dir=isedfit_dir, thissfhgrid=thissfhgrid, clobber=clobber, index=index, $
         outprefix=outprefix, upperlimits=upperlimits 
;%, /photoz
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
