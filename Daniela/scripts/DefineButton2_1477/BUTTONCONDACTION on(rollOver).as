on(rollOver){
   _root.thereIsASlotSelected = true;
   _root.KrinToolTipper.tt = _root.KrinLang[_root.KLangChoosen].MENU[3];
   if(_root.Krin.mouseItem != 0)
   {
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].MENU[4] + " €" + Math.round(_root["KRINITEM" + _root.Krin.mouseItem][5] / 3);
   }
   else
   {
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].MENU[5];
   }
   _root.KrinToolTipper.gotoAndStop("GO");
}
