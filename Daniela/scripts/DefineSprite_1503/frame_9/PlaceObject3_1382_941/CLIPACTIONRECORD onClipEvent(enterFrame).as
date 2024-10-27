onClipEvent(enterFrame){
   if(prx != undefined)
   {
      avIn.gotoAndStop("mainPlayer");
      if(sLmT2 == 0)
      {
         _root.Krin.PauseForScreen2 = false;
      }
      else
      {
         sLmT2--;
      }
      if(setLimiter > 0)
      {
         setLimiter--;
         exp += adderPer;
         exp2 = Math.round(exp) + "%";
         bar._width = exp / 100 * 95.10000000000001;
         if(exp >= 100)
         {
            _parent.playerLeveled = true;
            exp = 0;
            exp2 = "100%";
            setLimiter = 0;
            _root.Krin.LevelStats[prx]++;
            _root.Krin.Level += 1;
            bar.gotoAndStop("level");
            bar._width = 95.10000000000001;
            levelI = _root.KrinLang[_root.KLangChoosen].MENU[0] + _root.Krin.LevelStats[prx];
            _root.Krin.skillPoints += 1;
            _root.Krin.statPoints += 2;
         }
      }
      else
      {
         _root.Krin.ExpSets[prx] = exp;
      }
   }
}
