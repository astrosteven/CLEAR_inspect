pro redraw,xx,yy,color=color
  if keyword_set(color) then begin
     axis,xx[0],yy[0],xax=0,xtickname=strarr(20)+' ',color=djs_icolor(color)
     axis,xx[0],yy[0],yax=0,ytickname=strarr(20)+' ',color=djs_icolor(color)
     axis,xx[0],yy[1],xax=1,xtickname=strarr(20)+' ',color=djs_icolor(color)
     axis,xx[1],yy[0],yax=1,ytickname=strarr(20)+' ',color=djs_icolor(color)
  endif else begin
     axis,xx[0],yy[0],xax=0,xtickname=strarr(20)+' '
     axis,xx[0],yy[0],yax=0,ytickname=strarr(20)+' '
     axis,xx[0],yy[1],xax=1,xtickname=strarr(20)+' '
     axis,xx[1],yy[0],yax=1,ytickname=strarr(20)+' '
  endelse
end
