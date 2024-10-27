onClipEvent(enterFrame){
   if(_root.Krin.statPoints == 0)
   {
      this.gotoAndStop("dead");
   }
   else
   {
      this.gotoAndStop(1);
   }
}
