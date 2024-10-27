on(press){
   if(_root.Krin.PauseForScreen != true)
   {
      njsvnerivneri = random(11);
      _root.Krin.BattlePick = _root.Krin.trainingArray[_root.Krin.sectionIn][njsvnerivneri];
      _root.Krin.progressFight = false;
      _root.gotoAndPlay("LOADBATTLESCENE");
      _root.KrinScreen._visible = false;
   }
}
