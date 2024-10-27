on(release){
   _root.UITmouseHold = talent;
   _root.KrinToolTipper.inner2.gotoAndStop(_root["KRINABILITY" + _root.UITmouseHold][0]);
   _root.KrinToolTipper.inner2.ACD = "";
   unloadMovie(_root.KrinToolTipper.inner2.bfilter);
   for(u in _root.elementMainArray)
   {
      if(_root.elementMainArray[u] == _root["KRINABILITYB" + _root.UITmouseHold][0])
      {
         _root.KrinToolTipper.inner2.KNcolor2 = _root.elementColorArray[u];
      }
   }
}
