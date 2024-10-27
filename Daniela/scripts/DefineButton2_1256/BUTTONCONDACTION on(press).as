on(press){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.bossFight = false;
      if(_root.Krin.progressLevelOn > _root.Krin.progressArray[_root.Krin.sectionIn][1])
      {
         _root.Krin.BattlePick = _root.Krin.progressArray[_root.Krin.sectionIn][1];
         _root.Krin.bossFight = true;
      }
      else
      {
         if(_root.Krin.progressLevelOn == _root.Krin.progressArray[_root.Krin.sectionIn][1])
         {
            _root.Krin.bossFight = true;
         }
         _root.Krin.BattlePick = _root.Krin.progressLevelOn;
         _root.Krin.progressFight = true;
      }
      _root.gotoAndPlay("LOADBATTLESCENE");
      _root.KrinScreen._visible = false;
   }
}
