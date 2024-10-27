on(release){
   if(_root.Krin.statPoints > 0)
   {
      _root.Krin.StatSets0[3] += 1;
      _root.Krin.statPoints--;
      statPoints--;
      yut_spd2++;
      _root.Krin.SPEED += 1;
      if(_root.Krin.statPoints == 0)
      {
         statColor.gotoAndStop("dead");
      }
   }
}
