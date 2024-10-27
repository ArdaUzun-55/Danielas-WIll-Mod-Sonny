onClipEvent(load){
   this.gotoAndStop("None");
   this.ACD = "";
   if(!_root.turnBasedKrin)
   {
      thinger1 = "No ability selected!";
      thinger2 = "First select your target then choose an ability to use.";
      thinger3 = "Cannot cancel during action.";
   }
   else
   {
      thinger1 = "No ability selected!";
      thinger2 = "You may click here to skip your turn.";
      thinger3 = "Cannot skip during action.";
   }
   this.toolTipTitle = thinger1;
   this.toolTip = thinger2;
   chimney = true;
}
