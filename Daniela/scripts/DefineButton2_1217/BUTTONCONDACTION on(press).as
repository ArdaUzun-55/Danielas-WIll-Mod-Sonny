on(press){
   if(_root.Krin.progressLevelOn == 15)
   {
      _root.Krin.friendArray = [0,1,-1,-1,-1,-1];
   }
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.bossFight = false;
      _root.Krin.BattlePick = _root.Krin.progressLevelOn;
      _root.Krin.progressFight = true;
      if(_root.Krin.progressLevelOn > _root.Krin.progressArray[_root.Krin.sectionIn][1] - 1)
      {
         _root.Krin.BattlePick = _root.Krin.progressArray[_root.Krin.sectionIn][1] - 1;
         _root.Krin.bossFight = true;
         _root.Krin.progressFight = false;
      }
      if(_root.Krin.progressLevelOn == _root.Krin.progressArray[_root.Krin.sectionIn][1] - 1)
      {
         _root.Krin.bossFight = true;
      }
      _root.gotoAndPlay("LOADBATTLESCENE");
      _root.KrinScreen._visible = false;
   }
}
