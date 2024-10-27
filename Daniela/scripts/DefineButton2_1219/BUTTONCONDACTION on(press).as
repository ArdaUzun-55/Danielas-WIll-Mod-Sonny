on(press){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.BattlePick = _root.Krin.trainingArray[_root.Krin.sectionIn][random(8)];
      _root.Krin.progressFight = false;
      _root.gotoAndPlay("LOADBATTLESCENE");
      _root.KrinScreen._visible = false;
   }
}
