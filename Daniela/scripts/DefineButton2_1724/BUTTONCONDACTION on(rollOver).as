on(rollOver){
   _root.thereIsASlotSelected = true;
   _root.KrinToolTipper.tt = _root.KrinLang[_root.KLangChoosen].ZONES[sectionID];
   _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].ZONES2[sectionID];
   _root.KrinToolTipper.gotoAndStop("GO");
}
