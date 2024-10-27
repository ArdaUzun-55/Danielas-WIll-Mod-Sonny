onClipEvent(load){
   vbbc0 = _root.KrinLang[_root.KLangChoosen].MENU[14];
   if(_root.winCondition == 1)
   {
      _root.winCondition = -1;
      this.gotoAndStop("win");
      _root.Krin.Pause = true;
   }
   else
   {
      this.gotoAndStop("hide");
   }
}
