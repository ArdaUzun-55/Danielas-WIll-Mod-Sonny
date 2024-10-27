on(release){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.shopId = 0;
      KRINMENU.gotoAndStop("data");
      Krin.dataMode = "save";
      _root.krinHandleData(1);
   }
}
