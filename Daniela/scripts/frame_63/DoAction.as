dollPartsArray = new Array();
dollPartsArray = ["head","chest","arm1","arm2","hand1","hand2","leg1","leg2","leg3","leg4","foot1","foot2","weapon1","weapon2","shoulder"];
dollPartsCores = new Array();
dollPartsCores = [0,1,1,1,2,2,3,3,4,4,4,4,5,6,1];
dollPartsCores2 = new Array();
dollPartsCores2 = ["HEAD","CHEST","ARM","ARM","HAND","HAND","ARM","ARM","LEG2","LEG2","FOOT","FOOT","WEAPON","WEAPON","SHOULDER"];
playerKrin6 = new Object();
playerKrin6.model = ["MODEL1","THREE","SIX","F"];
changer = "ROCKSTAR";
playerKrin6.equip = [0,changer,changer,changer,changer,"SPELLSTAFF",0];
player6.attachMovie(_root.playerKrin6.model[0],"inner",0);
for(h in dollPartsArray)
{
   player6.inner[dollPartsArray[h]].attachMovie(_root.playerKrin6.model[3] + "_S" + dollPartsCores2[h] + "_" + _root.playerKrin6.model[1],"innerX",-1);
   player6.inner[dollPartsArray[h]].attachMovie(_root.playerKrin6.model[3] + "_" + dollPartsCores2[h] + "_" + _root.playerKrin6.equip[dollPartsCores[h]],"inner",0);
}
if(_root.playerKrin6.equip[0] == 0)
{
   player6.inner.head.attachMovie("HAIR_" + _root.playerKrin6.model[2],"hair",2);
}
if(gameoverKrin)
{
   gameoverKrin = false;
   gotoAndStop("gameOverMenu");
}
