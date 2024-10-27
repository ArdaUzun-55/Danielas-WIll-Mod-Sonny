on(release){
   _root.Krin.slotInUse = 4;
   if(_root.Krin.dataMode == "save")
   {
      _root.Krin.nameUser = _root.krinNameUser;
      _root.thereIsASlotSelected = false;
      _root.KrinToolTipper.tt = "";
      _root.KrinToolTipper.t = "";
      _root.KrinToolTipper.gotoAndStop(1);
      if(_root.isDebugMode)
      {
         var debugLevel = 99;
         _root.Krin.Level = debugLevel;
         _root.Krin.skillPoints = debugLevel + 5;
         _root.Krin.statPoints = debugLevel + 1;
         _root.Krin.LevelStats[0] = debugLevel;
         _root.Krin.Euro = 1000000;
         _root.Krin.progressLevelOn = 36;
         _root.Krin.highestZoneDefeated = 2;
      }
      gotoAndStop("classMenu");
   }
   else if(_root["danielas_slot" + _root.Krin.slotInUse].data.nameUser != undefined)
   {
      _root.krinNameUser = _root["danielas_slot" + _root.Krin.slotInUse].data.nameUser;
      _root.krinHandleData(_root.Krin.slotInUse);
      _root["danielas_slot" + _root.Krin.slotInUse].flush();
      gotoAndStop("Navigation");
   }
}
