on(release){
   if(_root.Krin.PauseForScreen2 != true)
   {
      if(_root.Krin.bossJustPwned)
      {
         if(_root.Krin.autoSaver)
         {
            _root.krinHandleData(_root.Krin.slotInUse);
         }
         if(_root.Krin.progressLevelOn == 9)
         {
            _root.gotoSceneKrin = "overMap";
            stopAllSounds();
            _root.gotoAndStop("CS_BRIDGE");
         }
         else if(_root.Krin.progressLevelOn == 42)
         {
            _root.gotoSceneKrin = "endMenu";
            stopAllSounds();
            _root.gotoAndStop("CS_OUTRO");
         }
         else
         {
            _root.gotoAndStop("overMap");
         }
      }
      else
      {
         _root.Krin.PauseForScreen = false;
         if(_root.Krin.autoSaver)
         {
            _root.krinHandleData(_root.Krin.slotInUse);
         }
         if(playerLeveled == true)
         {
            gotoAndStop("skills");
         }
         else
         {
            gotoAndStop("hide");
            _root.krinNavTutSpeech();
            _root.KrinScreen._visible = true;
         }
      }
   }
}
