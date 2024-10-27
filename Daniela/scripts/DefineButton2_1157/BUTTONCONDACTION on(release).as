on(release){
   if(_root.Krin.graphics)
   {
      _root.Krin.graphics = false;
   }
   else
   {
      _root.Krin.graphics = true;
   }
   if(_root.Krin.sound)
   {
      tit_3 = _root.KrinLang[_root.KLangChoosen].MENU[29];
   }
   else
   {
      tit_3 = _root.KrinLang[_root.KLangChoosen].MENU[30];
   }
   if(_root.Krin.graphics)
   {
      tit_4 = _root.KrinLang[_root.KLangChoosen].MENU[31];
   }
   else
   {
      tit_4 = _root.KrinLang[_root.KLangChoosen].MENU[32];
   }
}
