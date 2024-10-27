on(release){
   if(_root.Krin.sound)
   {
      _root.Krin.sound = false;
      _root.soundModeKrin = 0;
      stopAllSounds();
   }
   else
   {
      _root.Krin.sound = true;
      _root.soundModeKrin = 0;
      _root.soundPlayCounter = 0;
      _root.addSound("Music",1);
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
