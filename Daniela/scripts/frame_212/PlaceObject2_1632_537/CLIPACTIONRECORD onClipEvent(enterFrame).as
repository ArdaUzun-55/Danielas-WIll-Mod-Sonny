onClipEvent(enterFrame){
   if(eivwienviwenvie)
   {
      if(Key.isDown(32))
      {
         _visible = true;
      }
      else
      {
         _visible = false;
      }
      i = 0;
      while(i < 9)
      {
         this["v" + i] = _root[_root.MoveArrayFINAL[i] + "MOVE"][1] + " > " + _root[_root.MoveArrayFINAL[i] + "MOVE"][2] + " with " + _root[_root.MoveArrayFINAL[i] + "MOVE"][3];
         i++;
      }
      i = 0;
      while(i < 9)
      {
         this["b" + i] = "";
         i++;
      }
      this["b" + _root.PlayerToMove] = this["v" + _root.PlayerToMove];
   }
   _visible = false;
}
