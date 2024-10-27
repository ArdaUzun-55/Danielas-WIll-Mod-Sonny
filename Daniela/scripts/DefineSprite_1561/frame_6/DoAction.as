zoomPauseCounter++;
if(_root.KrinSettings.SFX3 == false)
{
   _root._quality = _root.KrinSettings.QUALITY;
}
if(zoomPauseCounter == _root.zoomPause)
{
   gotoAndStop("KrinZoomPlay");
   play();
   if(_root.KrinSettings.SFX3 == false)
   {
      _root._quality = "LOW";
   }
}
else
{
   gotoAndStop("KrinZoomPause");
   play();
}
