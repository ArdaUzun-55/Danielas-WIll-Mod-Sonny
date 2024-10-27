on(press){
   hivhbwerhvgwr = 0;
   vniwbovdnb = 0;
   if(_root["KRINITEM" + _root.Krin.mouseItem][1] == IPS)
   {
      vniwbovdnb = 1;
   }
   if(_root["KRINITEM" + _root.Krin.mouseItem][3] == _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect])
   {
      hivhbwerhvgwr = 1;
   }
   if(_root["KRINITEM" + _root.Krin.mouseItem][3] == 0)
   {
      hivhbwerhvgwr = 1;
   }
   if(_root["KRINITEM" + _root.Krin.mouseItem][4] <= _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect] && hivhbwerhvgwr + vniwbovdnb == 2 || _root.Krin.mouseItem == 0)
   {
      if(_root.Krin.mouseItem == 0)
      {
         _root.Krin.previousItemSlot = this;
      }
      itemHolder = _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id];
      if(itemHolder != 0)
      {
         for(p in _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect])
         {
            _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][p] -= _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdater[p];
         }
         for(p in _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect])
         {
            _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect][p] -= _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdaterP[p];
         }
         for(p in _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect])
         {
            _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect][p] -= _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdaterD[p];
         }
      }
      _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id] = _root.Krin.mouseItem;
      _root.Krin.mouseItem = itemHolder;
      _root.KrinToolTipper.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.mouseItem]);
      inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]]);
      for(p in _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect])
      {
         _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdater[p];
      }
      for(p in _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect])
      {
         _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdaterP[p];
      }
      for(p in _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect])
      {
         _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].statUpdaterD[p];
      }
      _parent.updateStatus();
      _root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][2];
      _root.krinChangeColor(_root.KrinToolTipper.fontBacker2,_root.KrinToolTipper.colorChange = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][2]);
      if(_root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][1] < 2)
      {
         _root.KrinToolTipper.gotoAndStop("GO");
         _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][0];
         _root.KrinToolTipper.t = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTip;
         _root.KrinToolTipper.my_txt2.text = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][0];
         _root.KrinToolTipper.my_txt.text = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTip;
         _root.KrinToolTipper.my_txt2.setTextFormat(_root.KrinToolTipper.my_fmt2);
         _root.KrinToolTipper.my_txt.setTextFormat(_root.KrinToolTipper.my_fmt);
      }
      else
      {
         _root.KrinToolTipper.tt = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]][0];
         rubyCount = 0;
         _root.KrinToolTipper.t3 = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].req;
         _root.KrinToolTipper.TX = new Array();
         for(t in _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTipAlt)
         {
            if(_root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTipAlt[t] != 0)
            {
               _root.KrinToolTipper.TX[rubyCount] = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTipAlt[t];
               rubyCount++;
            }
         }
         _root.KrinToolTipper.ttx = _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][id]].toolTip;
         _root.KrinToolTipper.gotoAndPlay("GO5");
      }
      _parent.updateDoll();
   }
   else
   {
      _root.KrinCombatText.play();
      if(_root["KRINITEM" + _root.Krin.mouseItem][4] > _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect])
      {
         _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].ITEMERROR1;
      }
      else if(hivhbwerhvgwr == false)
      {
         _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].ITEMERROR2;
      }
      else
      {
         _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].ITEMERROR3;
      }
   }
}
