if(Krin.bossFight == true && Krin.progressFight == true)
{
   Krin.bossJustPwned = true;
   var zoneId = _root.Krin.highestZoneDefeated + 1;
   _root.updateZoneDefeated(zoneId);
}
else
{
   Krin.bossJustPwned = false;
}
Krin.bossFight = false;
if(Krin.progressFight)
{
   Krin.progressLevelOn += 1;
   Krin.progressFight = false;
}
_root.checkAndUpdateZoneAchievements();
Krin.tutSpeecher = false;
Mouse.removeListener(someListenerKrin);
gotoAndStop("Navigation");
