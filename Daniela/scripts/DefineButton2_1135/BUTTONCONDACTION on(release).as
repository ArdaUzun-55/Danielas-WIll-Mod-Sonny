on(release){
   _root.Krin.slotInUse = 1;
   if(_root.Krin.dataMode == "save")
   {
      _root.Krin.nameUser = _root.userNameInput;
      _root.thereIsASlotSelected = false;
      _root.KrinToolTipper.tt = "";
      _root.KrinToolTipper.t = "";
      _root.KrinToolTipper.gotoAndStop(1);
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
