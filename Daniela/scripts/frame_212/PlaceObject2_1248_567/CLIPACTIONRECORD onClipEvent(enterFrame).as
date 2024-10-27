onClipEvent(enterFrame){
   if(this.hitTest(_root._xmouse,_root._ymouse))
   {
      _root.KrinToolTipper.tt = _root.KrinLang[_root.KLangChoosen].SYSTEM[25];
      _root.KrinToolTipper.t = _root.KrinLang[_root.KLangChoosen].SYSTEM[26];
      _root.KrinToolTipper.gotoAndPlay("GO");
   }
}
