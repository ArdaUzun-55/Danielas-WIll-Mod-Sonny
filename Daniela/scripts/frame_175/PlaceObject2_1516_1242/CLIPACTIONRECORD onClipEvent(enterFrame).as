onClipEvent(enterFrame){
   if(frameGo == undefined)
   {
      if(_alpha > 0)
      {
         _alpha = _alpha - 15;
      }
   }
   else if(_alpha < 100)
   {
      _alpha = _alpha + 15;
   }
   else
   {
      _root.gotoAndStop(frameGo);
   }
}
