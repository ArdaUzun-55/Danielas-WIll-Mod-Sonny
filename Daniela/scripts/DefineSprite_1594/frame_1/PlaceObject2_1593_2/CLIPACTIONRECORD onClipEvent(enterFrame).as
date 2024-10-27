onClipEvent(enterFrame){
   this._rotation = -180 + 180 * (_root.BattleTimeNow / (_root.BattleTimeLimit / 2));
   if(this._rotation >= 0)
   {
      _rotation = 0;
   }
}
