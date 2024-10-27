onClipEvent(load){
   moveStart = false;
   _root.BAMBAMBAM = false;
   turnTime = 0;
   timerWait = 30;
   AttackEndCounterLimit = 25;
   AttackEndCounter = AttackEndCounterLimit + 1;
   if(_root["playerKrin" + _root.Krin.playerNumber].teamSide == _root.TeamMoveNow)
   {
      this.thingerClock.gotoAndStop("friend");
   }
   else
   {
      this.thingerClock.gotoAndStop("enemy");
   }
   _root.firstUpdate = true;
   i = 1;
   while(i < 7)
   {
      if(_root["playerKrin" + i].active)
      {
         _root.lifeBarUpdate(i);
      }
      else
      {
         _root["p" + i + "BAR"]._visible = false;
      }
      i++;
   }
   _root.firstUpdate = false;
}
