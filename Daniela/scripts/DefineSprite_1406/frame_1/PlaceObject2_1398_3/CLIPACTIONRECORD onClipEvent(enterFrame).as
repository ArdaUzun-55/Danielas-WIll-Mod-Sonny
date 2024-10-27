onClipEvent(enterFrame){
   if(_Y <= 0 && _xmove > 0 || _Y >= - maxH && _xmove < 0)
   {
      this._y += _xmove;
   }
}
