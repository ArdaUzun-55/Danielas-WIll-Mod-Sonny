on(release){
   if(_root.InBattle == false)
   {
      _root.krinAddMove(Krin.playerNumber,Krin.playerNumber,0);
      if(turnBasedKrin)
      {
         if(_root.InBattle == false && battleClocker.timerWait == 0 && _root.winCondition < 0 && _root.speechDone == true)
         {
            _root.moveChoosen = true;
         }
      }
      else
      {
         this.krinToMove2._visible = false;
         this.krinToMove._visible = false;
         this.krinToMove.toolTipTitle = this.krinToMove.thinger1;
         this.krinToMove.toolTip = this.krinToMove.thinger2;
      }
   }
}
