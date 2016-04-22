function plotfilter,file,plot=plot

readcol,file,mylambda,trans,/silent
if max(trans) gt 1.0d0 then trans=trans/100.0d0

low=min(where(trans ge 0.50d0*max(trans)))
high=max(where(trans ge 0.50d0*max(trans)))

fwhm=mylambda(high)-mylambda(low)
lam_c=(mylambda(high)+mylambda(low))/2.0d0

if keyword_set(plot) then begin
plot,lambda,trans,yr=[0,1.1*max(trans)],xr=[lam_c-1.3*fwhm,lam_c+1.3*fwhm]
plots,[lam_c,lam_c],[0,1.1*max(trans)]
plots,[lam_c-(fwhm/2.0d0),lam_c+(fwhm/2.0d0)],[0.5d0*max(trans),0.5d0*max(trans)]
xyouts,set_xposition(0.05),set_yposition(0.9),'!7k!6!Dc!N = '+strcompress(string(lam_c,F='(F8.1)'),/rem)+' A',charsize=2
xyouts,set_xposition(0.05),set_yposition(0.85),'FWHM = '+strcompress(string(fwhm,F='(F8.1)'),/rem)+' A',charsize=2
endif

result=[lam_c,fwhm]

return,result

end
