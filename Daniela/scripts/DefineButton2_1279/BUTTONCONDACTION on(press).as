on(press){
   if(_root.Krin.mouseItem == 0)
   {
      _root.Krin.previousItemSlot = this;
      _root.addSound("Effects","Click3pickup");
   }
   else
   {
      _root.addSound("Effects","Click2putdown");
   }
   itemHolder = _root.Krin.itemArray[id];
   _root.Krin.itemArray[id] = _root.Krin.mouseItem;
   _root.Krin.mouseItem = itemHolder;
   _root.KrinToolTipper.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.mouseItem]);
   inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.itemArray[id]]);
   _root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.itemArray[id]][2];
   _root.krinChangeColor(_root.KrinToolTipper.fontBacker2,_root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.itemArray[id]][2]);
   if(_root["KRINITEM" + _root.Krin.itemArray[id]][1] < 2)
   {
      _root.KrinToolTipper.gotoAndStop("GO");
      _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.itemArray[id]][0];
      _root.KrinToolTipper.t = _root["KRINITEM" + _root.Krin.itemArray[id]].toolTip;
      _root.KrinToolTipper.my_txt2.text = _root["KRINITEM" + _root.Krin.itemArray[id]][0];
      _root.KrinToolTipper.my_txt.text = _root["KRINITEM" + _root.Krin.itemArray[id]].toolTip;
      _root.KrinToolTipper.my_txt2.setTextFormat(_root.KrinToolTipper.my_fmt2);
      _root.KrinToolTipper.my_txt.setTextFormat(_root.KrinToolTipper.my_fmt);
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
      _root.KrinToolTipper.gotoAndPlay("GO5");
   }
}
