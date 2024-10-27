on(release){
   if(_root.Krin.sound)
   {
      _root.Krin.sound = false;
   }
   else
   {
      _root.Krin.sound = true;
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
