onClipEvent(enterFrame){
   if(_parent.teamChangeCD == false)
   {
      bobbybobby++;
      if(bobbybobby == 5)
      {
         _parent.teamChangeCD = true;
         bobbybobby = 0;
      }
   }
}
