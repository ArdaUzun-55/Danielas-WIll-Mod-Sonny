on(release){
   checker = true;
   if(_root.Krin.skillPoints == 0)
   {
      checker = false;
      _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].TALENTERROR1;
      _root.KrinCombatText.play();
   }
   if(_root.Krin.talentMainArray[id] == _root.Krin.abilityXer[id].TIER)
   {
      checker = false;
      _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].TALENTERROR2;
      _root.KrinCombatText.play();
   }
   if(_root.Krin.Level < guessLevel)
   {
      checker = false;
      _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].TALENTERROR3;
      _root.KrinCombatText.play();
   }
   for(krinu in _root.Krin.abilityXer[id].PRESKILL)
   {
      if(_root.Krin.talentMainArray[_root.Krin.abilityXer[id].PRESKILL[krinu]] == 0)
      {
         checker = false;
         _root.KrinCombatText.combatTexter = _root.KrinLang[_root.KLangChoosen].TALENTERROR4;
         _root.KrinCombatText.play();
      }
   }
   if(checker)
   {
      _root.Krin.skillPoints--;
      _parent._parent.skillPoints--;
      _root.Krin.talentMainArray[id]++;
      if(_root.Krin.abilityXer[id].CLASSIFY == 0)
      {
         for(krinp in _root.Krin.moveMatrix)
         {
            if(_root.Krin.moveMatrix[krinp] == _root.Krin.skillAdderMatrix[id])
            {
               if(_root.Krin.moveMatrix[krinp] != 0)
               {
                  _root.Krin.moveMatrix[krinp] = _root.Krin.abilityXer[id].ID + (_root.Krin.talentMainArray[id] - 1);
               }
            }
         }
         _root.Krin.skillAdderMatrix[id] = _root.Krin.abilityXer[id].ID + (_root.Krin.talentMainArray[id] - 1);
         _root.Krin.moveMatrix2 = new Array();
         _root.Krin.moveMatrix2.push(_root.Krin.startSkill1);
         _root.Krin.moveMatrix2.push(_root.Krin.startSkill2);
         for(krinu in _root.Krin.skillAdderMatrix)
         {
            if(_root.Krin.skillAdderMatrix[krinu] > 0)
            {
               _root.Krin.moveMatrix2.push(_root.Krin.skillAdderMatrix[krinu]);
               _parent._parent.KrinCreateAbilityMatrix();
            }
         }
      }
      else
      {
         _root.Krin.buffAdderMatrix[id] = _root.Krin.abilityXer[id].BUFFNAME + _root.Krin.talentMainArray[id];
      }
      _parent.krinRemakeTree();
   }
}
