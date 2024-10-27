on(rollOver){
   _root.thereIsASlotSelected = true;
   _root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.dropArray[id]][2];
   if(_root["KRINITEM" + _root.Krin.dropArray[id]][1] < 2)
   {
      if(slotType == "drop")
      {
         _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.dropArray[id]][0];
      }
      else
      {
         _root.KrinToolTipper.tt = "€" + _root["KRINITEM" + _root.Krin.dropArray[id]][5] + " - " + _root["KRINITEM" + _root.Krin.dropArray[id]][0];
      }
      _root.KrinToolTipper.t = _root["KRINITEM" + _root.Krin.dropArray[id]].toolTip;
      _root.KrinToolTipper.gotoAndStop("GO");
   }
   else
   {
      if(slotType == "drop")
      {
         _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.dropArray[id]][0];
      }
      else
      {
         _root.KrinToolTipper.tt = "€" + _root["KRINITEM" + _root.Krin.dropArray[id]][5] + " - " + _root["KRINITEM" + _root.Krin.dropArray[id]][0];
      }
      rubyCount = 0;
      _root.KrinToolTipper.t3 = _root["KRINITEM" + _root.Krin.dropArray[id]].req;
      _root.KrinToolTipper.TX = new Array();
      for(t in _root["KRINITEM" + _root.Krin.dropArray[id]].toolTipAlt)
      {
         if(_root["KRINITEM" + _root.Krin.dropArray[id]].toolTipAlt[t] != 0)
         {
            _root.KrinToolTipper.TX[rubyCount] = _root["KRINITEM" + _root.Krin.dropArray[id]].toolTipAlt[t];
            rubyCount++;
         }
      }
      _root.KrinToolTipper.ttx = _root["KRINITEM" + _root.Krin.dropArray[id]].toolTip;
      _root.KrinToolTipper.gotoAndStop("GO4");
   }
}
