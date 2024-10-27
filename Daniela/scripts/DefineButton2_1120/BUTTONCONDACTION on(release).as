on(release){
   nameInputLive = nameInputField.text;
   trace("User Name Input is: " + nameInputLive);
   if(nameInputLive == undefined)
   {
      _root.Krin.tempUserName = "NoNameUser";
   }
   else
   {
      _root.Krin.tempUserName = nameInputLive;
   }
   gotoAndStop("dataMenu");
}
