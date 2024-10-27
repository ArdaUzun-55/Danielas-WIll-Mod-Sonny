on(rollOver){
   _root.thereIsASlotSelected = true;
   _root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.itemArray[id]][2];
   if(_root["KRINITEM" + _root.Krin.itemArray[id]][1] < 2)
   {
      _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.itemArray[id]][0];
      _root.KrinToolTipper.t = _root["KRINITEM" + _root.Krin.itemArray[id]].toolTip;
      _root.KrinToolTipper.gotoAndStop("GO");
   }
   else
   {
      _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.itemArray[id]][0];
      rubyCount = 0;
      _root.KrinToolTipper.t3 = _root["KRINITEM" + _root.Krin.itemArray[id]].req;
      _root.KrinToolTipper.TX = new Array();
      for(t in _root["KRINITEM" + _root.Krin.itemArray[id]].toolTipAlt)
      {
         if(_root["KRINITEM" + _root.Krin.itemArray[id]].toolTipAlt[t] != 0)
         {
            _root.KrinToolTipper.TX[rubyCount] = _root["KRINITEM" + _root.Krin.itemArray[id]].toolTipAlt[t];
            rubyCount++;
         }
      }
      _root.KrinToolTipper.ttx = _root["KRINITEM" + _root.Krin.itemArray[id]].toolTip;
      _root.KrinToolTipper.gotoAndStop("GO4");
   }
}
