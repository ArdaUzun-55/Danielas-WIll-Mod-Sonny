function updateStat_Player(theGuy)
{
   _root[theGuy].abilityCoolDown = [0,0,0,0,0,0,0,0];
   shtName.active = true;
   for(krinyt in _root[theGuy].buffAdderMatrix)
   {
      if(_root[theGuy].buffAdderMatrix[krinyt] != 0)
      {
         shtName.passiveBuffs.push(_root[theGuy].buffAdderMatrix[krinyt]);
      }
   }
   shtName.STRENGTHU = shtName.STRENGTH = _root[theGuy].STRENGTH;
   shtName.SPEEDU = shtName.SPEED = _root[theGuy].SPEED;
   shtName.LIFEU = Math.round(shtName.LIFE = _root[theGuy].LIFE * vitLifeFactor);
   shtName.MAGICU = shtName.MAGIC = _root[theGuy].MAGIC;
   shtName.FOCUSU = shtName.FOCUS = _root[theGuy].FOCUS;
   shtName.FOCUSN = shtName.FOCUSU;
   shtName.LIFEN = shtName.LIFEU;
   shtName.plevel = _root[theGuy].LevelStats[0];
   shtName.voiceHit = new Array();
   shtName.voiceHit[0] = "hit_sonny1";
   shtName.voiceHit[1] = "hit_sonny2";
   shtName.voiceHit[2] = "hit_sonny3";
   shtName.voiceDie = "dead_sonny";
   if(Krin.ClassStats[0] == 277)
   {
      shtName.BLOODYFURY = 0.5;
   }
   shtName.model = ["MODEL1",Krin.skinArray[Krin.SkinSet[0]],Krin.hairArray[Krin.HairSet[0]],Krin.gArray[Krin.GSet[0]]];
   thte = 0;
   while(thte < 7)
   {
      if(_root[theGuy].equipArray0[thte] != 0)
      {
         shtName.equip[thte] = _root["KRINITEM" + _root[theGuy].equipArray0[thte]].looks;
      }
      else
      {
         shtName.equip[thte] = 0;
      }
      thte++;
   }
   if(_root.arenaMode)
   {
      u_i_o = 0;
      while(u_i_o < 9)
      {
         _root[theGuy].PER[_root.elementMainArray[u_i_o]] = 100 + 15 * shtName.plevel + _root[theGuy].PerSets0[u_i_o];
         _root[theGuy].DEF[_root.elementMainArray[u_i_o]] = 100 + 15 * shtName.plevel + _root[theGuy].DefSets0[u_i_o];
         u_i_o++;
      }
   }
   wefjnew = 0;
   while(wefjnew < 9)
   {
      shtName.PER[_root.elementMainArray[wefjnew]] = shtName.PERU[_root.elementMainArray[wefjnew]] = _root[theGuy].PER[_root.elementMainArray[wefjnew]];
      shtName.DEF[_root.elementMainArray[wefjnew]] = shtName.DEFU[_root.elementMainArray[wefjnew]] = _root[theGuy].DEF[_root.elementMainArray[wefjnew]];
      wefjnew++;
   }
}
KRS = new Array();
r = 0;
while(r < 100)
{
   KRS[r] = random(100);
   r++;
}
KRSC = 0;
if(!arenaMode)
{
   if(Krin.difficulty == 0)
   {
      turnBasedKrin = true;
   }
   else if(Krin.difficulty == 1)
   {
      turnBasedKrin = true;
   }
   else if(Krin.difficulty == 3)
   {
      turnBasedKrin = true;
   }
   else
   {
      turnBasedKrin = false;
   }
}
var AchVal1 = 0;
var AchVal2 = false;
var AchVal3 = 0;
var AchVal4 = 0;
_root.moneyConstGain = 0;
_root.totalEnemyGain = 0;
addSound("Music",2);
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
phase = 1;
playerKrin0 = new Object();
playerKrin0.active = true;
playerKrin0.playerName = "Information";
Krin.friendlySlotsFFTT = new Array();
_root.Krin.MenuPlayerSelect = 0;
updateStatus();
Krin.LIFE = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][0] + Math.ceil(_root.getStat(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][1],_root.Krin.LevelStats[_root.Krin.MenuPlayerSelect],true));
Krin.STRENGTH = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][1] + Math.ceil(_root.getStat(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][2],_root.Krin.LevelStats[_root.Krin.MenuPlayerSelect],true));
Krin.MAGIC = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][2] + Math.ceil(_root.getStat(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][3],_root.Krin.LevelStats[_root.Krin.MenuPlayerSelect],true));
Krin.SPEED = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][3] + Math.ceil(_root.getStat(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][4],_root.Krin.LevelStats[_root.Krin.MenuPlayerSelect],true));
Krin.FOCUS = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][5],true);
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
      shtName.BUFFARRAYK.push({buffId:"None",CD:0,buffValue:0,shieldBuffValue:0});
      e++;
   }
   shtName.FILTERSBUFFARRAY = new Array();
   shtName.FILTERSBUFFARRAY = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
   shtName.DOTTICKERARRAY = new Array();
   shtName.DOTTICKERARRAY = [0,0,0,0,0,0,0,0,0,0,0];
   shtName.changeArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
   shtName.changeArrayEP = [0,0,0,0,0,0,0,0,0];
   shtName.changeArrayEP2 = [0,0,0,0,0,0,0,0,0];
   shtName.changeArrayED = [0,0,0,0,0,0,0,0,0];
   shtName.changeArrayED2 = [0,0,0,0,0,0,0,0,0];
   shtName.playerName = "John Doe";
   shtName.changeArray = new Array();
   shtName.changeArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
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
   shtName.HIT = 0;
   shtName.DODGE = 0;
   shtName.AINEXTATTACK = 0;
   shtName.DMG = 0;
   shtName.TURN = 0;
   shtName.PHASE = 0;
   shtName.FOCUSPLUS = 0;
   shtName.CRIT = 0;
   shtName.DMG2 = 0;
   shtName.DEFENSE = 1;
   shtName.IDMG = 0;
   shtName.STANCE = 0;
   shtName.STANCEMAX = 0;
   shtName.BLEED = 100;
   shtName.BLEED2 = 0;
   shtName.BLEEDMAX = 100;
   shtName.FROSTBITTEN = 100;
   shtName.FROSTBITTEN2 = 0;
   shtName.FROSTBITTENMAX = 100;
   shtName.IDMG2 = 0;
   shtName.IDMGP = 0;
   shtName.IDMGP2 = 1;
   shtName.CRITMODIFIER = 1;
   shtName.IDOT = 1;
   shtName.IHOT = 1;
   shtName.ODOT = 1;
   shtName.NODAMAGE = true;
   shtName.abilityhistory = new Array();
   shtName.abilityhistory2 = new Array();
   shtName.FOCUSCHANGE = 0;
   shtName.SSWITCH = 0;
   shtName.HEALMOD_PLUS = 1;
   shtName.HEALMOD_MINUS = 1;
   shtName.HEALMOD = 1;
   shtName.STUN = 0;
   shtName.START = 0;
   shtName.STUNP = 0;
   shtName.REFLECTDMG = 0;
   shtName.SHIELD = 0;
   shtName.SHIELDCOUNTER = 0;
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
   if(Krin.singlePlayer == true)
   {
      if(Krin.playerNumber == i)
      {
         shtName.playerName = "Sonny";
         updateStat_Player("Krin");
      }
      else
      {
         krinAddNewUnit(i,"Krin");
      }
   }
   else if(i == 1)
   {
      shtName.playerName = arenaPlayer1.krinNameUser;
      updateStat_Player("arenaPlayer1");
   }
   else if(i == 2)
   {
      shtName.playerName = arenaPlayer2.krinNameUser;
      updateStat_Player("arenaPlayer2");
   }
   else if(i == 3 || i == 5)
   {
      krinAddNewUnit(i,"arenaPlayer1");
   }
   else
   {
      krinAddNewUnit(i,"arenaPlayer2");
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
Krin.itemRareDropCheck = _root["KBR" + Krin.BattlePick].itemRareDropper2;
while(Krin.itemRareDropCheck > 0)
{
   doppelGangerRandom = Math.floor(random(_root["KBR" + Krin.BattlePick].itemRare2.length * 100) / 100);
   Krin.dropArray[pewPewItemDrop] = _root["KBR" + Krin.BattlePick].itemRare2[doppelGangerRandom];
   Krin.itemRareDropCheck--;
   pewPewItemDrop++;
}
Krin.itemRareDropCheck = _root["KBR" + Krin.BattlePick].itemRareDropper3;
while(Krin.itemRareDropCheck > 0)
{
   doppelGangerRandom = Math.floor(random(_root["KBR" + Krin.BattlePick].itemRare3.length * 100) / 100);
   Krin.dropArray[pewPewItemDrop] = _root["KBR" + Krin.BattlePick].itemRare3[doppelGangerRandom];
   Krin.itemRareDropCheck--;
   pewPewItemDrop++;
}
Krin.timeLock = _root["KBR" + Krin.BattlePick].timeLock;
