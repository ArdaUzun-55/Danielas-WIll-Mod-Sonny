onClipEvent(load){
   this.gotoAndStop(_root.krinClassArray[_root.Krin.Class]);
   krinRemakeTree = function()
   {
      thingerDepthK = 0;
      krink = 0;
      while(krink < 40)
      {
         this["st" + krink].id = krink;
         this["st" + krink].thingoShow.numShow = _root.Krin.talentMainArray[krink];
         this["st" + krink].thingoShow.numShow2 = _root.Krin.abilityXer[krink].TIER;
         if(!Key.isDown(32))
         {
            this["st" + krink].thingoShow._visible = false;
         }
         this["st" + krink].thing2.ACD = "";
         this["st" + krink].OKAY = true;
         this["st" + krink].guessLevel = _root.Krin.abilityXer[krink].LEVELMIN + _root.Krin.abilityXer[krink].LEVELSCALE * _root.Krin.talentMainArray[krink];
         this["st" + krink].thing2.dontHide = true;
         this["st" + krink].thing2.gotoAndStop(_root["KRINABILITY" + _root.Krin.abilityXer[krink].ID][0]);
         this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITY" + _root.Krin.abilityXer[krink].ID][17];
         bobJimJohn = _root.Krin.talentMainArray[krink] - 1;
         if(bobJimJohn < 0)
         {
            bobJimJohn = 0;
         }
         this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][17];
         if(Key.isDown(16))
         {
            if(Key.isDown(49) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][120] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][120];
               if(_root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][140] != 0)
               {
                  this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][130]);
               }
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][130];
            }
            if(Key.isDown(50) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][121] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][121];
               if(_root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][140] != 0)
               {
                  this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][131]);
               }
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][131];
            }
            if(Key.isDown(51) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][122] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][122];
               this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][127]);
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][127];
            }
            if(Key.isDown(52) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][123] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][123];
               this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][128]);
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][128];
            }
            if(Key.isDown(53) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][124] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][124];
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][125];
               this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][125]);
            }
            if(Key.isDown(54) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][126] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][126];
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][129];
               this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][129]);
            }
            if(Key.isDown(55) && _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][143] != 0)
            {
               this["st" + krink].thing2.toolTip = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][143];
               this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][142];
               this["st" + krink].thing2.gotoAndStop(_root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][142]);
            }
         }
         if(_root.Krin.talentMainArray[krink] < _root.Krin.abilityXer[krink].TIER)
         {
            if(_root.Krin.abilityXer[krink].CLASSIFY == 1)
            {
               this["st" + krink].thing2.toolTip4 = _root.KrinLang[_root.KLangChoosen].SKILLTALENTTIP + this["st" + krink].guessLevel + "): " + _root.KrinLang[_root.KLangChoosen].BUFFSAY[_root.Krin.abilityXer[krink].BUFFNAME + _root.Krin.talentMainArray[krink]];
            }
            else
            {
               this["st" + krink].thing2.toolTip4 = _root.KrinLang[_root.KLangChoosen].SKILLTALENTTIP + this["st" + krink].guessLevel + "): " + _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + _root.Krin.talentMainArray[krink])][17];
            }
         }
         else
         {
            this["st" + krink].thing2.toolTip4 = _root.KrinLang[_root.KLangChoosen].SKILLTALENTTIP3;
         }
         this["st" + krink].thing2.toolTip3 = _root["KRINABILITYB" + (_root.Krin.abilityXer[krink].ID + bobJimJohn)][18];
         if(_root.Krin.abilityXer[krink].CLASSIFY == 1)
         {
            this["st" + krink].thing2.gotoAndStop(_root.Krin.abilityXer[krink].BUFFNAME);
            this["st" + krink].thing2.toolTipTitle = "(" + _root.Krin.talentMainArray[krink] + "/" + _root.Krin.abilityXer[krink].TIER + ")  " + _root.KrinLang[_root.KLangChoosen].BUFFSAY[_root.Krin.abilityXer[krink].BUFFNAME];
            this["st" + krink].thing2.toolTip = _root.KrinLang[_root.KLangChoosen].BUFFSAY[_root.Krin.abilityXer[krink].BUFFNAME + bobJimJohn];
            this["st" + krink].thing2.toolTip3 = _root.KrinLang[_root.KLangChoosen].SKILLAURA;
         }
         for(u in _root.elementMainArray)
         {
            if(_root.elementMainArray[u] == _root["KRINABILITYB" + _root.Krin.abilityXer[krink].ID][0])
            {
               this["st" + krink].thing2.KNcolor2 = _root.elementColorArray[u];
            }
         }
         if(_root.Krin.talentMainArray[krink] == 0)
         {
            this["st" + krink].thing2.bfilter._visible = true;
            this["st" + krink].thing2.bfilter._alpha = 80;
            this["st" + krink].thing2.toolTip = _root.KrinLang[_root.KLangChoosen].SKILLTALENTTIP2;
         }
         else
         {
            this["st" + krink].thing2.bfilter._visible = false;
         }
         for(krinRE in _root.Krin.abilityXer[krink].PRESKILL)
         {
            if(_root.Krin.abilityXer[krink].PRESKILL.length > 0)
            {
               if(_root.Krin.abilityXer[krink].PRESKILL[krinRE] != -1)
               {
                  lineMC.createEmptyMovieClip("line_mc" + thingerDepthK,thingerDepthK);
                  lineMC["line_mc" + thingerDepthK].lineStyle(6,0,100);
                  lineMC["line_mc" + thingerDepthK].moveTo(this["st" + krink]._x,this["st" + krink]._y);
                  lineMC["line_mc" + thingerDepthK].lineTo(this["st" + _root.Krin.abilityXer[krink].PRESKILL[krinRE]]._x,this["st" + _root.Krin.abilityXer[krink].PRESKILL[krinRE]]._y);
                  thingerDepthK++;
                  lineMC.createEmptyMovieClip("line_mc" + thingerDepthK,thingerDepthK);
                  if(_root.Krin.talentMainArray[_root.Krin.abilityXer[krink].PRESKILL[krinRE]] > 0)
                  {
                     lineMC["line_mc" + thingerDepthK].lineStyle(2,16763904,100);
                  }
                  else
                  {
                     lineMC["line_mc" + thingerDepthK].lineStyle(2,2829099,100);
                  }
                  lineMC["line_mc" + thingerDepthK].moveTo(this["st" + krink]._x,this["st" + krink]._y);
                  lineMC["line_mc" + thingerDepthK].lineTo(this["st" + _root.Krin.abilityXer[krink].PRESKILL[krinRE]]._x,this["st" + _root.Krin.abilityXer[krink].PRESKILL[krinRE]]._y);
                  thingerDepthK++;
               }
            }
         }
         krink++;
      }
   };
   krinRemakeTree();
   _parent.KrinCreateAbilityMatrix();
}
