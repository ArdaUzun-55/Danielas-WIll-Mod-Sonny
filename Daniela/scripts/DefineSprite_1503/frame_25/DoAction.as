_root.UITmouseHold = 0;
yut_lif = _root.KrinLang[_root.KLangChoosen].SYSTEM[0] + ":";
yut_str = _root.KrinLang[_root.KLangChoosen].SYSTEM[1] + ":";
yut_mag = _root.KrinLang[_root.KLangChoosen].SYSTEM[2] + ":";
yut_spd = _root.KrinLang[_root.KLangChoosen].SYSTEM[3] + ":";
yut_foc = _root.KrinLang[_root.KLangChoosen].SYSTEM[4] + ":";
_root.Krin.MenuPlayerSelect = 0;
skillPoints = _root.Krin.skillPoints;
statPoints = _root.Krin.statPoints;
k_title1 = _root.KrinLang[_root.KLangChoosen].K_TITLE1;
k_title2 = _root.KrinLang[_root.KLangChoosen].K_TITLE2;
k_title3 = _root.KrinLang[_root.KLangChoosen].K_TITLE3;
k_title4 = _root.KrinLang[_root.KLangChoosen].MENU[16];
skLoadKrin = _root.KrinLang[_root.KLangChoosen].SKLOAD + ":";
spLoadKrin = _root.KrinLang[_root.KLangChoosen].SPLOAD + ":";
yut_name = _root.Krin.NameSets[_root.Krin.MenuPlayerSelect];
yut_info = _root.KrinLang[_root.KLangChoosen].MENU[0] + _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect] + " " + _root.KrinLang[_root.KLangChoosen].CLASS[_root.Krin.ClassStats[_root.Krin.MenuPlayerSelect] - 1];
yut_lif2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][0] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][1] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][2] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
yut_str2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][1] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][3] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][4] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
yut_mag2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][2] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][5] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][6] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
yut_spd2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][3] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][7] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][8] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
yut_foc2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][9]);
talentPool.talentPool2._y = 0;
KrinCreateAbilityMatrix = function()
{
   now = 0;
   now2 = 0;
   spacey = 35;
   starty = 25;
   talentPool.talentPool2.maxH = starty - 140;
   krinv = 0;
   while(krinv < 70)
   {
      removeMovieClip(talentPool.talentPool2["t" + krinv]);
      krinv++;
   }
   for(krini in _root.Krin.moveMatrix2)
   {
      talentPool.talentPool2.attachMovie("talenter","t" + now,now);
      talentPool.talentPool2["t" + now]._y = now2 * spacey + starty;
      talentPool.talentPool2["t" + now]._x = Math.pow(-1,now) * -40 + 45;
      talentPool.talentPool2["t" + now].talent = _root.Krin.moveMatrix2[krini];
      talentPool.talentPool2["t" + now].inner.gotoAndStop(_root["KRINABILITY" + _root.Krin.moveMatrix2[krini]][0]);
      if(_root.Krin.abilityXer[_root.Krin.moveMatrix2[krini]].CLASSIFY == 1)
      {
         talentPool.talentPool2["t" + now].inner.gotoAndStop(_root.Krin.abilityXer[krink].BUFFNAME);
      }
      talentPool.talentPool2["t" + now].inner.toolTipTitle = _root["KRINABILITY" + _root.Krin.moveMatrix2[krini]][17];
      talentPool.talentPool2["t" + now].inner.toolTip = _root["KRINABILITYB" + _root.Krin.moveMatrix2[krini]][17] + _root.KrinLang[_root.KLangChoosen].SKILLTHRS1 + _root["KRINABILITY" + _root.Krin.moveMatrix2[krini]][8] + _root.KrinLang[_root.KLangChoosen].SKILLTHRS2;
      talentPool.talentPool2["t" + now].inner.toolTip3 = _root["KRINABILITYB" + _root.Krin.moveMatrix2[krini]][18];
      talentPool.talentPool2["t" + now].useNum = _root["KRINABILITY" + _root.Krin.moveMatrix2[krini]][8];
      for(u in _root.elementMainArray)
      {
         if(_root.elementMainArray[u] == _root["KRINABILITYB" + _root.Krin.moveMatrix2[krini]][0])
         {
            talentPool.talentPool2["t" + now].inner.KNcolor2 = _root.elementColorArray[u];
         }
      }
      now++;
      if(Math.pow(-1,now) > 0)
      {
         now2++;
      }
      else
      {
         talentPool.talentPool2.maxH += spacey;
      }
   }
   i = 0;
   while(i < 8)
   {
      selector["thing" + i].gotoAndStop(_root["KRINABILITY" + _root.Krin.moveMatrix[i]][0]);
      selector["thing" + i].toolTipTitle = _root["KRINABILITY" + _root.Krin.moveMatrix[i]][17];
      selector["thing" + i].toolTip = _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][17];
      selector["thing" + i].toolTip3 = _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][18];
      for(u in _root.elementMainArray)
      {
         if(_root.elementMainArray[u] == _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][0])
         {
            selector["thing" + i].KNcolor2 = _root.elementColorArray[u];
         }
      }
      if(_root["KRINABILITY" + _root.Krin.moveMatrix[i]][0] == "None")
      {
         selector["thing" + i].gotoAndStop("Empty");
         selector["thing" + i].toolTipTitle = _root.KrinLang[_root.KLangChoosen].SKILLNONE;
         selector["thing" + i].toolTip = _root.KrinLang[_root.KLangChoosen].SKILLTUT;
         selector["thing" + i].toolTip3 = _root.KrinLang[_root.KLangChoosen].SKILLTUT2;
      }
      selector["thing" + i].assignedThing = i;
      selector["thing" + i].ACD = "";
      i++;
   }
};
KrinCreateAbilityMatrix();
