zoomXGo = zoomPointX * zoomPoint;
zoomYGo = zoomPointY * zoomPoint;
scaleXGo = zoomScaleX * zoomPoint;
scaleYGo = zoomScaleY * zoomPoint;
_root.BATTLESCREEN._x += zoomXGo * zoomReverse;
_root.BATTLESCREEN._y += zoomYGo * zoomReverse;
_root.BATTLESCREEN._xscale += scaleXGo * zoomReverse;
_root.BATTLESCREEN._yscale += scaleYGo * zoomReverse;
zoomPoint--;
if(zoomPoint == zoomTime + 1)
{
   zoomPoint = 0;
}
if(zoomPoint > 0)
{
   gotoAndStop("KrinZoomPlay");
   play();
}
else if(zoomReverse == 1)
{
   zoomReverse = -1;
   zoomPoint = zoomTime;
   zoomPauseCounter = 0;
   gotoAndStop("KrinZoomPause");
   play();
}
else
{
   _root.BATTLESCREEN._x = _root.BATTLESCREEN.saverX;
   _root.BATTLESCREEN._y = _root.BATTLESCREEN.saverY;
   if(_root.KrinSettings.SFX3 == false)
   {
      _root._quality = _root.KrinSettings.QUALITY;
   }
   gotoAndStop("KrinZoomStop");
}
