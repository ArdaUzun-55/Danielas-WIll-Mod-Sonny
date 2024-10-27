on(release){
   if(_root.Krin.autoSaver)
   {
      _root.Krin.autoSaver = false;
   }
   else
   {
      _root.Krin.autoSaver = true;
   }
   if(_root.Krin.autoSaver)
   {
      tit_7 = _root.KrinLang[_root.KLangChoosen].MENU[29];
   }
   else
   {
      tit_7 = _root.KrinLang[_root.KLangChoosen].MENU[30];
   }
}
