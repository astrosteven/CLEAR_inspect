
; quick routine to fit a gaussian to a specified wavelength (emission
; line) to get a quick redshift
; 
; Written by CJP, 2016 June 2
; 

FUNCTION MYGAUSS, X, P

; p[0] = continuum flux
; p[1] = central wavelength
; p[2] = sigma
; p[3] = area of Gaussian

  RETURN, P[0] + GAUSS1(X, P[1:3])
END

pro cjpfitline, specpath, field, fobj, tindex, lam_c, fwhm, gaussfit=gaussfit

  ;read in 1D stack spectrum:
  stack_1D=findfile(specpath+'COMBINED/1D/FITS/'+field+'-G102_'+strn(fobj.id_3dhst(tindex),F='(I10)')+'*1D.fits')

  ftab_ext,stack_1d,[1,2,3,4,7],lam, flux, fluxerr, contam, sens

  params = [0.0, lam_c, fwhm/2.35, 0.02/sqrt(2*!pi*fwhm^2/2.35^2)]
  parinfo = replicate({value:0.D, fixed:0, limited:[0,0], $
                       limits:[0.D,0]}, n_elements(params))

  parinfo[1].limited[*] = 1
  parinfo[1].limits = lam_c + [-1,1]*fwhm*1.5 ; limit the central wavelength
  parinfo[2].limited[*] = 1
  parinfo[2].limits= [0,fwhm*2.0]
  parinfo[3].limited[0] = 1
  parinfo[2].limits[0] = 0.0
  

  t =where( abs(lam - lam_c) lt (fwhm*4 > 200.) and finite(flux))
  if t[0] ne -1 then begin
  
     res = mpfitfun('mygauss', lam[t], flux[t], fluxerr[t], params, perror=paramsErr,/quiet, parinfo=parinfo)
  endif else begin
     print,'% no valid wavelength points'
     return
  endelse
  print, '% CJPFITLINE:  continuum / flux = ',res[0],'+/-',paramsErr[0]
  print, '% CJPFITLINE:  central wavelength / Angstrom = ',res[1],'+/-',paramsErr[1]
  print, '% CJPFITLINE:  FWHM / Angstrom =', abs(res[2])*2.35, '+/-', paramsErr[2]*2.35
  print, '% CJPFITLINE:  Ly-alpha redshift = ',res[1]/1216.-1.,'+/-',paramsErr[1]/1216.
  gaussfit = { lam: lam[t], fit: mygauss(lam[t], res), z: res[1]/1216.-1.}
     
end
