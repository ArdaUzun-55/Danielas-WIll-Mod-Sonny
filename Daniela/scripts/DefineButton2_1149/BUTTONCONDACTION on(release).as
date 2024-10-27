on(release){
   _root.Krin.Class = 1;
   _root.loadTalents(_root.Krin.Class);
   _root.Krin.moveMatrix[0] = _root.Krin.startSkill1;
   _root.Krin.moveMatrix[1] = _root.Krin.startSkill2;
   _root.Krin.moveMatrix2[0] = _root.Krin.startSkill1;
   _root.Krin.moveMatrix2[1] = _root.Krin.startSkill2;
   gotoAndStop("optionsMenu");
   play();
}
