;***************************************************************************************
pro makeplot,pos,im,title
sz=size(im,dim=2)
plot,[0],[0],position=[pos[0],pos[1]+0.01,pos[2],pos[3]-0.01],xticks=0,yticks=0,xtickname=strarr(10)+' ',ytickname=strarr(10)+' ',xr=[1,sz[0]],yr=[1,sz[1]],tit=title,charsize=2
end
;***************************************************************************************
;***************************************************************************************
pro displayband,wind,tindex,fobj,bstamp,vstamp,istamp,i814stamp,zstamp,ystamp,jstamp,hstamp,s1,s2
  wset,wind
  ymin=0.15 & ymax=0.85
  sz=size(reform(hstamp(tindex,*,*))) & cen=sz[1]/2.0d0+0.5d0
  !p.multi=[0,1,8]
  if wind eq 1 then sacs1=min([-0.001,s1-0.002]) else sacs1=s1
  if wind eq 1 then sacs2=max([0.001,s2+0.002]) else sacs2=s2  
  loadct,0,/silent
  pos=[0.0,ymin,0.17,ymax]
  simdisp,bytscl(reform(bstamp(tindex,*,*)),sacs1,sacs2),/axis,xtit='arcsec',tit='!5 F435W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=['0','0.6','1.2','1.8','2.4','3.0'],xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  pos=[0.135,ymin,0.285,ymax]
  simdisp,bytscl(reform(vstamp(tindex,*,*)),sacs1,sacs2),/axis,xtit='arcsec',tit='!5 F606W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  pos=[0.25,ymin,0.40,ymax]
  simdisp,bytscl(reform(istamp(tindex,*,*)),sacs1,sacs2),/axis,xtit='arcsec',tit='!5 F775W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent
  
  pos=[0.37,ymin,0.52,ymax]
  simdisp,bytscl(reform(i814stamp(tindex,*,*)),sacs1+0.001,sacs2-0.001),/axis,xtit='arcsec',tit='!5 F814W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  pos=[0.49,ymin,0.64,ymax]
  simdisp,bytscl(reform(zstamp(tindex,*,*)),sacs1,sacs2),/axis,xtit='arcsec',tit='!5 F850LP',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent
  
  pos=[0.61,ymin,0.76,ymax]
  simdisp,bytscl(reform(ystamp(tindex,*,*)),s1,s2),/axis,xtit='arcsec',tit='!5 F098M/F105W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  pos=[0.73,ymin,0.88,ymax]
  simdisp,bytscl(reform(jstamp(tindex,*,*)),s1,s2),/axis,xtit='arcsec',tit='!5 F125W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  pos=[0.85,ymin,0.99,ymax] 
  simdisp,bytscl(reform(hstamp(tindex,*,*)),s1,s2),/axis,xtit='arcsec',tit='!5 F160W',xtickname=['0','0.6','1.2','1.8','2.4','3.0'],ytickname=strarr(10)+' ',xticks=5,yticks=5,position=pos,charsize=2
  tvcircle,3.33d0,cen,cen,/data,color=djs_icolor('yellow'),thick=2,line=2 & loadct,0,/silent

  !p.multi=0
