on(release){
   if(_root.Krin.diff == "HARD")
   {
      _root.Krin.diff = "NORMAL";
      _difficulty = "NORMAL";
   }
   else
   {
      _root.Krin.diff = "HARD";
      _difficulty = "HARD";
   }
   if(_root.Krin.diff == "NORMAL")
   {
      tit_12 = _root.KrinLang[_root.KLangChoosen].MENU[52];
   }
   else
   {
      tit_12 = _root.KrinLang[_root.KLangChoosen].MENU[53];
   }
}
