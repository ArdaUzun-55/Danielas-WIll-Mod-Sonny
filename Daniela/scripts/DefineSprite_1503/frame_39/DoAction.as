tit_1 = _root.KrinLang[_root.KLangChoosen].MENU[27];
tit_2 = _root.KrinLang[_root.KLangChoosen].MENU[28];
tit_8 = _root.KrinLang[_root.KLangChoosen].MENU[35];
tit_9 = _root.KrinLang[_root.KLangChoosen].MENU[38];
if(_root.Krin.sound)
{
   tit_3 = _root.KrinLang[_root.KLangChoosen].MENU[29];
}
else
{
   tit_3 = _root.KrinLang[_root.KLangChoosen].MENU[30];
}
if(_root.Krin.graphics)
{
   tit_4 = _root.KrinLang[_root.KLangChoosen].MENU[31];
}
else
{
   tit_4 = _root.KrinLang[_root.KLangChoosen].MENU[32];
}
if(_root.Krin.qual == "LOW")
{
   tit_11 = _root.KrinLang[_root.KLangChoosen].MENU[32];
}
else
{
   tit_11 = _root.KrinLang[_root.KLangChoosen].MENU[31];
}
if(_root.Krin.diff == "HARD")
{
   tit_12 = _root.KrinLang[_root.KLangChoosen].MENU[53];
}
else
{
   tit_12 = _root.KrinLang[_root.KLangChoosen].MENU[52];
}
if(_root.Krin.autoSaver)
{
   tit_7 = _root.KrinLang[_root.KLangChoosen].MENU[29];
}
else
{
   tit_7 = _root.KrinLang[_root.KLangChoosen].MENU[30];
}
whatToSayY = _root.KrinLang[_root.KLangChoosen].MENU[36];
var bgElementsFound = 0;
var i = 0;
while(i < _root.Krin.bgElementsInteracted.length)
{
   bgElementsFound += _root.Krin.bgElementsInteracted[i];
   i++;
}
gs_zone_cleared = _root.Krin.highestZoneDefeated;
gs_respec_used = _root.Krin.numberOfRespecUsed;
gs_training_used = _root.Krin.numberOfTrainingUsed;
gs_top_dmg_physical = _root.Krin.topDamagePhysical;
gs_top_dmg_elemental = _root.Krin.topDamageElemental;
gs_bg_found = bgElementsFound;
