onClipEvent(enterFrame){
   if(this.hitTest(_root._xmouse,_root._ymouse))
   {
      if(_parent._parent._visible && !_parent.zero)
      {
         if(_parent.chimney)
         {
            _root.KrinToolTipper.tt = _parent.toolTipTitle;
            _root.KrinToolTipper.t = _parent.toolTip;
            _root.KrinToolTipper.gotoAndPlay("GO");
         }
         else
         {
            _root.KrinToolTipper.tt = _parent.toolTipTitle;
            _root.KrinToolTipper.t = _parent.toolTip;
            _root.KrinToolTipper.t3 = _parent.toolTip3;
            if(hitter == 20)
            {
               if(_parent._parent.OKAY == true)
               {
                  _root.KrinToolTipper.tyut = _parent.toolTip4;
                  _root.KrinToolTipper.gotoAndPlay("GO7");
               }
               else
               {
                  _root.KrinToolTipper.gotoAndPlay("GO2");
               }
            }
            else
            {
               hitter++;
               _root.KrinToolTipper.gotoAndPlay("GO3");
            }
         }
      }
   }
   else
   {
      hitter = 0;
   }
}