end
;***************************************************************************************
;***************************************************************************************
pro plot2d,specpath,field,fobj,tindex,scl_2d_lo,scl_2d_hi
  wset,4 & loadct,0,/silent
  ;1D stack
  stack_1D=findfile(specpath+field+'/'+field+'-G102_'+strn(fobj.id_3dhst(tindex),F='(I6)')+'*1D.fits')
  ftab_ext,stack_1d,[1,2,3,4,7],lam1d,flux1d,dflux1d,contam1d,sens
  !p.multi=[0,1,3]
  plot,lam1d/1.0d4,flux1d,position=[0.0925,0.15,0.94,0.48],xtit='Wavelength (um)',ytit='Flux (e!U-!N/s)',charsize=3
  polyfill,0.1216d0*(1.0d0+[fobj.zphot_l95(tindex),fobj.zphot_u95(tindex),fobj.zphot_u95(tindex),fobj.zphot_l95(tindex)]),[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu6')
  polyfill,0.1216d0*(1.0d0+[fobj.zphot_l68(tindex),fobj.zphot_u68(tindex),fobj.zphot_u68(tindex),fobj.zphot_l68(tindex)]),[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu8')
  oploterror,lam1d/1.0d4,flux1d,dflux1d,thick=0.5,color=fsc_color('red6'),/nohat
  oplot,lam1d/1.0d4,flux1d
  wset,4 & loadct,0,/silent
  ;2D stack
  stack_2d=findfile(specpath+field+'/'+field+'-G102_'+strn(fobj.id_3dhst(tindex),F='(I6)')+'*2D.fits')
  sci2d=readfits(stack_2d,ext=5,head2d,/silent) & wht2d=readfits(stack_2d,ext=6,/silent) & model2d=readfits(stack_2d,ext=7,/silent)
  contam2d=readfits(stack_2d,ext=8,/silent) & lam2d=readfits(stack_2d,ext=9,/silent) & trace2d=readfits(stack_2d,ext=11,/silent)
  pos=[0.09,0.74,0.94,0.99] & makeplot,pos,sci2d
  pos=[0.065,0.74,0.965,0.99] & simdisp,bytscl(sci2d,scl_2d_lo,scl_2d_hi),position=pos
  oplot,trace2d,color=djs_icolor('yellow'),line=1,thick=3 & loadct,0,/silent
  plots,findel(lam2d,8000.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,8500.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,9000.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,9500.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,10000.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,10500.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,11000.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  plots,findel(lam2d,11500.0d0),!y.crange,line=2,color=djs_icolor('yellow'),thick=1
  loadct,0,/silent
  pos=[0.09,0.49,0.94,0.74] & makeplot,pos,sci2d
  pos=[0.065,0.49,0.965,0.74] & simdisp,bytscl(contam2d,scl_2d_lo,scl_2d_hi),position=pos
  oplot,trace2d,color=djs_icolor('yellow'),line=1,thick=3 & loadct,0,/silent
  !p.multi=0
end
;***************************************************************************************
;***************************************************************************************
pro plotpas,specpath,field,fobj,tindex,scl_2d_lo,scl_2d_hi
;Individual PAs
wset,5 & loadct,0,/silent
pas=findfile(specpath+field+'/'+field+'-*-G102_'+strn(fobj.id_3dhst(tindex),F='(I6)')+'.2D.fits')
!p.multi=[0,1,6]
for p=0,n_elements(pas)-1 do begin
   temp=strsplit(pas(p),'-',/extract)
   label='PA='+temp[1]+'_'+temp[2]
   if p eq 0 then begin & pos1=[0.03,0.73,0.47,0.9] & pos2=[0.01,0.65,0.49,0.99] & endif
   if p eq 1 then begin & pos1=[0.03,0.43,0.47,0.6] & pos2=[0.01,0.35,0.49,0.69] & endif
   if p eq 2 then begin & pos1=[0.03,0.13,0.47,0.3] & pos2=[0.01,0.05,0.49,0.39] & endif
   if p eq 3 then begin & pos1=[0.53,0.73,0.97,0.9] & pos2=[0.51,0.65,0.99,0.99] & endif
   if p eq 4 then begin & pos1=[0.53,0.43,0.97,0.6] & pos2=[0.51,0.35,0.99,0.69] & endif
   if p eq 5 then begin & pos1=[0.53,0.13,0.97,0.3] & pos2=[0.51,0.05,0.99,0.39] & endif
   spec=readfits(pas(p),ext=5,/silent) & trace=readfits(pas(p),ext=11,/silent)
   makeplot,pos1,spec,label  
   simdisp,bytscl(spec,scl_2d_lo,scl_2d_hi),position=pos2
   oplot,trace,color=djs_icolor('yellow'),line=1,thick=3 & loadct,0,/silent
   delvarx,spec,trace,pos
endfor
!p.multi=0
end
;***************************************************************************************
;***************************************************************************************
pro inspect_clear,field,zsample=zsample,specpath=specpath
  if not keyword_set(specpath) then specpath='Files/Spectra/'
  if not keyword_set(zsample) then zsample=7l
  if zsample eq 6 or zsample eq 7 or zsample eq 8 then zsamp='678'
  if zsample eq 4 or zsample eq 4 or zsample eq 8 then zsamp='45'

  print,' '
  print,'##########################################'
  print,'Reading in objects for Field '+field+' for z='+zsamp
  print,'##########################################' & print,' '
  restore,'Files/Samples/'+field+'_z'+zsamp+'.idl'

  filts=['ACS/ACS_F435W','ACS/ACS_F606W','ACS/ACS_F775W','ACS/ACS_F814W','ACS/ACS_F850LP','WFC3/WFC3_F105W','WFC3/WFC3_F125W','WFC3/WFC3_F160W']
  filt_lamc=dblarr(n_elements(filts)) & filt_fwhm=filt_lamc
  for ff=0,n_elements(filts)-1 do begin
     res=plotfilter('Files/filters/'+filts(ff)+'.txt')
     filt_lamc(ff)=res[0]/1.0d4 & filt_fwhm(ff)=res[1]/1.0d4
  endfor
  
  window,1,xsize=1420,ysize=200,xpos=10,ypos=30
  window,2,xsize=500,ysize=280,xpos=10,ypos=590
  window,3,xsize=500,ysize=300,xpos=10,ypos=260
  window,4,xsize=880,ysize=320,xpos=550,ypos=550
  window,5,xsize=880,ysize=265,xpos=550,ypos=260

  fi=findfile('verify_'+field+'_'+zsamp+'.idl')
  if fi[0] eq 'verify_'+field+'_'+zsamp+'.idl' then begin
     restore,'verify_'+field+'_'+zsamp+'.idl'
  endif else begin
     result=create_struct('id',fobj.id_candels,'inspect',dblarr(n_elements(fobj.id_candels))-1.0d0,'apcorr',dblarr(n_elements(fobj.id_candels))-1.0d0,'notes',strarr(n_elements(fobj.id_candels)))
  endelse
  
;Option to start on a specific object
g=min(where(result.inspect eq -1.0)) & if min(g) ge 0 then tindex=g else tindex=0

if keyword_set(start) then tindex=start
index=dindgen(n_elements(fobj.id_candels))
while tindex le max(index) do begin
   print,'Index ='+strn(index(tindex),F='(I5)')+'/'+strn(n_elements(index)-1,F='(I5)')+'; ID='+fobj.id_candels(tindex)
   if result.inspect(tindex) eq -1.0 then print,'Object not yet classified'
   if result.inspect(tindex) eq 0.0 then print,'Object previously classified as BAD: '+result.notes(tindex)
   if result.inspect(tindex) eq 1.0 then print,'Object previously classified as GOOD'
   if result.inspect(tindex) eq 2.0 then print,'Object previously classified as GOOD/FIXAPCORR'
   ;Initial values for parameters
   s1=-0.007 & s2=0.007
   s1_2d=-0.008 & s2_2d=0.008
   comm='' & zz=0 & real='' & notes=''
   cont='' & skip='' & skipsample='' & next='' & good='' & bad='' & quit=''

;##########Initial display##########
displayband,1,tindex,fobj,bstamp,vstamp,istamp,i814stamp,zstamp,ystamp,jstamp,hstamp,s1,s2
;###################################

;############ Plot P(z) ############
wset,2
ttitle='CANDELS ID '+fobj.id_candels(tindex)+'; 3DHST ID '+strn(fobj.id_3dhst(tindex),F='(I6)')
if fobj.zspec(tindex) le 0.0d0 then begin
   plot,fobj.zgrid,fobj.pz(*,tindex),xtit='z',ytit='P(z)',background=djs_icolor('white'),color=djs_icolor('black'),charsize=1.3,title=ttitle
   if fobj.zspec(tindex) gt 0.0d0 then plots,fobj.zspec(tindex),!y.crange,thick=2,line=2
endif else begin
   if abs(fobj.zspec(tindex)-fobj.zphot(tindex)) gt 0.5d0 then col='dark red' else col='green'
   plot,fobj.zgrid,fobj.pz(*,tindex),xtit='z',ytit='P(z)',background=djs_icolor(col),color=djs_icolor('black'),charsize=1.3,title=ttitle
   if fobj.zspec(tindex) gt 0.0d0 then plots,fobj.zspec(tindex),!y.crange,thick=2,line=2,color=djs_icolor('black')
   xyouts,set_xposition(0.03),set_yposition(0.35),'z!Dspec!N='+strn(fobj.zspec(tindex),F='(F5.2)'),charsize=2.5,color=djs_icolor('black')
endelse
polyfill,[fobj.zphot_l95(tindex),fobj.zphot_u95(tindex),fobj.zphot_u95(tindex),fobj.zphot_l95(tindex)],[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu6')
polyfill,[fobj.zphot_l68(tindex),fobj.zphot_u68(tindex),fobj.zphot_u68(tindex),fobj.zphot_l68(tindex)],[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu8')
oplot,fobj.zgrid,fobj.pz(*,tindex),color=fsc_color('red5'),thick=3
oplot,fobj.zgrid,fobj.pz(*,tindex),color=fsc_color('red2'),thick=1
axis,0,0,xax=0,xtickname=strarr(20)+' ',color=djs_icolor('black')
;###################################


;############ Display SED ############
wset,3
flux=[fobj.flux.fb(tindex),fobj.flux.fv(tindex),fobj.flux.fi(tindex),fobj.flux.fi814(tindex),fobj.flux.fz(tindex),$
      fobj.flux.fy(tindex),fobj.flux.fj(tindex),fobj.flux.fh(tindex)]
dflux=[fobj.dflux.fb(tindex),fobj.dflux.fv(tindex),fobj.dflux.fi(tindex),fobj.dflux.fi814(tindex),fobj.dflux.fz(tindex),$
       fobj.dflux.fy(tindex),fobj.dflux.fj(tindex),fobj.dflux.fh(tindex)]

plot,[0],[0],xr=[3000,18500]/1.0d4,yr=[1.0,2.0*fobj.flux.fh(tindex)],/ylog,xtit='Lambda (!7l!5m)',ytit='f!D!7m!5!N (nJy)';,background=djs_icolor(col)
polyfill,0.1216d0*(1.0d0+[fobj.zphot_l95(tindex),fobj.zphot_u95(tindex),fobj.zphot_u95(tindex),fobj.zphot_l95(tindex)]),10.0d0^[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu6')
polyfill,0.1216d0*(1.0d0+[fobj.zphot_l68(tindex),fobj.zphot_u68(tindex),fobj.zphot_u68(tindex),fobj.zphot_l68(tindex)]),10.0d0^[!y.crange[0],!y.crange[0],!y.crange[1],!y.crange[1]],color=fsc_color('blu8')

for i=0,n_elements(filt_lamc)-1 do begin
   if flux(i)/dflux(i) ge 2.0d0 then begin
      plots,[filt_lamc(i)-filt_fwhm(i)/2.0,filt_lamc(i)+filt_fwhm(i)/2.0],flux(i),color=fsc_color('red5')
      plots,filt_lamc(i)-filt_fwhm(i)/2.0,flux(i)*[0.89,1.12],color=fsc_color('red5') & plots,filt_lamc(i)+filt_fwhm(i)/2.0,flux(i)*[0.89,1.12],color=fsc_color('red5')
      oploterror,filt_lamc(i),flux(i),dflux(i),psym=3,color=fsc_color('red5')
      plotsym,0,1.5,/fill & oplot,[filt_lamc(i)],[flux(i)],psym=8,color=fsc_color('red5')
      plotsym,0,1.0,/fill & oplot,[filt_lamc(i)],[flux(i)],psym=8,color=fsc_color('red2')
   endif else begin
      plots,[filt_lamc(i)-filt_fwhm(i)/2.0,filt_lamc(i)+filt_fwhm(i)/2.0],dflux(i)*1.0d0,color=fsc_color('red5')
      plots,filt_lamc(i)-filt_fwhm(i)/2.0,dflux(i)*1.0d0*[0.89,1.12],color=fsc_color('red5') & plots,filt_lamc(i)+filt_fwhm(i)/2.0,dflux(i)*1.0d0*[0.89,1.12],color=fsc_color('red5')
      plotsym,1,4,/fill & oplot,[filt_lamc(i)],[dflux(i)*1.0d0],psym=8,color=fsc_color('red5')
   endelse
endfor
;###################################

;########## Plot Spectra ###########
plot2d,specpath,field,fobj,tindex,s1_2d,s2_2d
plotpas,specpath,field,fobj,tindex,s1_2d,s2_2d
;###################################


;############Query Input############
while comm ne 'done' do begin
   read,'Command  (type ? for options):  ',comm
   if comm eq '?' then begin
      print,'stretch = set image stretch; pair, e.g. -0.005,0.005'
      print,'stretch2d = set 2D spectrum stretch; pair, e.g. -0.005,0.005'
      print,'hard = harden image stretch'
      print,'soft = soften image stretch'
      print,'hard2d = harden 2D spectrum stretch'
      print,'soft2d = soften 2D spectrum stretch'
      print,'skip = give index of object to skip to'
      print,'skipid = give ID of object to skip to'
      print,'png = open 3DHST pipeline PNG'
      print,'p/previous or n/next = skip to previous or next object in list'
      print,'skipsample = skip to 1st object in a sample: takes 4,5,6,7 or 8'
      print,'good, bad or fixapcorr = record result for this object'
      print,'quit = save and quit'
   endif
;###################################

if comm eq 'skip' then begin
   read,'Skip to index #: ',skip
   tindex=skip
   wset,1 & erase & wset,2 & erase & wset,3 & erase & wset,4 & erase & wset,5 & erase
   comm='done'
endif

if comm eq 'skipid' then begin
   read,'Skip to ID #: ',skipid
   tindex=where(fobj.id_candels eq skipid)
   wset,1 & erase & wset,2 & erase & wset,3 & erase & wset,4 & erase & wset,5 & erase
   comm='done'
endif

if comm eq 'n' or comm eq 'next' then begin
   tindex=tindex+1
   wset,1 & erase & wset,2 & erase & wset,3 & erase & wset,4 & erase & wset,5 & erase
   comm='done'
endif
if comm eq 'p' or comm eq 'previous' then begin
   tindex=tindex-1
   wset,1 & erase & wset,2 & erase & wset,3 & erase & wset,4 & erase & wset,5 & erase
   comm='done'
endif

if comm eq 'skipsample' then begin
   read,'Skip to sample z= ',skipsample
   tindex=min(where(fobj.photz.sample eq strn(skipsample,F='(A1)')))
   wset,1 & erase & wset,2 & erase & wset,3 & erase & wset,4 & erase & wset,5 & erase
   comm='done'
endif

if comm eq 'png' then begin
   temp=findfile(specpath+field+'/*'+strn(fobj.id_3dhst(tindex),F='(I6)')+'*stack.png')
   spawn,'open '+temp & delvarx,temp
   comm='done'
endif

if comm eq 'stretch' then read,'stretch:  ',s1,s2

if comm eq 'hard' then begin
   if s1 lt -0.001 then s1=s1+0.001
   if s2 gt 0.001 then s2=s2-0.001
endif

if comm eq 'soft' then begin
   s1=s1-0.001 & s2=s2+0.001
endif

if comm eq 'stretch2d' then read,'stretch2d:  ',s1_2d,s2_2d

if comm eq 'hard2d' then begin
   if s1_2d lt -0.001 then s1_2d=s1_2d+0.001
   if s2_2d gt 0.001 then s2_2d=s2_2d-0.001
endif

if comm eq 'soft2d' then begin
   s1_2d=s1_2d-0.001 & s2_2d=s2_2d+0.001
endif


;Display image
if comm eq 'soft' or comm eq 'hard' or comm eq 'stretch' then begin
   displayband,1,tindex,fobj,bstamp,vstamp,istamp,i814stamp,zstamp,ystamp,jstamp,hstamp,s1,s2
endif

if comm eq 'soft2d' or comm eq 'hard2d' or comm eq 'stretch2d' then begin
   plot2d,specpath,field,fobj,tindex,s1_2d,s2_2d
   plotpas,specpath,field,fobj,tindex,s1_2d,s2_2d
endif

if (comm eq 'good' or comm eq 'g') then begin
   print,'Setting object as good...'
   wset,0 & erase & wset,1 & erase & wset,2 & erase
   result.inspect(tindex)=1 & result.apcorr(tindex)=-1.0d0
   read,'Notes?  Only a few words please:  ',notes
   result.notes(tindex)=notes & tindex=tindex+1
   comm='done'
endif
if (comm eq 'bad' or comm eq 'b') then begin
   print,'Setting object as bad...'
   result.inspect(tindex)=0 & result.apcorr(tindex)=-1.0d0
   read,'Notes?  Only a few words please:  ',notes
   result.notes(tindex)=notes & tindex=tindex+1
   wset,0 & erase & wset,1 & erase & wset,2 & erase
   comm='done'
endif

if comm eq 'quit' then begin
   tindex=max(index)+1
   comm='done'
endif

save,result,filename='verify_'+field+'_'+zsamp+'.idl'

endwhile
endwhile

save,result,filename='verify_'+field+'_'+zsamp+'.idl'

end
