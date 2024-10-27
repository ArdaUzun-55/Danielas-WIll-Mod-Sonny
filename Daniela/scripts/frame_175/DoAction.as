navTitle = "";
navText = "";
Krin.PauseForScreen = false;
Krin.wSaver = krinXbarPro.bar._width;
Krin.levelMaxProgress = Krin.progressArray[Krin.sectionIn][1] - Krin.progressArray[Krin.sectionIn][0];
Krin.levelMinProgress = 1 + (Krin.progressLevelOn - Krin.progressArray[Krin.sectionIn][0]);
if(Krin.levelMinProgress > Krin.levelMaxProgress)
{
   Krin.levelMinProgress = Krin.levelMaxProgress;
}
krinXbarPro.bar._width = Krin.levelMinProgress / Krin.levelMaxProgress * Krin.wSaver;
klt1 = _root.KrinLang[KLangChoosen].SYSTEM[9] + (Krin.sectionIn + 1);
klt2 = _root.KrinLang[KLangChoosen].ZONES[Krin.sectionIn] + ": " + _root.KrinLang[KLangChoosen].ZONES2[Krin.sectionIn];
klt3 = _root.KrinLang[KLangChoosen].SYSTEM[10] + (_root.Krin.progressLevelOn - 1);
addSound("Music",1);
_root.slotSaveGO = Krin.slotInUse;
stop();
menuMode = true;
Krin.Pause = false;
KrinToolTipper.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.mouseItem]);
_root.thereIsASlotSelected = false;
whatToSay3 = _root.KrinLang[KLangChoosen].MENU[19];
onMouseDown = function()
{
   if(UITmouseHold > 0)
   {
      if(UITdrop != true)
      {
         UITmouseHold = 0;
         _root.KrinToolTipper.inner2.gotoAndStop("Empty2");
      }
   }
   if(!_root.thereIsASlotSelected)
   {
      if(_root.Krin.mouseItem != 0)
      {
         if(_root.Krin.previousItemSlot.slotType == "itemSlot")
         {
            _root.Krin.itemArray[_root.Krin.previousItemSlot.id] = _root.Krin.mouseItem;
            _root.Krin.previousItemSlot.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin.itemArray[_root.Krin.previousItemSlot.id]]);
         }
         else
         {
            _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][_root.Krin.previousItemSlot.id] = _root.Krin.mouseItem;
            _root.Krin.previousItemSlot.inner.gotoAndStop(_root.KrinLang.ENGLISH.ITEMNAME[_root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][_root.Krin.previousItemSlot.id]]);
            for(p in _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect])
            {
               _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][_root.Krin.previousItemSlot.id]].statUpdater[p];
            }
            for(p in _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect])
            {
               _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][_root.Krin.previousItemSlot.id]].statUpdaterP[p];
            }
            for(p in _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect])
            {
               _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect][p] += _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][_root.Krin.previousItemSlot.id]].statUpdaterD[p];
            }
            KRINMENU.updateStatus();
            KRINMENU.updateDoll();
         }
         _root.Krin.mouseItem = 0;
         _root.KrinToolTipper.inner.gotoAndStop("None");
      }
   }
};
