on(release){
   _root.krinHandleData(_root.slotSaveGO);
   _root.Krin.slotInUse = _root.slotSaveGO;
   _root["danielas_slot" + _root.slotSaveGO].flush();
   gotoAndStop("Navigation");
}
