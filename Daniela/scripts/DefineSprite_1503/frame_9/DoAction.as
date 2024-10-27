_root.Krin.PauseForScreen = true;
_root.Krin.PauseForScreen2 = true;
_root.Krin.dataMode = "save";
itemsthatdropped = 0;
_root.KrinScreen._visible = false;
_root.Krin.EnemyXPFinal = _root.Krin.EnemyXP / _root.Krin.EnemyXP3 * _root.Krin.EnemyXP2;
for(w in _root.Krin.itemArray)
{
   this["itemSlot" + w].inner.gotoAndStop(_root.KrinLang[_root.KLangChoosen].ITEMNAME[_root.Krin.itemArray[w]]);
   this["itemSlot" + w].id = w;
   this["itemSlot" + w].slotType = "itemSlot";
}
w = 0;
while(w < 15)
{
   this["dropSlot" + w].inner.gotoAndStop(_root.KrinLang[_root.KLangChoosen].ITEMNAME[_root.Krin.dropArray[w]]);
   this["dropSlot" + w].id = w;
   this["dropSlot" + w].slotType = "drop";
   if(_root.Krin.dropArray[w] == 0)
   {
      this["dropSlot" + w]._visible = false;
   }
   else
   {
      itemsthatdropped = 1;
   }
   w++;
}
if(itemsthatdropped == 0)
{
   vb99 = _root.KrinLang[_root.KLangChoosen].MENU[12];
}
else
{
   vb99 = "";
}
moneyGain = Math.round(_root.Krin.EnemyXPFinal * _root.Krin.EuroConstant * ((85 + random(30)) / 100));
_root.Krin.Euro += moneyGain;
dumbEuro = _root.Krin.Euro;
vb1 = _root.KrinLang[_root.KLangChoosen].VICTORY[0];
vb2 = _root.KrinLang[_root.KLangChoosen].VICTORY[1];
vb3 = _root.KrinLang[_root.KLangChoosen].VICTORY[2];
vb4 = _root.KrinLang[_root.KLangChoosen].VICTORY[3];
vb5 = "€" + moneyGain;
vbbc1 = _root.KrinLang[_root.KLangChoosen].MENU[15];
vb7 = _root.KrinLang[_root.KLangChoosen].VICTORY[4];
vb8 = _root.KrinLang[_root.KLangChoosen].MENU[13];
