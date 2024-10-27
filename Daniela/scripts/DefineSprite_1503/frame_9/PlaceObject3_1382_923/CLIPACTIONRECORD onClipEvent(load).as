onClipEvent(load){
   prx = _root.Krin.friendlySlotsFFTT[1];
   if(prx == undefined)
   {
      _visible = false;
   }
   else
   {
      exp = _root.Krin.ExpSets[prx];
      exp2 = Math.round(exp);
      _root.expWorkOut(_root.Krin.EnemyXPFinal,_root.Krin.LevelStats[prx]);
      setLimiter = 30;
      adderPer = _root.Krin.totalXP / setLimiter;
      namerI = _root.Krin.NameSets[prx];
      levelI = _root.KrinLang[_root.KLangChoosen].MENU[0] + _root.Krin.LevelStats[prx];
   }
}
