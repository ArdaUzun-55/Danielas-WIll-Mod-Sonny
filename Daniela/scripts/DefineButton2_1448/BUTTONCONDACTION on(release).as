on(release){
   if(_root.Krin.statPoints > 0)
   {
      _root.Krin.StatSets0[1] += 1;
      _root.Krin.statPoints--;
      statPoints--;
      yut_str2++;
      _root.Krin.STRENGTH += 1;
      if(_root.Krin.statPoints == 0)
      {
         statColor.gotoAndStop("dead");
      }
   }
}
