onClipEvent(enterFrame){
   this._rotation = 180 * (_root.BattleTimeNow / (_root.BattleTimeLimit / 2)) - 180;
   if(_rotation < 0)
   {
      _rotation = 0;
   }
}
