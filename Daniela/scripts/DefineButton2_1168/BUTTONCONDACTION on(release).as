on(release){
   if(_root.Krin.qual == "HIGH")
   {
      _root.Krin.qual = "LOW";
      _quality = "LOW";
   }
   else
   {
      _root.Krin.qual = "HIGH";
      _quality = "HIGH";
   }
   if(_root.Krin.qual == "HIGH")
   {
      tit_11 = _root.KrinLang[_root.KLangChoosen].MENU[31];
   }
   else
   {
      tit_11 = _root.KrinLang[_root.KLangChoosen].MENU[32];
   }
}
