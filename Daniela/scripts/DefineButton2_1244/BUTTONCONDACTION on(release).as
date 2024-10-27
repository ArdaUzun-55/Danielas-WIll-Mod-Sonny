on(release){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.shopId = 0;
      KRINMENU.gotoAndStop("shop");
      KrinScreen._visible = false;
   }
}
