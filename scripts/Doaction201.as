
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
   shtName.FILTERSBUFFARRAY = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
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
   shtName.DMG = 0;
   shtName.TURN = 0;
   shtName.PHASE = 0;
   shtName.FOCUSPLUS = 0;
   shtName.CRIT = 0;
   shtName.DMG2 = 0;
   shtName.DEFENSE = 1;
   shtName.IDMG = 0;
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
