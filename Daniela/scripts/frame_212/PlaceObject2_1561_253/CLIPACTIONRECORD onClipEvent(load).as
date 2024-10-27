onClipEvent(load){
   zoomTime = 10;
   zoomRatio = 10;
   scaleChange = 13;
   zoomStep = zoomRatio / zoomTime;
   zoomFactor = zoomTime * (zoomStep + zoomRatio) / 2;
   zoomPoint = 0;
}
