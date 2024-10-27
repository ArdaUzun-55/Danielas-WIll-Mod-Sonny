i = 1;
while(i < 5)
{
   _root["nameSlot" + i] = _root["danielas_slot" + i].data.nameUser;
   _root["danielas_slot" + i].flush();
   if(_root["nameSlot" + i] == undefined)
   {
      _root["nameSlot" + i] = "< Empty Slot >";
   }
   i++;
}
slotNamerText = _root.KrinLang[KLangChoosen].MENU[23];
trace("Data Mode: " + _root.Krin.dataMode);
