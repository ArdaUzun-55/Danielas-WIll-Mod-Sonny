onClipEvent(enterFrame){
   _root["music" + _root.musicCounter2].setVolume(100 - _alpha / 1.2);
   if(_root.nextSpeechKKK == false)
   {
      if(_alpha < 100)
      {
         _alpha = _alpha + 5;
      }
      else
      {
         _alpha = 100;
      }
      timeX += 30 / _root.frameRateNowKrin;
      if(timeX >= _root.timeSpeechKKKUP)
      {
         _root.nextSpeechKKK = true;
      }
   }
   else if(_alpha > 0)
   {
      _alpha = _alpha - 5;
   }
   else
   {
      _root.hardSkip = false;
   }
}
