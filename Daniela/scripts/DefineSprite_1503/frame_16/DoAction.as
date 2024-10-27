function updateFriends()
{
   i = 1;
   while(i < 6)
   {
      this["fa" + i].blacker._visible = true;
      this["fa" + i].inTheTeam = false;
      if(_root.Krin.friendArrayX[0] == i)
      {
         this["fa" + i].blacker._visible = false;
         this["fa" + i].inTheTeam = true;
         this["fa" + i].inTheTeam2 = 0;
      }
      if(_root.Krin.friendArrayX[1] == i)
      {
         this["fa" + i].blacker._visible = false;
         this["fa" + i].inTheTeam = true;
         this["fa" + i].inTheTeam2 = 1;
      }
      i++;
   }
}
stop();
i = 0;
while(i < 6)
{
   this["fa" + i].id = _root.Krin.friendArray[i];
   if(this["fa" + i].id < 0)
   {
      this["fa" + i]._visible = false;
   }
   else
   {
      if(i == 0)
      {
         this["fa" + i].avIn.gotoAndStop("mainPlayer");
      }
      this["fa" + i].avIn.gotoAndStop(_root.Krin.friendArray[i]);
   }
   i++;
}
teamChangeCD = true;
bickerPicker = 0;
if(_root.Krin.friendArrayX[0] == 0)
{
   bickerPicker = 0;
}
if(_root.Krin.friendArrayX[1] == 0)
{
   bickerPicker = 1;
}
updateFriends();
wefjnew = 0;
while(wefjnew < 8)
{
   perBarShow["bar" + wefjnew].saveH = perBarShow["bar" + wefjnew]._height;
   var my_colorKKCCXX = new Color(perBarShow["bar" + wefjnew].inner);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   var my_colorKKCCXX = new Color(perBarShow["gbar" + wefjnew]);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   var my_colorKKCCXX = new Color(perBarShow["ybar" + wefjnew].inner);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   perBarShow["gbar" + wefjnew].saveH = perBarShow["bar" + wefjnew]._height / 100;
   wefjnew++;
}
wefjnew = 0;
while(wefjnew < 8)
{
   var my_colorKKCCXX = new Color(defBarShow["bar" + wefjnew].inner);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   var my_colorKKCCXX = new Color(defBarShow["gbar" + wefjnew]);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   var my_colorKKCCXX = new Color(defBarShow["ybar" + wefjnew].inner);
   my_colorKKCCXX.setRGB(_root.elementColorArray[wefjnew]);
   wefjnew++;
}
yut_lif = _root.KrinLang[_root.KLangChoosen].SYSTEM[0] + ":";
yut_str = _root.KrinLang[_root.KLangChoosen].SYSTEM[1] + ":";
yut_mag = _root.KrinLang[_root.KLangChoosen].SYSTEM[2] + ":";
yut_spd = _root.KrinLang[_root.KLangChoosen].SYSTEM[3] + ":";
yut_foc = _root.KrinLang[_root.KLangChoosen].SYSTEM[4] + ":";
_root.Krin.MenuPlayerSelect = 0;
for(w in _root.Krin.itemArray)
{
   this["itemSlot" + w].inner.gotoAndStop(_root.KrinLang[_root.KLangChoosen].ITEMNAME[_root.Krin.itemArray[w]]);
   this["itemSlot" + w].id = w;
   this["itemSlot" + w].slotType = "itemSlot";
}
updateEquip = function()
{
   for(w in _root.Krin.equipArray0)
   {
      this["playerSlot" + w].inner.gotoAndStop(_root.KrinLang[_root.KLangChoosen].ITEMNAME[_root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][w]]);
      this["playerSlot" + w].id = w;
      this["playerSlot" + w].slotType = "playerSlot";
   }
};
dollPartsArray = new Array();
dollPartsArray = ["head","chest","arm1","arm2","hand1","hand2","leg1","leg2","leg3","leg4","foot1","foot2","weapon1","weapon2","shoulder"];
dollPartsCores = new Array();
dollPartsCores = [0,1,1,1,2,2,3,3,4,4,4,4,5,6,1];
dollPartsCores2 = new Array();
dollPartsCores2 = ["HEAD","CHEST","ARM","ARM","HAND","HAND","ARM","ARM","LEG2","LEG2","FOOT","FOOT","WEAPON","WEAPON","SHOULDER"];
updateDoll = function()
{
   for(h in dollPartsArray)
   {
      removeMovieClip(this[dollPartsArray[h]].inner);
      removeMovieClip(this[dollPartsArray[h]].innerX);
   }
   for(h in dollPartsArray)
   {
      this[dollPartsArray[h]].attachMovie(_root.Krin.gArray[_root.Krin.GSet[_root.Krin.MenuPlayerSelect]] + "_S" + dollPartsCores2[h] + "_" + _root.Krin.skinArray[_root.Krin.SkinSet[_root.Krin.MenuPlayerSelect]],"innerX",-1);
      this[dollPartsArray[h]].attachMovie(_root.Krin.gArray[_root.Krin.GSet[_root.Krin.MenuPlayerSelect]] + "_" + dollPartsCores2[h] + "_" + _root["KRINITEM" + _root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][dollPartsCores[h]]].looks,"inner",0);
   }
   removeMovieClip(this.head.hair);
   if(_root.Krin["equipArray" + _root.Krin.MenuPlayerSelect][dollPartsCores[h]] == 0)
   {
      this.head.attachMovie("HAIR_" + _root.Krin.hairArray[_root.Krin.HairSet[_root.Krin.MenuPlayerSelect]],"hair",2);
   }
};
updateAvs = function()
{
   i = 0;
   while(i < 6)
   {
      this["fa" + i].borderFrame._visible = false;
      if(i == _root.Krin.MenuPlayerSelect)
      {
         this["fa" + i].borderFrame._visible = true;
      }
      i++;
   }
};
updateStatus = function()
{
   yut_name = _root.Krin.NameSets[_root.Krin.MenuPlayerSelect];
   yut_per = _root.KrinLang[_root.KLangChoosen].SYSTEM[5];
   yut_def = _root.KrinLang[_root.KLangChoosen].SYSTEM[6];
   yut_info = _root.KrinLang[_root.KLangChoosen].MENU[0] + _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect] + " " + _root.KrinLang[_root.KLangChoosen].CLASS[_root.Krin.ClassStats[_root.Krin.MenuPlayerSelect] - 1];
   yut_def2 = new Array();
   yut_per2 = new Array();
   yut_lif2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][0] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][1] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][2] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
   yut_str2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][1] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][3] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][4] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
   yut_mag2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][2] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][5] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][6] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
   yut_spd2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][3] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][7] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][8] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
   yut_foc2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][9]);
   wefjnew = 0;
   while(wefjnew < 8)
   {
      yut_per2[wefjnew] = _root.Krin["PerSets" + _root.Krin.MenuPlayerSelect][wefjnew] + Math.ceil(25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      yut_def2[wefjnew] = _root.Krin["DefSets" + _root.Krin.MenuPlayerSelect][wefjnew] + Math.ceil(25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      perBarShow["bar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH * ((1 - (25 - yut_per2[wefjnew] / (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]) * 25) / 100 - 0.78125) / 0.78125);
      perBarShow["gbar" + wefjnew]._height = perBarShow["gbar" + wefjnew].saveH * (15 * (yut_per2[wefjnew] / (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect])));
      perBarShow["xbar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH * ((1 - 25 * (1 - 25 * (yut_per2[wefjnew] / (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect])) / 200) / 100 - 0.78125) / 0.78125);
      if(perBarShow["bar" + wefjnew]._height > perBarShow["bar" + wefjnew].saveH)
      {
         perBarShow["bar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH;
      }
      if(perBarShow["gbar" + wefjnew]._height > perBarShow["bar" + wefjnew].saveH)
      {
         perBarShow["gbar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH;
      }
      defBarShow["bar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH * ((yut_def2[wefjnew] - (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect])) / 100);
      defBarShow["gbar" + wefjnew]._height = perBarShow["gbar" + wefjnew].saveH * (yut_def2[wefjnew] / (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]) * 25 * 0.875 - 21.800000000000008);
      defBarShow["xbar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH * (0.15 - (25 + 5 * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]) / yut_def2[wefjnew] * 0.15);
      if(defBarShow["bar" + wefjnew]._height > perBarShow["bar" + wefjnew].saveH)
      {
         defBarShow["bar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH;
      }
      if(defBarShow["gbar" + wefjnew]._height > perBarShow["bar" + wefjnew].saveH)
      {
         defBarShow["gbar" + wefjnew]._height = perBarShow["bar" + wefjnew].saveH;
      }
      wefjnew++;
   }
   if(_root.Krin.MenuPlayerSelect == 0)
   {
      _root.Krin.LIFE = yut_lif2;
      _root.Krin.STRENGTH = yut_str2;
      _root.Krin.MAGIC = yut_mag2;
      _root.Krin.SPEED = yut_spd2;
      _root.Krin.FOCUS = yut_foc2;
      wefjnew = 0;
      while(wefjnew < 8)
      {
         _root.Krin.PER[_root.elementMainArray[wefjnew]] = yut_per2[wefjnew];
         _root.Krin.DEF[_root.elementMainArray[wefjnew]] = yut_def2[wefjnew];
         wefjnew++;
      }
   }
};
updateEquip();
updateDoll();
updateAvs();
updateStatus();
dumbEuro = _root.Krin.Euro;
dumbEuro = _root.Krin.Euro;
_root.krinSetShop(_root.Krin.shopId);
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
   this["dropSlot" + w].slotType = "buy";
   if(_root.Krin.dropArray[w] == 0)
   {
      this["dropSlot" + w]._visible = false;
   }
   else
   {
      this["dropSlot" + w]._visible = true;
   }
   w++;
}
vb1 = _root.KrinLang[_root.KLangChoosen].MENU[6];
vb2 = _root.KrinLang[_root.KLangChoosen].SHOP[_root.Krin.shopId];
