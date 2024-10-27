on(release){
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.numberOfRespecUsed += 1;
      _root.Krin.skillPoints = _root.Krin.Level + 5;
      _root.Krin.statPoints = _root.Krin.Level * 2;
      KRINMENU.skillPoints = _root.Krin.skillPoints;
      KRINMENU.statPoints = _root.Krin.statPoints;
      Krin.moveMatrix = new Array();
      Krin.moveMatrix = [0,0,0,0,0,0,0,0];
      Krin.moveMatrix2 = new Array();
      Krin.moveMatrix2Limit = new Array();
      _root.Krin.moveMatrix[0] = _root.Krin.startSkill1;
      _root.Krin.moveMatrix[1] = _root.Krin.startSkill2;
      _root.Krin.moveMatrix2[0] = _root.Krin.startSkill1;
      _root.Krin.moveMatrix2[1] = _root.Krin.startSkill2;
      Krin.abilityCoolDown = new Array();
      Krin.abilityCoolDown = [0,0,0,0,0,0,0,0];
      Krin.skillAdderMatrix = new Array();
      Krin.skillAdderMatrix = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      Krin.skillAdderMatrixOld = new Array();
      Krin.skillAdderMatrixOld = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      Krin.buffAdderMatrix = new Array();
      Krin.buffAdderMatrix = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      Krin.talentMainArray = new Array();
      Krin.talentMainArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      Krin.StatSets0 = [0,0,0,0,0];
      kriniux = 0;
      while(kriniux < 7)
      {
         for(p in _root.Krin.StatSets0)
         {
            _root.Krin.StatSets0[p] += _root["KRINITEM" + _root.Krin.equipArray0[kriniux]].statUpdater[p];
         }
         kriniux++;
      }
      KRINMENU.yut_lif2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][0] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][1] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][2] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      KRINMENU.yut_str2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][1] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][3] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][4] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      KRINMENU.yut_mag2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][2] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][5] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][6] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      KRINMENU.yut_spd2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][3] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][7] + _root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][8] * _root.Krin.LevelStats[_root.Krin.MenuPlayerSelect]);
      KRINMENU.yut_foc2 = _root.Krin["StatSets" + _root.Krin.MenuPlayerSelect][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[_root.Krin.MenuPlayerSelect]][9]);
      KRINMENU.talenttreefull.krinRemakeTree();
      KRINMENU.KrinCreateAbilityMatrix();
   }
}
