on(release){
   if(_root.Krin.statPoints > 0)
   {
      _root.Krin.StatSets0[2] += 1;
      _root.Krin.statPoints--;
      statPoints--;
      yut_mag2++;
      _root.Krin.MAGIC += 1;
      if(_root.Krin.statPoints == 0)
      {
         statColor.gotoAndStop("dead");
      }
   }
}
