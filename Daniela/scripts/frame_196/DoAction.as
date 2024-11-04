addSound("Music",2);
if(!Krin.progressFight)
{
   Krin.numberOfTrainingUsed += 1;
}
if(Krin.graphics)
{
   KrinSettings.SFX = true;
   KrinSettings.SFX2 = false;
   KrinSettings.SFX3 = true;
   KrinSettings.QUALITY = "HIGH";
}
else
{
   KrinSettings.SFX = false;
   KrinSettings.SFX2 = false;
   KrinSettings.SFX3 = true;
   KrinSettings.QUALITY = "HIGH";
}
turnBasedKrin = true;
i = 1;
while(i < 7)
{
   _root["playerKrin" + i] = new Object();
   _root["playerKrin" + i].active = false;
   _root["playerKrin" + i].AION = false;
   _root["playerKrin" + i].playerID = i;
   _root["playerKrin" + i].playerName = "John Dead";
   _root["playerKrin" + i].SPEEDU = 0;
   i++;
}
playerKrin0 = new Object();
playerKrin0.active = true;
playerKrin0.playerName = "Information";
Krin.friendlySlotsFFTT = new Array();
_root.Krin.MenuPlayerSelect = 0;
Krin.LIFE = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][0] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][1] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][2] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
Krin.STRENGTH = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][1] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][3] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][4] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
Krin.MAGIC = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][2] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][5] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][6] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
Krin.SPEED = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][3] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][7] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][8] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
Krin.FOCUS = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][9]);
i = 1;
while(i < 7)
{
   _root["playerKrin" + i] = new Object();
   shtName = _root["playerKrin" + i];
   shtName.active = false;
   shtName.playerID = i;
   shtName.plevel = 1;
   shtName.model = new Array();
   shtName.equip = new Array();
   shtName.model = ["MODEL1","ONE","ONE","M"];
   shtName.equip = ["NINJA","NINJA","NINJA","NINJA","NINJA","SWORD1","SWORD1"];
   shtName.characterColorState = "Normal";
   shtName.characterFilterState = KrinFilterNone;
   shtName.changeArray = new Array();
   shtName.changeArrayEP = new Array();
   shtName.changeArrayEP2 = new Array();
   shtName.changeArrayED = new Array();
   shtName.changeArrayED2 = new Array();
   shtName.BUFFARRAYK = new Array();
   e = 0;
   while(e < _root.maxBuffLimit)
   {
      shtName.BUFFARRAYK.push({buffId:"None",CD:0,buffValue:0});
      e++;
   }
   shtName.FILTERSBUFFARRAY = new Array();
   shtName.FILTERSBUFFARRAY = [0,0,0,0,0,0,0,0,0];
   shtName.DOTTICKERARRAY = new Array();
   shtName.DOTTICKERARRAY = [0,0,0,0,0,0,0,0,0,0];
   shtName.changeArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
   shtName.changeArrayEP = [0,0,0,0,0,0,0,0];
   shtName.changeArrayEP2 = [0,0,0,0,0,0,0,0];
   shtName.changeArrayED = [0,0,0,0,0,0,0,0];
   shtName.changeArrayED2 = [0,0,0,0,0,0,0,0];
   shtName.playerName = "John Doe";
   shtName.changeArray = new Array();
   shtName.changeArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
   shtName.passiveBuffs = new Array();
   shtName.SPEEDU = 0;
   shtName.SPEEDN = 0;
   shtName.MAGICN = 0;
   shtName.STRENGTHN = 0;
   shtName.SILENCED = 0;
   shtName.FURY = 0;
   shtName.BLOODYFURY = 0;
   shtName.IGNORE = 0;
   shtName.STUNRESIST = 0;
   shtName.SLOWRESIST = 0;
   shtName.FLAMED = 0;
   shtName.FLAMED2 = 0;
   shtName.HIT = 0;
   shtName.DODGE = 0;
   shtName.CONDITION = 0;
   shtName.CONDITION2 = 0;
   shtName.CONDITION3 = 0;
   shtName.CONDITION4 = 0;
   shtName.CONDITION5 = 0;
   shtName.AINEXTATTACK = 0;
   shtName.DMG = 0;
   shtName.TURN = 0;
   shtName.PHASE = 0;
   shtName.FOCUSPLUS = 0;
   shtName.POLYGOT = 0;
   shtName.CRIT = 0;
   shtName.DPS = 0;
   shtName.DMG2 = 0;
   shtName.DEFENSE = 1;
   shtName.IDMG = 0;
   shtName.STANCE = 0;
   shtName.STANCEMAX = 0;
   shtName.BLEED = 100;
   shtName.BLEED2 = 0;
   shtName.TENCHIJIN = 0;
   shtName.LIVINGDEAD = 0;
   shtName.LIVINGDEAD10 = 0;
   shtName.BLEEDMAX = 100;
   shtName.FROSTBITTEN = 100;
   shtName.FROSTBITTEN2 = 0;
   shtName.FROSTBITTENMAX = 100;
   shtName.PALETTEGAUGE = 0;
   shtName.PALETTEGAUGEMAX = 100;
   shtName.DMG = 0;
   shtName.DMG2 = 0;
   shtName.DMG3 = 0;
   shtName.IDMG = 0;
   shtName.IDMG2 = 0;
   shtName.IDMG3 = 0;
   shtName.IDMGP = 0;
   shtName.SEDUCED = 0;
   shtName.ELECTROPE = 0;
   shtName.ELECTROPE2 = 0;
   shtName.IDMGP2 = 1;
   shtName.IDOT = 1;
   shtName.IHOT = 1;
   shtName.ODOT = 1;
   shtName.BMANA = 0;
   shtName.WMANA = 0;
   shtName.BMANAMAX = 100;
   shtName.WMANAMAX = 100;
   shtName.FOCUSCHANGE = 0;
   shtName.SSWITCH = 0;
   shtName.IGNORETURN = false;
   shtName.HEALMOD_PLUS = 1;
   shtName.HEALMOD_MINUS = 1;
   shtName.HEALMOD = 1;
   shtName.STUN = 0;
   shtName.SHIE = 0;
   shtName.BUNSHIN = 0;
   shtName.CDFORTEN = 0;
   shtName.STUNP = 0;
   shtName.REFLECTDMG = 0;
   shtName.SHIELD = 0;
   shtName.SHIELDCOUNTER = 0;
   shtName.abilityhistoryIDKM = new Array();
   f = 0;
   while(f < 19)
   {
      shtName.abilityhistoryIDKM[f] = 0;
      f++;
   }
   f = 0;
   shtName.abilityhistoryIDKM2 = new Array();
   while(f < 140)
   {
      shtName.abilityhistoryIDKM2[f] = 0;
      f++;
   }
   if(Math.pow(-1,i) < 0)
   {
      shtName.teamSide = 1;
   }
   else
   {
      shtName.teamSide = 2;
   }
   shtName.PER = new Object();
   shtName.DEF = new Object();
   shtName.PERU = new Object();
   shtName.DEFU = new Object();
   randomGo = 1;
   if(Krin.playerNumber == i)
   {
      Krin.abilityCoolDown = [0,0,0,0,0,0,0,0];
      shtName.playerName = "Sonny";
      shtName.active = true;
      for(krinyt in Krin.buffAdderMatrix)
      {
         if(Krin.buffAdderMatrix[krinyt] != 0)
         {
            shtName.passiveBuffs.push(Krin.buffAdderMatrix[krinyt]);
         }
      }
      shtName.STRENGTHU = shtName.STRENGTH = Krin.STRENGTH;
      shtName.SPEEDU = shtName.SPEED = Krin.SPEED;
      shtName.LIFEU = Math.round(shtName.LIFE = Krin.LIFE * 8);
      shtName.MAGICU = shtName.MAGIC = Krin.MAGIC;
      shtName.FOCUSU = shtName.FOCUS = Krin.FOCUS;
      shtName.FOCUSN = shtName.FOCUSU;
      shtName.LIFEN = shtName.LIFEU;
      shtName.plevel = Krin.LevelStats[0];
      shtName.voiceHit = new Array();
      shtName.voiceHit[0] = "SonnyHit1";
      shtName.voiceHit[1] = "SonnyHit2";
      shtName.voiceHit[2] = "SonnyHit3";
      shtName.voiceDie = "SonnyDie";
      shtName.model = ["MODEL1",Krin.skinArray[Krin.SkinSet[0]],Krin.hairArray[Krin.HairSet[0]],Krin.gArray[Krin.GSet[0]]];
      thte = 0;
      while(thte < 7)
      {
         if(_root.Krin.equipArray0[thte] != 0)
         {
            shtName.equip[thte] = _root["KRINITEM" + _root.Krin.equipArray0[thte]].looks;
         }
         else
         {
            shtName.equip[thte] = 0;
         }
         thte++;
      }
      wefjnew = 0;
      while(wefjnew < 8)
      {
         shtName.PER[_root.elementMainArray[wefjnew]] = shtName.PERU[_root.elementMainArray[wefjnew]] = _root.Krin.PER[_root.elementMainArray[wefjnew]];
         shtName.DEF[_root.elementMainArray[wefjnew]] = shtName.DEFU[_root.elementMainArray[wefjnew]] = _root.Krin.DEF[_root.elementMainArray[wefjnew]];
         wefjnew++;
      }
   }
   else if(Krin.singlePlayer == true)
   {
      krinAddNewUnit(i);
   }
   else
   {
      shtName.active = true;
      shtName.active = false;
      shtName.STRENGTHU = shtName.STRENGTH = 10 + random(50);
      shtName.SPEEDU = shtName.SPEED = 10 + random(50);
      shtName.LIFEU = shtName.LIFE = 100 + random(50);
      shtName.MAGICU = shtName.MAGIC = 10 + random(50);
      shtName.FOCUSU = shtName.FOCUS = 100;
      shtName.FOCUSN = shtName.FOCUSU;
      shtName.LIFEN = shtName.LIFEU;
      shtName.PER.Physical = 25;
      shtName.PER.Magic = 25;
      shtName.PER.Ice = 25;
      shtName.PER.Fire = 25;
      shtName.PER.Lightning = 25;
      shtName.PER.Earth = 25;
      shtName.PER.Shadow = 25;
      shtName.PER.Poison = 25;
      shtName.PERU.Physical = 25;
      shtName.PERU.Magic = 25;
      shtName.PERU.Ice = 25;
      shtName.PERU.Fire = 25;
      shtName.PERU.Lightning = 25;
      shtName.PERU.Earth = 25;
      shtName.PERU.Shadow = 25;
      shtName.PERU.Poison = 25;
      shtName.DEF.Physical = 25;
      shtName.DEF.Magic = 25;
      shtName.DEF.Ice = 25;
      shtName.DEF.Fire = 25;
      shtName.DEF.Lightning = 25;
      shtName.DEF.Earth = 25;
      shtName.DEF.Shadow = 25;
      shtName.DEF.Poison = 25;
      shtName.DEFU.Physical = 25;
      shtName.DEFU.Magic = 25;
      shtName.DEFU.Ice = 25;
      shtName.DEFU.Fire = 25;
      shtName.DEFU.Lightning = 25;
      shtName.DEFU.Earth = 25;
      shtName.DEFU.Shadow = 25;
      shtName.DEFU.Poison = 25;
   }
   i++;
}
winCondition = -1;
winDate = _root["KBR" + Krin.BattlePick].winDate;
winDateCondition = _root["KBR" + Krin.BattlePick].winDateCondition;
GOTIPPER = Krin.BattlePick;
Krin.dropArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
pewPewItemDrop = 0;
Krin.ZoneBG = _root["KBR" + Krin.BattlePick].ZoneBG;
Krin.SkyBG = _root["KBR" + Krin.BattlePick].SkyBG;
absoluteStart = _root["KBR" + Krin.BattlePick].absoluteStart;
for(krinj in _root["KBR" + Krin.BattlePick].itemDrops)
{
   Krin.randomerItemDrop = random(100);
   if(_root["KBR" + Krin.BattlePick].itemDrops[krinj].CHANCE > Krin.randomerItemDrop)
   {
      Krin.dropArray[pewPewItemDrop] = _root["KBR" + Krin.BattlePick].itemDrops[krinj].ID;
      pewPewItemDrop++;
   }
}
Krin.itemRareDropCheck = _root["KBR" + Krin.BattlePick].itemRareDropper;
while(Krin.itemRareDropCheck > 0)
{
   doppelGangerRandom = Math.floor(random(_root["KBR" + Krin.BattlePick].itemRare.length * 100) / 100);
   Krin.dropArray[pewPewItemDrop] = _root["KBR" + Krin.BattlePick].itemRare[doppelGangerRandom];
   Krin.itemRareDropCheck--;
   pewPewItemDrop++;
}
Krin.timeLock = _root["KBR" + Krin.BattlePick].timeLock;
