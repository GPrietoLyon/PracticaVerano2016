.run global_pegase
global_pegase, /write_param, /build_grids, /model_photometry,  /isedfit, /qaplot_sed, /clobber
;Enviar un email
$(pwd & date) | mail -s "IDL Terra - done" ptroncos@astro.puc.cl
