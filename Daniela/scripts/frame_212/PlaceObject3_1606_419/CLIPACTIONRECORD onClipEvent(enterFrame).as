onClipEvent(enterFrame){
   if(clicker)
   {
      i = 0;
      while(i < 8)
      {
         _root.selector["thing" + i].bfilter._visible = false;
         this["thing" + i].bfilter._alpha = 75;
         if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][103] != 0 && _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][120] != 0)
         {
            this["thing" + i].toolTipTitle = _root["KRINABILITY" + _root.Krin.moveMatrix[i]][17];
            this["thing" + i].toolTip = _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][17];
            this["thing" + i].gotoAndStop(_root["KRINABILITY" + _root.Krin.moveMatrix[i]][0]);
            if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][127] == this["thing" + i].toolTipTitle)
            {
               this["thing" + i].gotoAndStop(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][127]);
            }
            if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][128] == this["thing" + i].toolTipTitle)
            {
               this["thing" + i].gotoAndStop(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][128]);
            }
            if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][129] == this["thing" + i].toolTipTitle)
            {
               this["thing" + i].gotoAndStop(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][129]);
            }
            if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][125] == this["thing" + i].toolTipTitle)
            {
               this["thing" + i].gotoAndStop(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][125]);
            }
         }
         if(_root["KRINABILITY" + _root.Krin.moveMatrix[i]][_root.theEnemyToMoveVS2] == 0)
         {
            _root.selector["thing" + i].bfilter._visible = true;
         }
         if(_root.Krin.abilityCoolDown[i] > 0)
         {
            this["thing" + i].ACD = _root.Krin.abilityCoolDown[i];
            _root.selector["thing" + i].bfilter._visible = true;
         }
         else
         {
            this["thing" + i].ACD = "";
         }
         i++;
      }
      if(_alpha < 100)
      {
         _alpha = _alpha + 50;
      }
      else
      {
         _alpha = 100;
         i = 0;
         while(i < 8)
         {
            this["thing" + i].bfilter._alpha = 85;
            i++;
         }
         clicker = false;
      }
   }
   else if(!this.hitTest(_root._xmouse,_root._ymouse))
   {
      _alpha = _alpha - 10;
      i = 0;
      while(i < 8)
      {
         this["thing" + i].ACD = "";
         i++;
      }
      if(_alpha <= 0)
      {
         _visible = false;
      }
   }
   else
   {
      _alpha = 100;
      i = 0;
      while(i < 8)
      {
         _root.selector["thing" + i].bfilter._visible = false;
         this["thing" + i].bfilter._alpha = 85;
         if(_root["KRINABILITY" + _root.Krin.moveMatrix[i]][_root.theEnemyToMoveVS2] == 0)
         {
            _root.selector["thing" + i].bfilter._visible = true;
         }
         if(_root.Krin.abilityCoolDown[i] > 0)
         {
            this["thing" + i].ACD = _root.Krin.abilityCoolDown[i];
            _root.selector["thing" + i].bfilter._visible = true;
         }
         else
         {
            this["thing" + i].ACD = "";
         }
         i++;
      }
   }
}
