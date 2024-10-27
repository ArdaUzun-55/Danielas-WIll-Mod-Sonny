on(release){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.dataMode = "save";
      _root.krinHandleData(_root.Krin.slotInUse);
      _root.krinNavHideUI(0);
   }
}
