on(press){
   thereIsSlot = -1;
   for(krinp in _root.Krin.itemArray)
   {
      if(_root.Krin.itemArray[krinp] == 0)
      {
         thereIsSlot = krinp;
      }
   }
   if(thereIsSlot != -1)
   {
      if(slotType == "drop")
      {
         _root.Krin.itemArray[thereIsSlot] = _root.Krin.dropArray[id];
         _parent["itemSlot" + thereIsSlot].inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.dropArray[id]]);
         _root.Krin.dropArray[id] = 0;
         inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.dropArray[id]]);
         _root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.dropArray[id]][2];
         _root.krinChangeColor(_root.KrinToolTipper.fontBacker2,_root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin.dropArray[id]][2]);
         _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin.dropArray[id]][0];
         _root.KrinToolTipper.t = _root["KRINITEM" + _root.Krin.dropArray[id]].toolTip;
         _root.KrinToolTipper.my_txt2.text = _root["KRINITEM" + _root.Krin.dropArray[id]][0];
         _root.KrinToolTipper.my_txt.text = _root["KRINITEM" + _root.Krin.dropArray[id]].toolTip;
         _root.KrinToolTipper.my_txt2.setTextFormat(_root.KrinToolTipper.my_fmt2);
         _root.KrinToolTipper.my_txt.setTextFormat(_root.KrinToolTipper.my_fmt);
         _root.KrinToolTipper.gotoAndStop("GO");
      }
      else if(_root.Krin.Euro >= _root["KRINITEM" + _root.Krin.dropArray[id]][5])
      {
         _root.Krin.itemArray[thereIsSlot] = _root.Krin.dropArray[id];
         _parent["itemSlot" + thereIsSlot].inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.dropArray[id]]);
         _root.Krin.Euro -= _root["KRINITEM" + _root.Krin.dropArray[id]][5];
         _parent.dumbEuro = _root.Krin.Euro;
      }
   }
}
