on(press){
   if(_root.Krin.mouseItem != 0)
   {
      _root.Krin.Euro += Math.ceil(_root["KRINITEM" + _root.Krin.mouseItem][5] / 4);
      dumbEuro = _root.Krin.Euro;
      _root.Krin.mouseItem = 0;
      _root.KrinToolTipper.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.mouseItem]);
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].MENU[5];
   }
}
