onClipEvent(keyDown){
   if(Key.isDown(32))
   {
      _root.nextSpeechKKK = true;
      _root.hardSkip = true;
      _root.my_sound1.stop();
      _root.my_sound2.stop();
      _root.my_sound3.stop();
   }
}
