on(press){
   if(_root.Krin.mouseItem != 0)
   {
      _root.Krin.mouseItem = 0;
      _root.KrinToolTipper.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.mouseItem]);
   }
}
