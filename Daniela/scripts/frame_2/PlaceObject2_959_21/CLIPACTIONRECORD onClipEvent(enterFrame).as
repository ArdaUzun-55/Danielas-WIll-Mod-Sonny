onClipEvent(enterFrame){
   if(_root.getBytesLoaded() == _root.getBytesTotal())
   {
      _root.nextFrame();
   }
}
