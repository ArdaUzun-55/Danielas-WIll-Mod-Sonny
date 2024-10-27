on(release){
   if(_root.winCondition == -1)
   {
      if(_root.Krin.PauseForScreen != true)
      {
         Mouse.removeListener(someListenerKrin);
         gotoAndStop("resetHere");
         play();
      }
   }
}
