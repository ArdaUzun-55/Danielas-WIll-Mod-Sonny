on(rollOver){
   _root.thereIsASlotSelected = true;
   if(id != 0)
   {
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].MENU[48];
   }
   else
   {
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].MENU[49];
   }
   _root.KrinToolTipper.tt = _root.Krin.NameSets[id];
   _root.KrinToolTipper.gotoAndStop("GO");
}
