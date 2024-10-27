onClipEvent(enterFrame){
   if(_root.Krin.MenuPlayerSelect == 0)
   {
      _visible = false;
   }
   else
   {
      _visible = true;
      gotoAndStop(_root.Krin.agMode[_root.Krin.MenuPlayerSelect]);
      worder = "AI Mode: " + wordArray[_root.Krin.agMode[_root.Krin.MenuPlayerSelect]];
   }
}
