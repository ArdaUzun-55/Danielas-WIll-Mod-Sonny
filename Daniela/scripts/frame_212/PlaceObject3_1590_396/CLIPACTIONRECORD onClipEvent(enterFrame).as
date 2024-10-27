onClipEvent(enterFrame){
   if(this.hitter.hitTest(_root._xmouse,_root._ymouse))
   {
      if(_alpha < 100 && _root.InBattle == false)
      {
         _alpha = _alpha + 20;
      }
      _root.hitTarget[0] = 1;
      _root.HTX = _X;
      _root.HTY = _Y;
   }
   else
   {
      if(_alpha > 0)
      {
         _alpha = _alpha - 5;
      }
      _root.hitTarget[0] = 0;
   }
}
