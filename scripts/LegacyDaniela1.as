function krinChangeColor(target, colorType)
{
   if(colorType == "Poison")
   {
      var _loc3_ = new flash.geom.ColorTransform();
      var _loc4_ = new flash.geom.Transform(target);
      _loc3_.redOffset = 20;
      _loc3_.greenOffset = 130;
      _loc3_.blueOffset = -50;
      _loc4_.colorTransform = _loc3_;
   }
   if(colorType == "Normal")
   {
      var _loc5_ = new flash.geom.ColorTransform();
      var _loc6_ = new flash.geom.Transform(target);
      _loc5_.redOffset = 0;
      _loc5_.greenOffset = 0;
      _loc5_.blueOffset = 0;
      _loc6_.colorTransform = _loc5_;
   }
   if(colorType == "Hit")
   {
      var _loc7_ = new flash.geom.ColorTransform();
      var _loc8_ = new flash.geom.Transform(target);
      _loc7_.redOffset = 0;
      _loc7_.greenOffset = 0;
      _loc7_.blueOffset = 0;
      _loc8_.colorTransform = _loc7_;
   }
   if(colorType == "Common")
   {
      var _loc9_ = new flash.geom.ColorTransform();
      var _loc10_ = new flash.geom.Transform(target);
      _loc9_.redOffset = 0;
      _loc9_.greenOffset = 0;
      _loc9_.blueOffset = 0;
      _loc10_.colorTransform = _loc9_;
   }
   if(colorType == "Uncommon")
   {
      _loc9_ = new flash.geom.ColorTransform();
      _loc10_ = new flash.geom.Transform(target);
      _loc9_.redOffset = -62;
      _loc9_.greenOffset = -51;
      _loc9_.blueOffset = 0;
      _loc10_.colorTransform = _loc9_;
   }
   if(colorType == "Rare")
   {
      _loc9_ = new flash.geom.ColorTransform();
      _loc10_ = new flash.geom.Transform(target);
      _loc9_.redOffset = 86;
      _loc9_.greenOffset = 0;
      _loc9_.blueOffset = -164;
      _loc10_.colorTransform = _loc9_;
   }
   if(colorType == "Unique")
   {
      _loc9_ = new flash.geom.ColorTransform();
      _loc10_ = new flash.geom.Transform(target);
      _loc9_.redOffset = -67;
      _loc9_.greenOffset = 0;
      _loc9_.blueOffset = -159;
      _loc10_.colorTransform = _loc9_;
   }
   if(colorType == "Hit")
   {
      _loc7_ = new flash.geom.ColorTransform();
      _loc8_ = new flash.geom.Transform(target);
      _loc7_.redOffset = 0;
      _loc7_.greenOffset = 0;
      _loc7_.blueOffset = 0;
      _loc8_.colorTransform = _loc7_;
   }
}
function krinAddMove(playerID, targetID, moveID)
{
   adder = 3;
   _root[_root.CurrentMoveID + "MOVE"] = new Array();
   _root[_root.CurrentMoveID + "MOVE"][0] = _root["playerKrin" + playerID];
   _root[_root.CurrentMoveID + "MOVE"][1] = playerID;
   _root[_root.CurrentMoveID + "MOVE"][2] = targetID;
   _root[_root.CurrentMoveID + "MOVE"][3] = moveID;
   if(_root["playerKrin" + playerID].teamSide == _root.TeamMove)
   {
      if(_root.TeamMove == _root.TeamMoveNow && _root.autoMoveK == false)
      {
         adder = 0;
      }
      else
      {
         adder = 6;
      }
   }
   moveBox = adder + _root["playerKrin" + playerID].teamAdder;
   _root.MoveArrayFINAL[moveBox] = _root.CurrentMoveID;
   _root.CurrentMoveID += 1;
}
function krinMelee(shooter, hitter, attackColor, attackType, boomType, mAry2)
{
   shooter.boltx = shooter._x;
   shooter.bolty = shooter._y;
   shooter.SpeedConst = _root.krinBoltSpeed;
   shooter.targetMC = hitter;
   shooter.dir = 1;
   shooter.attacking = 0;
   shooter.moveNow = true;
   shooter.counter = 0;
   if(shooter._x < hitter._x)
   {
      shooter.endPoint = hitter._x - hitter._width / 2 - shooter._width / 2;
      shooter.faceing = 1;
   }
   else
   {
      shooter.endPoint = hitter._x + hitter._width / 2 + shooter._width / 2;
      shooter.faceing = -1;
   }
   shooter.slowPoint = shooter.endPoint - shooter._x;
   shooter.relX = 0;
   if(_root.KrinSettings.SFX)
   {
      _root.xPoint1 = hitter._x + hitter._width / 2;
      _root.yPoint1 = hitter._y + hitter._height / 2;
      _root.zoomPointX = _root.xPoint1 * (- _root.zoomRatioNEW) + 400;
      _root.zoomPointY = _root.yPoint1 * (- _root.zoomRatioNEW) + 300;
      _root.GridZoomer.gotoAndPlay("KrinZoomGo");
      _root.zoomPause = krinMeleeAttackCD * 2;
   }
   shooter.onEnterFrame = function()
   {
      if(this.moveNow == true)
      {
         if(this.attacking == 1)
         {
            this.counter += 1;
            if(this.counter == krinMeleeAttackCD)
            {
               if(mAry2 > 1)
               {
                  JI = 0;
                  while(JI < mAry2)
                  {
                     if(_root.strikeSuccessmultiple[JI] == true)
                     {
                        _root.BATTLESCREEN.attachMovie(boomType,"b1",-9);
                     }
                     JI++;
                  }
               }
               else if(_root.strikeSuccess)
               {
                  _root.BATTLESCREEN.attachMovie(boomType,"b1",-9);
               }
               _root.BAMBAMBAM = true;
               this._parent.b1._x = this.targetMC._x;
               this._parent.b1._y = this.targetMC._y;
               this.attacking = 2;
               this.counter = 0;
            }
         }
         if(this.attacking == 2)
         {
            this.counter += 1;
            if(this.counter == krinMeleeAttackEndCD)
            {
               this.attacking = 0;
               this.dir = -1;
               this.inner.gotoAndPlay("runback");
            }
         }
         yLength = this.targetMC._y - this._y;
         xLength = this.targetMC._x - this._x;
         this.goRat = this.relX / this.slowPoint;
         if(this.dir == 1)
         {
            this.spdXCoEFFER = 1.5 - 1.45 * this.goRat;
         }
         else
         {
            this.spdXCoEFFER = 1.45 * this.goRat;
         }
         if(this.spdXCoEFFER > 1)
         {
            this.spdXCoEFFER = 1;
         }
         this.xLPiece = (this.targetMC._x - this.boltx) / _root.krinBoltTime;
         this.yLPiece = (this.targetMC._y - this.bolty) / _root.krinBoltTime;
         this._x += this.spdXCoEFFER * this.xLPiece * _root.krinBodyMove * this.dir;
         this.relX += this.spdXCoEFFER * this.xLPiece * _root.krinBodyMove * this.dir;
         this._y += this.spdXCoEFFER * this.yLPiece * _root.krinBodyMove * this.dir;
         if(this.relX * this.faceing <= 0.000001 && this.dir == -1)
         {
            this._x = this.boltx;
            this._y = this.bolty;
            this.dir = 0;
            this.moveNow = false;
         }
         if(this.relX / this.slowPoint >= 1 && this.dir == 1)
         {
            if(this.attacking == 0)
            {
               this.attacking = 1;
               this.dir = 0;
               this.inner.gotoAndPlay("attack1");
               this.inner.colortobe = attackColor;
            }
         }
      }
   };
}
function krinBoltMake(shooter, hitter, tColorKrin, projectileModel, boomType, mAry2)
{
   _root.boltMakerCounter += 1;
   _root.BATTLESCREEN.attachMovie(projectileModel,"t" + _root.boltMakerCounter,600 + _root.boltMakerCounter);
   _root.BATTLESCREEN["t" + _root.boltMakerCounter]._x = shooter._x;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter]._y = shooter._y - 15;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].boltMakerCounter = _root.boltMakerCounter;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].boltx = _root.BATTLESCREEN["t" + _root.boltMakerCounter]._x;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].bolty = _root.BATTLESCREEN["t" + _root.boltMakerCounter]._y;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].SpeedConst = _root.krinBoltSpeed;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].RotA = true;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].tColorKrin = tColorKrin;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter]._alpha = 0;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].targetMC = hitter;
   if(shooter._x < hitter._x)
   {
      _root.BATTLESCREEN["t" + _root.boltMakerCounter].checker = 1;
   }
   else
   {
      _root.BATTLESCREEN["t" + _root.boltMakerCounter].checker = -1;
   }
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].onEnterFrame = function()
   {
      if(this._alpha < 100)
      {
         this._alpha += 10;
      }
      yLength = this.targetMC._y - this._y;
      xLength = this.targetMC._x - this._x;
      xLPiece = (this.targetMC._x - this.boltx) / _root.krinBoltTime;
      yLPiece = (this.targetMC._y - this.bolty) / _root.krinBoltTime;
      this._x += xLPiece * this.SpeedConst;
      this._y += yLPiece * this.SpeedConst;
      this.SpeedConst *= _root.krinBoltIncrease;
      if(this.RotA)
      {
         this.RotA = false;
         _root.BATTLESCREEN.attachMovie("KrinTrail","tt" + this.boltMakerCounter,500 + this.boltMakerCounter);
         var _loc3_ = new Color(this._parent["tt" + this.boltMakerCounter]);
         _loc3_.setRGB(this.tColorKrin);
         this._parent["tt" + this.boltMakerCounter]._x = this._x;
         this._parent["tt" + this.boltMakerCounter]._y = this._y;
         this._rotation = Math.atan(yLength / xLength) * 57.29577951308232;
         if(this._x > this.targetMC._x)
         {
            this._rotation += 180;
         }
         _root.BATTLESCREEN["tt" + this.boltMakerCounter]._rotation = this._rotation;
      }
      if((this.targetMC._x - this._x) * this.checker <= 0)
      {
         _root.BAMBAMBAM = true;
         if(mAry2 > 1)
         {
            JI = 0;
            while(JI < mAry2)
            {
               if(_root.strikeSuccessmultiple[JI] == true)
               {
                  _root.BATTLESCREEN.attachMovie(boomType,"bbb" + this.boltMakerCounter,400 + this.boltMakerCounter);
                  this._parent["bbb" + this.boltMakerCounter]._x = this.targetMC._x;
                  this._parent["bbb" + this.boltMakerCounter]._y = this.targetMC._y;
               }
               else
               {
                  _root.BATTLESCREEN["tt" + this.boltMakerCounter].inner._xscale += 8.3 * (Math.sqrt(Math.pow(xLPiece,2) + Math.pow(yLPiece,2)) * this.SpeedConst);
                  if(this._x > 500 || this._x < -500)
                  {
                     this.removeMovieClip();
                  }
               }
               JI++;
            }
            this.removeMovieClip();
         }
         else if(_root.strikeSuccess)
         {
            _root.BATTLESCREEN.attachMovie(boomType,"bbb" + this.boltMakerCounter,400 + this.boltMakerCounter);
            this._parent["bbb" + this.boltMakerCounter]._x = this.targetMC._x;
            this._parent["bbb" + this.boltMakerCounter]._y = this.targetMC._y;
            this.removeMovieClip();
         }
         else
         {
            _root.BATTLESCREEN["tt" + this.boltMakerCounter].inner._xscale += 8.3 * (Math.sqrt(Math.pow(xLPiece,2) + Math.pow(yLPiece,2)) * this.SpeedConst);
            if(this._x > 500 || this._x < -500)
            {
               this.removeMovieClip();
            }
         }
      }
      else
      {
         _root.BATTLESCREEN["tt" + this.boltMakerCounter].inner._xscale += 8.3 * (Math.sqrt(Math.pow(xLPiece,2) + Math.pow(yLPiece,2)) * this.SpeedConst);
      }
   };
}
function KRRR()
{
   _root.KRSO = _root.KRS[_root.KRSC];
   _root.KRSC += 1;
   if(_root.KRSC == 100)
   {
      _root.KRSC = 0;
   }
}
function executeMove(IDKM, IDKM2, IDKC, IDKT, JI, owegwe)
{
   AVGNUMC = 100 + 15 * IDKC.plevel;
   SPEEDCRITCALC = IDKC.SPEEDU / getStat(10,IDKC.plevel) - 1;
   PERCALK = IDKC.PERU[IDKM2[0]] / AVGNUMC;
   DEFCALK = IDKT.DEFU[IDKM2[0]] / AVGNUMC;
   if(DEFCALK <= 0)
   {
      DEFCALK = 0.1;
   }
   if(PERCALK <= 0)
   {
      PERCALK = 0.1;
   }
   CRITCALC_X = PERCALK / DEFCALK;
   if(CRITCALC_X > 10)
   {
      CRITCALC_X = 10;
   }
   PERCOEF = 1;
   _root.perKSuccess = false;
   focusCoEF = IDKM2[25] + IDKC.FOCUSN / 100 * IDKM2[11];
   if(IDKM[14] == "Full Damage")
   {
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKM2[9];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,DEFCALK,IDKM2);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 0.016666667 * Math.pow(CRITCALC_X + 1,4) - 0.25 * Math.pow(CRITCALC_X + 1,3) + 1.233333 * Math.pow(CRITCALC_X + 1,2) - 1.9000000000000001 * (CRITCALC_X + 1) + 1.9000000000000001;
         if(coEFKN6724 < 0)
         {
            coEFKN6724 = 0;
         }
      }
      else
      {
         if(CRITCALC_X <= 1)
         {
            coEFKN6724 = CRITCALC_X;
         }
         else
         {
            coEFKN6724 = 1 + 0.07 * (PERCALK - DEFCALK);
         }
         if(coEFKN6724 <= 0)
         {
            coEFKN6724 = 0.01;
         }
      }
      if(IDKM[0] == "Biscuitmaker")
      {
         _root.addSound("Effects","PCT10");
      }
      _root.DamageOutputKrinFinal = Math.ceil(IDKC.DMG + IDKT.IDMG + numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * (1 + IDKC.DMG2) * (1 + IDKT.IDMG2) * IDKT.IDMGP2);
      _root.DamageOutputKrinFinal2 = 0;
      IDKC.DPS = _root.DamageOutputKrinFinal;
      if(_root.DamageOutputKrinFinal <= 0 || _root.DamageOutputKrinFinal == NaN)
      {
         _root.DamageOutputKrinFinal = 1;
      }
      if(IDKM2[59] > 0)
      {
         _root.DamageOutputKrinFinal += IDKM2[59] * IDKT.LIFEN;
      }
      if(IDKM2[115] > 0)
      {
         _root.DamageOutputKrinFinal += IDKM2[115] * (IDKT.LIFEU - IDKT.LIFEN);
      }
      if(IDKC.playerName == "Sonny")
      {
         if(IDKM[0] == "Soul Grasp")
         {
            if(_root.playerKrin2.active == true && _root.playerKrin4.active == true && _root.playerKrin6.active == true)
            {
               _root.DamageOutputKrinFinal *= 0.25;
            }
            if(_root.playerKrin2.active == false && _root.playerKrin4.active == true && _root.playerKrin6.active == true || _root.playerKrin2.active == true && _root.playerKrin4.active == false && _root.playerKrin6.active == true || _root.playerKrin2.active == true && _root.playerKrin4.active == true && _root.playerKrin6.active == false)
            {
               _root.DamageOutputKrinFinal *= 0.5;
            }
         }
      }
      else if(IDKC.playerName != "Sonny")
      {
         if(IDKM[0] == "Soul Grasp")
         {
            if(_root.playerKrin1.active == true && _root.playerKrin3.active == true && _root.playerKrin5.active == true)
            {
               _root.DamageOutputKrinFinal *= 0.25;
            }
            if(_root.playerKrin1.active == false && _root.playerKrin3.active == true && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == false && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == true && _root.playerKrin5.active == false)
            {
               _root.DamageOutputKrinFinal *= 0.5;
            }
         }
      }
      differenceForSH = 0;
      if(IDKT.SHIELD > 0)
      {
         differenceForSH = IDKT.SHIELD - _root.DamageOutputKrinFinal;
      }
      if(differenceForSH > 0)
      {
         IDKT.SHIELD -= _root.DamageOutputKrinFinal;
         _root.BATTLESCREEN["player" + IDKT.playerID].shield.play();
         _root.addSound("Effects","Forcefield");
         _root.KrinNumberShow("shield","player" + IDKT.playerID,IDKM2[0]);
      }
      else
      {
         if(IDKT.SHIE == 0.31)
         {
            IDKT.FOCUSN += 30;
         }
         if(IDKT.SHIE == 0.07)
         {
            IDKT.FOCUSN -= 900;
         }
         if(IDKT.SHIE == 0.05)
         {
            IDKT.FOCUSN += 900;
         }
         _root.DamageOutputKrinFinal -= IDKT.SHIELD;
         MULTI = 0;
         while(MULTI < IDKM2[45])
         {
            if(!(IDKM2[45] == 2 && MULTI == 1))
            {
               _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,IDKM2[0]);
            }
            MULTI++;
         }
         IDKT.SHIELD = 0;
         if(IDKT.SSWITCH == 0)
         {
            if(IDKC.playerID == _root.Krin.playerNumber)
            {
               if(IDKT.IDMG < 500)
               {
                  var _loc8_ = IDKM2[0];
                  var _loc9_ = _root.DamageOutputKrinFinal;
                  var _loc10_ = _loc8_ == elementMainArray[0];
                  if(_loc10_)
                  {
                     _root.updateTopPhysicalDamage(_loc9_);
                  }
                  else
                  {
                     _root.updateTopElementalDamage(_loc9_);
                  }
               }
            }
            MULTI = 0;
            while(MULTI < IDKM2[45])
            {
               if(!(IDKM2[45] == 2 && MULTI == 1))
               {
                  _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,IDKM2[0]);
               }
               MULTI++;
            }
            IDKT.LIFEN -= _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN <= 0 && IDKT.FOCUSU != 101 && IDKT.LIVINGDEAD10 != 1)
            {
               IDKT.LIFEN = 0;
               IDKT.FOCUSN = 0;
            }
            if(IDKC.playerName == "Sonny")
            {
               AchVal1 += _root.DamageOutputKrinFinal;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("hit");
            if(IDKT.STUN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("hit");
            }
            if(IDKT.LIFEN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("dead");
               IDKT.active = false;
               BUFFS = 0;
               while(BUFFS < _root.maxBuffLimit)
               {
                  if(_root["KRINBUFF" + IDKT.BUFFARRAYK[BUFFS].buffId][173] != 0 && IDKT.BUFFARRAYK[BUFFS].CD != 0)
                  {
                     G = 0;
                     while(G < 3)
                     {
                        if(_root["playerKrin" + (IDKT.teamSide + G * 2)].active == true)
                        {
                           _root.applyBuffKrin(_root["playerKrin" + (IDKT.teamSide + G * 2)],_root["KRINBUFF" + IDKT.BUFFARRAYK[BUFFS].buffId][173],1,IDKC);
                           _root.applyChangesKrin(_root["playerKrin" + (IDKT.teamSide + G * 2)]);
                        }
                        G++;
                     }
                  }
                  BUFFS++;
               }
               wefvergrervw = 1;
               while(wefvergrervw < 7)
               {
                  if(!_root.arenaMode)
                  {
                     if(IDKT.playerID == _root.Krin.playerNumber)
                     {
                        _root["KrinSelector" + wefvergrervw]._x = -300;
                        _root["KrinSelector" + wefvergrervw]._y = -300;
                     }
                     if(_root["KrinSelector" + wefvergrervw].TargetEr == IDKT.playerID)
                     {
                        _root["KrinSelector" + wefvergrervw]._x = -300;
                        _root["KrinSelector" + wefvergrervw]._y = -300;
                     }
                  }
                  wefvergrervw++;
               }
               _root.krinAddMove(IDKT.playerID,IDKT.playerID,0);
            }
            else
            {
               addSound("Effects",IDKT.voiceHit[random(3)]);
            }
         }
         else
         {
            if(_root.DamageOutputKrinFinal != NaN)
            {
               _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"HEAL");
               IDKT.LIFEN += _root.DamageOutputKrinFinal;
            }
            if(IDKT.LIFEN > IDKT.LIFEU)
            {
               IDKT.LIFEN = IDKT.LIFEU;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("heal");
         }
         _root.lifeBarUpdate(IDKT.playerID);
      }
   }
   if(IDKM[14] == "Heal")
   {
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKC.LIFEU * IDKM2[12] + IDKM2[9];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,1,IDKM2);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 1.5;
         if(IDKC.playerName == "Felicity")
         {
            _root.addSound("Effects","crit_felicity3");
         }
         if(IDKC.playerName == "Vendara")
         {
            _root.addSound("Effects","VO_Vendara_Crit02");
         }
      }
      else
      {
         coEFKN6724 = 1;
      }
      _root.DamageOutputKrinFinal = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      _root.DamageOutputKrinFinal2 = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      IDKC.DPS = 1;
      if(_root.DamageOutputKrinFinal <= 0)
      {
         _root.DamageOutputKrinFinal = 0;
      }
      if(_root.DamageOutputKrinFinal > 0)
      {
         if(IDKT.SSWITCH == 0)
         {
            _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"HEAL");
            IDKT.LIFEN += _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN > IDKT.LIFEU)
            {
               IDKT.LIFEN = IDKT.LIFEU;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("heal");
            _root.lifeBarUpdate(IDKT.playerID);
         }
         else
         {
            _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"Shadow");
            IDKT.LIFEN -= _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN <= 0)
            {
               IDKT.LIFEN = 0;
               IDKT.FOCUSN = 0;
            }
            _root.lifeBarUpdate(IDKT.playerID);
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("hit");
            if(IDKT.STUN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("hit");
            }
            if(IDKT.LIFEN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("dead");
               IDKT.active = false;
               wefvergrervw = 1;
               while(wefvergrervw < 7)
               {
                  if(IDKT.playerID == _root.Krin.playerNumber)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
                  if(_root["KrinSelector" + wefvergrervw].TargetEr == IDKT.playerID)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
                  wefvergrervw++;
               }
               _root.krinAddMove(IDKT.playerID,IDKT.playerID,0);
            }
         }
      }
   }
   if(IDKM[14] == "Focus")
   {
      IDKT.FOCUSN += IDKM2[9];
      if(IDKT.FOCUSN > IDKT.FOCUSU)
      {
         IDKT.FOCUSN = IDKT.FOCUSU;
      }
      if(IDKT.FOCUSN < 0)
      {
         IDKT.FOCUSN = 0;
      }
      IDKC.DPS = 1;
      _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
      _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
      _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
      _root.BATTLEFLASH.DFTP = IDKT;
      _root.BATTLEFLASH.gotoAndPlay("heal");
      _root.lifeBarUpdate(IDKT.playerID);
   }
   if(IDKM[14] == "Focus3")
   {
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKC.LIFEU * IDKM2[12] + IDKM2[9];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,1,IDKM2);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 1.5;
         if(IDKC.playerName == "Felicity")
         {
            _root.addSound("Effects","crit_felicity3");
         }
         if(IDKC.playerName == "Vendara")
         {
            _root.addSound("Effects","VO_Vendara_Crit02");
         }
      }
      else
      {
         coEFKN6724 = 1;
      }
      _root.DamageOutputKrinFinal = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      _root.DamageOutputKrinFinal2 = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      IDKC.DPS = 1;
      if(_root.DamageOutputKrinFinal <= 0)
      {
         _root.DamageOutputKrinFinal = 0;
      }
      if(_root.DamageOutputKrinFinal > 0)
      {
         if(IDKT.SSWITCH == 0)
         {
            _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"HEAL");
            IDKT.LIFEN += _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN > IDKT.LIFEU)
            {
               IDKT.LIFEN = IDKT.LIFEU;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("heal");
            _root.lifeBarUpdate(IDKT.playerID);
         }
         else
         {
            _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"Shadow");
            IDKT.LIFEN -= _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN <= 0)
            {
               IDKT.LIFEN = 0;
               IDKT.FOCUSN = 0;
            }
            _root.lifeBarUpdate(IDKT.playerID);
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("hit");
            if(IDKT.STUN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("hit");
            }
            if(IDKT.LIFEN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("dead");
               IDKT.active = false;
               wefvergrervw = 1;
               while(wefvergrervw < 7)
               {
                  if(IDKT.playerID == _root.Krin.playerNumber)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
                  if(_root["KrinSelector" + wefvergrervw].TargetEr == IDKT.playerID)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
                  wefvergrervw++;
               }
               _root.krinAddMove(IDKT.playerID,IDKT.playerID,0);
            }
         }
      }
      IDKT.FOCUSN += IDKM2[9];
      if(IDKT.FOCUSN > IDKT.FOCUSU)
      {
         IDKT.FOCUSN = IDKT.FOCUSU;
      }
      if(IDKT.FOCUSN < 0)
      {
         IDKT.FOCUSN = 0;
      }
      _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
      _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
      _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
      _root.BATTLEFLASH.DFTP = IDKT;
      _root.BATTLEFLASH.gotoAndPlay("focus");
      _root.lifeBarUpdate(IDKT.playerID);
   }
   if(IDKM[14] == "Focus2")
   {
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKM2[9];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,DEFCALK,IDKM2);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 0.016666667 * Math.pow(CRITCALC_X + 1,4) - 0.25 * Math.pow(CRITCALC_X + 1,3) + 1.233333 * Math.pow(CRITCALC_X + 1,2) - 1.9000000000000001 * (CRITCALC_X + 1) + 1.9000000000000001;
         if(coEFKN6724 < 0)
         {
            coEFKN6724 = 0;
         }
         if(IDKC.playerName == "Veradux")
         {
            _root.addSound("Effects","Angry_Dux");
         }
         if(IDKC.playerName == "Roald")
         {
            _root.addSound("Effects","Angry_Roald");
         }
         if(IDKC.playerName == "Felicity")
         {
            _root.addSound("Effects","crit_felicity2");
         }
         if(IDKC.playerName == "Vendara")
         {
            _root.addSound("Effects","VO_Vendara_Crit01");
         }
      }
      else
      {
         if(CRITCALC_X <= 1)
         {
            coEFKN6724 = CRITCALC_X;
         }
         else
         {
            coEFKN6724 = 1 + 0.07 * (PERCALK - DEFCALK);
         }
         if(coEFKN6724 <= 0)
         {
            coEFKN6724 = 0.01;
         }
      }
      _root.DamageOutputKrinFinal = Math.ceil(IDKC.DMG + IDKT.IDMG + numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * (1 + IDKC.DMG2) * (1 + IDKT.IDMG2) * IDKT.IDMGP2);
      IDKC.DPS = _root.DamageOutputKrinFinal;
      if(_root.DamageOutputKrinFinal <= 0 || _root.DamageOutputKrinFinal == NaN)
      {
         _root.DamageOutputKrinFinal = 1;
      }
      differenceForSH = 0;
      if(IDKT.SHIELD > 0)
      {
         differenceForSH = IDKT.SHIELD - _root.DamageOutputKrinFinal;
      }
      if(differenceForSH > 0)
      {
         IDKT.SHIELD -= _root.DamageOutputKrinFinal;
         _root.BATTLESCREEN["player" + IDKT.playerID].shield.play();
         _root.addSound("Effects","sfx_shield");
         _root.KrinNumberShow("shield","player" + IDKT.playerID,IDKM2[0]);
      }
      else
      {
         _root.DamageOutputKrinFinal -= IDKT.SHIELD;
         _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,IDKM2[0]);
         IDKT.SHIELD = 0;
         if(IDKT.SSWITCH == 0)
         {
            _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,IDKM2[0]);
            IDKT.LIFEN -= _root.DamageOutputKrinFinal;
            if(IDKT.LIFEN <= 0)
            {
               IDKT.LIFEN = 0;
               IDKT.FOCUSN = 0;
            }
            if(IDKC.playerName == "Sonny")
            {
               AchVal1 += _root.DamageOutputKrinFinal;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("hit");
            if(IDKT.STUN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("hit");
            }
            if(IDKT.LIFEN == 0)
            {
               _root.BATTLESCREEN["player" + IDKT.playerID].inner.gotoAndPlay("dead");
               IDKT.active = false;
               wefvergrervw = 1;
               while(wefvergrervw < 7)
               {
                  if(!_root.arenaMode)
                  {
                     if(IDKT.playerID == _root.Krin.playerNumber)
                     {
                        _root["KrinSelector" + wefvergrervw]._x = -300;
                        _root["KrinSelector" + wefvergrervw]._y = -300;
                     }
                     if(_root["KrinSelector" + wefvergrervw].TargetEr == IDKT.playerID)
                     {
                        _root["KrinSelector" + wefvergrervw]._x = -300;
                        _root["KrinSelector" + wefvergrervw]._y = -300;
                     }
                  }
                  wefvergrervw++;
               }
               _root.krinAddMove(IDKT.playerID,IDKT.playerID,0);
            }
            else
            {
               addSound("Effects",IDKT.voiceHit[random(3)]);
            }
         }
         else
         {
            if(_root.DamageOutputKrinFinal != NaN)
            {
               _root.KrinNumberShow(_root.DamageOutputKrinFinal,"player" + IDKT.playerID,"HEAL");
               IDKT.LIFEN += _root.DamageOutputKrinFinal;
            }
            if(IDKT.LIFEN > IDKT.LIFEU)
            {
               IDKT.LIFEN = IDKT.LIFEU;
            }
            _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
            _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
            _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
            _root.BATTLEFLASH.DFTP = IDKT;
            _root.BATTLEFLASH.gotoAndPlay("heal");
         }
         _root.lifeBarUpdate(IDKT.playerID);
      }
      IDKT.FOCUSN += IDKM2[9];
      if(IDKT.FOCUSN > IDKT.FOCUSU)
      {
         IDKT.FOCUSN = IDKT.FOCUSU;
      }
      if(IDKT.FOCUSN < 0)
      {
         IDKT.FOCUSN = 0;
      }
      _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
      _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
      _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
      _root.BATTLEFLASH.DFTP = IDKT;
      _root.BATTLEFLASH.gotoAndPlay("focus");
      _root.lifeBarUpdate(IDKT.playerID);
   }
}
function perScript(PERCALKK, DEFCALKK, GGG)
{
   _root.KRRR();
   if(SPEEDCRITCALC < 0)
   {
      SPEEDCRITCALC = 0;
   }
   if(_root.KRSO < (PERCALKK + GGG[7]) * GGG[8] / DEFCALKK * 15)
   {
      _root.perKSuccess = true;
   }
   else
   {
      _root.perKSuccess = false;
   }
}
function addNewBuffKrin(a, b, c)
{
   _root["KRINBUFF" + a] = new Array();
   _root["KRINBUFF" + a][0] = b;
   _root["KRINBUFF" + a][1] = c;
   i = 2;
   while(i < 189)
   {
      _root["KRINBUFF" + a][i] = 0;
      i++;
   }
   _root.hackMove2 = _root["KRINBUFF" + a];
}
function checkDispellAoe(mCaster, mTarget, mAry1, mAry2)
{
   dispelCounterXYUX = mAry2[16];
   eged = 0;
   while(eged < _root.maxBuffLimit)
   {
      for(neinh in mAry2[15])
      {
         if(mTarget.BUFFARRAYK[eged].CD > 0 && mAry2[15][neinh] == _root["KRINBUFF" + mTarget.BUFFARRAYK[eged].buffId][1])
         {
            if(dispelCounterXYUX > 0)
            {
               if(mAry2[19] == _root["KRINBUFF" + mTarget.BUFFARRAYK[eged].buffId][20])
               {
                  dispelCounterXYUX--;
                  numberRandomerBuffHit = Math.random();
                  if(numberRandomerBuffHit <= mAry2[22])
                  {
                     numberRandomerBuffHit = Math.random();
                     if(numberRandomerBuffHit >= _root["KRINBUFF" + mTarget.BUFFARRAYK[eged].buffId][32])
                     {
                        mTarget.BUFFARRAYK[eged].CD = 0;
                        _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[eged].buffId,-1,0,mTarget.BUFFARRAYK[eged].buffValue,eged);
                     }
                  }
               }
            }
         }
      }
      eged++;
   }
}
function ModifyHP(Damage, element, ignoreDefense, mCaster, mTarget)
{
   num2 = 0;
   num = 0;
   num3 = 0;
   if(Damage > 0)
   {
      num = ignoreDefense * (100 + mTarget.plevel * 5) / (mTarget.DEFU[element] * mTarget.DEFENSE);
      if(num == 0)
      {
         num = 1;
      }
      num2 = Damage * num;
      num3 = Math.ceil(mTarget.IDMG + num2 * (1 + mTarget.IDMG2) * mTarget.IDMGP2);
   }
   else
   {
      num3 = Math.ceil(Damage * mTarget.HEALMOD_PLUS * mTarget.HEALMOD_MINUS);
   }
   if(mTarget.SSWITCH == 1)
   {
      num3 *= -1;
   }
   if(num3 > 0)
   {
      differenceForSH = 0;
      if(mTarget.SHIELD > 0)
      {
         differenceForSH = mTarget.SHIELD - num3;
      }
      if(differenceForSH > 0)
      {
         mTarget.SHIELD -= num3;
         _root.BATTLESCREEN["player" + mTarget.playerID].shield.play();
         _root.addSound("Effects","sfx_shield");
         _root.KrinNumberShow("shield","player" + mTarget.playerID,element);
      }
      else
      {
         num3 -= mTarget.SHIELD;
         _root.KrinNumberShow(num3,"player" + mTarget.playerID,element);
         mTarget.SHIELD = 0;
         mTarget.LIFEN -= num3;
         if(mTarget.LIFEN <= 0)
         {
            mTarget.LIFEN = 0;
            mTarget.FOCUSN = 0;
         }
         if(mTarget.LIFEN < 0 && (mTarget.FOCUSU == 101 || mTarget.LIVINGDEAD10 == 1))
         {
            mTarget.LIFEN = 0;
            mTarget.FOCUSN = 0;
            _root.BATTLESCREEN["player" + mTarget.playerID].inner.gotoAndPlay("stun");
            _root.krinAddMove(mTarget.playerID,mTarget.playerID,0);
            Stun = 1;
         }
         if(mTarget.LIFEN > 0 && (mTarget.FOCUSU == 101 || mTarget.LIVINGDEAD10 == 1) && Stun == 1)
         {
            _root.BATTLESCREEN["player" + mTarget.playerID].inner.gotoAndPlay("outofstun");
            _root.krinAddMove(mTarget.playerID,mTarget.playerID,0);
            Stun = 0;
         }
         if(mTarget.LIFEN == 0 && mTarget.FOCUSU != 101 && mTarget.LIVINGDEAD10 != 1)
         {
            _root.BATTLESCREEN["player" + mTarget.playerID].inner.gotoAndPlay("dead");
            mTarget.active = false;
            wefvergrervw = 1;
            while(wefvergrervw < 7)
            {
               if(!_root.arenaMode)
               {
                  if(mTarget.playerID == _root.Krin.playerNumber)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
                  if(_root["KrinSelector" + wefvergrervw].TargetEr == mTarget.playerID)
                  {
                     _root["KrinSelector" + wefvergrervw]._x = -300;
                     _root["KrinSelector" + wefvergrervw]._y = -300;
                  }
               }
               wefvergrervw++;
            }
            _root.krinAddMove(mTarget.playerID,mTarget.playerID,0);
         }
         _root.lifeBarUpdate(mTarget.playerID);
      }
   }
   if(num3 < 0)
   {
      num3 *= -1;
      _root.KrinNumberShow(num3,"player" + mTarget.playerID,"HEAL");
      mTarget.LIFEN += num3;
      if(mTarget.LIFEN > mTarget.LIFEU)
      {
         mTarget.LIFEN = mTarget.LIFEU;
      }
      _root.lifeBarUpdate(mTarget.playerID);
   }
}
function applyBuffKrin(ukcb2, bn, iftbc, ukcb4, debuffValue, limo)
{
   bffker = _root["KRINBUFF" + bn];
   ukcb2.STUN += iftbc * bffker[17];
   ukcb2.SHIE += iftbc * bffker[41];
   ukcb2.REFLECT += iftbc * bffker[18];
   ukcb2.HEALMOD_PLUS += iftbc * bffker[35];
   ukcb2.HEALMOD_MINUS -= iftbc * bffker[36];
   ukcb2.HEALMOD += iftbc * bffker[37];
   ukcb2.IDOT += iftbc * bffker[46];
   ukcb2.IHOT += iftbc * bffker[47];
   ukcb2.ODOT += iftbc * bffker[48];
   ukcb2.FOCUSPLUS += iftbc * bffker[84];
   ukcb2.FOCUSCHANGE += iftbc * bffker[49];
   ukcb2.SILENCED += iftbc * bffker[50];
   ukcb2.FURY += iftbc * bffker[68];
   ukcb2.HIT += iftbc * bffker[77];
   ukcb2.DODGE += iftbc * bffker[131];
   ukcb2.CRIT += iftbc * bffker[86];
   ukcb2.STUNRESIST += iftbc * bffker[80];
   ukcb2.TENCHIJIN += iftbc * bffker[177];
   ukcb2.BLOODYFURY += iftbc * bffker[128];
   ukcb2.CRITMODIFIER += iftbc * bffker[134];
   ukcb2.SLOWRESIST += iftbc * bffker[80];
   ukcb2.IGNORE += iftbc * bffker[81];
   ukcb2.DEFENSE += iftbc * bffker[82];
   ukcb2.LIVINGDEAD += iftbc * bffker[145];
   ukcb2.LIVINGDEAD10 += iftbc * bffker[164];
   ukcb2.FLAMED += iftbc * bffker[151];
   ukcb2.FLAMED2 += iftbc * bffker[152];
   ukcb2.ELECTROPE2 += iftbc * bffker[181];
   ukcb2.CALORIC += iftbc * bffker[187];
   if(iftbc < 0 && bffker[187] != 0)
   {
      ukcb2.CALORIC = 0;
   }
   if(iftbc < 0 && bffker[140] != 0)
   {
      ukcb2.AINEXTATTACK = 0;
   }
   if(iftbc > 0 && bffker[140] != 0)
   {
      ukcb2.AINEXTATTACK = bffker[140];
   }
   if(iftbc < 0 && bffker[165] != 0)
   {
      ukcb2.CONDITION = 0;
   }
   if(iftbc > 0 && bffker[165] != 0)
   {
      ukcb2.CONDITION = bffker[165];
   }
   if(iftbc < 0 && bffker[166] != 0)
   {
      ukcb2.CONDITION2 = 0;
   }
   if(iftbc > 0 && bffker[166] != 0)
   {
      ukcb2.CONDITION2 = bffker[166];
   }
   if(iftbc < 0 && bffker[174] != 0)
   {
      ukcb2.CONDITION3 = 0;
   }
   if(iftbc > 0 && bffker[174] != 0)
   {
      ukcb2.CONDITION3 = bffker[174];
   }
   if(iftbc < 0 && bffker[179] != 0)
   {
      ukcb2.CONDITION4 = 0;
   }
   if(iftbc > 0 && bffker[179] != 0)
   {
      ukcb2.CONDITION4 = bffker[179];
   }
   if(iftbc < 0 && bffker[180] != 0)
   {
      ukcb2.CONDITION5 = 0;
   }
   if(iftbc > 0 && bffker[180] != 0)
   {
      ukcb2.CONDITION5 = bffker[180];
   }
   if(iftbc > 0)
   {
      ukcb2.STANCE += iftbc * bffker[142];
   }
   if(ukcb2.STANCE > ukcb2.STANCEMAX)
   {
      ukcb2.STANCE = ukcb2.STANCEMAX;
   }
   if(bffker[90] != 0)
   {
      ukcb2.STRENGTHN = ukcb2.STRENGTH * iftbc * bffker[90];
   }
   if(bffker[91] != 0)
   {
      ukcb2.MAGICN = ukcb2.MAGIC * iftbc * bffker[91];
   }
   if(bffker[92] != 0)
   {
      ukcb2.SPEEDN = ukcb2.SPEED * iftbc * bffker[92];
   }
   ukcb2.START = bffker[79];
   ukcb2.FILTERSBUFFARRAY[bffker[31]] += iftbc;
   appliedBuff = false;
   if(iftbc == 1)
   {
      i = 0;
      while(i < _root.maxBuffLimit)
      {
         if(appliedBuff == false && ukcb2.BUFFARRAYK[i].CD == 0)
         {
            ukcb2.BUFFARRAYK[i].CD = bffker[16];
            ukcb2.BUFFARRAYK[i].CD2 = bffker[78];
            ukcb2.BUFFARRAYK[i].buffId = bn;
            theLfactor = i;
            appliedBuff = true;
         }
         i++;
      }
   }
   else
   {
      theLfactor = limo;
   }
   ukcb2.SSWITCH += iftbc * bffker[26];
   s = 0;
   while(s < 12)
   {
      if(s == 11)
      {
         if(bffker[s + 2] > 0)
         {
            ukcb2.changeArray[s] += iftbc * bffker[s + 2];
         }
         if(bffker[s + 2] < 0)
         {
            ukcb2.IDMGP -= iftbc * bffker[s + 2];
         }
      }
      else
      {
         ukcb2.changeArray[s] += iftbc * bffker[s + 2];
      }
      s++;
   }
   if(bffker[150] > 0)
   {
      if(ukcb2.STRENGTHU > ukcb2.MAGICU)
      {
         ukcb2.changeArray[1] += iftbc * bffker[150];
      }
      if(ukcb2.STRENGTHU < ukcb2.MAGICU)
      {
         ukcb2.changeArray[3] += iftbc * bffker[150];
      }
   }
   if(iftbc == 1)
   {
      numberShieldFind = bffker[19] + ukcb4.STRENGTHU * bffker[38] + ukcb4.MAGICU * bffker[39] + ukcb4.SPEEDU * bffker[40] + ukcb4.LIFEU * bffker[41];
      if(numberShieldFind <= 0)
      {
         numberShieldFind = 0;
      }
      ukcb2.BUFFARRAYK[theLfactor].shieldBuffValue = numberShieldFind;
   }
   else
   {
      numberShieldFind = ukcb2.BUFFARRAYK[theLfactor].shieldBuffValue;
   }
   if(iftbc == 1)
   {
      ukcb2.SHIELD += numberShieldFind;
   }
   else
   {
      shieldVoid = ukcb2.SHIELDCOUNTER - ukcb2.SHIELD;
      if(shieldVoid < numberShieldFind)
      {
         ukcb2.SHIELD -= numberShieldFind - shieldVoid;
      }
   }
   ukcb2.SHIELDCOUNTER += iftbc * numberShieldFind;
   if(ukcb2.SHIELDCOUNTER <= 0)
   {
      ukcb2.SHIELDCOUNTER = 0;
      ukcb2.SHIELD = 0;
   }
   if(bffker[15] > 0)
   {
      SLOWMOD = Math.min(1,Math.max(0,1 - ukcb2.SLOWRESIST));
   }
   else
   {
      SLOWMOD = 1;
   }
   ukcb2.DOTTICKERARRAY[9] += iftbc * Math.round(bffker[15] * SLOWMOD);
   i = 0;
   while(i < 8)
   {
      if(elementMainArray[i] == bffker[1])
      {
         ukcb2.changeArrayEP[i] += iftbc * bffker[21];
         ukcb2.changeArrayEP2[i] += iftbc * bffker[23];
         ukcb2.changeArrayED[i] += iftbc * bffker[22];
         ukcb2.changeArrayED2[i] += iftbc * bffker[24];
         if(iftbc == 1)
         {
            ukcb2.BUFFARRAYK[theLfactor].buffValue = 0;
            ukcb2.BUFFARRAYK[theLfactor].buffValue += Math.ceil(ukcb4.ODOT * (bffker[14] + bffker[28] * ukcb4.STRENGTHU + bffker[29] * ukcb4.MAGICU + bffker[30] * ukcb4.SPEEDU + bffker[33] * ukcb4.LIFEU + bffker[42] * ukcb2.STRENGTHU + bffker[43] * ukcb2.MAGICU + bffker[44] * ukcb2.SPEEDU + bffker[45] * ukcb2.LIFEU));
            changerUEOIHN = ukcb2.BUFFARRAYK[theLfactor].buffValue;
         }
         else
         {
            changerUEOIHN = - debuffValue;
         }
         gHecker = iftbc * changerUEOIHN;
         if(gHecker < 0)
         {
            ukcb2.DOTTICKERARRAY[8] += changerUEOIHN;
         }
         else
         {
            ukcb2.DOTTICKERARRAY[i] += changerUEOIHN;
         }
      }
      i++;
   }
}
function checkStatus(mCaster, mTarget, mAry2, mAry1, owegwe)
{
   if(mAry1[10] == "Melee" || mAry1[10] == "Melee2")
   {
      x = 0;
      while(x < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][127] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            BLEED2 = 15;
            differenceForSH = 0;
            if(BLEED2 > 0)
            {
               mTarget.BLEED -= BLEED2;
            }
            DMGBYFIRE = Math.ceil(mCaster.DMG + mTarget.IDMG + mCaster.DEFU.Fire * mAry2[77] * mTarget.DEFENSE + _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][127] * mCaster.STRENGTHU * (1 + mCaster.DMG2) * (1 + mTarget.IDMG2) * mTarget.IDMGP2);
            mTarget.LIFEN -= DMGBYFIRE;
            _root.KrinNumberShow(DMGBYFIRE,"player" + mTarget.playerID,"Fire");
            _root.lifeBarUpdate(mTarget.playerID);
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][143] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][143] * mTarget.LIFEU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],0,mTarget,mTarget);
         }
         x++;
      }
   }
   if(mAry2[104] != 0)
   {
      if(mAry2[20] == 1 && owegwe == 0 || mAry2[20] == 0)
      {
         mCaster.PALETTEGAUGE += mAry2[104];
      }
      if(mCaster.PALETTEGAUGE >= mCaster.PALETTEGAUGEMAX)
      {
         mCaster.PALETTEGAUGE = mCaster.PALETTEGAUGEMAX;
         _root.addSound("Effects","PCT1");
      }
   }
   if(mAry2[113] != 0 || mAry2[114] != 0)
   {
      if(mAry2[20] == 1 && owegwe == 0 || mAry2[20] == 0)
      {
         mCaster.BMANA += mAry2[113];
         mCaster.WMANA += mAry2[114];
      }
      if(mCaster.BMANA >= mCaster.BMANAMAX)
      {
         mCaster.BMANA = mCaster.BMANAMAX;
         _root.addSound("Effects","PCT1");
      }
      if(mCaster.WMANA >= mCaster.WMANAMAX)
      {
         mCaster.WMANA = mCaster.WMANAMAX;
         _root.addSound("Effects","PCT1");
      }
   }
   if((mAry1[14] == "Full Damage" || mAry1[14] == "Focus2") && mTarget.STANCE > 0 && mTarget.STUN == 0)
   {
      POISEDAMAGE = _root.DamageOutputKrinFinal / mTarget.LIFEU;
      if(POISEDAMAGE >= 0.1)
      {
         mTarget.STANCE -= 20;
      }
      if(POISEDAMAGE >= 0.05 && POISEDAMAGE < 0.1)
      {
         mTarget.STANCE -= 10;
      }
      if(POISEDAMAGE <= 0.05)
      {
         mTarget.STANCE -= 5;
      }
      if(mTarget.STANCE <= 0)
      {
         x = 0;
         while(x < _root.maxBuffLimit)
         {
            if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][142] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
            {
               mTarget.BUFFARRAYK[x].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
            }
            x++;
         }
         _root.applyBuffKrin(mTarget,"BROKENSTANCE",1,mCaster);
         _root.applyChangesKrin(mTarget);
         mTarget.STANCE = mTarget.STANCEMAX;
         _root.addSound("Effects","Theme3");
      }
   }
   if(mAry1[10] != "Melee" && mAry1[10] != "Melee2" && mAry1[14] != "Heal")
   {
      x = 0;
      while(x < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][133] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            BLEED2 = 15;
            if(BLEED2 > 0)
            {
               mTarget.BLEED -= BLEED2;
            }
            DMGBYFIRE = Math.ceil(mCaster.DMG + mTarget.IDMG + mCaster.DEFU.Fire * mAry2[77] * mTarget.DEFENSE + _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][133] * mCaster.MAGICU * (1 + mCaster.DMG2) * (1 + mTarget.IDMG2) * mTarget.IDMGP2);
            mTarget.LIFEN -= DMGBYFIRE;
            _root.KrinNumberShow(DMGBYFIRE,"player" + mTarget.playerID,"Fire");
            _root.lifeBarUpdate(mTarget.playerID);
         }
         x++;
      }
   }
   if(mAry1[14] != "Heal" && mAry1[14] != "Focus" && mAry1[14] != "Focus3")
   {
      x = 0;
      while(x < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][119] > 0 && mAry2[0] == "Physical" && mCaster.BUFFARRAYK[x].CD != 0)
         {
            BLEED2 = _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][119];
         }
         else
         {
            BLEED2 = 0;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][120] > 0 && mAry2[0] == "Ice" && mCaster.BUFFARRAYK[x].CD != 0)
         {
            FROSTBITTEN2 = _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][120];
         }
         else
         {
            FROSTBITTEN2 = 0;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][121] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            BLEED2 = 0;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][122] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            FROSTBITTEN2 = 0;
         }
         differenceForSH = 0;
         if(BLEED2 > 0)
         {
            mTarget.BLEED -= BLEED2;
         }
         if(FROSTBITTEN2 > 0)
         {
            mTarget.FROSTBITTEN -= FROSTBITTEN2;
            if(mTarget.FROSTBITTEN <= 0)
            {
               _root.DMGFROST = mTarget.LIFEU * 0.07;
               if(mTarget.SHIELD > 0)
               {
                  differenceForSH = mTarget.SHIELD - _root.DMGFROST;
               }
               if(differenceForSH > 0)
               {
                  mTarget.SHIELD -= _root.DMGFROST;
                  _root.BATTLESCREEN["player" + mTarget.playerID].shield.play();
                  _root.addSound("Effects","sfx_shield");
                  _root.KrinNumberShow("shield","player" + mTarget.playerID,IDKM2[0]);
                  _root.applyBuffKrin(mTarget,"FROSTBITTEN",1,mCaster);
                  _root.applyChangesKrin(mTarget);
                  mTarget.FROSTBITTEN = mTarget.FROSTBITTENMAX;
                  _root.addSound("Effects","Shatter");
               }
               else
               {
                  _root.DMGFROST -= mTarget.SHIELD;
                  mTarget.LIFEN -= _root.DMGFROST;
                  _root.KrinNumberShow(_root.DMGFROST,"player" + mTarget.playerID,"Ice");
                  _root.applyBuffKrin(mTarget,"FROSTBITTEN",1,mCaster);
                  _root.applyChangesKrin(mTarget);
                  mTarget.FROSTBITTEN = mTarget.FROSTBITTENMAX;
                  _root.addSound("Effects","Shatter");
               }
               _root.lifeBarUpdate(mTarget.playerID);
            }
         }
         x++;
      }
   }
   else
   {
      FROSTBITTEN2 = 0;
      BLEED2 = 0;
   }
   differenceForSH = 0;
   if(mAry2[79] > 0)
   {
      mTarget.BLEED -= mAry2[79];
   }
   differenceForSH = 0;
   if(mAry2[80] > 0)
   {
      mTarget.FROSTBITTEN -= mAry2[80];
      if(mTarget.FROSTBITTEN <= 0)
      {
         _root.DMGFROST = mTarget.LIFEU * 0.07;
         if(mTarget.SHIELD > 0)
         {
            differenceForSH = mTarget.SHIELD - _root.DMGFROST;
         }
         if(differenceForSH > 0)
         {
            mTarget.SHIELD -= _root.DMGFROST;
            _root.BATTLESCREEN["player" + mTarget.playerID].shield.play();
            _root.addSound("Effects","sfx_shield");
            _root.KrinNumberShow("shield","player" + mTarget.playerID,IDKM2[0]);
            _root.applyBuffKrin(mTarget,"FROSTBITTEN",1,mCaster);
            _root.applyChangesKrin(mTarget);
            mTarget.FROSTBITTEN = mTarget.FROSTBITTENMAX;
            _root.addSound("Effects","Shatter");
         }
         else
         {
            _root.DMGFROST -= mTarget.SHIELD;
            mTarget.LIFEN -= _root.DMGFROST;
            _root.KrinNumberShow(_root.DMGFROST,"player" + mTarget.playerID,"Ice");
            _root.applyBuffKrin(mTarget,"FROSTBITTEN",1,mCaster);
            _root.applyChangesKrin(mTarget);
            mTarget.FROSTBITTEN = mTarget.FROSTBITTENMAX;
            _root.addSound("Effects","Shatter");
         }
         _root.lifeBarUpdate(mTarget.playerID);
      }
   }
   if(mCaster.TENCHIJIN < 0)
   {
      mCaster.TENCHIJIN = 0;
   }
   q = 0;
   while(q < _root.maxBuffLimit)
   {
      if(mAry2[151] > 0)
      {
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[q].buffId][183] > 0 && mTarget.BUFFARRAYK[q].CD != 0)
         {
            mTarget.BUFFARRAYK[q].CD = 0;
            _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[q].buffId,-1,0,mTarget.BUFFARRAYK[q].buffValue,q);
         }
      }
      if(mAry2[152] > 0)
      {
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[q].buffId][184] > 0 && mTarget.BUFFARRAYK[q].CD != 0)
         {
            mTarget.BUFFARRAYK[q].CD = 0;
            _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[q].buffId,-1,0,mTarget.BUFFARRAYK[q].buffValue,q);
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][132] > 0 && mAry1[14] != "Heal" && mCaster.BUFFARRAYK[q].CD != 0)
      {
         differenceForSH = 0;
         mTarget.BLEED -= _root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][132];
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[q].buffId][167] > 0 && mAry1[14] == "Full Damage" && mTarget.BUFFARRAYK[q].CD != 0)
      {
         mCaster.SEDUCED += 1;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][167] > 0 && mCaster.BUFFARRAYK[q].CD == 1)
      {
         _root.applyBuffKrin(mTarget,"VULNERABLITY",1,mCaster);
         _root.applyChangesKrin(mTarget);
         mTarget.SEDUCED += 1;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][183] > 0 && mCaster.BUFFARRAYK[q].CD == 1)
      {
         ModifyHP(99999999 * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][1],0,mCaster,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][184] > 0 && mCaster.BUFFARRAYK[q].CD == 1)
      {
         ModifyHP(99999999 * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][1],0,mCaster,mCaster);
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[q].buffId][182] != 0 && mTarget.BUFFARRAYK[q].CD == 1)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mTarget.BUFFARRAYK[q].buffId][182],1,mCaster);
         _root.applyChangesKrin(mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][171] > 0 && mCaster.BUFFARRAYK[q].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][171] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               _root.addSound("Effects","FF30");
            }
            G++;
         }
      }
      q++;
   }
   if(mAry2[135] != 0)
   {
      mTarget.SEDUCED += mAry2[135];
      if(mTarget.SEDUCED < 0)
      {
         mTarget.SEDUCED = 0;
      }
   }
   if(mAry2[149] != 0)
   {
      mTarget.ELECTROPE += mAry2[149];
      if(mTarget.ELECTROPE < 0)
      {
         mTarget.ELECTROPE = 0;
      }
   }
   if(mCaster.SEDUCED > 0)
   {
      o = 0;
      while(o < _root.maxBuffLimit)
      {
         if(mCaster.SEDUCED >= 1)
         {
            if(mCaster.BUFFARRAYK[o].buffId == "LOVE0")
            {
               mCaster.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[o].buffId,-1,0,mCaster.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mCaster,"LOVE1",1,mCaster);
            }
         }
         if(mCaster.SEDUCED >= 2)
         {
            if(mCaster.BUFFARRAYK[o].buffId == "LOVE1")
            {
               mCaster.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[o].buffId,-1,0,mCaster.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mCaster,"LOVE2",1,mCaster);
            }
         }
         if(mCaster.SEDUCED >= 3)
         {
            if(mCaster.BUFFARRAYK[o].buffId == "LOVE2")
            {
               mCaster.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[o].buffId,-1,0,mCaster.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mCaster,"LOVE3",1,mCaster);
            }
         }
         if(mCaster.SEDUCED >= 4)
         {
            if(mCaster.BUFFARRAYK[o].buffId == "LOVE3")
            {
               mCaster.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[o].buffId,-1,0,mCaster.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mCaster,"LOVE4",1,mCaster);
               mCaster.SEDUCED = 0;
               _root.applyBuffKrin(_root["playerKrin" + 2],"HONEYBEEPOWER",1,mCaster);
               ModifyHP(_root["playerKrin" + 2].LIFEU * -0.1,"HEAL",0,_root["playerKrin" + 2],_root["playerKrin" + 2]);
            }
         }
         o++;
      }
   }
   if(mTarget.SEDUCED > 0)
   {
      o = 0;
      while(o < _root.maxBuffLimit)
      {
         if(mTarget.SEDUCED >= 1)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "LOVE0")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"LOVE1",1,mTarget);
            }
         }
         if(mTarget.SEDUCED >= 2)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "LOVE1")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"LOVE2",1,mTarget);
            }
         }
         if(mTarget.SEDUCED >= 3)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "LOVE2")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"LOVE3",1,mTarget);
            }
         }
         if(mTarget.SEDUCED >= 4)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "LOVE3")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"LOVE4",1,mTarget);
               mTarget.SEDUCED = 0;
               _root.applyBuffKrin(mCaster,"HONEYBEEPOWER",1,mCaster);
               ModifyHP(mCaster.LIFEU * -0.1,"HEAL",0,mCaster,mCaster);
            }
         }
         o++;
      }
   }
   if(mTarget.ELECTROPE > 0)
   {
      o = 0;
      while(o < _root.maxBuffLimit)
      {
         if(mTarget.ELECTROPE >= 1)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "ELECTROPE")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"ELECTROPE1",1,mTarget);
            }
         }
         if(mTarget.ELECTROPE >= 2)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "ELECTROPE1")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"ELECTROPE2",1,mTarget);
            }
         }
         if(mTarget.ELECTROPE >= 3)
         {
            if(mTarget.BUFFARRAYK[o].buffId == "ELECTROPE2")
            {
               mTarget.BUFFARRAYK[o].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[o].buffId,-1,0,mTarget.BUFFARRAYK[o].buffValue,o);
               _root.applyBuffKrin(mTarget,"ELECTROPE3",1,mTarget);
            }
         }
         o++;
      }
   }
   if(mTarget.BLEED <= 0)
   {
      _root.DMGBLEED = mTarget.LIFEU * 0.1;
      if(mTarget.SHIELD > 0)
      {
         differenceForSH = mTarget.SHIELD - _root.DMGBLEED;
      }
      if(differenceForSH > 0)
      {
         mTarget.SHIELD -= _root.DMGBLEED;
         _root.BATTLESCREEN["player" + mTarget.playerID].shield.play();
         _root.addSound("Effects","sfx_shield");
         _root.KrinNumberShow("shield","player" + mTarget.playerID,IDKM2[0]);
         mTarget.BLEED = mTarget.BLEEDMAX;
         _root.addSound("Effects","Wound");
      }
      else
      {
         _root.DMGBLEED -= mTarget.SHIELD;
         mTarget.LIFEN -= _root.DMGBLEED;
         _root.KrinNumberShow(_root.DMGBLEED,"player" + mTarget.playerID,"Physical");
         mTarget.BLEED += mTarget.BLEEDMAX;
         _root.addSound("Effects","Wound");
      }
      f = 0;
      while(f < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][123] != 0 && mCaster.BUFFARRAYK[f].CD != 0)
         {
            _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][123],1,mCaster);
            _root.applyChangesKrin(mCaster);
            break;
         }
         f++;
      }
      if(mAry2[83] != 0)
      {
         _root.applyBuffKrin(mCaster,mAry2[83],1,mCaster);
         _root.applyChangesKrin(mCaster);
      }
      if(mAry2[87] != 0)
      {
         _root.applyBuffKrin(mTarget,mAry2[87],1,mCaster);
         _root.applyChangesKrin(mTarget);
      }
      _root.lifeBarUpdate(mTarget.playerID);
   }
}
function precheckBuff(mCaster, mTarget, mAry2, mAry1)
{
   if(mCaster.BLOODYFURY > 0 && mCaster.LIFEN <= mCaster.LIFEU * 0.5)
   {
      if(mCaster.BLOODYFURY == 1)
      {
         _root.applyBuffKrin(mCaster,"FURYPASSIVE2",1,mCaster);
         _root.applyBuffKrin(mCaster,"FURYPASSIVE3",1,mCaster);
         _root.applyChangesKrin(mCaster);
         _root.addSound("Effects","Fury");
      }
      if(mCaster.BLOODYFURY == 0.5)
      {
         _root.applyBuffKrin(mCaster,"FURYPASSIVE",1,mCaster);
         _root.applyChangesKrin(mCaster);
         _root.addSound("Effects","Fury");
      }
   }
   if(mAry1[7] < 0 && mAry2[75] > 0)
   {
      mAry1[7] = mAry2[75] + 1;
   }
   if(mAry2[146] != 0)
   {
      _root["music" + musicCounter2].stop();
      _root["music" + musicCounter2].attachSound(mAry2[146]);
      _root["music" + musicCounter2].start(0,100);
   }
   if(mAry2[100] > 0)
   {
      if(mCaster.MAGICU > mCaster.STRENGTHU)
      {
         mAry2[4] = mAry2[100];
      }
      if(mCaster.MAGICU < mCaster.STRENGTHU)
      {
         mAry2[2] = mAry2[100];
      }
      if(mCaster.MAGICU == mCaster.STRENGTHU)
      {
         mAry2[4] = mAry2[100] / 2;
         mAry2[2] = mAry2[100] / 2;
      }
   }
   for(abilityhistorytype in mAry2[93])
   {
      if(mTarget.abilityhistoryIDKM[14] == mAry2[93][abilityhistorytype] && mAry2[94] != 0)
      {
         mAry2[4] *= mAry2[94];
      }
   }
   if(mCaster.LIFEN / mCaster.LIFEU < mAry2[68])
   {
      mAry2[2] += 1.8;
   }
   if(mCaster.LIFEN / mCaster.LIFEU < mAry2[60])
   {
      mAry2[20] = 1;
   }
   if(mAry2[76] > 0 && mCaster.NODAMAGE == true)
   {
      mAry2[2] *= 2;
      mAry2[4] *= 2;
   }
   FIRECHECK = false;
   BLIZZARDCHECK = false;
   BLIZZARDCHECK2 = false;
   POLYGOTCHECK = false;
   i = 0;
   while(19 > i)
   {
      mCaster.abilityhistoryIDKM[i] = mAry1[i];
      i++;
   }
   i = 0;
   while(140 > i)
   {
      mCaster.abilityhistoryIDKM2[i] = mAry2[i];
      i++;
   }
   if(mAry2[98] != 0 && mTarget.abilityhistoryIDKM[14] != 0 && mTarget.abilityhistoryIDKM[7] != 0)
   {
      i = 0;
      while(i < 19)
      {
         mAry1[i] = mTarget.abilityhistoryIDKM[i];
         i++;
      }
      i = 0;
      while(i < 140)
      {
         mAry2[i] = mTarget.abilityhistoryIDKM2[i];
         i++;
      }
   }
   if(mAry2[138] < 0)
   {
      if((mTarget.LIFEN + mTarget.SHIELD) / mTarget.LIFEU <= 0.5)
      {
         mAry1[7] -= mAry2[138];
      }
   }
   f = 0;
   while(f < _root.maxBuffLimit)
   {
      if(POLYGOTCHECK == false && _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][172] > 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         d = 0;
         while(d < _root.maxBuffLimit)
         {
            if((POLYGOTCHECK == false && mCaster.BUFFARRAYK[d].buffId == "BLIZZARDI" || mCaster.BUFFARRAYK[d].buffId == "FIREI") && mCaster.BUFFARRAYK[d].CD != 0)
            {
               mCaster.POLYGOT += 1;
               POLYGOTCHECK = true;
               if(mCaster.POLYGOT == 6)
               {
                  _root.applyBuffKrin(mCaster,"POLYGOT",1,mCaster);
                  _root.applyChangesKrin(mCaster);
                  mCaster.POLYGOT = 0;
               }
            }
            d++;
         }
      }
      FIREBLIZZARDIV = false;
      FIREBLIZZARDIV2 = false;
      if(mAry1[0] == "Edge of")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "LIGHTG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Lightning";
            mAry1[13] = "BOOM1";
            mAry2[13] = "DAMAGEUPL";
            mAry2[21] = 1;
         }
         if(mCaster.BUFFARRAYK[f].buffId == "DARKNESSG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Shadow";
            mAry1[13] = "BOOM_STAR_PURPLE";
            mAry2[13] = "DMGDOWNS";
            mAry2[21] = 0;
         }
      }
      if(mAry1[0] == "Akh Morn")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "LIGHTG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Lightning";
            mAry2[2] = 1;
            mAry2[45] = 4;
         }
         if(mCaster.BUFFARRAYK[f].buffId == "DARKNESSG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Shadow";
            mAry2[2] = 4;
            mAry2[45] = 1;
         }
      }
      if(mAry1[0] == "Smash of")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "LIGHTG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Lightning";
            mAry2[7] = 5;
         }
         if(mCaster.BUFFARRAYK[f].buffId == "DARKNESSG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Shadow";
            mAry2[7] = 5;
         }
      }
      if(mAry1[0] == "Shield of")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "LIGHTG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Lightning";
            mAry2[13] = "LIGHTSHIELD";
         }
         if(mCaster.BUFFARRAYK[f].buffId == "DARKNESSG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Shadow";
            mAry2[110] = "DARKSHIELD2";
            mAry2[13] = "DARKSHIELD";
         }
      }
      if(mAry1[0] == "Bio")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "LIGHTG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Lightning";
            mAry2[29] = "BIODMG";
            mAry2[21] = 0;
         }
         if(mCaster.BUFFARRAYK[f].buffId == "DARKNESSG" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[0] = "Shadow";
            mAry2[29] = "BIOBREACH";
            mAry2[21] = 0;
         }
      }
      if(mAry1[0] == "Flare")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "BLIZZARDI" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Freeze";
            mAry2[0] = "Ice";
            mAry1[13] = "BOOM2";
            mAry1[17] = "Freeze";
            mAry1[18] = "Freeze";
            mAry2[13] = "BLIZZARDIV";
            mAry2[29] = 0;
            mAry2[33] = 0;
            mAry2[34] = 0;
            mAry2[35] = 0;
            mAry2[40] = 0;
            mAry2[17] = krinABC1[51] + mAry2[2] * 100 + krinABC2[51];
            mAry1[5] = 8;
            FIREBLIZZARDIV2 = true;
         }
      }
      if(mAry1[0] == "Freeze" && FIREBLIZZARDIV2 == false)
      {
         if(mCaster.BUFFARRAYK[f].buffId == "FIREI" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Flare";
            mAry2[0] = "Fire";
            mAry1[13] = "BOOM1";
            mAry1[17] = "Flare";
            mAry1[18] = "Flare";
            mAry2[13] = "FIREI";
            mAry2[29] = "FIREI44";
            mAry2[40] = "FIREI55";
            mAry2[33] = ["Fire"];
            mAry2[34] = 99;
            mAry2[35] = 2;
            mAry2[17] = krinABC1[50] + mAry2[2] * 100 + krinABC2[50];
            mAry1[5] = 8;
         }
      }
      if(mAry1[0] == "Fire IV")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "BLIZZARDI" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Blizzard IV";
            mAry2[0] = "Ice";
            mAry1[13] = "BOOM2";
            mAry1[17] = "Blizzard IV";
            mAry1[18] = "Blizzard IV";
            mAry2[13] = "BLIZZARDIV";
            mAry2[21] = 1;
            mAry2[17] = krinABC1[49] + mAry2[2] * 100 + krinABC2[49];
            mAry1[5] = 8;
            FIREBLIZZARDIV = true;
         }
      }
      if(mAry1[0] == "Blizzard IV" && FIREBLIZZARDIV == false)
      {
         if(mCaster.BUFFARRAYK[f].buffId == "FIREI" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Fire IV";
            mAry2[0] = "Fire";
            mAry1[13] = "BOOM1";
            mAry1[17] = "Fire IV";
            mAry1[18] = "Fire IV";
            mAry2[13] = 0;
            mAry2[17] = krinABC1[48] + mAry2[2] * 100 + krinABC2[48];
            mAry2[21] = 0;
            mAry1[5] = 8;
         }
      }
      if(mAry2[131] == "Aeolian Edge")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "RAIJUREADY" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            n = 0;
            while(19 > n)
            {
               mAry1[n] = _root["KRINABILITY" + 1852][n];
               n++;
            }
            n = 0;
            while(120 > n)
            {
               mAry2[n] = _root["KRINABILITYB" + 1852][n];
               n++;
            }
            mCaster.BUFFARRAYK[f].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue,f);
         }
      }
      if(mAry2[140] == "Ninjutsu")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "DUDRA" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            n = 0;
            while(19 > n)
            {
               mAry1[n] = _root["KRINABILITY" + 1263][n];
               n++;
            }
            n = 0;
            while(120 > n)
            {
               mAry2[n] = _root["KRINABILITYB" + 1263][n];
               n++;
            }
         }
         if((mCaster.BUFFARRAYK[f].buffId == "TEN" || mCaster.BUFFARRAYK[f].buffId == "CHI" || mCaster.BUFFARRAYK[f].buffId == "JIN") && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mCaster.BUFFARRAYK[f].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue,f);
         }
         Nin = 0;
         while(Nin < _root.maxBuffLimit)
         {
            if(mCaster.BUFFARRAYK[Nin].buffId == "DUDRA3" && mCaster.BUFFARRAYK[Nin].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1330][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1330][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin].buffId == "DUDRA2" && mCaster.BUFFARRAYK[Nin].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1328][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1328][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin].buffId == "DUDRA4" && mCaster.BUFFARRAYK[Nin].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1237][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1237][n];
                  n++;
               }
            }
            Nin++;
         }
         Nin2 = 0;
         while(Nin2 < _root.maxBuffLimit)
         {
            if(mCaster.BUFFARRAYK[Nin2].buffId == "KASSATSU" && mAry1[0] == "Hyoton" && mCaster.BUFFARRAYK[Nin2].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1848][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1848][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin2].buffId == "KASSATSU" && mAry1[0] == "Katon" && mCaster.BUFFARRAYK[Nin2].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1331][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1331][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin2].buffId == "DUDRA5" && mCaster.BUFFARRAYK[Nin2].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1265][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1265][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin2].buffId == "DUDRA8" && mCaster.BUFFARRAYK[Nin2].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1266][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1266][n];
                  n++;
               }
            }
            if(mCaster.BUFFARRAYK[Nin2].buffId == "DUDRA6" && mCaster.BUFFARRAYK[Nin2].CD != 0)
            {
               n = 0;
               while(19 > n)
               {
                  mAry1[n] = _root["KRINABILITY" + 1238][n];
                  n++;
               }
               n = 0;
               while(120 > n)
               {
                  mAry2[n] = _root["KRINABILITYB" + 1238][n];
                  n++;
               }
            }
            Nin2++;
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][50] == 3 && mAry2[0] == "Ice" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 0;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][50] == 1 && mAry2[0] == "Fire" && mAry1[0] != "Flare" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 0;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][55] == -20 && mAry1[0] == "Fire III" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] -= 20;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][51] == 1 && mAry2[0] == "Ice" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 0;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] != 0 && mAry1[10] == "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         ModifyHP(99999999 * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] != 0 && mAry1[10] != "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               _root["playerKrin" + (mCaster.teamSide + G * 2)].CALORIC += 1;
            }
            G++;
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][186] != 0 && mAry1[10] != "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active && _root["playerKrin" + (mCaster.teamSide + G * 2)] != mCaster)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][186] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
            }
            G++;
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][52] > 0 && mAry2[0] == "Fire" % BLIZZARDCHECK == false && mCaster.BUFFARRAYK[f].CD != 0)
      {
         if(mAry1[0] != "Flare")
         {
            mAry1[5] *= 0.5;
         }
         if(mAry1[0] == "Flare")
         {
            mAry1[5] = mCaster.FOCUSN * 0.66;
         }
         BLIZZARDCHECK = true;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][51] == 1 && mAry2[0] == "Fire" && FIRECHECK == false && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 2;
         if(mAry1[0] == "Flare")
         {
            mAry1[5] = mCaster.FOCUSN;
         }
         FIRECHECK = true;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][54] == 2 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry2[2] *= 2;
      }
      if(mAry1[0] == "Witchhunt" && (_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][179] != 0 || _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][180] != 0) && mCaster.BUFFARRAYK[f].CD != 0)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][179] != 0)
         {
            mAry2[148] = _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][179];
         }
         else
         {
            mAry2[148] = _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][180];
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][158] != 0 && mCaster.BUFFARRAYK[f].CD != 2 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][160] != 0 && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[14] += _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][160];
         }
         if(mAry2[112] != 0)
         {
            mAry1[7] += _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][158];
         }
      }
      if((mAry1[0] == "Vercure" || mAry1[10] != "Melee" && mAry1[14] == "Full Damage") && mCaster.BUFFARRAYK[f].CD != 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][157] != 0)
      {
         DUALCAST = 0;
         DUALCAST2 = 0;
         while(DUALCAST < _root.maxBuffLimit)
         {
            if(_root["KRINBUFF" + mCaster.BUFFARRAYK[DUALCAST].buffId][158] != 0 && mCaster.BUFFARRAYK[DUALCAST].CD != 0)
            {
               DUALCAST2 = 1;
            }
            DUALCAST++;
         }
         if(DUALCAST2 == 0)
         {
            _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][157],1,mCaster);
         }
      }
      VERFIRESTONE = false;
      if(mAry1[0] == "Jolt2" || mAry1[0] == "Jolt3" || mAry1[0] == "Jolt" || mAry1[0] == "Scatter" || mAry1[0] == "Impact")
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][161] == "Grand Impact" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry2[4] = 6;
            mAry2[20] = 1;
            mAry2[105] = 0.4;
            mAry2[108] = "ACCELERATION2";
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][162] > 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         if(mAry1[0] == "Bhavacakra")
         {
            mAry2[6] += 4;
            mCaster.BUFFARRAYK[f].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue,f);
         }
         if(mAry1[0] == "Hellfrog Medium")
         {
            mAry2[6] += 2;
            mCaster.BUFFARRAYK[f].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue,f);
         }
      }
      if(mAry1[0] == "Verfire")
      {
         if(mCaster.BUFFARRAYK[f].buffId == "VERSTONE" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Verstone";
            mAry2[0] = "Earth";
            mAry1[17] = "Verstone";
            mAry1[18] = "Verstone";
            mAry2[29] = "VERSTONE2";
            mAry2[13] = "VERSTONE3";
            mAry2[67] = 1;
            mAry2[113] = 0;
            mAry2[114] = 15;
            mAry2[108] = "VERSTONE";
            VERFIRESTONE = true;
         }
      }
      if(mAry1[0] == "Verstone" && VERFIRESTONE == false)
      {
         if(mCaster.BUFFARRAYK[f].buffId == "VERFIRE" && mCaster.BUFFARRAYK[f].CD != 0)
         {
            mAry1[0] = "Verfire";
            mAry1[17] = "Verfire";
            mAry2[0] = "Fire";
            mAry1[18] = "Verfire";
            mAry2[13] = "VERFIRE2";
            mAry2[29] = "VERFIRE3";
            mAry2[67] = 0;
            mAry2[114] = 0;
            mAry2[113] = 15;
            mAry2[108] = "VERFIRE";
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][70] != 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][70],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][75] > 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[7] += _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][75];
         if(mAry2[78] != 0)
         {
            mAry1[7] -= _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][75];
         }
      }
      if(mAry2[70] > 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1] == "Lightning" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry2[72] = mAry2[70];
      }
      if(mAry1[0] == "Pulse" && _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1] == "Lightning" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry2[9] = -10;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][65] > 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][65] < 1 && mAry1[0] == "Fundas Cure II" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 0;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][65] > 1 && mAry1[0] == "Fundas Cure III" && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry1[5] *= 0.5;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][76] > 0 && mAry2[63] > 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         mAry2[45] = mAry2[63];
      }
      if(mCaster.FURY > 0 && mCaster.BUFFARRAYK[f].CD != 0 && (mAry1[10] == "Melee2" || mAry1[10] == "Melee"))
      {
         ModifyHP(mTarget.STRENGTHU * _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][68],_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mTarget,mCaster);
      }
      if(mCaster.FURY < 0 && mCaster.BUFFARRAYK[f].CD != 0 && (mAry1[10] == "Shock2" || mAry1[10] == "Missile" || mAry1[10] == "Missile2" || mAry1[10] == "Shock"))
      {
         ModifyHP(mTarget.STRENGTHU * _root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][68],_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mTarget,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][78] > 0 && mCaster.BUFFARRAYK[f].CD > 0)
      {
         mCaster.BUFFARRAYK[f].CD2 -= 1;
         if(mCaster.BUFFARRAYK[f].CD2 == 0)
         {
            mCaster.BUFFARRAYK[f].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue);
         }
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[f].buffId][1] == "Physical" && mAry2[69] > 0 && mTarget.BUFFARRAYK[f].CD != 0)
      {
         if(mAry1[0] == "Bloody Claw")
         {
            mAry2[2] += 0.8;
            mAry2[4] += 0.8;
         }
         if(mAry1[0] == "Bloody Claw2")
         {
            mAry2[7] += 10;
         }
      }
      f++;
   }
   if(mCaster.SPEEDU > mTarget.SPEEDU && mAry2[85] == 1)
   {
      mAry2[45] = 2;
   }
   if(mCaster.SPEEDU > mTarget.SPEEDU && mAry2[85] == 2)
   {
      mAry2[13] = "DARKSNAKE1";
   }
   if(mCaster.SPEEDU > mTarget.SPEEDU && mAry2[85] == 7)
   {
      fiss = 0;
      fiss = mTarget.SPEEDU / mCaster.SPEEDU;
      if(fiss <= 0.5)
      {
         mAry2[45] = 8;
      }
      if(fiss > 0.5 && fiss <= 0.75)
      {
         mAry2[45] = 4;
      }
      if(fiss > 0.75 && fiss < 1)
      {
         mAry2[45] = 2;
      }
   }
   if(mCaster.CALORIC != 0 && mAry1[10] == "Melee")
   {
      mCaster.CALORIC += 1;
   }
   if(mCaster.CALORIC == 5)
   {
      G = 0;
      while(G < 3)
      {
         if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
         {
            ModifyHP(99 * mCaster.STRENGTHU,"Fire",0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
         }
         G++;
      }
      mCaster.CALORIC = 1;
   }
   if(mCaster.SPEEDU >= mTarget.SPEEDU && mAry2[85] > 2 && mAry2[85] < 7)
   {
      SE = mAry2[85] - 2;
      mAry2[13] = "SNAKEHEAL" + SE;
   }
   if(mAry2[141] == 1 && mCaster.TENCHIJIN > 0)
   {
      if(mCaster.TENCHIJIN == 3)
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1263][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1263][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 2 && mAry1[0] == "Ten")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1330][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1330][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 2 && mAry1[0] == "Chi")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1328][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1328][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 2 && mAry1[0] == "Jin")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1237][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1237][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 1 && mAry1[0] == "Chi")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1265][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1265][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 1 && mAry1[0] == "Ten")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1238][n];
            }
            n++;
         }
         n = 0;
         while(120 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1238][n];
            n++;
         }
      }
      if(mCaster.TENCHIJIN == 1 && mAry1[0] == "Jin")
      {
         n = 0;
         while(19 > n)
         {
            if(n != 7)
            {
               mAry1[n] = _root["KRINABILITY" + 1266][n];
            }
            n++;
         }
         n = 0;
         while(140 > n)
         {
            mAry2[n] = _root["KRINABILITYB" + 1266][n];
            n++;
         }
      }
      mAry1[7] = 0;
      mCaster.TENCHIJIN -= 1;
   }
   KASSATSU = false;
   x = 0;
   while(x < _root.maxBuffLimit)
   {
      if(mAry2[140] == "Ninjutsu" && mCaster.BUFFARRAYK[x].buffId == "KASSATSU" && mCaster.BUFFARRAYK[x].CD != 0)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
         mAry2[6] *= 1.3;
         KASSATSU = true;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124] > 0 && (mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][125] || mAry1[0] == "Bloodflame Slash") && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mAry2[2] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124];
         if(mAry2[2] == 0 && mAry1[0] != "Bloodflame Slash")
         {
            mAry2[6] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124];
         }
         if(mAry2[2] == 0 && mAry2[100] > 0)
         {
            mAry2[4] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124];
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][148] > 0 && mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][125] && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mAry2[4] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][148];
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][130] > 0 && mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][125] && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mAry2[20] += _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][130];
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][127] > 0 && mCaster.BUFFARRAYK[x].CD != 0 && (mAry1[10] == "Melee" || mAry1[10] == "Melee2"))
      {
         mAry5[5] *= 0;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][133] > 0 && mCaster.BUFFARRAYK[x].CD != 0 && (mAry1[10] != "Melee" || mAry1[10] != "Melee2"))
      {
         mAry5[5] *= 0;
      }
      x++;
   }
   if(mAry2[144] != 0 && KASSATSU == false)
   {
      mCaster.CDFORTEN += mAry2[144];
   }
   _root.applyChangesKrin(mCaster);
}
function checkBuffafter(mCaster, mTarget, mAry2, mAry1, JI)
{
   if(JI == 1)
   {
      if(mAry2[45] > 1 && mAry2[85] == 1)
      {
         mAry2[45] = 1;
      }
   }
   if(mAry2[20] == 1 && mAry2[85] == 1)
   {
      mAry2[20] = 0;
   }
   if(mAry2[13] != 0 && mAry2[85] == 2)
   {
      mAry2[13] = 0;
   }
   if(mAry2[13] != 0 && mAry2[85] > 2 && mAry2[85] < 7)
   {
      mAry2[13] = 0;
   }
   if(mAry2[86] != 0 && mTarget.LIFEN <= 0)
   {
      _root.applyBuffKrin(mCaster,mAry2[86],1,mCaster);
      _root.applyChangesKrin(mCaster);
   }
   x = 0;
   while(x > _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][154] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
      {
         mCaster.PALETTEGAUGE += _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][154];
         if(mCaster.PALETTEGAUGE >= mCaster.PALETTEGAUGEMAX)
         {
            mCaster.PALETTEGAUGE = mCaster.PALETTEGAUGEMAX;
            _root.addSound("Effects","PCT1");
         }
      }
      x++;
   }
}
function checkPoison(mCaster, mTarget, mAry2, mAry1, FAUL)
{
   if(mAry2[133] != 0 || mAry1[0] == "Sidewisespark")
   {
      x = 0;
      while(x < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][170] == 1 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] != 0 && mCaster.BUFFARRAYK[x].CD > 0)
         {
            if(FAUL == 0)
            {
               if(_root.playerKrin1.active == false && _root.playerKrin3.active == true && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == false && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == true && _root.playerKrin5.active == false)
               {
                  ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
                  _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
               }
               if(_root.playerKrin1.active == false && _root.playerKrin3.active == false && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == false && _root.playerKrin5.active == false || _root.playerKrin1.active == false && _root.playerKrin3.active == true && _root.playerKrin5.active == false)
               {
                  ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
                  _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
                  ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
                  _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
               }
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
            }
            else
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][170] == 2 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] != 0 && mCaster.BUFFARRAYK[x].CD > 0)
         {
            FAUL2 = _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168];
            if(_root.playerKrin1.active == true && _root.playerKrin3.active == true && _root.playerKrin5.active == true)
            {
               _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] *= 0.25;
            }
            if(_root.playerKrin1.active == false && _root.playerKrin3.active == true && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == false && _root.playerKrin5.active == true || _root.playerKrin1.active == true && _root.playerKrin3.active == true && _root.playerKrin5.active == false)
            {
               _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] *= 0.5;
            }
            ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] * mCaster.MAGICU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],1,mCaster,mTarget);
            _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][169],1,mCaster);
            _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][168] = FAUL2;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][167] > 0 && mCaster.BUFFARRAYK[x].CD == 1)
         {
            _root.applyBuffKrin(mTarget,"VULNERABLITY",1,mCaster);
            _root.applyChangesKrin(mTarget);
            mTarget.SEDUCED += 1;
         }
         x++;
      }
      _root.applyChangesKrin(mTarget);
   }
}
function checkBuff(mCaster, mTarget, mAry2, mAry1, FIRE5, owegwe)
{
   if(_root.DamageOutputKrinFinal2 == 0 && _root.DamageOutputKrinFinal != 0)
   {
      if(mTarget.BLOODYFURY > 0 && mTarget.LIFEN <= mTarget.LIFEU * 0.5)
      {
         if(mTarget.BLOODYFURY == 1)
         {
            _root.applyBuffKrin(mTarget,"FURYPASSIVE2",1,mCaster);
            _root.applyBuffKrin(mTarget,"FURYPASSIVE3",1,mCaster);
            _root.applyChangesKrin(mTarget);
            _root.addSound("Effects","Fury");
         }
         if(mTarget.BLOODYFURY == 0.5)
         {
            _root.applyBuffKrin(mTarget,"FURYPASSIVE",1,mCaster);
            _root.applyChangesKrin(mTarget);
            _root.addSound("Effects","Fury");
         }
      }
   }
   if(mAry2[73] != 0 && _root.DamageOutputKrinFinal2 == 0)
   {
      ModifyHP(-1 * _root.DamageOutputKrinFinal * mAry2[73],mAry2[0],0,mTarget,mCaster);
   }
   if(mAry2[110] != 0 && owegwe == 0 && mAry2[116] == 0)
   {
      _root.applyBuffKrin(mCaster,mAry2[110],1,mCaster);
      if(mAry2[158] != 0)
      {
         _root.applyBuffKrin(mCaster,mAry2[158],1,mCaster);
      }
   }
   if(mAry2[110] != 0 && mAry2[116] != 0)
   {
      _root.applyBuffKrin(mTarget,mAry2[110],1,mCaster);
   }
   if(mAry2[156] != 0)
   {
      mTarget.IGNORETURN = false;
      mTarget.STUNRESIST = 1;
   }
   if(mAry2[137] != 0)
   {
      if(_root["KRINBUFF" + mAry2[137]][16] != 1 && owegwe == 0)
      {
         _root["KRINBUFF" + mAry2[137]][16] = 1;
      }
      _root.applyBuffKrin(mTarget,mAry2[137],1,mCaster);
      _root["KRINBUFF" + mAry2[137]][16] += 2;
   }
   if(mAry2[111] != 0 && owegwe == 0)
   {
      AOEHEAL = 0;
      while(AOEHEAL < 3)
      {
         if(_root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].active)
         {
            _root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].LIFEN += mCaster.MAGICU * mAry2[111];
            if(_root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].LIFEN > _root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].LIFEU)
            {
               _root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].LIFEN = _root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].LIFEU;
            }
            _root.KrinNumberShow(mCaster.MAGICU * mAry2[111],"player" + _root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].playerID,"HEAL");
            _root.lifeBarUpdate(_root["playerKrin" + (mCaster.teamSide + AOEHEAL * 2)].playerID);
         }
         AOEHEAL++;
      }
   }
   DER = true;
   H2F3 = true;
   UN = false;
   x = 0;
   while(x < _root.maxBuffLimit)
   {
      if((mCaster.BUFFARRAYK[x].buffId == "LIGHTG" || mCaster.BUFFARRAYK[x].buffId == "DARKNESSG") && mCaster.BUFFARRAYK[x].CD != 0 && mCaster.FOCUSN == 0)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][155] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
      {
         if(mTarget.SHIELD <= 0)
         {
            mTarget.BUFFARRAYK[x].CD = 0;
            _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
         }
      }
      if(mCaster.FLAMED2 == 0)
      {
         if(mAry2[0] == "Blackflame" && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][151] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            mCaster.FLAMED -= 1;
            if(mCaster.FLAMED == 0)
            {
               _root.addSound("Effects","Fury");
               _root.applyBuffKrin(mCaster,"FLAMEDFRIEND",1,mCaster);
               mCaster.FLAMED = _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][151];
            }
         }
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1] == mAry2[99] && mAry2[90] != 0 && mTarget.BUFFARRAYK[x].CD > 0 && DER == true)
      {
         _root.applyBuffKrin(mTarget,mAry2[90],1,mCaster);
         DER = false;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][67] != 0 && mAry1[14] == "Heal" && mCaster.BUFFARRAYK[x].CD != 0)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][67],1,mCaster);
      }
      if(mAry2[97] != 0 && _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][144] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
      {
         _root.applyBuffKrin(mTarget,mAry2[97],1,mCaster);
         mTarget.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][141] != 0 && mCaster.BUFFARRAYK[x].CD == 1)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][141],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][126] != 0 && mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][125] && mCaster.BUFFARRAYK[x].CD > 0)
      {
         _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][126],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][138] != 0 && mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][137] && mCaster.BUFFARRAYK[x].CD > 0)
      {
         _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][138],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][75] > 0 && mCaster.BUFFARRAYK[x].CD < 0)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
         mAry1[7] = FIRE5;
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][158] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && mCaster.BUFFARRAYK[x].CD != 2)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][88] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][85] < mCaster.LIFEN / mCaster.LIFEU)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][88],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][175] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][175] != mAry1[10])
         {
            _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][176],1,mCaster);
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][114] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][85] > mCaster.LIFEN / mCaster.LIFEU)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][114],1,mCaster);
      }
      if(mAry2[20] == 1 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][178] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
      {
         DOTONBUFF = 0;
         while(DOTONBUFF < _root.maxBuffLimit)
         {
            if(mTarget.BUFFARRAYK[DOTONBUFF].buffId == "DOTON" && mTarget.BUFFARRAYK[DOTONBUFF].CD != 0)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][178] * (mCaster.STRENGTHU + mCaster.MAGICU + mCaster.SPEEDU),_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],0,mTarget,mTarget);
            }
            DOTONBUFF++;
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][87] > 0 && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
      }
      if(mCaster.BUFFARRAYK[x].buffId == mAry2[108] && mCaster.BUFFARRAYK[x].CD > 0 && (owegwe == 0 || mAry2[20] != 1) && H2F3 == true)
      {
         H2F3 = false;
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
         if(mAry2[107] != 0)
         {
            _root.applyBuffKrin(mCaster,mAry2[107],1,mCaster);
         }
      }
      if(mCaster.BUFFARRAYK[x].buffId == mAry2[117] && mCaster.BUFFARRAYK[x].CD > 0 && (owegwe == 0 || mAry2[20] != 1))
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
      }
      if(mCaster.BUFFARRAYK[x].buffId == mAry2[118] && mCaster.BUFFARRAYK[x].CD > 0 && (owegwe == 0 || mAry2[20] != 1))
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][153] > 0 && mCaster.BUFFARRAYK[x].CD > 0)
      {
         if(mAry2[106] != 0 && (owegwe == 0 || mAry2[20] != 1))
         {
            _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][153] -= 1;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][153] == 0)
         {
            if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][159] != 0)
            {
               _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][159],1,mCaster);
            }
            _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][153] = mAry2[106];
            mCaster.BUFFARRAYK[x].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][188] > 0 && mCaster.BUFFARRAYK[x].CD > 0)
      {
         if(mAry2[106] != 0 && (owegwe == 0 || mAry2[20] != 1))
         {
            mCaster.PALETTE -= 1;
         }
         if(mCaster.PALETTE == 0)
         {
            mCaster.PALETTE = _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][188];
            mCaster.BUFFARRAYK[x].CD = 0;
            _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
         }
      }
      if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][97] != 0 && ((mAry2[2] != 0 || mAry2[4] != 0) && mAry1[14] == "Heal") && mTarget.BUFFARRAYK[x].CD != 0)
      {
         G = 0;
         while(G < 6)
         {
            if(G != 1 && G != 3 && G != 5 && _root["playerKrin" + G].FOCUSU == 151)
            {
               _root.applyBuffKrin(_root["playerKrin" + G],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][97],1,mCaster);
               _root.applyChangesKrin(_root["playerKrin" + G]);
               break;
            }
            G++;
         }
      }
      if(_root.DamageOutputKrinFinal2 == 0 && _root.DamageOutputKrinFinal != 0)
      {
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][111] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][111],1,mCaster);
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][110] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            if(_root.playerKrin2.active == false && _root.playerKrin4.active == true && _root.playerKrin6.active == false || _root.playerKrin2.active == true && _root.playerKrin4.active == false && _root.playerKrin6.active == false || _root.playerKrin2.active == false && _root.playerKrin4.active == false && _root.playerKrin6.active == true)
            {
               _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][110],1,mCaster);
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][57] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            ModifyHP(-1 * _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][57] * _root.DamageOutputKrinFinal,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],0,mTarget,mCaster);
         }
         if(mCaster.BUFFARRAYK[x].buffId == "DARKSHIELD2" && mCaster.BUFFARRAYK[x].CD != 0)
         {
            G = 0;
            while(G < 3)
            {
               ModifyHP(-1 * _root.DamageOutputKrinFinal,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],0,_root["playerKrin" + (mCaster.teamSide + G * 2)],_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               G++;
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][163] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            if(mAry1[0] != "DREAMWITH" && mAry1[10] != "Ninjutsu" && mAry1[10] != "Ninjutsu2")
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][163] * _root.DamageOutputKrinFinal,mAry2[0],0,mTarget,mTarget);
            }
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][59] == 1 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            mCaster.LIFEN -= _root.DamageOutputKrinFinal * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][59];
            _root.KrinNumberShow(_root.DamageOutputKrinFinal * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][59],"player" + mCaster.playerID,mAry2[0]);
            _root.lifeBarUpdate(mCaster.playerID);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][96] != 0 && mTarget.BUFFARRAYK[x].CD < 0)
         {
            _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][96],1,mCaster);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][96] != 0 && mTarget.BUFFARRAYK[x].CD > 0 && DER == true)
         {
            _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][96],1,mCaster);
            DER = false;
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][95] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && mTarget.LIFEN <= 0)
         {
            G = 0;
            while(G < 3)
            {
               _root.applyBuffKrin(_root["playerKrin" + (mTarget.teamSide + G * 2)],_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][95],1,mCaster);
               _root.applyChangesKrin(_root["playerKrin" + (mTarget.teamSide + G * 2)]);
               G++;
            }
         }
         if(UN == false && _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][94] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            if(mAry2[0] == "Physical")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][94],1,mTarget);
            }
            if(mAry2[0] == "Fire")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][101],1,mTarget);
            }
            if(mAry2[0] == "Magic")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][100],1,mTarget);
            }
            if(mAry2[0] == "Ice")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][102],1,mTarget);
            }
            if(mAry2[0] == "Lightning")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][103],1,mTarget);
            }
            if(mAry2[0] == "Earth")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][104],1,mTarget);
            }
            if(mAry2[0] == "Shadow")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][105],1,mTarget);
            }
            if(mAry2[0] == "Poison")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][106],1,mTarget);
            }
            if(mAry2[0] == "Blackflame")
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][107],1,mTarget);
            }
            UN = true;
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][79] != 0 && mTarget.BUFFARRAYK[x].CD != 0 && mTarget.LIFEN <= 0)
         {
            G = 0;
            while(G < 3)
            {
               _root.applyBuffKrin(_root["playerKrin" + (mCaster.teamSide + G * 2)],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][79],1,mCaster);
               _root.applyChangesKrin(_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               G++;
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][56] > 0 && mToBeBuffed.BUFFARRAYK[x].CD != 0)
         {
            mCaster.LIFEN += _root.DamageOutputKrinFinal * _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][56];
            _root.KrinNumberShow(_root.DamageOutputKrinFinal * _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][56],"player" + mCaster.playerID,"HEAL");
            _root.lifeBarUpdate(mCaster.playerID);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][64] > 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][64] != 3)
            {
               ModifyHP(mCaster.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][64],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mCaster,mTarget);
            }
            else
            {
               ModifyHP(mTarget.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][64],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mCaster,mTarget);
            }
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][66] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            ModifyHP(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][66] * _root.DamageOutputKrinFinal,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],1,mTarget,mCaster);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][149] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            POISEDAMAGE2 = _root.DamageOutputKrinFinal / mTarget.LIFEU;
            if(POISEDAMAGE2 >= 0.1)
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][149],1,mCaster);
            }
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][113] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            mTarget.FOCUSN += _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][113];
            _root.lifeBarUpdate(mCaster.playerID);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][112] > 0 && mTarget.BUFFARRAYK[x].CD != 0 && mTarget.LIFEN <= 0)
         {
            ModifyHP(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][112] * mCaster.STRENGTHU,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mTarget,mCaster);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][72] > 0 && mTarget.BUFFARRAYK[x].CD != 0 && (mAry1[10] == _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][147] || mAry1[10] == _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][147] + "2"))
         {
            ModifyHP(mTarget.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][72],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mTarget,mCaster);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][117] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            ModifyHP(mTarget.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][117],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mTarget,mCaster);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][71] > 0 && mTarget.BUFFARRAYK[x].CD > 0)
         {
            mTarget.BUFFARRAYK[x].CD = 0;
            _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][109] > 0 && mTarget.BUFFARRAYK[x].CD > 0)
         {
            _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][109] -= 1;
            if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][109] == 0)
            {
               _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][109] = _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][116];
               mTarget.BUFFARRAYK[x].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][69] > 0 && mCaster.BUFFARRAYK[x].CD != 0 && mAry2[0] == "Fire")
         {
            numberRandomerBuffHit = Math.random();
            if(numberRandomerBuffHit < _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][69])
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][139],1,mCaster);
            }
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][118] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][118],1,mCaster);
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][74] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][74],1,mCaster);
         }
         if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][73] > 0 && mCaster.BUFFARRAYK[x].CD != 0)
         {
            _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][73] -= 1;
            if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][73] == 0)
            {
               _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][73] = 2;
               mCaster.BUFFARRAYK[x].CD = 0;
               _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
            }
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][129] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            if(mTarget.SHIELD <= 0)
            {
               ModifyHP(mTarget.SPEEDU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][129],_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][1],0,mTarget,mTarget);
               _root.applyBuffKrin(mTarget,"FIREPIERCING",1,mTarget);
               mTarget.BUFFARRAYK[x].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
            }
         }
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][135] != 0 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            if(mTarget.SHIELD <= 0)
            {
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][135],1,mTarget);
               BUFFCD = mTarget.BUFFARRAYK[x].CD;
               mTarget.BUFFARRAYK[x].CD = 0;
               _root.applyBuffKrin(mTarget,mTarget.BUFFARRAYK[x].buffId,-1,0,mTarget.BUFFARRAYK[x].buffValue,x);
               l = 0;
               while(l < _root.maxBuffLimit)
               {
                  if(_root["KRINBUFF" + mTarget.BUFFARRAYK[l].buffId][136] != 0 && mTarget.BUFFARRAYK[l].CD != 0)
                  {
                     mTarget.BUFFARRAYK[l].CD = BUFFCD;
                  }
                  l++;
               }
            }
         }
         if(mCaster.LIFEN > mCaster.LIFEU)
         {
            mCaster.LIFEN = mCaster.LIFEU;
         }
         if(mTarget.LIFEN > mTarget.LIFEU)
         {
            mTarget.LIFEN = mTarget.LIFEU;
         }
      }
      x++;
   }
   _root.applyChangesKrin(mCaster);
   _root.applyChangesKrin(mTarget);
}
function checkAbilities(mCaster, mTarget, mAry2, mAry1, FIRE2, FIRE3, FIRE4, FIRE5, FIRE6, FIRE8, FIRE, FIRE9)
{
   if(mAry2[69] > 0 || mAry2[68] > 0)
   {
      mAry2[2] = FIRE2;
      mAry2[4] = FIRE3;
      mAry2[7] = 0;
   }
   if(mAry1[5] != FIRE)
   {
      mAry1[5] = FIRE;
   }
   if(mAry2[2] > FIRE2)
   {
      mAry2[2] = FIRE2;
   }
   if(mAry2[4] > FIRE3)
   {
      mAry2[4] = FIRE3;
   }
   if(mAry2[6] > FIRE4)
   {
      mAry2[6] = FIRE4;
   }
   if(mAry1[7] != FIRE5)
   {
      mAry1[7] = FIRE5;
   }
   if(mAry2[20] > FIRE6)
   {
      mAry2[20] = FIRE6;
   }
   if(mAry2[136] != FIRE9)
   {
      mAry2[136] = FIRE9;
   }
   if(mAry2[14] > FIRE8)
   {
      mAry2[14] = FIRE8;
   }
   if(mAry2[76] > 0)
   {
      mAry2[2] = FIRE2;
      mAry2[4] = FIRE2;
   }
   if(mAry1[0] == "Pulse")
   {
      mAry2[9] = 0;
   }
   if(mAry2[151] == 1 || mAry2[152] == 1)
   {
      mAry1[10] = "Shock";
   }
   if(mAry2[108] == "ACCELERATION2")
   {
      mAry2[108] = 0;
      mAry2[105] = 0;
   }
   if(mAry2[60] > 0 || mAry2[63] > 0)
   {
      mAry2[20] = 0;
      mAry2[45] = 1;
   }
   CHANGEISCONDITION = false;
   if(mCaster.abilityhistoryIDKM[0] != mAry1[0] && (mAry2[141] == 1 || mCaster.abilityhistoryIDKM2[131] == "Aeolian Edge"))
   {
      n = 0;
      while(19 > n)
      {
         mAry1[n] = mCaster.abilityhistoryIDKM[n];
         n++;
      }
      n = 0;
      while(140 > n)
      {
         mAry2[n] = mCaster.abilityhistoryIDKM2[n];
         n++;
      }
   }
   if(mAry1[0] == "Ten")
   {
      _root.applyBuffKrin(mCaster,"TEN",1,mCaster);
      _root.applyChangesKrin(mCaster);
   }
   if(mAry1[0] == "Chi")
   {
      _root.applyBuffKrin(mCaster,"CHI",1,mCaster);
      _root.applyChangesKrin(mCaster);
   }
   if(mAry1[0] == "Jin")
   {
      _root.applyBuffKrin(mCaster,"JIN",1,mCaster);
      _root.applyChangesKrin(mCaster);
   }
   if(mCaster.CDFORTEN == 2)
   {
      i = 0;
      while(i < 8)
      {
         if(_root["KRINABILITYB" + _root.Krin.moveMatrix[i]][145] != 0)
         {
            _root.Krin.abilityCoolDown[i] = _root["KRINABILITYB" + _root.Krin.moveMatrix[i]][145];
         }
         i++;
      }
      mCaster.CDFORTEN = 0;
   }
   if(mAry2[103] != 0)
   {
      if(mAry2[103] == "Acceleration" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 6;
         mAry2[103] = "Acceleration2";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Acceleration2" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry2[103] = "Acceleration";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Master Strike" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry2[102] = 0;
         mAry2[134] = "Melee";
         mAry2[103] = "Master Strike2";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Master Strike2" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 6;
         mAry2[102] = "Melee";
         mAry2[134] = 0;
         mAry2[103] = "Master Strike";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Stoneinyellow" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Stone in Yellow";
         mAry1[13] = "BOOM_SLASHORANGE";
         mAry1[18] = "Stoneinyellow";
         mAry1[17] = "Stone in Yellow";
         mAry2[0] = "Earth";
         mAry2[4] += 0.4;
         mAry2[103] = "Thunderinmagenta";
         mAry2[17] = krinABC1[302] + mAry2[4] * 100 + krinABC2[302];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Thunderinmagenta" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Thunder in Magenta";
         mAry1[13] = "BOOM3";
         mAry1[18] = "Thunderinmagenta";
         mAry1[17] = "Thunder in Magenta";
         mAry2[0] = "Lightning";
         mAry2[4] += 0.4;
         mAry2[13] = "WHITEPAINT";
         mAry2[103] = "Blizzardincyan";
         mAry2[17] = krinABC1[303] + mAry2[4] * 100 + krinABC2[303];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Blizzardincyan" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Blizzardincyan";
         mAry1[13] = "BOOM2";
         mAry1[17] = "Blizzard in Cyan";
         mAry1[18] = "Blizzardincyan";
         mAry2[0] = "Ice";
         mAry2[4] -= 0.8;
         mAry2[13] = 0;
         mAry2[103] = "Stoneinyellow";
         mAry2[17] = krinABC1[153] + mAry2[4] * 100 + krinABC2[153];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Stoneinyellow2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Stone II in Yellow";
         mAry1[17] = "Stone II in Yellow";
         mAry1[13] = "BOOM_SLASHORANGE";
         mAry1[18] = "Stoneinyellow2";
         mAry2[0] = "Earth";
         mAry2[4] += 0.2;
         mAry2[103] = "Thunderinmagenta2";
         mAry2[17] = krinABC1[304] + mAry2[4] * 100 + krinABC2[304];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Thunderinmagenta2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Thunder II in Magenta";
         mAry1[17] = "Thunder II in Magenta";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[18] = "Thunderinmagenta2";
         mAry2[0] = "Lightning";
         mAry2[4] += 0.2;
         mAry2[13] = "WHITEPAINT";
         mAry2[103] = "Blizzardincyan2";
         mAry2[17] = krinABC1[305] + mAry2[4] * 100 + krinABC2[305];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Blizzardincyan2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Blizzardincyan2";
         mAry1[13] = "BOOM2";
         mAry1[17] = "Blizzard II in Cyan";
         mAry1[18] = "Blizzardincyan2";
         mAry2[0] = "Ice";
         mAry2[4] -= 0.4;
         mAry2[13] = 0;
         mAry2[103] = "Stoneinyellow2";
         mAry2[17] = krinABC1[154] + mAry2[4] * 100 + krinABC2[154];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Fireinred" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Fireinred";
         mAry1[12] = "Krin.Firebolt";
         mAry1[13] = "BOOM1";
         mAry1[17] = "Fire in Red";
         mAry1[18] = "Fireinred";
         mAry2[0] = "Fire";
         mAry2[13] = 0;
         mAry2[4] -= 0.8;
         mAry2[104] = 0;
         mAry2[103] = "Aeroingreen";
         mAry2[17] = krinABC1[146] + mAry2[4] * 100 + krinABC2[146];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Waterinblue" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Water in BLue";
         mAry1[12] = "Krin.Icebolt";
         mAry1[13] = "BOOM_SLASHBLUE";
         mAry1[17] = "Water in Blue";
         mAry1[18] = "Waterinblue";
         mAry2[0] = "Ice";
         mAry2[13] = "WHITEPAINT";
         mAry2[104] = 25;
         mAry2[4] += 0.4;
         mAry2[103] = "Fireinred";
         mAry2[17] = krinABC1[148] + mAry2[4] * 100 + krinABC2[148];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Rage of a Guardian" && CHANGEISCONDITION == false)
      {
         mAry1[13] = "BOOM_SLASHORANGE";
         mAry1[17] = "Rage of a Guardian";
         mAry1[18] = "Royal Authority";
         mAry2[13] = "DIVINEMIGHT";
         mAry2[2] += 0.5;
         mAry2[103] = "Riot Blade";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Royal Authority" && CHANGEISCONDITION == false)
      {
         mAry1[13] = "BOOM_SLASHORANGE";
         mAry1[17] = "Royal Authority";
         mAry1[18] = "Royal Authority";
         mAry2[13] = "DIVINEMIGHT";
         mAry2[29] = "ATONEMENT";
         mAry2[2] += 0.5;
         mAry2[103] = "Riot Blade";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Riot Blade" && CHANGEISCONDITION == false)
      {
         mAry1[13] = "BOOM_SLASH";
         mAry1[17] = "Riot Blade";
         mAry1[18] = "Riot Blade";
         mAry2[13] = "RIOTBLADE";
         mAry2[2] -= 0.5;
         if(mAry2[29] != 0)
         {
            mAry2[103] = "Royal Authority";
         }
         else
         {
            mAry2[103] = "Rage of a Guardian";
         }
         mAry2[29] = 0;
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Aeroingreen" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Aero in Green";
         mAry1[12] = "Krin.Poisonbolt";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[17] = "Aero in Green";
         mAry1[18] = "Aeroingreen";
         mAry2[0] = "Poison";
         mAry2[4] += 0.4;
         mAry2[103] = "Waterinblue";
         mAry2[17] = krinABC1[147] + mAry2[4] * 100 + krinABC2[147];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Gust Slash" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Gust Slash";
         mAry1[13] = "BOOM_SLASHORANGE";
         mAry1[17] = "Gust Slash";
         mAry1[18] = "Gustslash";
         mAry2[6] += 1;
         mAry2[103] = "Aeolian Edge";
         mAry2[17] = krinABC1[312] + mAry2[6] * 100 + krinABC2[312];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Aeolian Edge" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Aeolian Edge";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[17] = "Aeolian Edge";
         mAry1[18] = "Aeolian Edge";
         mAry2[6] += 1;
         mAry1[5] = -20;
         mAry2[103] = "Spinning Edge";
         mAry2[17] = krinABC1[313] + mAry2[6] * 100 + krinABC2[313];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Spinning Edge" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Spinning Edge";
         mAry1[13] = "BOOM_RED";
         mAry1[17] = "Spinning Edge";
         mAry1[18] = "Spinningedge";
         mAry2[6] -= 2;
         mAry1[5] = -5;
         mAry2[103] = "Gust Slash";
         mAry2[17] = krinABC1[130] + mAry2[6] * 100 + krinABC2[130];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Fireinred2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Fireinred2";
         mAry1[17] = "Fire II in Red";
         mAry1[12] = "Krin.Firebolt";
         mAry1[13] = "BOOM1";
         mAry1[18] = "Fireinred2";
         mAry2[0] = "Fire";
         mAry2[13] = 0;
         mAry2[4] -= 0.4;
         mAry2[104] = 0;
         mAry2[29] = 0;
         mAry2[103] = "Aeroingreen2";
         mAry2[17] = krinABC1[149] + mAry2[4] * 100 + krinABC2[149];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Waterinblue2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Water II in Blue";
         mAry1[17] = "Water II in Blue";
         mAry1[12] = "Krin.Icebolt";
         mAry1[13] = "BOOM_SLASHBLUE";
         mAry1[18] = "Waterinblue2";
         mAry2[0] = "Ice";
         mAry2[13] = "WHITEPAINT";
         mAry2[104] = 25;
         mAry2[4] += 0.2;
         mAry2[103] = "Fireinred2";
         mAry2[17] = krinABC1[301] + mAry2[4] * 100 + krinABC2[301];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Aeroingreen2" && CHANGEISCONDITION == false)
      {
         mAry1[0] = "Aero II in Green";
         mAry1[17] = "Aero II in Green";
         mAry1[12] = "Krin.Poisonbolt";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[18] = "Aeroingreen2";
         mAry2[0] = "Poison";
         mAry2[4] += 0.2;
         mAry2[103] = "Waterinblue2";
         mAry2[17] = krinABC1[300] + mAry2[4] * 100 + krinABC2[300];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Emergency Destruct" && CHANGEISCONDITION == false)
      {
         mAry1[5] = 0;
         mAry1[7] = 6;
         mAry1[13] = "BOOM1";
         mAry1[18] = "Explode";
         mAry1[10] = "Shock";
         mAry2[4] = 4;
         mAry2[0] = "Lightning";
         mAry2[13] = "DAMAGEDOWNVERA";
         mAry2[2] = 4;
         mAry2[20] = 1;
         mAry2[103] = "Zombie Poison";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Zombie Poison" && CHANGEISCONDITION == false)
      {
         mAry1[5] = 15;
         mAry1[10] = "Missile";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[7] = 0;
         mAry1[18] = "PoisonHit";
         mAry2[4] = 0;
         mAry2[0] = "Poison";
         mAry2[20] = 0;
         mAry2[2] = 2.6;
         mAry2[13] = "POISONZOMBIE";
         mAry2[103] = "Emergency Destruct";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Hammer Stamp" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 6;
         mAry1[2] = 0;
         mAry1[3] = 1;
         mAry1[14] = "Full Damage";
         mAry1[17] = "Hammer Stamp";
         mAry1[13] = "BOOM_SLASHRED";
         mAry1[18] = "Hammerstamp";
         mAry2[2] += 4.8;
         mAry2[20] = 1;
         mAry2[105] = 0.5;
         mAry2[13] = "STUN1";
         mAry2[103] = "Hammermotif";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Hammermotif" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[2] = 1;
         mAry1[3] = 0;
         mAry1[14] = "Heal";
         mAry1[17] = "Hammermotif";
         mAry1[13] = "BOOM_POWERUP";
         mAry1[18] = "Hammermotif";
         mAry2[2] -= 4.8;
         mAry2[13] = 0;
         mAry2[105] = 0;
         mAry2[20] = 0;
         mAry2[103] = "Hammer Stamp";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Starrymuse" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 12;
         mAry1[14] = "Heal";
         mAry1[17] = "Starry Muse";
         mAry1[13] = "BOOM3";
         mAry1[18] = "Starrymuse";
         mAry2[20] = 1;
         mAry2[13] = "STARRYMUSE";
         mAry2[158] = "SUBTRACTIVEPALETTE";
         mAry2[40] = "STARSTRUCK";
         mAry2[110] = "STARRYMUSE2";
         mAry2[103] = "Starryskymotif";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Cooldown" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 25;
         mAry2[103] = 0;
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Starryskymotif" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[14] = "Heal";
         mAry1[17] = "Starryskymotif";
         mAry1[13] = "BOOM_POWERUP";
         mAry1[18] = "Starryskymotif";
         mAry2[13] = 0;
         mAry2[29] = 0;
         mAry2[40] = 0;
         mAry2[158] = 0;
         mAry2[110] = 0;
         mAry2[20] = 0;
         mAry2[103] = "Starrymuse";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Pommuse" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 6;
         mAry1[2] = 0;
         mAry1[3] = 1;
         mAry1[14] = "Full Damage";
         mAry1[17] = "Pom Muse";
         mAry1[13] = "BOOM_DARK";
         mAry1[18] = "Pommuse";
         mAry2[4] += 11;
         mAry2[13] = "SUPERSTUN";
         mAry2[103] = "Pommotif";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Pommotif" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[2] = 1;
         mAry1[3] = 0;
         mAry1[14] = "Heal";
         mAry1[17] = "Pom Motif";
         mAry1[13] = "BOOM_POWERUP";
         mAry1[18] = "Pommotif";
         mAry2[4] = 0;
         mAry2[13] = 0;
         mAry2[103] = "Pommuse";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Veilofthorns" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 12;
         mAry1[2] = 0;
         mAry1[3] = 1;
         mAry1[14] = "Full Damage";
         mAry1[17] = "Vice of Thorns";
         mAry1[13] = "BOOM_DARK";
         mAry1[18] = "Veilofthorns";
         mAry2[4] += 7;
         mAry2[105] = 0.4;
         mAry2[13] = 0;
         mAry2[103] = "Embolden";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Phantomkamaitachi" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 9;
         mAry1[5] = -10;
         mAry1[2] = 0;
         mAry1[3] = 1;
         mAry1[14] = "Full Damage";
         mAry1[17] = "Phantom Kamaitachi";
         mAry1[13] = "BOOM_SLASHGREEN";
         mAry1[18] = "Phantomkamaitachi";
         mAry2[6] += 6;
         mAry2[105] = 0.5;
         mAry2[29] = 0;
         mAry2[20] = 1;
         mAry2[103] = "Bunshin";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Bunshin" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[5] = 50;
         mAry1[2] = 1;
         mAry2[20] = 0;
         mAry1[3] = 0;
         mAry1[14] = "Heal";
         mAry1[17] = "Bunshin";
         mAry1[13] = "BOOM_SHIELD";
         mAry1[18] = "XAngriff";
         mAry2[6] -= 6;
         mAry2[29] = "BUNSHIN";
         mAry2[103] = "Phantomkamaitachi";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Goring Blade" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 6;
         mAry1[2] = 0;
         mAry1[3] = 1;
         mAry1[10] = "Melee";
         mAry1[14] = "Full Damage";
         mAry1[17] = "Goring Blade";
         mAry1[13] = "BOOM_SLASHRED";
         mAry1[18] = "PCT4";
         mAry2[2] += 7;
         mAry2[13] = 0;
         mAry2[103] = "Fight or Flight";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Fight or Flight" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[2] = 1;
         mAry1[3] = 0;
         mAry2[2] -= 7;
         mAry1[14] = "Heal";
         mAry1[10] = "Shock";
         mAry1[17] = "Fight or Flight";
         mAry1[13] = "BOOM_POWERUP";
         mAry1[18] = "Cometinblack2";
         mAry2[13] = "FIGHTORFLIGHT";
         mAry2[103] = "Goring Blade";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Embolden" && CHANGEISCONDITION == false)
      {
         mAry1[7] = 0;
         mAry1[2] = 1;
         mAry1[3] = 0;
         mAry1[14] = "Heal";
         mAry1[17] = "Embolden";
         mAry1[13] = "BOOM_POWERUP";
         mAry1[18] = "Embolden";
         mAry2[4] = 0;
         mAry2[13] = "EMBOLDEN";
         mAry2[103] = "Veilofthorns";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Riposte" && CHANGEISCONDITION == false)
      {
         mAry2[18] += " Black and White Mana Cost: 20 (50 for the full combo)";
         mAry1[17] = "Riposte";
         mAry1[18] = "Riposte";
         mAry2[0] = "Fire";
         mAry1[10] = "Melee";
         mAry1[13] = "BOOM_SLASHRED";
         mAry2[113] = -20;
         mAry2[114] = -20;
         mAry2[20] = 0;
         mAry2[4] = 3;
         mAry2[103] = "Zwerchhau";
         mAry2[17] = krinABC1[174] + mAry2[4] * 100 + krinABC2[174];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Zwerchhau" && CHANGEISCONDITION == false)
      {
         mAry1[17] = "Zwerchhau";
         mAry1[18] = "Zwerchau";
         mAry2[0] = "Fire";
         mAry2[113] = -15;
         mAry2[18] = " Black and White Mana Cost: 15 (50 for the full combo)";
         mAry2[114] = -15;
         mAry2[4] = 3.6;
         mAry2[17] = krinABC1[306] + mAry2[4] * 100 + krinABC2[306];
         mAry2[103] = "Redoublement";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Redoublement" && CHANGEISCONDITION == false)
      {
         mAry1[17] = "Redoublement";
         mAry1[18] = "Redoublement";
         mAry2[0] = "Fire";
         mAry2[4] = 5.3;
         mAry2[17] = krinABC1[307] + mAry2[4] * 100 + krinABC2[307];
         if(mCaster.BMANA > mCaster.WMANA)
         {
            mAry2[103] = "Verholy";
         }
         if(mCaster.WMANA > mCaster.BMANA)
         {
            mAry2[103] = "Verflare";
         }
         if(mCaster.WMANA == mCaster.BMANA)
         {
            RandomNumber = Math.random();
            if(RandomNumber > 0.5)
            {
               mAry2[103] = "Verflare";
            }
            else
            {
               mAry2[103] = "Verholy";
            }
         }
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Verholy" && CHANGEISCONDITION == false)
      {
         mAry2[18] = 0;
         mAry1[17] = "Verholy";
         mAry1[18] = "Verholy";
         mAry2[0] = "Magic";
         mAry2[4] = 6.2;
         mAry1[10] = "Shock";
         mAry1[13] = "BOOM_SPARK";
         mAry2[13] = "VERSTONE";
         mAry2[20] = 1;
         mAry2[105] = 0.4;
         mAry2[114] = 11;
         mAry2[113] = 0;
         mAry2[103] = "Scorch";
         mAry2[17] = krinABC1[309] + mAry2[4] * 100 + krinABC2[309];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Verflare" && CHANGEISCONDITION == false)
      {
         mAry2[18] = 0;
         mAry1[17] = "Verflare";
         mAry1[18] = "Verflare";
         mAry2[0] = "Fire";
         mAry1[10] = "Shock";
         mAry2[4] = 6.2;
         mAry1[13] = "BOOM1";
         mAry2[13] = "VERFIRE";
         mAry2[20] = 1;
         mAry2[105] = 0.4;
         mAry2[113] = 11;
         mAry2[114] = 0;
         mAry2[103] = "Scorch";
         mAry2[17] = krinABC1[308] + mAry2[4] * 100 + krinABC2[308];
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Scorch" && CHANGEISCONDITION == false)
      {
         mAry1[17] = "Scorch";
         mAry1[18] = "Scorch";
         mAry2[0] = "Shadow";
         mAry2[4] = 7;
         mAry1[13] = "BOOM_DARK";
         mAry2[17] = krinABC1[310] + mAry2[4] * 100 + krinABC2[310];
         mAry2[20] = 1;
         mAry2[13] = 0;
         mAry2[105] = 0.4;
         mAry2[114] = 4;
         mAry2[113] = 4;
         mAry2[103] = "Resolution";
         CHANGEISCONDITION = true;
      }
      if(mAry2[103] == "Resolution" && CHANGEISCONDITION == false)
      {
         mAry1[17] = "Resolution";
         mAry1[18] = "Resolution";
         mAry2[0] = "Shadow";
         mAry2[4] = 8;
         mAry2[17] = krinABC1[311] + mAry2[4] * 100 + krinABC2[311];
         mAry1[13] = "BOOM_DARK";
         mAry2[20] = 1;
         mAry2[105] = 0.4;
         mAry2[114] = 4;
         mAry2[113] = 4;
         mAry2[103] = "Riposte";
         CHANGEISCONDITION = true;
      }
   }
}
function checkBuffAoe(mCaster, mTarget, mAry2, mAry1)
{
}
function checkBuffStun(mCaster, mTarget, mAry2, mAry1)
{
   f = 0;
   while(f < _root.maxBuffLimit)
   {
      if((mCaster.BUFFARRAYK[f].buffId == "LIGHTG" || mCaster.BUFFARRAYK[f].buffId == "DARKNESSG") && mCaster.BUFFARRAYK[f].CD != 0 && mCaster.FOCUSN == 0)
      {
         mCaster.BUFFARRAYK[f].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[f].buffId,-1,0,mCaster.BUFFARRAYK[f].buffValue,f);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] != 0 && mAry1[10] == "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         ModifyHP(99999999 * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] != 0 && mAry1[10] != "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][185] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               _root["playerKrin" + (mCaster.teamSide + G * 2)].CALORIC += 1;
            }
            G++;
         }
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][186] != 0 && mAry1[10] != "Melee" && mCaster.BUFFARRAYK[f].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active && _root["playerKrin" + (mCaster.teamSide + G * 2)] != mCaster)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][186] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
            }
            G++;
         }
      }
      f++;
   }
   if(mCaster.CALORIC == 5)
   {
      G = 0;
      while(G < 3)
      {
         if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
         {
            ModifyHP(99 * mCaster.STRENGTHU,"Fier",0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
         }
         G++;
      }
      mCaster.CALORIC = 1;
   }
   x = 0;
   while(x < _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][115] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][115],1,mCaster);
         _root.applyChangesKrin(mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][171] > 0 && mCaster.BUFFARRAYK[x].CD == 1)
      {
         G = 0;
         while(G < 3)
         {
            if(_root["playerKrin" + (mCaster.teamSide + G * 2)].active)
            {
               ModifyHP(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][171] * mCaster.STRENGTHU,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][1],0,mCaster,_root["playerKrin" + (mCaster.teamSide + G * 2)]);
               _root.addSound("Effects","FF30");
            }
            G++;
         }
      }
      x++;
   }
}
function buffTicker(ukcb3)
{
   _root.buffTickChecker = false;
   totalDmgCalcZ = 0;
   totalFocusCalcZ = ukcb3.DOTTICKERARRAY[9];
   totalDmgCalcZ += ukcb3.DOTTICKERARRAY[8] * ukcb3.HEALMOD_PLUS * ukcb3.HEALMOD_MINUS * ukcb3.IHOT;
   if(totalDmgCalcZ > 0)
   {
      totalDmgCalcZ = 0;
   }
   _root.perKSuccess = false;
   colorChGERUU = 0;
   colorChGERUU2 = 0;
   colorToBe = "Physical";
   vyy = 0;
   while(vyy < 8)
   {
      esogneribhf = Math.ceil((1 + ukcb3.IDMG2) * ukcb3.IDMGP2 * ukcb3.IDOT * (ukcb3.DOTTICKERARRAY[vyy] * ((100 + ukcb3.plevel * 5) / ukcb3.DEFU[elementMainArray[vyy]])));
      totalDmgCalcZ += esogneribhf;
      colorChGERUU2 = esogneribhf;
      if(colorChGERUU2 > colorChGERUU)
      {
         colorChGERUU = colorChGERUU2;
         colorToBe = elementMainArray[vyy];
      }
      vyy++;
   }
   autoDebuffer = new Array();
   b = 0;
   while(b < _root.maxBuffLimit)
   {
      if(ukcb3.BUFFARRAYK[b].CD > 0)
      {
         ukcb3.BUFFARRAYK[b].CD--;
         if(ukcb3.BUFFARRAYK[b].CD == 0)
         {
            autoDebuffer.push(b);
         }
      }
      b++;
   }
   for(o in autoDebuffer)
   {
      _root.applyBuffKrin(ukcb3,ukcb3.BUFFARRAYK[autoDebuffer[o]].buffId,-1,0,ukcb3.BUFFARRAYK[autoDebuffer[o]].buffValue,autoDebuffer[o]);
   }
   if(ukcb3.SSWITCH > 0)
   {
      totalDmgCalcZ *= -1;
   }
   differenceForSH = 0;
   if(ukcb3.SHIELD > 0 && totalDmgCalcZ > 0)
   {
      differenceForSH = ukcb3.SHIELD - totalDmgCalcZ;
   }
   if(differenceForSH > 0)
   {
      ukcb3.SHIELD -= totalDmgCalcZ;
      _root.KrinNumberShow("shield","player" + ukcb3.playerID);
      _root.BATTLESCREEN["player" + IDKT.playerID].shield.play();
   }
   else
   {
      if(totalDmgCalcZ > 0)
      {
         totalDmgCalcZ -= ukcb3.SHIELD;
         if(totalDmgCalcZ < 0)
         {
            totalDmgCalcZ = 0;
         }
         ukcb3.SHIELD = 0;
      }
      if(totalDmgCalcZ != 0)
      {
         _root.buffTickChecker = true;
         if(totalDmgCalcZ < 0)
         {
            _root.KrinNumberShow(- totalDmgCalcZ,"player" + ukcb3.playerID,"HEAL");
         }
         else
         {
            _root.KrinNumberShow(totalDmgCalcZ,"player" + ukcb3.playerID,colorToBe);
         }
      }
      ukcb3.LIFEN -= totalDmgCalcZ;
   }
   _root.buffTickChecker = totalDmgCalcZ;
   ukcb3.FOCUSN -= totalFocusCalcZ;
   if(ukcb3.FOCUSN > ukcb3.FOCUSU)
   {
      ukcb3.FOCUSN = ukcb3.FOCUSU;
   }
   if(ukcb3.FOCUSU == 99)
   {
      ukcb3.FOCUSU = 100;
   }
   if(ukcb3.FOCUSN < 0)
   {
      ukcb3.FOCUSN = 0;
   }
   if(ukcb3.LIFEN < 0 && (ukcb3.FOCUSU == 101 || ukcb3.LIVINGDEAD10 == 1))
   {
      ukcb3.LIFEN = 0;
      ukcb3.FOCUSN = 0;
      _root.BATTLESCREEN["player" + ukcb3.playerID].inner.gotoAndPlay("stun");
      _root.krinAddMove(ukcb3.playerID,ukcb3.playerID,0);
      Stun = 1;
   }
   if(ukcb3.LIFEN > 0 && (ukcb3.FOCUSU == 101 || ukcb3.LIVINGDEAD10 == 1) && Stun == 1)
   {
      _root.BATTLESCREEN["player" + ukcb3.playerID].inner.gotoAndPlay("outofstun");
      _root.krinAddMove(ukcb3.playerID,ukcb3.playerID,0);
      Stun = 0;
   }
   if(ukcb3.LIFEN <= 0 && ukcb3.FOCUSU != 101 && ukcb3.LIVINGDEAD10 != 1)
   {
      ukcb3.LIFEN = 0;
      ukcb3.FOCUSN = 0;
      _root.BATTLESCREEN["player" + ukcb3.playerID].inner.gotoAndPlay("dead");
      ukcb3.active = false;
      BUFFS = 0;
      while(BUFFS < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + ukcb3.BUFFARRAYK[BUFFS].buffId][173] != 0 && ukcb3.BUFFARRAYK[BUFFS].CD != 0)
         {
            G = 0;
            while(G < 3)
            {
               if(_root["playerKrin" + (ukcb3.teamSide + G * 2)].active == true)
               {
                  _root.applyBuffKrin(_root["playerKrin" + (ukcb3.teamSide + G * 2)],_root["KRINBUFF" + ukcb3.BUFFARRAYK[BUFFS].buffId][173],1,ukcb3);
                  _root.applyChangesKrin(_root["playerKrin" + (ukcb3.teamSide + G * 2)]);
               }
               G++;
            }
         }
         BUFFS++;
      }
      wefvergrervw = 1;
      while(wefvergrervw < 7)
      {
         if(ukcb3.playerID == _root.Krin.playerNumber)
         {
            if(arenaMode == false)
            {
               _root["KrinSelector" + wefvergrervw]._x = -300;
               _root["KrinSelector" + wefvergrervw]._y = -300;
            }
         }
         if(_root["KrinSelector" + wefvergrervw].TargetEr == ukcb3.playerID)
         {
            _root["KrinSelector" + wefvergrervw]._x = -300;
            _root["KrinSelector" + wefvergrervw]._y = -300;
         }
         wefvergrervw++;
      }
      _root.krinAddMove(ukcb3.playerID,ukcb3.playerID,0);
   }
   applyChangesKrin(ukcb3);
}
function applyChangesKrin(ukcb)
{
   epy = ukcb.changeArray;
   if(ukcb.active)
   {
      if(ukcb.STUN != ukcb.STUNP)
      {
         if(ukcb.STUN - ukcb.STUNP > 0)
         {
            _root.BATTLESCREEN["player" + ukcb.playerID].inner.gotoAndPlay("stun");
         }
         else
         {
            _root.BATTLESCREEN["player" + ukcb.playerID].inner.gotoAndPlay("outofstun");
         }
      }
   }
   ukcb.STUNP = ukcb.STUN;
   ukcb.STRENGTHU = Math.ceil((ukcb.STRENGTH + epy[0]) * (1 + epy[1]));
   ukcb.MAGICU = Math.ceil((ukcb.MAGIC + epy[2]) * (1 + epy[3]));
   if(bffker[60] == 1)
   {
      ukcb.MAGICU = Math.ceil((ukcb.SPEED + epy[2]) * (1 + epy[3]));
   }
   ukcb.SPEEDU = Math.ceil((ukcb.SPEED + epy[4]) * (1 + epy[5]));
   if(ukcb.STRENGTHU < 0)
   {
      ukcb.STRENGTHU = 0;
   }
   if(ukcb.MAGICU < 0)
   {
      ukcb.MAGICU = 0;
   }
   if(ukcb.SPEEDU < 0)
   {
      ukcb.SPEEDU = 0;
   }
   if(ukcb.FOCUSCHANGE != 0)
   {
      if(bffker[49] == 111)
      {
         ukcb.FOCUSU = 100;
         ukcb.FOCUS = 100;
         ukcb.FOCUSN = 100;
         ukcb.FOCUSCHANGE = 0;
      }
      if(bffker[49] != 111)
      {
         ukcb.FOCUSU = ukcb.FOCUS + ukcb.FOCUSCHANGE;
         if(bffker[49] != 1)
         {
            ukcb.FOCUSN = ukcb.FOCUSU;
         }
         ukcb.FOCUSCHANGE = 0;
      }
   }
   liferAdder = Math.ceil((ukcb.LIFE + epy[6]) * (1 + epy[7]) - ukcb.LIFEU);
   innoKCF = false;
   if(ukcb.LIFEN > 0)
   {
      innoKCF = true;
   }
   t_k_factor = ukcb.LIFEN / ukcb.LIFEU;
   ukcb.LIFEU += liferAdder;
   if(ukcb.LIFEU < 1)
   {
      ukcb.LIFEU = 1;
   }
   if(liferAdder > 0)
   {
      ukcb.LIFEN += liferAdder;
      _root.Krin.IronSkinner = true;
   }
   else
   {
      ukcb.LIFEN = Math.round(t_k_factor * ukcb.LIFEU);
   }
   if(ukcb.LIFEN <= 0 && innoKCF == true)
   {
      ukcb.LIFEN = 1;
   }
   if(ukcb.LIFEN > ukcb.LIFEU)
   {
      ukcb.LIFEN = ukcb.LIFEU;
   }
   ukcb.DMG = epy[8];
   ukcb.DMG2 = epy[9];
   ukcb.IDMG = epy[10];
   ukcb.IDMG2 = epy[11];
   ukcb.IDMGP2 = 1 - ukcb.IDMGP;
   if(ukcb.IDMGP2 < 0)
   {
      ukcb.IDMGP2 = 0;
   }
   i = 0;
   while(i < 8)
   {
      ukcb.PERU[elementMainArray[i]] = ukcb.PER[elementMainArray[i]] + ukcb.changeArrayEP[i];
      ukcb.PERU[elementMainArray[i]] *= ukcb.changeArrayEP2[i] + 1;
      if(ukcb.PERU[elementMainArray[i]] < 1)
      {
         ukcb.PERU[elementMainArray[i]] = 1;
      }
      i++;
   }
   i = 0;
   while(i < 8)
   {
      ukcb.DEFU[elementMainArray[i]] = ukcb.DEF[elementMainArray[i]] + ukcb.changeArrayED[i];
      ukcb.DEFU[elementMainArray[i]] *= ukcb.changeArrayED2[i] + 1;
      if(ukcb.DEFU[elementMainArray[i]] < 1)
      {
         ukcb.DEFU[elementMainArray[i]] = 1;
      }
      i++;
   }
   if(firstUpdate == false)
   {
      _root.lifeBarUpdate(ukcb.playerID);
   }
   ukcb.BUFFARRAYK.sortOn("CD",Array.DESCENDING | Array.NUMERIC);
   buffSpaceGF = 17;
   buffOffsetGF = 110;
   if(ukcb.teamSide == 1)
   {
      buffMultiGF = 1;
   }
   else
   {
      buffMultiGF = -1;
   }
   h = 0;
   while(h < 7)
   {
      removeMovieClip(_root["p" + ukcb.playerID + "BAR"]["bshr" + h]);
      if(ukcb.BUFFARRAYK[h].CD != 0)
      {
         _root["p" + ukcb.playerID + "BAR"].attachMovie("KrinBuffShower","bshr" + h,h);
         _root["p" + ukcb.playerID + "BAR"]["bshr" + h]._x = (buffOffsetGF + buffSpaceGF * h) * buffMultiGF;
         _root["p" + ukcb.playerID + "BAR"]["bshr" + h].buffCounter = ukcb.BUFFARRAYK[h].CD;
         _root["p" + ukcb.playerID + "BAR"]["bshr" + h].buffIcon.gotoAndStop(ukcb.BUFFARRAYK[h].buffId);
         for(r in elementMainArray)
         {
            if(elementMainArray[r] == _root["KRINBUFF" + ukcb.BUFFARRAYK[h].buffId][1])
            {
               KNcolor2 = elementColorArray[r];
            }
         }
         var _loc3_ = new Color(_root["p" + ukcb.playerID + "BAR"]["bshr" + h].buffColor);
         _loc3_.setRGB(KNcolor2);
         _root["p" + ukcb.playerID + "BAR"]["bshr" + h].toolTipTitle = _root["KRINBUFF" + ukcb.BUFFARRAYK[h].buffId][0];
         _root["p" + ukcb.playerID + "BAR"]["bshr" + h].toolTip = _root["KRINBUFF" + ukcb.BUFFARRAYK[h].buffId][25];
      }
      h++;
   }
   statusOfC = "Normal";
   statusOfF = KrinFilterNone;
   statusOfM = "STANDARD";
   if(ukcb.FILTERSBUFFARRAY[1] > 0)
   {
      statusOfC = "Poison";
   }
   if(ukcb.FILTERSBUFFARRAY[3] > 0)
   {
      statusOfF = KrinFilterFrostGreen;
   }
   if(ukcb.FILTERSBUFFARRAY[4] > 0)
   {
      statusOfM = "BARON";
   }
   if(ukcb.FILTERSBUFFARRAY[9] > 0)
   {
      statusOfM = "PREDATOR";
   }
   if(ukcb.FILTERSBUFFARRAY[10] > 0)
   {
      statusOfM = "TOXICANT";
   }
   if(ukcb.FILTERSBUFFARRAY[11] > 0)
   {
      statusOfM = "GUARDIAN";
   }
   if(ukcb.FILTERSBUFFARRAY[12] > 0)
   {
      statusOfM = "AVENGER";
   }
   if(ukcb.FILTERSBUFFARRAY[13] > 0)
   {
      statusOfM = "PSYCHO";
   }
   if(ukcb.FILTERSBUFFARRAY[14] > 0)
   {
      statusOfM = "WRAITH";
   }
   if(ukcb.FILTERSBUFFARRAY[15] > 0)
   {
      statusOfM = "GHOSTBOSS";
   }
   if(ukcb.FILTERSBUFFARRAY[16] > 0)
   {
      statusOfM = "HOUND";
   }
   if(ukcb.FILTERSBUFFARRAY[17] > 0)
   {
      statusOfM = "WEREWOLF";
   }
   if(ukcb.FILTERSBUFFARRAY[18] > 0)
   {
      statusOfF = KrinFilterRed;
   }
   if(ukcb.FILTERSBUFFARRAY[19] > 0)
   {
      statusOfM = "GHOSTBOSS2";
   }
   if(ukcb.FILTERSBUFFARRAY[5] > 0)
   {
      statusOfF = KrinFilterShadow;
   }
   if(ukcb.FILTERSBUFFARRAY[6] > 0)
   {
      statusOfF = KrinFilterIcy;
   }
   if(ukcb.FILTERSBUFFARRAY[7] > 0)
   {
      statusOfC = "Enrage";
   }
   if(ukcb.FILTERSBUFFARRAY[8] > 0)
   {
      statusOfF = KrinFilterOrange;
   }
   if(ukcb.FILTERSBUFFARRAY[2] > 0)
   {
      statusOfF = KrinFilterFrost;
   }
   if(ukcb.dressNow != statusOfM)
   {
      changeForm(statusOfM,ukcb.playerID);
   }
   _root.krinChangeColor(_root.BATTLESCREEN["player" + ukcb.playerID].inner,statusOfC);
   _root.BATTLESCREEN["player" + ukcb.playerID].inner.filters = statusOfF;
   ukcb.characterColorState = statusOfC;
   ukcb.characterFilterState = statusOfF;
}
function changeForm(changeTo, p_id)
{
   if(changeTo == "BARON")
   {
      dressChar("BARON",p_id,"","MODEL1","ZOMBIE2","M","","SHAMANSWORD","");
   }
   else if(changeTo == "STANDARD")
   {
      dressChar("STANDARD",p_id,"STANDARD","model","skin","gender","hair","wep1","wep2");
   }
   else if(changeTo == "PREDATOR")
   {
      dressChar("PREDATOR",p_id,"","MODEL1","PREDATOR","M","","NONE","NONE");
   }
   else if(changeTo == "TOXICANT")
   {
      dressChar("TOXICANT",p_id,"","MODEL1","TOXICANT","M","","NONE","NONE");
   }
   else if(changeTo == "GUARDIAN")
   {
      dressChar("GUARDIAN",p_id,"","MODEL1","GUARDIAN","M","","NONE","NONE");
   }
   else if(changeTo == "AVENGER")
   {
      dressChar("AVENGER",p_id,"","MODEL1","AVENGER","M","","NONE","NONE");
   }
   else if(changeTo == "PSYCHO")
   {
      dressChar("PSYCHO",p_id,"","MODEL1","PSYCHO","M","","NONE","NONE");
   }
   else if(changeTo == "WRAITH")
   {
      dressChar("WRAITH",p_id,"","MODEL1","WRAITH","M","","NONE","NONE");
   }
   else if(changeTo == "GHOSTBOSS")
   {
      dressChar("GHOSTBOSS",p_id,"","MODEL1","GHOSTBOSS","M","","SHANK","SHANK");
   }
   else if(changeTo == "HOUND")
   {
      dressChar("HOUND",p_id,"","MODEL5","HOUND","M","","NONE","NONE");
   }
   else if(changeTo == "WEREWOLF")
   {
      dressChar("WEREWOLF",p_id,"","MODEL5","WEREWOLF","M","","NONE","NONE");
   }
   else if(changeTo == "GHOSTBOSS2")
   {
      dressChar("GHOSTBOSS2",p_id,"","MODEL1","GHOSTBOSS2","M","","FELKNIFE2","FELKNIFE2");
   }
   if(_root["playerKrin" + p_id].STUN)
   {
      _root.BATTLESCREEN["player" + p_id].inner.gotoAndPlay("stun2");
   }
}
attachMovie("dog","dog1",1000);
attachMovie("dog","dog2",1001);
attachMovie("dog","dogA",1002);
attachMovie("dog","dogB",1003);
attachMovie("dog","dogC",1004);
var my_sound1 = new Sound(_root.dogA);
var my_sound2 = new Sound(_root.dogB);
var my_sound3 = new Sound(_root.dogC);
music1 = new Sound(_root.dog1);
music2 = new Sound(_root.dog2);
soundCounter = 1;
musicCounter = 1;
musicCounter2 = 2;
musicSwitch = 0;
addSound = function(a, b)
{
   if(_root.Krin.sound)
   {
      if(a == "Effects")
      {
         if(b != undefined)
         {
            _root["my_sound" + soundCounter].attachSound(b);
            _root["my_sound" + soundCounter].start();
            soundCounter++;
            if(soundCounter == 4)
            {
               soundCounter = 1;
            }
         }
      }
      if(a == "Music")
      {
         if(b == 1)
         {
            if(soundModeKrin != 1)
            {
               soundModeKrin = 1;
               _root["music" + musicCounter].attachSound(soundPlayArray[soundPlayCounter]);
               soundPlayCounter++;
               if(soundPlayCounter == 4)
               {
                  soundPlayCounter = 0;
               }
               _root["music" + musicCounter].setVolume(0);
               _root["music" + musicCounter].start(0,100);
               musicCounter++;
               musicCounter2++;
               musicSwitch = 1;
               volUpRate = 0;
               if(musicCounter == 3)
               {
                  musicCounter = 1;
               }
               if(musicCounter2 == 3)
               {
                  musicCounter2 = 1;
               }
            }
         }
         if(b == 2)
         {
            if(soundModeKrin != 2)
            {
               soundModeKrin = 2;
               bossMusicYesNo = false;
               dbossMusicYesNo = false;
               d2bossMusicYesNo = false;
               d3bossMusicYesNo = false;
               d4bossMusicYesNo = false;
               d5bossMusicYesNo = false;
               d6bossMusicYesNo = false;
               d7bossMusicYesNo = false;
               if(_root.Krin.bossFight == true)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 15)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 17)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 23)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 24)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 30)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 33)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 35)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 36)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 41)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 42)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 54)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 38)
               {
                  dbossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 39)
               {
                  d2bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 40)
               {
                  d3bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 43)
               {
                  d6bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 44)
               {
                  d7bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 45)
               {
                  bossMusicYesNo = true;
               }
               if(_root.Krin.progressLevelOn == 41)
               {
                  bossMusicYesNo = true;
               }
               if(bossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("BossBattleloopable");
                  if(_root.Krin.BattlePick == 42)
                  {
                     _root["music" + musicCounter].attachSound("Athena the tireless One");
                  }
                  if(_root.Krin.BattlePick == 46)
                  {
                     _root["music" + musicCounter].attachSound("Wickedtheme1");
                  }
               }
               else if(dbossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("Fuma Shuriken8");
               }
               else if(d2bossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("Erichtio");
               }
               else if(d6bossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("PCT5");
               }
               else if(d7bossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("FF3");
               }
               else if(d3bossMusicYesNo)
               {
                  _root["music" + musicCounter].attachSound("Golbez");
               }
               else
               {
                  _root["music" + musicCounter].attachSound(soundPlayArray[soundPlayCounter]);
               }
               soundPlayCounter++;
               if(soundPlayCounter == 4)
               {
                  soundPlayCounter = 0;
               }
               if(bangStart)
               {
                  _root["music" + musicCounter].setVolume(100);
                  volUpRate = 100;
                  bangStart = false;
                  _root["music" + musicCounter2].stop();
               }
               else
               {
                  _root["music" + musicCounter].setVolume(0);
                  volUpRate = 0;
               }
               _root["music" + musicCounter].start(0,100);
               musicCounter++;
               musicCounter2++;
               musicSwitch = 1;
               if(musicCounter == 3)
               {
                  musicCounter = 1;
               }
               if(musicCounter2 == 3)
               {
                  musicCounter2 = 1;
               }
            }
         }
      }
   }
};
onEnterFrame = function()
{
   if(musicSwitch)
   {
      if(volUpRate < 100)
      {
         volUpRate += 5;
         _root["music" + musicCounter2].setVolume(volUpRate);
         _root["music" + musicCounter].setVolume(100 - volUpRate);
         if(volUpRate == 100)
         {
            _root["music" + musicCounter].stop();
            musicSwitch = false;
         }
      }
   }
};
expWorkOut = function(enemyXP, yourXP)
{
   Krin.diffXP = 1 + (enemyXP - yourXP) * 0.15;
   if(Krin.diffXP < 0)
   {
      Krin.diffXP = 0;
   }
   if(Krin.diffXP > 3)
   {
      Krin.diffXP = 3;
   }
   Krin.totalXP = Krin.diffXP * (100 / (1 + Math.pow(yourXP,0.6 + 0.3 * (yourXP / 100))));
};
var KrinFilterNone = new Array();
var KFBlur0 = new flash.filters.BlurFilter(2,2,1);
var KrinFilterBlur0 = new Array();
KrinFilterBlu0r.push(KFBlur0);
var KFBlur1 = new flash.filters.BlurFilter(4,4,1);
var KrinFilterBlur1 = new Array();
KrinFilterBlur1.push(KFBlur1);
var KFBlur2 = new flash.filters.BlurFilter(6,6,1);
var KrinFilterBlur2 = new Array();
KrinFilterBlur2.push(KFBlur2);
var KFBlur3 = new flash.filters.BlurFilter(8,8,1);
var KrinFilterBlur3 = new Array();
KrinFilterBlur3.push(KFBlur3);
var KFHit1 = new flash.filters.GlowFilter(16777215,1,100,100,10,1,true,false);
var KFHit2 = new flash.filters.GlowFilter(16763904,1,10,10,1,1,false,false);
var KFHit3 = new flash.filters.GlowFilter(16763904,1,10,10,1,1,true,false);
var KrinFilterHit = new Array();
KrinFilterHit.push(KFHit1);
KrinFilterHit.push(KFHit2);
KrinFilterHit.push(KFHit3);
var KFHeal1 = new flash.filters.GlowFilter(16777215,1,100,100,10,1,true,false);
var KFHeal2 = new flash.filters.GlowFilter(10092288,1,10,10,1,1,false,false);
var KFHeal3 = new flash.filters.GlowFilter(10092288,1,10,10,1,1,true,false);
var KrinFilterHeal = new Array();
KrinFilterHeal.push(KFHeal1);
KrinFilterHeal.push(KFHeal2);
KrinFilterHeal.push(KFHeal3);
var KFIce1 = new flash.filters.GlowFilter(16777215,1,14,14,1.4000000000000001,1,true,true);
var KFIce2 = new flash.filters.GlowFilter(3381759,1,24,24,3.8000000000000003,1,false,false);
var KrinFilterFrost = new Array();
KrinFilterFrost.push(KFIce1);
KrinFilterFrost.push(KFIce2);
var KFFire1 = new flash.filters.GlowFilter(16776960,1,14,14,1.4000000000000001,1,true,true);
var KFFire2 = new flash.filters.GlowFilter(16763904,1,11,11,4.700000000000002,3,false,false);
var KFFire3 = new flash.filters.GlowFilter(16724736,1,33,33,2.2,1,false,false);
var KrinFilterFlame = new Array();
KrinFilterFlame.push(KFFire1);
KrinFilterFlame.push(KFFire2);
KrinFilterFlame.push(KFFire3);
krinBoltTime = 60;
krinBoltSpeed = 1;
krinBoltIncrease = 1.1500000000000001;
krinBodyMove = 10;
krinMeleeAttackCD = 15;
krinMeleeAttackEndCD = 15;
_root.zoomRatioNEW = 0.4;
KrinSettings = new Object();
_root.boltMakerCounter = 0;
MoveCount = 0;
addNewMove = function(a, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s)
{
   _root["KRINABILITY" + MoveCount] = new Array();
   short = _root["KRINABILITY" + MoveCount];
   _root["KRINABILITYB" + MoveCount] = new Array();
   short2 = _root["KRINABILITYB" + MoveCount];
   short[0] = a;
   short[1] = MoveCount;
   short[2] = c;
   short[3] = d;
   short[4] = e;
   short[5] = f;
   short[6] = g;
   short[7] = h;
   short[8] = i;
   short[9] = j;
   short[10] = k;
   short[11] = l;
   short[12] = m;
   short[13] = n;
   short[14] = o;
   short[15] = p;
   short[16] = q;
   short[17] = _root.KrinLang[KLangChoosen].SKILLNAME[r];
   short[18] = s;
   s = undefined;
   short2[0] = "Physical";
   short2[1] = 0;
   short2[2] = 0;
   short2[3] = 0;
   short2[4] = 0;
   short2[5] = 0;
   short2[6] = 0;
   short2[7] = 0;
   short2[8] = 1;
   short2[9] = 0;
   short2[10] = 1;
   short2[11] = 0;
   short2[12] = 0;
   short2[13] = 0;
   short2[14] = 1;
   short2[15] = new Array();
   short2[15] = [0];
   short2[16] = 0;
   short2[17] = "No Tooltip assigned";
   short2[18] = "Costs ";
   short2[19] = 1;
   short2[20] = 0;
   short2[21] = 0;
   short2[22] = 1;
   short2[23] = "Physical";
   short2[24] = 0;
   short2[25] = 1;
   short2[26] = 0;
   short2[27] = 0;
   short2[29] = 0;
   short2[30] = 1;
   short2[31] = 0;
   short2[32] = 0;
   short2[33] = new Array();
   short2[33] = [0];
   short2[34] = 0;
   short2[35] = 1;
   short2[40] = 0;
   short2[41] = 0;
   short2[45] = 1;
   short2[51] = "Physical";
   short2[52] = 0;
   short2[53] = 0;
   short2[54] = 0;
   short2[55] = 0;
   short2[56] = 0;
   short2[57] = 0;
   short2[58] = 1;
   short2[59] = 0;
   short2[60] = 0;
   short2[61] = 0;
   short2[62] = 0;
   short2[63] = 0;
   short2[64] = 0;
   short2[65] = 0;
   short2[66] = 0;
   short2[67] = 0;
   short2[68] = 0;
   short2[69] = 0;
   short2[70] = 0;
   short2[71] = 0;
   short2[72] = 1;
   short2[73] = 0;
   short2[74] = 0;
   short2[75] = 0;
   short2[76] = 0;
   short2[77] = 0;
   short2[78] = 0;
   short2[79] = 0;
   short2[80] = 0;
   short2[81] = 0;
   short2[82] = 0;
   short2[83] = 0;
   short2[84] = 0;
   short2[85] = 0;
   short2[86] = 0;
   short2[87] = 0;
   short2[88] = 0;
   short2[89] = 1;
   short2[90] = 0;
   short2[91] = 0;
   short2[92] = 0;
   short2[93] = new Array();
   short2[93] = [0];
   short2[94] = 0;
   short2[95] = 1;
   short2[96] = 0;
   short2[97] = 0;
   short2[98] = 0;
   short2[99] = 0;
   short2[100] = 0;
   short2[101] = 0;
   short2[102] = 0;
   short2[103] = 0;
   short2[104] = 0;
   short2[105] = 0;
   short2[106] = 0;
   short2[107] = 0;
   short2[108] = 0;
   short2[109] = 0;
   short2[110] = 0;
   short2[111] = 0;
   short2[112] = 0;
   short2[113] = 0;
   short2[114] = 0;
   short2[115] = 0;
   short2[116] = 0;
   short2[117] = 0;
   short2[118] = 0;
   short2[119] = 0;
   short2[120] = 0;
   short2[121] = 0;
   short2[122] = 0;
   short2[123] = 0;
   short2[124] = 0;
   short2[125] = 0;
   short2[126] = 0;
   short2[127] = 0;
   short2[128] = 0;
   short2[129] = 0;
   short2[130] = 0;
   short2[131] = 0;
   short2[132] = 0;
   short2[133] = 0;
   short2[134] = 0;
   short2[135] = 0;
   short2[136] = 0;
   short2[137] = 0;
   short2[138] = 0;
   short2[139] = 0;
   short2[140] = 0;
   short2[141] = 0;
   short2[142] = 0;
   short2[143] = 0;
   short2[144] = 0;
   short2[145] = 0;
   short2[146] = 0;
   short2[147] = 0;
   short2[148] = 0;
   short2[149] = 0;
   short2[150] = 0;
   short2[151] = 0;
   short2[152] = 0;
   short2[153] = 0;
   short2[154] = 0;
   short2[155] = 0;
   short2[156] = 0;
   short2[157] = 0;
   short2[158] = 0;
   short2[159] = 0;
   short2[160] = 0;
   if(f > 0)
   {
      short2[18] += f + " Focus";
   }
   if(f < 0)
   {
      short2[18] += "No Focus";
   }
   if(g > 0)
   {
      if(f > 0)
      {
         short2[18] += " and ";
      }
      short2[18] += p + " Health";
   }
   if(q > 0)
   {
      if(f > 0 || g > 0)
      {
         short2[18] += " and ";
      }
      short2[18] += q * 100 + "% of Total Health";
   }
   if(f + g + q == 0)
   {
      short2[18] = "This move costs nothing";
   }
   if(h != 0)
   {
      short2[18] += ". (CD: " + h + ")";
   }
   _root.hackMove = short2;
   MoveCount++;
};
addNewMove("None");
krinABC1 = _root.KrinLang[KLangChoosen].SKILLTIP;
krinABC2 = _root.KrinLang[KLangChoosen].SKILLTIP2;
krinABC3 = _root.KrinLang[KLangChoosen].SKILLTIP3;
krinABC4 = _root.KrinLang[KLangChoosen].SKILLTIP4;
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 2;
_root.hackMove[9] = 5;
_root.hackMove[17] = krinABC1[0] + "200%" + krinABC2[0] + "5" + krinABC3[0];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 2.5;
_root.hackMove[9] = 8;
_root.hackMove[17] = krinABC1[0] + "250%" + krinABC2[0] + "8" + krinABC3[0];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 2.9;
_root.hackMove[9] = 15;
_root.hackMove[17] = krinABC1[0] + "290%" + krinABC2[0] + "15" + krinABC3[0];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 3.2;
_root.hackMove[9] = 20;
_root.hackMove[17] = krinABC1[0] + "320%" + krinABC2[0] + "20" + krinABC3[0];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 3.5;
_root.hackMove[9] = 30;
_root.hackMove[17] = krinABC1[0] + "350%" + krinABC2[0] + "30" + krinABC3[0];
addNewMove("Wound",0,1,0,7,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,1,"Hit2");
_root.hackMove[2] = 2;
_root.hackMove[13] = "WOUND1";
_root.hackMove[17] = krinABC1[1] + "4" + krinABC2[1] + "10%" + krinABC3[1];
addNewMove("Wound",0,1,0,7,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,1,"Hit2");
_root.hackMove[2] = 2;
_root.hackMove[17] = krinABC1[1] + "8" + krinABC2[1] + "12%" + krinABC3[1];
_root.hackMove[13] = "WOUND2";
addNewMove("Wound",0,1,0,7,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,1,"Hit2");
_root.hackMove[2] = 2;
_root.hackMove[17] = krinABC1[1] + "12" + krinABC2[1] + "15%" + krinABC3[1];
_root.hackMove[13] = "WOUND3";
addNewMove("Break",0,1,0,10,0,3,1,2.5,"Melee","0xFF0000","Attack","BOOM_SLASH","Full Damage",1,0,2,"Hit3");
_root.hackMove[2] = 2;
_root.hackMove[17] = krinABC1[2];
_root.hackMove[13] = "STUN1";
addNewMove("Rage",1,0,1,3,0,7,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,3,"PowerupOffense");
_root.hackMove[17] = krinABC1[3] + "20%" + krinABC2[3] + "4" + krinABC3[3];
_root.hackMove[13] = "RAGE1";
_root.hackMove[0] = "Fire";
addNewMove("Rage",1,0,1,3,0,7,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,3,"PowerupOffense");
_root.hackMove[17] = krinABC1[3] + "25%" + krinABC2[3] + "8" + krinABC3[3];
_root.hackMove[13] = "RAGE2";
_root.hackMove[0] = "Fire";
addNewMove("Rage",1,0,1,3,0,7,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,3,"PowerupOffense");
_root.hackMove[17] = krinABC1[3] + "30%" + krinABC2[3] + "12" + krinABC3[3];
_root.hackMove[13] = "RAGE3";
_root.hackMove[0] = "Fire";
addNewMove("Ironskin",1,0,0,3,0,7,1,0,"Shock","0x99FF00","Attack","BOOM_SPARK","Heal",1,0,4,"PowerupDefense");
_root.hackMove[17] = krinABC1[4] + "100" + krinABC2[4];
_root.hackMove[13] = "IRONSKIN1";
addNewMove("Ironskin",1,0,0,3,0,7,1,0,"Shock","0x99FF00","Attack","BOOM_SPARK","Heal",1,0,4,"PowerupDefense");
_root.hackMove[17] = krinABC1[4] + "150" + krinABC2[4];
_root.hackMove[13] = "IRONSKIN2";
addNewMove("Ironskin",1,0,0,3,0,7,1,0,"Shock","0x99FF00","Attack","BOOM_SPARK","Heal",1,0,4,"PowerupDefense");
_root.hackMove[17] = krinABC1[4] + "200" + krinABC2[4];
_root.hackMove[13] = "IRONSKIN3";
addNewMove("Ironskin",1,0,0,3,0,7,1,0,"Shock","0x99FF00","Attack","BOOM_SPARK","Heal",1,0,4,"PowerupDefense");
_root.hackMove[17] = krinABC1[4] + "250" + krinABC2[4];
_root.hackMove[13] = "IRONSKIN4";
addNewMove("Ironskin",1,0,0,3,0,7,1,0,"Shock","0x99FF00","Attack","BOOM_SPARK","Heal",1,0,4,"PowerupDefense");
_root.hackMove[17] = krinABC1[4] + "300" + krinABC2[4];
_root.hackMove[13] = "IRONSKIN5";
addNewMove("Disrupt",0,1,0,5,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_SPARKBLUE","Focus",1,0,5,"Hit5");
_root.hackMove[9] = -15;
_root.hackMove[17] = krinABC1[5] + 15 + krinABC2[5];
addNewMove("Disrupt",0,1,0,4,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_SPARKBLUE","Focus",1,0,5,"Hit5");
_root.hackMove[9] = -17;
_root.hackMove[17] = krinABC1[5] + 17 + krinABC2[5];
addNewMove("Disrupt",0,1,0,3,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_SPARKBLUE","Focus",1,0,5,"Hit5");
_root.hackMove[9] = -19;
_root.hackMove[17] = krinABC1[5] + 19 + krinABC2[5];
addNewMove("Disrupt",0,1,0,2,0,4,8,1,"Melee","0xFF0000","Attack","BOOM_SPARKBLUE","Focus",1,0,5,"Hit5");
_root.hackMove[9] = -21;
_root.hackMove[17] = krinABC1[5] + 21 + krinABC2[5];
addNewMove("Disrupt",0,1,0,1,0,4,8,1,"Melee","0xFF0000","Attack","BOOM_SPARKBLUE","Focus",1,0,5,"Hit5");
_root.hackMove[9] = -23;
_root.hackMove[17] = krinABC1[5] + 23 + krinABC2[5];
MoveCount = 26;
addNewMove("Cell Reformation",1,0,0,5,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[20] = 1;
_root.hackMove[9] = 60;
_root.hackMove[15] = ["Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Cell Reformation",1,0,0,5,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3.5;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[9] = 80;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Cell Reformation",1,0,0,5,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[9] = 100;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Cell Reformation",1,0,0,5,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[9] = 120;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Cell Reformation",1,0,0,5,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 6;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[20] = 1;
_root.hackMove[9] = 140;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Heroic Motivation",1,0,1,10,0,3,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.7;
_root.hackMove[4] = 1.7;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[7] + "170%" + krinABC2[7] + 1 + krinABC3[7];
addNewMove("Heroic Motivation",1,0,1,10,0,3,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.3000000000000003;
_root.hackMove[4] = 2.3000000000000003;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 2;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[7] + "230%" + krinABC2[7] + 2 + krinABC3[7];
addNewMove("Heroic Motivation",1,0,1,10,0,3,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.9;
_root.hackMove[4] = 2.9;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[7] + "290%" + krinABC2[7] + 3 + krinABC3[7];
addNewMove("Blood Focus",1,0,0,0,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_SPARKBLUE","Focus",1,0.03,8,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 40;
_root.hackMove[17] = krinABC1[8] + 40 + krinABC2[8];
addNewMove("Blood Focus",1,0,0,0,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_SPARKBLUE","Focus",1,0.03,8,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 50;
_root.hackMove[17] = krinABC1[8] + 50 + krinABC2[8];
addNewMove("Blood Focus",1,0,0,0,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_SPARKBLUE","Focus",1,0.03,8,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 60;
_root.hackMove[17] = krinABC1[8] + 60 + krinABC2[8];
addNewMove("Blood Focus",1,0,0,0,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_SPARKBLUE","Focus",1,0.03,8,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 70;
_root.hackMove[17] = krinABC1[8] + 70 + krinABC2[8];
addNewMove("Blood Focus",1,0,0,0,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_SPARKBLUE","Focus",1,0.03,8,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 80;
_root.hackMove[17] = krinABC1[8] + 80 + krinABC2[8];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 60;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 75;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 90;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 110;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 140;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 160;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 180;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 200;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 220;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Blood Strike",0,1,0,0,0,2,1,2,"Melee","0xFF0000","Attack","BOOM_SLASHRED","Full Damage",1,0.05,9,"Hit4");
_root.hackMove[2] = 1.1;
_root.hackMove[9] = 240;
_root.hackMove[17] = krinABC1[0] + "110%" + krinABC2[0] + _root.hackMove[9] + krinABC3[0];
addNewMove("Block",1,0,0,7,0,7,2,1,"Shock","0x99FF00","Heal","BOOM_SHIELD","Heal",1,0,11,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "BLOCK1";
_root.hackMove[17] = krinABC1[11];
addNewMove("Block",1,0,0,6,0,6,2,1,"Shock","0x99FF00","Heal","BOOM_SHIELD","Heal",1,0,11,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "BLOCK1";
_root.hackMove[17] = krinABC1[11];
addNewMove("Block",1,0,0,5,0,5,2,1,"Shock","0x99FF00","Heal","BOOM_SHIELD","Heal",1,0,11,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "BLOCK1";
_root.hackMove[17] = krinABC1[11];
addNewMove("Master Strike",0,1,0,12,0,0,1,2,"Shock","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 8;
_root.hackMove[13] = "WARDENS5";
_root.hackMove[134] = "Melee";
_root.hackMove[103] = "Master Strike2";
_root.hackMove[133] = 99;
_root.hackMove[18] += " CD:6";
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[12];
addNewMove("Master Strike",0,1,0,12,0,4,2,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[7] = 35;
_root.hackMove[8] = 1.2;
_root.hackMove[2] = 1.3000000000000005;
_root.hackMove[6] = 0.9000000000000002;
_root.hackMove[17] = krinABC2[12];
addNewMove("Master Strike",0,1,0,12,0,4,2,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[7] = 40;
_root.hackMove[8] = 1.2;
_root.hackMove[2] = 1.4000000000000001;
_root.hackMove[6] = 1;
_root.hackMove[17] = krinABC2[12];
addNewMove("Master Strike",0,1,0,12,0,4,2,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[7] = 45;
_root.hackMove[8] = 1.2;
_root.hackMove[2] = 1.5;
_root.hackMove[6] = 1.1;
_root.hackMove[17] = krinABC2[12];
addNewMove("Master Strike",0,1,0,12,0,4,2,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[7] = 50;
_root.hackMove[8] = 1.2;
_root.hackMove[2] = 1.6;
_root.hackMove[6] = 1.2;
_root.hackMove[17] = krinABC2[12];
addNewMove("Flame Strike",0,1,0,15,0,3,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,13,"Explode");
_root.hackMove[9] = 75;
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3.5;
_root.hackMove[17] = krinABC1[13];
addNewMove("Sunder",0,1,0,4,0,3,8,1,"Melee","0x99FF00","Attack","BOOM_SLASH2","Full Damage",1,0,14,"Hit4");
_root.hackMove[13] = "SUNDER1";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[14] + "12%" + krinABC2[14] + "12%." + krinABC3[14];
addNewMove("Sunder",0,1,0,4,0,3,8,1,"Melee","0x99FF00","Attack","BOOM_SLASH2","Full Damage",1,0,14,"Hit4");
_root.hackMove[13] = "SUNDER2";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[14] + "14%" + krinABC2[14] + "14%." + krinABC3[14];
addNewMove("Sunder",0,1,0,4,0,3,8,1,"Melee","0x99FF00","Attack","BOOM_SLASH2","Full Damage",1,0,14,"Hit4");
_root.hackMove[13] = "SUNDER3";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[14] + "16%" + krinABC2[14] + "16%." + krinABC3[14];
addNewMove("Sunder",0,1,0,4,0,3,8,1,"Melee","0x99FF00","Attack","BOOM_SLASH2","Full Damage",1,0,14,"Hit4");
_root.hackMove[13] = "SUNDER4";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[14] + "18%" + krinABC2[14] + "18%." + krinABC3[14];
addNewMove("Sunder",0,1,0,4,0,3,8,1,"Melee","0x99FF00","Attack","BOOM_SLASH2","Full Damage",1,0,14,"Hit4");
_root.hackMove[13] = "SUNDER5";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[14] + "20%" + krinABC2[14] + "20%." + krinABC3[14];
addNewMove("Coup De Grace",0,1,0,35,0,8,1,0.7000000000000001,"Melee","0xFFCC00","Attack","BOOM_SLASHRED","Full Damage",1,0,15,"Hit3");
_root.hackMove[2] = 2;
_root.hackMove[7] = 25;
_root.hackMove[8] = 1.5;
_root.hackMove[9] = 240;
_root.hackMove[17] = krinABC1[15] + _root.hackMove[9] + krinABC2[15] + "30%" + krinABC3[15];
addNewMove("Coup De Grace",0,1,0,35,0,8,1,0.7000000000000001,"Melee","0xFFCC00","Attack","BOOM_SLASHRED","Full Damage",1,0,15,"Hit3");
_root.hackMove[2] = 2.100000000000001;
_root.hackMove[7] = 25;
_root.hackMove[8] = 1.5;
_root.hackMove[9] = 400;
_root.hackMove[17] = krinABC1[15] + _root.hackMove[9] + krinABC2[15] + "30%" + krinABC3[15];
addNewMove("Coup De Grace",0,1,0,35,0,8,1,0.7000000000000001,"Melee","0xFFCC00","Attack","BOOM_SLASHRED","Full Damage",1,0,15,"Hit3");
_root.hackMove[2] = 2.2;
_root.hackMove[7] = 25;
_root.hackMove[8] = 1.5;
_root.hackMove[9] = 800;
_root.hackMove[17] = krinABC1[15] + _root.hackMove[9] + krinABC2[15] + "30%" + krinABC3[15];
addNewMove("Cripple",0,1,0,10,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM_SLASH2","Full Damage",1,0,16,"PoisonHit");
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "CRIPPLE1";
_root.hackMove[17] = krinABC1[16] + "30%." + krinABC2[16];
addNewMove("Cripple",0,1,0,10,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM_SLASH2","Full Damage",1,0,16,"PoisonHit");
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "CRIPPLE2";
_root.hackMove[17] = krinABC1[16] + "40%." + krinABC2[16];
addNewMove("Cripple",0,1,0,10,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM_SLASH2","Full Damage",1,0,16,"PoisonHit");
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "CRIPPLE3";
_root.hackMove[17] = krinABC1[16] + "50%." + krinABC2[16];
addNewMove("Quick Strike",0,1,0,0,0,0,1,1.8000000000000005,"Melee","0xFF0000","Attack","","Full Damage",1,0,17,"Hit5");
_root.hackMove[2] = 0.5;
_root.hackMove[4] = 0.5;
_root.hackMove[6] = 0.5;
_root.hackMove[17] = krinABC1[17];
addNewMove("Suppression",1,0,0,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_RED","Heal",1,0,18,"PowerupDefense");
_root.hackMove[13] = "SUPRESSION";
_root.hackMove[17] = krinABC1[18];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 20;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 30;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 40;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 50;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 60;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 70;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 80;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 90;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[13] = "MAGICWOUND";
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 100;
_root.hackMove[4] = 1.2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Electro Bolt",0,1,0,7,0,4,2,3,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,20,"ElectricHit");
_root.hackMove[2] = 1.4000000000000001;
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 1.2;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[20] + "1" + krinABC2[20];
addNewMove("Electro Bolt",0,1,0,6,0,4,2,3,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,20,"ElectricHit");
_root.hackMove[2] = 1.9000000000000001;
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 1.7;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 2;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[20] + "2" + krinABC2[20];
addNewMove("Electro Bolt",0,1,0,5,0,4,2,3,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,20,"ElectricHit");
_root.hackMove[2] = 2.4;
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 2.2;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 3;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[20] + "3" + krinABC2[20];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[21] = 1;
_root.hackMove[13] = "INTERVENTION1";
_root.hackMove[17] = krinABC1[21] + 60 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION2";
_root.hackMove[17] = krinABC1[21] + 100 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION3";
_root.hackMove[17] = krinABC1[21] + 150 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION4";
_root.hackMove[17] = krinABC1[21] + 200 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION5";
_root.hackMove[17] = krinABC1[21] + 260 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION6";
_root.hackMove[17] = krinABC1[21] + 320 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION7";
_root.hackMove[17] = krinABC1[21] + 380 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION8";
_root.hackMove[17] = krinABC1[21] + 440 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION9";
_root.hackMove[17] = krinABC1[21] + 500 + krinABC2[21];
addNewMove("Intervention",1,0,1,7,0,5,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION10";
_root.hackMove[17] = krinABC1[21] + 600 + krinABC2[21];
addNewMove("Flame Blast",0,1,0,25,0,5,1,1,"Missile","0xFFCC00","Krin.Firebolt","BOOM1","Full Damage",1,0,22,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC1[22];
_root.hackMove[13] = "BURNING";
addNewMove("Flame Blast",0,1,0,20,0,5,1,1,"Missile","0xFFCC00","Krin.Firebolt","BOOM1","Full Damage",1,0,22,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC2[22];
_root.hackMove[13] = "BURNING";
addNewMove("Flame Blast",0,1,0,15,0,5,1,1,"Missile","0xFFCC00","Krin.Firebolt","BOOM1","Full Damage",1,0,22,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC2[22];
_root.hackMove[13] = "BURNING";
addNewMove("Shatter Bolt",0,1,0,25,0,8,2,1.5,"Missile","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,23,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.3;
_root.hackMove[8] = 1.5;
_root.hackMove[17] = krinABC1[23] + "50%" + krinABC2[23];
_root.hackMove[29] = "SHATTER";
addNewMove("Shatter Bolt",0,1,0,20,0,8,2,1.5,"Missile","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,23,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.3;
_root.hackMove[8] = 1.7;
_root.hackMove[17] = krinABC1[23] + "70%" + krinABC2[23];
_root.hackMove[13] = "SHATTER";
addNewMove("Shatter Bolt",0,1,0,15,0,8,2,1.5,"Missile","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,23,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.3;
_root.hackMove[8] = 1.9000000000000001;
_root.hackMove[17] = krinABC1[23] + "90%" + krinABC2[23];
_root.hackMove[13] = "SHATTER";
addNewMove("Void",0,1,0,5,0,6,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.2;
_root.hackMove[17] = krinABC1[24] + 3 + krinABC2[24];
_root.hackMove[13] = "VOID1";
addNewMove("Void",0,1,0,5,0,6,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.2;
_root.hackMove[17] = krinABC1[24] + 5 + krinABC2[24];
_root.hackMove[13] = "VOID2";
addNewMove("Void",0,1,0,5,0,6,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.2;
_root.hackMove[17] = krinABC1[24] + 7 + krinABC2[24];
_root.hackMove[13] = "VOID3";
addNewMove("Void",0,1,0,5,0,6,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.2;
_root.hackMove[17] = krinABC1[24] + 12 + krinABC2[24];
_root.hackMove[13] = "VOID4";
addNewMove("Void",0,1,0,5,0,6,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.2;
_root.hackMove[17] = krinABC1[24] + 21 + krinABC2[24];
_root.hackMove[13] = "VOID5";
addNewMove("Re-Energize",1,0,1,0,0,9,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 40;
_root.hackMove[17] = krinABC1[25];
addNewMove("Subversion",1,1,1,15,0,8,1,1.5,"Shock","0x00FFFF","Krin.Icebolt","BOOM_DARK","Heal",1,0,26,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[17] = krinABC1[26];
_root.hackMove[13] = "SUBVERSION";
MoveCount = 500;
addNewMove("Strike",0,1,0,0,0,0,8,1,"Melee","0xFFFFFF","Attack","BOOM_SPARK","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 1;
_root.hackMove[17] = "Attack the target.";
addNewMove("Power Up",1,0,0,25,0,10,8,1,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,0,"PowerupOffense");
_root.hackMove[13] = "POWERUP";
_root.hackMove[17] = "";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "POISONZOMBIE";
_root.hackMove[17] = "";
addNewMove("SWAT Fire",0,1,0,15,0,0,8,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1;
addNewMove("SWAT Heal",1,0,1,22,0,6,8,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 3;
_root.hackMove[17] = "";
addNewMove("SWAT Ray",0,1,0,15,0,5,8,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[13] = "FIRESHOCK";
addNewMove("Ice Strike",0,1,0,10,0,3,8,1,"Melee","0x00FFFF","Attack","BOOM2","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "COLDSOUL";
addNewMove("Shadow Blend",1,0,0,10,0,15,8,1,"Shock","0x9966FF","Attack","BOOM_DARK","Heal",1,0,0,"PowerupDefense");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SPEEDUP";
addNewMove("Re-Energize",1,0,0,0,0,20,1,1,"Shock","0xFFCC00","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "REGENFOC";
_root.hackMove[17] = krinABC1[25];
addNewMove("Re-Energize",0,0,1,0,0,20,1,1,"Shock","0xFFCC00","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "REGENFOC";
_root.hackMove[17] = krinABC1[25];
addNewMove("(Mana) Strike",0,1,0,10,0,0,8,1,"Melee","0xFFFFFF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,0,"Hit2");
_root.hackMove[2] = 1;
_root.hackMove[17] = "Attack the target.";
addNewMove("Emergency Heal",1,0,1,0,0,8,8,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 3;
_root.hackMove[17] = "";
addNewMove("Medic Heal",1,0,1,15,0,0,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 0.3;
_root.hackMove[4] = 2.5;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
addNewMove("Water Bolt",0,1,0,5,0,0,1,1.5,"Missile","0x3399FF","Krin.Iceball","BOOM_SLASHBLUE","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.8;
_root.hackMove[7] = 1.7;
_root.hackMove[13] = "WASHED";
addNewMove("Water Regen",1,0,1,5,0,4,8,1,"Shock","0x66FFFF","Heal","BOOM_SHIELD","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.2;
_root.hackMove[13] = "REGENSHAMAN";
addNewMove("Water Heal",1,0,1,1,0,0,8,1,"Shock","0x66FFFF","Heal","BOOM_HEAL","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.5;
addNewMove("Earth Smash",0,1,0,0,0,4,8,1.6,"Melee","0x996633","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Earth";
_root.hackMove[2] = 2;
_root.hackMove[9] = 5;
addNewMove("Decay",0,1,0,5,0,0,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"PoisonHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 1.2;
_root.hackMove[13] = "DECAY";
addNewMove("BlackOut",0,1,0,6,0,10,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 1.2;
_root.hackMove[13] = "BLACKOUT";
addNewMove("Subversion",1,0,0,10,0,3,1,1.5,"Shock","0x00FFFF","Krin.Icebolt","BOOM_DARK","Full Damage",1,0,26,"PowerupDefense");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SUBVERSION";
addNewMove("Paladin Heal",1,0,1,1000,0,0,8,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 20;
_root.hackMove[17] = "";
addNewMove("Pally Intervention",1,0,1,10,0,24,8,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,21,"PowerupDefense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "INTERVENTION8";
_root.hackMove[17] = krinABC1[21];
addNewMove("Shatter Bolt2",0,1,0,20,0,5,3,1.5,"Missile","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,23,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 1;
_root.hackMove[8] = 1.7;
_root.hackMove[17] = krinABC1[23] + krinABC2[23];
_root.hackMove[13] = "SHATTER2";
addNewMove("Electro Bolt Med",0,1,0,10,0,3,8,3,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,20,"ElectricHit");
_root.hackMove[2] = 0.8;
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 0.8;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[20] + "1" + krinABC2[20];
addNewMove("Void Mob",0,1,0,5,0,3,8,1.5,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM_DARK","Full Damage",1,0,24,"ElectricHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.7000000000000001;
_root.hackMove[17] = krinABC1[24] + 21 + krinABC2[24];
_root.hackMove[13] = "VOIDMOB";
addNewMove("Ignite",0,1,0,5,0,0,8,1.5,"Missile","0xFFCC00","Krin.Firebolt","BOOM1","Full Damage",1,0,24,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 0.5;
_root.hackMove[13] = "IGNITE";
addNewMove("Fate",0,1,0,0,0,2,8,1.5,"Shock","0x9933FF","Krin.Firebolt","BOOM_DARK","Full Damage",1,0,24,"PoisonHit");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0.5;
_root.hackMove[13] = "FATE";
addNewMove("Dark Regen",1,0,0,5,0,9,8,1.5,"Shock","0x9933FF","Krin.Firebolt","BOOM_DARK","Heal",1,0,24,"Healing");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "DARKREGEN";
addNewMove("Doctor\'s Fury",1,0,0,0,0,4,8,1.5,"Shock","0xFF0000","Krin.Firebolt","BOOM_POWERUP","Heal",1,0,24,"PowerupOffense");
_root.hackMove[13] = "DOCTOR";
_root.hackMove[2] = 1.7;
_root.hackMove[4] = 1.7;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 10;
_root.hackMove[19] = -1;
addNewMove("Rage",1,0,0,3,0,7,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,3,"PowerupOffense");
_root.hackMove[17] = krinABC1[3] + "30%" + krinABC2[3] + "12" + krinABC3[3];
_root.hackMove[13] = "RAGE3";
_root.hackMove[0] = "Fire";
addNewMove("Super Heal",1,0,0,0,0,0,8,1.5,"Shock","0x99FF00","Krin.Firebolt","BOOM_HEAL2","Heal",1,0,24,"Healing");
_root.hackMove[9] = 2000000;
addNewMove("Mana Bomb",0,1,0,100,0,0,8,3,"Missile","0x00FFFF","Krin.Iceball","BOOM2","Full Damage",1,0,24,"Explode");
_root.hackMove[9] = 5000;
_root.hackMove[0] = "Ice";
addNewMove("Re-Energize",1,0,0,0,0,5,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 100;
addNewMove("Cell Reformation Shaman",1,0,0,5,0,18,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,6,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[9] = 60;
_root.hackMove[17] = krinABC1[6] + _root.hackMove[9] + krinABC2[6] + (_root.hackMove[2] * 100 + "%") + krinABC3[6];
addNewMove("Fireball",0,1,0,15,0,0,8,1,"Missile","0xFFCC00","Krin.Firebolt","BOOM1","Full Damage",1,0,1,undefined);
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 0.85;
_root.hackMove[17] = "Fire a ball of flame at the target, making them burn.";
_root.hackMove[13] = "BURNS";
addNewMove("Healing Light",1,0,1,10,0,3,8,1,"Shock","0xFFFFFF","Heal","BOOM2","Heal",1,0,2,undefined);
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[17] = "Heal the target.";
addNewMove("Frost Bolt",0,1,0,8,5,6,8,1,"Missile","0x00CCFF","Krin.Icebolt","BOOM2","Full Damage",1,0,3,undefined);
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2.100000000000001;
_root.hackMove[7] = 25;
_root.hackMove[13] = "POISON";
_root.hackMove[14] = 100;
_root.hackMove[17] = "Fire a bolt of ice at the enemy, stunning them.";
addNewMove("Blessing of Light",1,0,1,10,0,5,8,1,"Shock","0xFFFFFF","Heal","BOOM2","Heal",1,0,4,undefined);
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0.5;
_root.hackMove[4] = 0.5;
_root.hackMove[13] = "REGEN";
_root.hackMove[15] = ["Fire","Ice"];
_root.hackMove[16] = 2;
_root.hackMove[19] = -1;
_root.hackMove[17] = "Dispels 2 harmful effects on the target, and heals them every turn for seven turns.";
addNewMove("Paladin Heal",1,0,1,2000,0,0,8,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 50;
_root.hackMove[17] = "Heals Target with a grate a mount of HP";
addNewMove("Flame Bomb",0,1,0,35,0,5,1,1,"Missile","0xFFCC00","Krin.Electrobolt2","BOOM1","Full Damage",1,0,22,"Explode");
_root.hackMove[2] = 2;
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[17] = "Great Missile to destroy Your opponent";
_root.hackMove[13] = "BURNS";
addNewMove("Magic Bolt",0,1,0,20,0,3,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Healing");
_root.hackMove[13] = "POWERUP";
_root.hackMove[0] = "Fire";
_root.hackMove[9] = 110;
_root.hackMove[4] = 2;
_root.hackMove[17] = "Destroy and HELP your oppponent";
addNewMove("Earth Smash",0,1,0,0,0,4,8,1.6,"Melee","0x996633","Attack","BOOM2","Full Damage",1,0,3,"Explode");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 3;
_root.hackMove[9] = 5;
_root.hackMove[17] = "Its time to DESTROY!";
addNewMove("Ice Strike",0,1,0,20,0,3,8,1,"Melee","0x00FFFF","Attack","BOOM2","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2;
_root.hackMove[4] = 2;
_root.hackMove[13] = "COLDSOUL";
addNewMove("Ice Strike",1,0,1,20,0,6,8,1,"Shock","0x00FFFF","Attack","BOOM2","Heal",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 0.5;
_root.hackMove[4] = 0.5;
_root.hackMove[13] = "INTERVENTION11";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Missile","0x99FF00","Krin.Electrobolt2","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 1;
_root.hackMove[13] = "POISONZOMBIE2";
_root.hackMove[17] = "";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Shock","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 2;
_root.hackMove[13] = "POISONZOMBIE3";
_root.hackMove[17] = "";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Melee","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 3;
_root.hackMove[13] = "POISONZOMBIE4";
_root.hackMove[17] = "";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 1.1;
_root.hackMove[4] = 1.1;
_root.hackMove[13] = "POISONZOMBIE5";
_root.hackMove[17] = "";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 0.9;
_root.hackMove[4] = 2;
_root.hackMove[13] = "POISONZOMBIE6";
_root.hackMove[17] = "";
addNewMove("Re-Energize",1,0,1,0,0,5,1,1,"Shock","0x99FF00","Krin.Poisonbolt","BOOM3","Focus",1,0,25,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[9] = 80;
_root.hackMove[13] = "REGENFOC";
_root.hackMove[17] = krinABC1[25];
addNewMove("Heroic Motivation",1,0,1,10,0,8,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 2;
_root.hackMove[4] = 2;
_root.hackMove[13] = "POISONZOMBIE";
_root.hackMove[15] = ["Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[7] + "100%" + krinABC2[7] + 1 + krinABC3[7];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHGREEN","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 4;
_root.hackMove[9] = 50;
_root.hackMove[17] = krinABC1[0] + "250%" + krinABC2[0] + "30" + krinABC3[0];
addNewMove("Smash",0,1,0,15,0,6,8,1,"Shock","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 4;
_root.hackMove[4] = 1;
_root.hackMove[9] = 50;
_root.hackMove[17] = krinABC1[0] + "250%" + krinABC2[0] + "30" + krinABC3[0];
addNewMove("Water Bolt",0,1,0,25,0,2,2,1.5,"Missile","0x3399FF","Krin.Iceball","BOOM_SLASHBLUE","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 1.5;
_root.hackMove[7] = 1.4;
_root.hackMove[13] = "WASHED";
addNewMove("Water Bolt",0,1,0,25,0,1,3,1.5,"Missile","0x3399FF","Krin.Iceball","BOOM_SLASHBLUE","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 0.8;
_root.hackMove[7] = 4.3;
_root.hackMove[13] = "WASHED2";
addNewMove("Water Bolt",0,1,0,35,0,5,4,1.5,"Missile","0x3399FF","Krin.Iceball","BOOM_SLASHBLUE","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 3;
_root.hackMove[7] = 1.4;
_root.hackMove[13] = "WASHED3";
addNewMove("Water Regen",1,0,1,0,0,6,8,1,"Shock","0x66FFFF","Heal","BOOM_SHIELD","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2;
_root.hackMove[13] = "REGENSHAMAN";
addNewMove("Water Heal",1,0,1,200,0,8,8,1,"Shock","0x66FFFF","Heal","BOOM_HEAL","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 5;
addNewMove("Smash",0,1,0,15,0,6,8,1,"Shock","0xFF0000","Attack","BOOM_SLASHGREEN","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 8;
_root.hackMove[9] = 50;
_root.hackMove[17] = krinABC1[0] + "250%" + krinABC2[0] + "30" + krinABC3[0];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[2] = 2;
_root.hackMove[4] = 2;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Sniper Fire",0,1,0,100,0,4,8,1,"Missile","0xFF9900","Krin.Electrobolt","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 4;
addNewMove("Medic Heal",1,0,1,22,0,2,8,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2;
_root.hackMove[13] = "REGENSHAMAN";
_root.hackMove[17] = "";
addNewMove("Sniper Punishment",0,1,0,5,0,7,8,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 0.1;
_root.hackMove[13] = "FIRESHOCK2";
addNewMove("Medic Shield",1,0,1,0,0,6,8,1,"Shock","0x66FFFF","Heal","BOOM_SHIELD","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 3;
_root.hackMove[13] = "REGENSHAMAN";
addNewMove("Coup De Shaman",0,1,0,35,0,8,1,0.7000000000000001,"Melee","0xFFCC00","Attack","BOOM_SLASHRED","Full Damage",1,0,15,"Hit3");
_root.hackMove[2] = 2.1;
_root.hackMove[7] = 30;
_root.hackMove[8] = 1.5;
_root.hackMove[9] = 50;
addNewMove("Master Strike",0,1,0,12,0,4,2,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,12,"Hit2");
_root.hackMove[7] = 100;
_root.hackMove[8] = 1.2;
_root.hackMove[2] = 1.1;
_root.hackMove[6] = 0.8;
_root.hackMove[17] = krinABC1[12];
addNewMove("Earth Strike",0,1,0,15,0,4,8,1,"Missile","0xFF9900","Krin.Electrobolt","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Earth";
_root.hackMove[7] = 100;
_root.hackMove[4] = 4;
addNewMove("Earth Strike",0,1,0,15,0,6,8,1,"Missile","0xFF9900","Krin.Electrobolt","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Earth";
_root.hackMove[7] = 300;
_root.hackMove[2] = 2;
addNewMove("Blood Strike",0,1,0,15,0,4,1,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,27,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[7] = 30;
_root.hackMove[6] = 1.9;
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[27];
addNewMove("Blood Strike",0,1,0,15,0,3,1,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,27,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2;
_root.hackMove[7] = 50;
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC2[27];
addNewMove("Blood Strike",0,1,0,15,0,3,1,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,27,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2.5;
_root.hackMove[7] = 70;
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC3[27];
addNewMove("Blood Strike",0,1,0,15,0,2,2,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,27,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 3;
_root.hackMove[2] = 2;
_root.hackMove[7] = 80;
_root.hackMove[17] = krinABC1[28];
addNewMove("Zombie Frost",0,1,0,15,0,3,8,1,"Missile","0x68CBF4","Krin.Iceblade","BOOM_SLASHBLUE","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "FROSTZOMBIE";
_root.hackMove[17] = "";
addNewMove("Ghost Frost",0,1,0,15,0,4,8,1,"Missile","0x68CBF4","Krin.Iceblade","BOOM_SLASHBLUE","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "FROSTGHOST";
_root.hackMove[17] = "";
addNewMove("Re-Energize",1,0,0,0,0,5,1,1,"Shock","0x99FF00","Krin.Electrobolt2","BOOM1","Focus",1,0,25,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[9] = 100;
_root.hackMove[17] = krinABC1[25];
addNewMove("SWAT Fire",0,1,0,15,0,1,8,1,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1;
addNewMove("Medic Heal",1,0,1,15,0,0,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,7,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 0.5;
_root.hackMove[4] = 2.3;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
addNewMove("ZPCI Fire!",0,1,0,15,0,4,8,1,"Missile","0xFF6600","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 0.6;
_root.hackMove[13] = "FIREZPCI";
_root.hackMove[17] = "";
addNewMove("ZPCI Fire and Kill",0,1,0,50,0,4,8,1,"Missile","0xFF6600","Krin.Firebolt","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 0.8;
_root.hackMove[13] = "FIREZPCI2";
_root.hackMove[17] = "";
addNewMove("ZPCI Dot",0,1,0,15,0,4,8,1,"Missile","0xFF6600","Krin.Firebolt","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 0.9;
_root.hackMove[13] = "FIREZPCI3";
_root.hackMove[17] = "";
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[2] = 4;
_root.hackMove[4] = 4;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[2] = 5;
_root.hackMove[4] = 5;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[13] = "COSMIC3";
_root.hackMove[2] = 3;
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[13] = "COSMIC";
_root.hackMove[2] = 2;
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Magic Bolt",0,1,0,10,0,1,2,2,"Missile","0xFF66FF","Krin.Magicball","BOOM1","Full Damage",1,0,19,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[9] = 10;
_root.hackMove[13] = "COSMIC2";
_root.hackMove[2] = 2;
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC1[19] + _root.hackMove[9] + krinABC2[19];
addNewMove("Daniela\'s WIll",1,0,0,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_DARK","Heal",1,0,18,"PowerupOffense");
_root.hackMove[13] = "COSMIC4";
MoveCount = 900;
addNewMove("Dark Echoes",0,1,0,20,0,3,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,82,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2;
_root.hackMove[4] = 1;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("Dark Echoes",0,1,0,20,0,3,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,82,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.5;
_root.hackMove[4] = 1.5;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("Dark Echoes",0,1,0,22,0,2,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,82,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[4] = 2;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("Dark Echoes",0,1,0,25,0,2,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,82,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3.1;
_root.hackMove[4] = 3;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("Placebo",0,1,0,10,0,3,1,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,83,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1;
_root.hackMove[4] = 2;
_root.hackMove[13] = "C1";
_root.hackMove[17] = krinABC1[83] + _root.hackMove[4] * 100 + krinABC2[83] + _root.hackMove[2] * 100 + krinABC3[83] + "5" + krinABC4[83];
addNewMove("Placebo",0,1,0,20,0,3,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,83,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 2.5;
_root.hackMove[13] = "CV1";
_root.hackMove[17] = krinABC1[83] + _root.hackMove[4] * 100 + krinABC2[83] + _root.hackMove[2] * 100 + krinABC3[83] + "10" + krinABC4[83];
addNewMove("Placebo",0,1,0,20,0,2,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,83,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2;
_root.hackMove[4] = 3;
_root.hackMove[13] = "CV11";
_root.hackMove[17] = krinABC1[83] + _root.hackMove[4] * 100 + krinABC2[83] + _root.hackMove[2] * 100 + krinABC3[83] + "15" + krinABC4[83];
addNewMove("Placebo",0,1,0,30,0,1,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,83,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[4] = 3.1;
_root.hackMove[13] = "CV111";
_root.hackMove[17] = krinABC1[83] + _root.hackMove[4] * 100 + krinABC2[83] + _root.hackMove[2] * 100 + krinABC3[83] + "20" + krinABC4[83];
addNewMove("Shock Therapy",0,1,0,20,0,5,1,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,84,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1;
_root.hackMove[4] = 1;
_root.hackMove[13] = "C2";
_root.hackMove[17] = krinABC1[84] + _root.hackMove[4] * 100 + krinABC2[84] + _root.hackMove[2] * 100 + krinABC3[84] + "10" + krinABC4[84];
addNewMove("Shock Therapy",0,1,0,15,0,5,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,84,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.2;
_root.hackMove[4] = 1.2;
_root.hackMove[13] = "CV2";
_root.hackMove[17] = krinABC1[84] + _root.hackMove[4] * 100 + krinABC2[84] + _root.hackMove[2] * 100 + krinABC3[84] + "15" + krinABC4[84];
addNewMove("Shock Therapy",0,1,0,10,0,5,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,84,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "CV22";
_root.hackMove[17] = krinABC1[84] + _root.hackMove[4] * 100 + krinABC2[84] + _root.hackMove[2] * 100 + krinABC3[84] + "20" + krinABC4[84];
addNewMove("Shock Therapy",0,1,0,5,0,4,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,84,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2;
_root.hackMove[4] = 2;
_root.hackMove[13] = "CV222";
_root.hackMove[17] = krinABC1[84] + _root.hackMove[4] * 100 + krinABC2[84] + _root.hackMove[2] * 100 + krinABC3[84] + "25" + krinABC4[84];
addNewMove("Dark Infusion",0,1,0,0,0,0,1,2,"Melee","0xFF99FF","Attack","BOOM_SLASH","Full Damage",1,0,90,"MagicHit");
_root.hackMove[2] = 1;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1;
_root.hackMove[21] = 1;
_root.hackMove[13] = "PREPARED";
_root.hackMove[17] = krinABC1[90];
addNewMove("Determination",1,0,1,5,0,3,1,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,85,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C3";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[85];
addNewMove("Determination",1,0,1,15,0,3,2,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,85,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C33";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[91];
addNewMove("Empower",1,0,1,5,0,4,1,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,86,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C4";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[86];
addNewMove("Empower",1,0,1,15,0,4,2,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,86,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C44";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[92];
addNewMove("Guardian State",1,0,1,5,0,4,1,1,"Shock","0xFF99FF","Attack","BOOM_HEAL","Heal",1,0,87,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C5";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[87];
addNewMove("Guardian State",1,0,1,15,0,4,2,1,"Shock","0xFF99FF","Attack","BOOM_HEAL","Heal",1,0,87,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C55";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[93];
addNewMove("Sacrifice",1,0,1,5,0,4,1,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,88,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C6";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[88];
addNewMove("Sacrifice",1,0,1,15,0,4,2,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,88,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C66";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[94];
addNewMove("Ultimatum",1,0,0,100,0,99,1,1,"Shock","0xFF99FF","Attack_Upper","BOOM_SHIELD","Heal",1,0,89,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C7";
_root.hackMove[17] = krinABC1[89];
addNewMove("Enrage",1,0,0,100,0,10,1,1,"Shock","0xFF99FF","Attack","BOOM_DARK","Heal",1,0,95,"PowerupOffense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C8";
_root.hackMove[17] = krinABC1[95];
addNewMove("Enrage",1,0,0,100,0,10,1,1,"Shock","0xFF99FF","Attack","BOOM_DARK","Heal",1,0,95,"PowerupOffense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C88";
_root.hackMove[17] = krinABC1[96];
addNewMove("Enrage",1,0,0,100,0,10,1,1,"Shock","0xFF99FF","Attack","BOOM_DARK","Heal",1,0,95,"PowerupOffense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C888";
_root.hackMove[17] = krinABC1[97];
addNewMove("Nerve Shock",0,1,0,0,0,3,1,1,"Missile","0xFF99FF","Krin.Magicbolt","BOOM_SPARK","Full Damage",1,0,98,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[2] = 1;
_root.hackMove[13] = "ENERGYDRAIN";
_root.hackMove[17] = "Deal Damage equal to 200% of your Instinct and 100% of your Strength and afflict the target with Energydrain, draining 3 of the targets focus each turn.";
addNewMove("Nerve Shock",0,1,0,0,0,2,1,1,"Missile","0xFF99FF","Krin.Magicbolt","BOOM_SPARK","Full Damage",1,0,98,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.2;
_root.hackMove[2] = 1.2;
_root.hackMove[13] = "ENERGYDRAIN2";
_root.hackMove[17] = "Deal Damage equal to 220% of your Instinct and 120% of your Strength and afflict the target with Energydrain, draining 5 of the targets focus each turn.";
addNewMove("Nerve Shock",0,1,0,0,0,2,1,1,"Missile","0xFF99FF","Krin.Magicbolt","BOOM_SPARK","Full Damage",1,0,98,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "ENERGYDRAIN3";
_root.hackMove[17] = "Deal Damage equal to 250% of your Instinct and 150% of your Strength and afflict the target with Energydrain, draining 7 of the targets focus each turn.";
addNewMove("Nerve Shock",0,1,0,0,0,2,1,1,"Missile","0xFF99FF","Krin.Magicbolt","BOOM_SPARK","Full Damage",1,0,98,"ElectricHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "ENERGYDRAIN4";
_root.hackMove[17] = "Deal Damage equal to 300% of your Instinct and 250% of your Strength and afflict the target with Energydrain, draining 10 of the targets focus each turn.";
addNewMove("Betrayal",0,1,0,20,0,4,1,1,"Shock","0x6600FF","Attack","BOOM_POWERUP","Full Damage",1,0,99,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 0.5;
_root.hackMove[4] = 0.5;
_root.hackMove[13] = "C9";
_root.hackMove[17] = "Deal Damage equal to 50% of your Instinct and Strength also apply Cosm to the target reducing target\'s Strength and Instinct by 25%.";
addNewMove("High Voltage",0,1,0,200,0,5,1,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,100,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[4] = 3;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("High Voltage",0,1,0,200,0,5,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,100,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4.5;
_root.hackMove[4] = 3.5;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("High Voltage",0,1,0,250,0,5,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,100,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[4] = 4;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("High Voltage",0,1,0,300,0,5,2,2,"Missile","0xFF99FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,100,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5.1;
_root.hackMove[4] = 5;
_root.hackMove[17] = krinABC1[82] + _root.hackMove[4] * 100 + krinABC2[82] + _root.hackMove[2] * 100 + krinABC3[82];
addNewMove("Electric Discharge",0,1,0,200,0,5,1,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,101,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[4] = 4;
_root.hackMove[13] = "C11";
_root.hackMove[17] = krinABC1[101] + _root.hackMove[4] * 100 + krinABC2[101] + _root.hackMove[2] * 100 + krinABC3[101];
addNewMove("Electric Discharge",0,1,0,200,0,5,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,101,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3.5;
_root.hackMove[4] = 4.5;
_root.hackMove[13] = "C11";
_root.hackMove[17] = krinABC1[101] + _root.hackMove[4] * 100 + krinABC2[101] + _root.hackMove[2] * 100 + krinABC3[101];
addNewMove("Electric Discharge",0,1,0,250,0,5,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,101,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[4] = 5;
_root.hackMove[13] = "C11";
_root.hackMove[17] = krinABC1[101] + _root.hackMove[4] * 100 + krinABC2[101] + _root.hackMove[2] * 100 + krinABC3[101];
addNewMove("Electric Discharge",0,1,0,300,0,5,2,2,"Missile","0xFF99FF","Krin.Magicball","BOOM1","Full Damage",1,0,101,"Explode");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[4] = 5.1;
_root.hackMove[13] = "C11";
_root.hackMove[17] = krinABC1[101] + _root.hackMove[4] * 100 + krinABC2[101] + _root.hackMove[2] * 100 + krinABC3[101];
addNewMove("Electron Charge",0,1,0,200,0,5,1,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,102,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3;
_root.hackMove[4] = 3;
_root.hackMove[13] = "C12";
_root.hackMove[17] = krinABC1[102] + _root.hackMove[4] * 100 + krinABC2[102] + _root.hackMove[2] * 100 + krinABC3[102];
addNewMove("Electron Charge",0,1,0,200,0,5,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,102,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3.2;
_root.hackMove[4] = 3.2;
_root.hackMove[13] = "C12";
_root.hackMove[17] = krinABC1[102] + _root.hackMove[4] * 100 + krinABC2[102] + _root.hackMove[2] * 100 + krinABC3[102];
addNewMove("Electron Charge",0,1,0,250,0,5,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,102,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 3.5;
_root.hackMove[4] = 3.5;
_root.hackMove[13] = "C12";
_root.hackMove[17] = krinABC1[102] + _root.hackMove[4] * 100 + krinABC2[102] + _root.hackMove[2] * 100 + krinABC3[102];
addNewMove("Electron Charge",0,1,0,300,0,4,2,2,"Shock","0xFF99FF","Attack","BOOM1","Full Damage",1,0,102,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[4] = 4;
_root.hackMove[13] = "C12";
_root.hackMove[17] = krinABC1[102] + _root.hackMove[4] * 100 + krinABC2[102] + _root.hackMove[2] * 100 + krinABC3[102];
addNewMove("Solitary Confinement",0,1,0,10,0,3,1,1,"Melee","0xFF99FF","Attack_Stab","BOOM_DARK","Full Damage",1,0,103,"sfx_terror");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "C13";
_root.hackMove[17] = "Deal damage equal to 150% of your Strength and Stun the target for 1 Turn. While Stunned the Target also takes 25% extra Damage.";
addNewMove("Insecurity",1,0,1,200,0,3,1,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,104,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C16";
_root.hackMove[17] = krinABC1[104];
addNewMove("Insecurity",1,0,1,200,0,3,2,1,"Shock","0xFF99FF","Attack","BOOM_SHIELD","Heal",1,0,104,"PowerupDefense");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C17";
_root.hackMove[17] = krinABC1[105];
addNewMove("Danielas Big Love",1,0,1,200,0,6,1,1,"Shock","0x6600FF","Attack","BOOM_DARK","Heal",1,0,106,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C14";
_root.hackMove[17] = krinABC1[106];
addNewMove("Danielas Big Love",1,0,1,250,0,5,1,1,"Shock","0x6600FF","Attack","BOOM_DARK","Heal",1,0,106,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C15";
_root.hackMove[17] = krinABC1[107];
addNewMove("Haunt",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,108,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[13] = "C18";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 250% of your Instinct and gain a Buff increasing your Speed by 30%.";
addNewMove("Haunt",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,108,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[13] = "C18";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 300% of your Instinct and gain a Buff increasing your Speed by 30%.";
addNewMove("Haunt",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,108,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3.5;
_root.hackMove[13] = "C18";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 350% of your Instinct and gain a Buff increasing your Speed by 30%.";
addNewMove("Haunt",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,108,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4;
_root.hackMove[13] = "C18";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 400% of your Instinct and gain a Buff increasing your Speed by 30%.";
addNewMove("Dark Lullaby",0,1,0,20,0,5,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,112,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1;
_root.hackMove[2] = 1;
_root.hackMove[13] = "JUSTICEBEDONE";
_root.hackMove[17] = "Deal damage equal to 100% of your Strength and Instinct and also apply a Buff to the target decreasing healing taken.";
addNewMove("Dark Lullaby",0,1,0,20,0,5,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,112,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1.5;
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "JUSTICEBEDONE";
_root.hackMove[17] = "Deal damage equal to 150% of your Strength and Instinct and also apply a Buff to the target decreasing healing taken.";
addNewMove("Dark Lullaby",0,1,0,20,0,5,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,112,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[2] = 2;
_root.hackMove[13] = "JUSTICEBEDONE";
_root.hackMove[17] = "Deal damage equal to 200% of your Strength and Instinct and also apply a Buff to the target decreasing healing taken.";
addNewMove("Dark Lullaby",0,1,0,20,0,5,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,112,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "JUSTICEBEDONE";
_root.hackMove[17] = "Deal damage equal to 250% of your Strength and Instinct and also apply a Buff to the target decreasing healing taken.";
addNewMove("Corruption",1,0,1,30,0,0,1,2,"Shock","0xFF66FF","Attack","BOOM_DARK","Heal",1,0,116,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1;
_root.hackMove[4] = 1;
_root.hackMove[17] = "Heal the target equal to 100% of your Strength and Instinct.";
addNewMove("Wraith Form",1,0,1,20,0,3,1,2,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,117,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[17] = "Dispell 1 Earth, Lightning or Shadow Debuff from the target.";
_root.hackMove[15] = ["Earth","Lightning","Shadow"];
_root.hackMove[16] = 1;
_root.hackMove[14] = 1;
_root.hackMove[19] = -1;
addNewMove("Psychopath Form",1,0,1,200,0,6,1,2,"Shock2","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,118,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[17] = "Dispell 3 Earth, Lightning or Shadow Debuff from the target.";
_root.hackMove[15] = ["Earth","Lightning","Shadow"];
_root.hackMove[16] = 1;
_root.hackMove[14] = 1;
_root.hackMove[19] = -3;
addNewMove("Danielas Big Heart",1,0,1,200,0,5,1,1,"Shock","0xFF99FF","Attack","BOOM_DARK","Heal",1,0,119,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C20";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[119];
addNewMove("Danielas Big Heart",1,0,1,200,0,5,1,1,"Shock","0xFF99FF","Attack","BOOM_DARK","Heal",1,0,119,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "C21";
_root.hackMove[16] = 3;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[120];
addNewMove("Epiphany",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,121,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1.5;
_root.hackMove[2] = 1;
_root.hackMove[13] = "FORCEOFJUSTICE2";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 150% of your Instinct and 100% of your Strength and gain a Buff which increases your Strength and Instinct by 20%.";
addNewMove("Epiphany",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,121,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "FORCEOFJUSTICE3";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 200% of your Instinct and 150% of your Strength and gain a Buff which increases your Strength and Instinct by 25%.";
addNewMove("Epiphany",0,1,0,20,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,121,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[2] = 2;
_root.hackMove[13] = "FORCEOFJUSTICE4";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 250% of your Instinct and 200% of your Strength and gain a Buff which increases your Strength and Instinct by 30%.";
addNewMove("Epiphany",0,1,0,25,0,5,1,1,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,121,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "FORCEOFJUSTICE5";
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 300% of your Instinct and 250% of your Strength and gain a Buff which increases your Strength and Instinct by 40%.";
addNewMove("Superconductor",1,1,1,5,0,10,1,1,"Shock","0xFF66FF","Attack","BOOM_DARK","Full Damage",1,0,122,"MagicHit");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 0.1;
_root.hackMove[6] = _root.hackMove[2];
_root.hackMove[13] = "C222";
_root.hackMove[17] = "Deal Damage equal to 10% of your Speed and Stun the target for 3 turns but targets damage taken is reduced by 100%.";
addNewMove("Vicious Strike",0,1,0,20,0,3,2,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,123,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "C23";
_root.hackMove[14] = 0.3;
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 150% of your Strength and Instinct. You have a 30% Chance to gain Daniela\'s Blood regenerating Health each turn.";
addNewMove("Vicious Strike",0,1,0,20,0,3,2,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,123,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "C23";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 150% of your Strength and Instinct. You have a 50% Chance to gain Daniela\'s Blood regenerating Health each turn.";
addNewMove("Vicious Strike",0,1,0,20,0,3,2,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,123,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "C23";
_root.hackMove[14] = 0.8;
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 150% of your Strength and Instinct. You have a 80% Chance to gain Daniela\'s Blood regenerating Health each turn.";
addNewMove("Vicious Strike",0,1,0,20,0,3,2,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,123,"Slash");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 1.5;
_root.hackMove[4] = 1.5;
_root.hackMove[13] = "C23";
_root.hackMove[14] = 1;
_root.hackMove[21] = 1;
_root.hackMove[17] = "Deal Damage equal to 150% of your Strength and Instinct. You have a 100% Chance to gain Daniela\'s Blood regenerating Health each turn.";
MoveCount = 1000;
addNewMove("Poison Smash",0,1,0,15,0,5,4,1,"Melee","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,29,"Hit3");
_root.hackMove[6] = 1.6;
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "ENVENOM67";
_root.hackMove[14] = 1;
_root.hackMove[17] = krinABC1[29] + "160%" + krinABC2[29] + "50" + krinABC3[29];
addNewMove("Poison Smash",0,1,0,15,0,5,4,1,"Melee","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,29,"Hit3");
_root.hackMove[6] = 2;
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "ENVENOM67A";
_root.hackMove[14] = 1;
_root.hackMove[17] = krinABC1[29] + "200%" + krinABC2[29] + "60" + krinABC3[29];
addNewMove("Poison Smash",0,1,0,15,0,5,4,1,"Melee","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,29,"Hit3");
_root.hackMove[6] = 2.4;
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "ENVENOM67B";
_root.hackMove[14] = 1;
_root.hackMove[17] = krinABC1[29] + "240%" + krinABC2[29] + "70" + krinABC3[29];
addNewMove("Poison Smash",0,1,0,15,0,5,4,1,"Melee","0x99FF00","Attack","BOOM_SLASHGREEN","Full Damage",1,0,29,"Hit3");
_root.hackMove[6] = 2.45;
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "ENVENOM67C";
_root.hackMove[14] = 1;
_root.hackMove[17] = krinABC1[29] + "245%" + krinABC2[29] + "80" + krinABC3[29];
addNewMove("Zombie Poison",0,1,0,15,0,4,3,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,30,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[6] = 1;
_root.hackMove[14] = 1;
_root.hackMove[13] = "POISONDEFENSE";
_root.hackMove[17] = krinABC1[30] + "100%" + krinABC2[30] + "10" + krinABC3[30];
addNewMove("Zombie Poison",0,1,0,15,0,4,3,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,30,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[6] = 1.3;
_root.hackMove[14] = 1;
_root.hackMove[13] = "POISONDEFENSE2";
_root.hackMove[17] = krinABC1[30] + "130%" + krinABC2[30] + "15" + krinABC3[30];
addNewMove("Zombie Poison",0,1,0,15,0,4,3,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,30,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[6] = 1.6;
_root.hackMove[14] = 1;
_root.hackMove[13] = "POISONDEFENSE3";
_root.hackMove[17] = krinABC1[30] + "160%" + krinABC2[30] + "18" + krinABC3[30];
addNewMove("Zombie Poison",0,1,0,15,0,4,3,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,30,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[6] = 1.9;
_root.hackMove[14] = 1;
_root.hackMove[13] = "POISONDEFENSE4";
_root.hackMove[17] = krinABC1[30] + "190%" + krinABC2[30] + "20" + krinABC3[30];
addNewMove("Sharp Senses",1,0,0,0,0,4,2,1,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,31,"PowerupOffense");
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "AWARENESS1";
_root.hackMove[14] = 1;
_root.hackMove[21] = 0;
_root.hackMove[31] = krinABC1[31] + "120%" + krinABC2[31];
addNewMove("Sharp Senses",1,0,0,0,0,4,2,1,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,31,"PowerupOffense");
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "AWARENESS2";
_root.hackMove[14] = 1;
_root.hackMove[21] = 0;
_root.hackMove[31] = krinABC1[31] + "135%" + krinABC2[31];
addNewMove("Sharp Senses",1,0,0,0,0,4,2,1,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,31,"PowerupOffense");
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "AWARENESS3";
_root.hackMove[14] = 1;
_root.hackMove[21] = 0;
_root.hackMove[31] = krinABC1[31] + "150%" + krinABC2[31];
addNewMove("Sharp Senses",1,0,0,0,0,4,2,1,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,31,"PowerupOffense");
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "AWARENESS4";
_root.hackMove[14] = 1;
_root.hackMove[21] = 0;
_root.hackMove[31] = krinABC1[31] + "165%" + krinABC2[31];
addNewMove("Shadow Blend",1,0,1,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_DARK","Heal",1,0,32,"sfx_shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SHADOWBLEND1";
_root.hackMove[14] = 1;
_root.hackMove[32] = 0;
_root.hackMove[17] = krinABC1[32] + "100%" + krinABC2[32];
addNewMove("Shadow Blend",1,0,1,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_DARK","Heal",1,0,32,"sfx_shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SHADOWBLEND2";
_root.hackMove[14] = 1;
_root.hackMove[32] = 0;
_root.hackMove[17] = krinABC1[32] + "200%" + krinABC2[32];
addNewMove("Shadow Blend",1,0,1,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_DARK","Heal",1,0,32,"sfx_shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SHADOWBLEND3";
_root.hackMove[14] = 1;
_root.hackMove[32] = 0;
_root.hackMove[17] = krinABC1[32] + "300%" + krinABC2[32];
addNewMove("Shadow Blend",1,0,1,0,0,5,1,1,"Shock","0xFF0000","Attack","BOOM_DARK","Heal",1,0,32,"sfx_shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SHADOWBLEND4";
_root.hackMove[14] = 1;
_root.hackMove[32] = 0;
_root.hackMove[17] = krinABC1[32] + "400%" + krinABC2[32];
addNewMove("Shadow Smash",0,1,0,15,0,5,2,1,"Melee","0xFF0000","Attack","BOOM_DARK","Full Damage",1,0,33,"Hit3");
_root.hackMove[6] = 1.6;
_root.hackMove[13] = "SHADSHI";
_root.hackMove[14] = 1;
_root.hackMove[21] = 1;
_root.hackMove[0] = "Shadow";
_root.hackMove[17] = krinABC1[33] + "160%" + krinABC2[33] + "50" + krinABC3[33];
addNewMove("Shadow Smash",0,1,0,15,0,5,3,1,"Melee","0xFF0000","Attack","BOOM_DARK","Full Damage",1,0,33,"Hit3");
_root.hackMove[6] = 2;
_root.hackMove[13] = "SHADSHI2";
_root.hackMove[14] = 1;
_root.hackMove[21] = 1;
_root.hackMove[0] = "Shadow";
_root.hackMove[17] = krinABC1[33] + "200%" + krinABC2[33] + "70" + krinABC3[33];
addNewMove("Shadow Smash",0,1,0,15,0,5,3,1,"Melee","0xFF0000","Attack","BOOM_DARK","Full Damage",1,0,33,"Hit3");
_root.hackMove[6] = 2.4;
_root.hackMove[13] = "SHADSHI3";
_root.hackMove[14] = 1;
_root.hackMove[21] = 1;
_root.hackMove[0] = "Shadow";
_root.hackMove[17] = krinABC1[33] + "240%" + krinABC2[33] + "90" + krinABC3[33];
addNewMove("Shadow Smash",0,1,0,15,0,5,3,1,"Melee","0xFF0000","Attack","BOOM_DARK","Full Damage",1,0,33,"Hit3");
_root.hackMove[6] = 2.45;
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "SHADSHI4";
_root.hackMove[14] = 1;
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[33] + "245%" + krinABC2[33] + "100" + krinABC3[33];
MoveCount = 1100;
addNewMove("Impair",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASH2","Full Damage",1,0.08,34,"Hit3");
_root.hackMove[2] = 1.2;
_root.hackMove[13] = "IMPAIR1";
_root.hackMove[17] = krinABC1[34] + 100 * _root.hackMove[2] + krinABC2[34] + "6" + krinABC3[34];
addNewMove("Impair",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASH2","Full Damage",1,0.08,34,"Hit3");
_root.hackMove[2] = 1.4;
_root.hackMove[13] = "IMPAIR2";
_root.hackMove[17] = krinABC1[34] + 100 * _root.hackMove[2] + krinABC2[34] + "9" + krinABC3[34];
addNewMove("Impair",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASH2","Full Damage",1,0.08,34,"Hit3");
_root.hackMove[2] = 1.6;
_root.hackMove[13] = "IMPAIR3";
_root.hackMove[17] = krinABC1[34] + 100 * _root.hackMove[2] + krinABC2[34] + "12" + krinABC3[34];
addNewMove("Impair",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASH2","Full Damage",1,0.08,34,"Hit3");
_root.hackMove[2] = 1.8;
_root.hackMove[13] = "IMPAIR4";
_root.hackMove[17] = krinABC1[34] + 100 * _root.hackMove[2] + krinABC2[34] + "15" + krinABC3[34];
addNewMove("Bloodshed",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0.08,35,"Hit2");
_root.hackMove[2] = 1.2;
_root.hackMove[13] = "BLOODRUSH1";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[35] + 100 * _root.hackMove[2] + krinABC2[35] + "6" + krinABC3[35];
addNewMove("Bloodshed",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0.08,35,"Hit2");
_root.hackMove[2] = 1.4;
_root.hackMove[13] = "BLOODRUSH2";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[35] + 100 * _root.hackMove[2] + krinABC2[35] + "9" + krinABC3[35];
addNewMove("Bloodshed",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0.08,35,"Hit2");
_root.hackMove[2] = 1.6;
_root.hackMove[13] = "BLOODRUSH3";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[35] + 100 * _root.hackMove[2] + krinABC2[35] + "12" + krinABC3[35];
addNewMove("Bloodshed",0,1,0,0,0,1,2,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0.08,35,"Hit2");
_root.hackMove[2] = 1.8;
_root.hackMove[13] = "BLOODRUSH4";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[35] + 100 * _root.hackMove[2] + krinABC2[35] + "15" + krinABC3[35];
addNewMove("Regulate",0,1,0,0,0,0,1,1,"Melee","0x066FF","Attack","BOOM_SPARKBLUE","Focus",1,0.05,36,"PoisonHit");
_root.hackMove[9] = -30;
_root.hackMove[21] = 1;
_root.hackMove[13] = "REGULATE1";
_root.hackMove[15] = ["Physical","Ice","Fire","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[36] + _root.hackMove[16] + krinABC2[36] + "5" + krinABC3[36];
addNewMove("Regulate",0,1,0,0,0,0,1,1,"Melee","0x066FF","Attack","BOOM_SPARKBLUE","Focus",1,0.02,36,"PoisonHit");
_root.hackMove[9] = -30;
_root.hackMove[21] = 1;
_root.hackMove[13] = "REGULATE2";
_root.hackMove[15] = ["Physical","Ice","Fire","Poison"];
_root.hackMove[16] = 2;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[36] + _root.hackMove[16] + krinABC2[36] + "8" + krinABC3[36];
addNewMove("Regulate",0,1,0,0,0,0,1,1,"Melee","0x066FF","Attack","BOOM_SPARKBLUE","Focus",1,0,36,"PoisonHit");
_root.hackMove[9] = -30;
_root.hackMove[21] = 1;
_root.hackMove[13] = "REGULATE3";
_root.hackMove[15] = ["Physical","Ice","Fire","Poison"];
_root.hackMove[16] = 3;
_root.hackMove[19] = 1;
_root.hackMove[17] = krinABC1[36] + _root.hackMove[16] + krinABC2[36] + "11" + krinABC3[36];
addNewMove("Burning Acid",0,1,0,15,0,0,2,99,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,37,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[37] + _root.hackMove[2] + krinABC2[37];
addNewMove("Burning Acid",0,1,0,15,0,0,2,99,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,37,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1.4;
_root.hackMove[17] = krinABC1[37] + _root.hackMove[2] + krinABC2[37];
addNewMove("Burning Acid",0,1,0,15,0,0,2,99,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,37,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1.8;
_root.hackMove[17] = krinABC1[37] + _root.hackMove[2] + krinABC2[37];
addNewMove("Burning Acid",0,1,0,15,0,0,2,99,"Shock","0xFF9900","","BOOM1","Full Damage",1,0,37,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2;
_root.hackMove[17] = krinABC1[37] + _root.hackMove[2] + krinABC2[37];
addNewMove("Heal",1,0,1,22,0,3,2,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,38,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
_root.hackMove[17] = krinABC1[38] + _root.hackMove[2] + krinABC2[38];
addNewMove("Heal",1,0,1,22,0,3,2,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,38,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.4;
_root.hackMove[17] = krinABC1[38] + _root.hackMove[2] + krinABC2[38];
addNewMove("Heal",1,0,1,22,0,3,2,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,38,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.8;
_root.hackMove[17] = krinABC1[38] + _root.hackMove[2] + krinABC2[38];
addNewMove("Heal",1,0,1,22,0,3,2,1,"Shock","0x99FF00","","BOOM_HEAL2","Heal",1,0,38,"Healing");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 3;
_root.hackMove[17] = krinABC1[38] + _root.hackMove[2] + krinABC2[38];
addNewMove("Fireball",0,1,0,15,0,5,1,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,39,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[13] = "FIRESHOCK";
_root.hackMove[17] = krinABC1[39] + _root.hackMove[2] + krinABC2[39];
addNewMove("Fireball",0,1,0,15,0,5,1,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,39,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2.4;
_root.hackMove[13] = "FIRESHOCK";
_root.hackMove[17] = krinABC1[39] + _root.hackMove[2] + krinABC2[39];
addNewMove("Fireball",0,1,0,15,0,5,1,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,39,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2.8;
_root.hackMove[13] = "FIRESHOCK";
_root.hackMove[17] = krinABC1[39] + _root.hackMove[2] + krinABC2[39];
addNewMove("Fireball",0,1,0,15,0,5,2,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,39,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3;
_root.hackMove[13] = "FIRESHOCK";
_root.hackMove[17] = krinABC1[39] + _root.hackMove[2] + krinABC2[39];
addNewMove("Fire",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM_SLASHORANGE","Full Damage",1,0,40,"Fire I");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1.6;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[13] = "FIREI";
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[17] = krinABC1[40] + _root.hackMove[2] * 100 + krinABC2[40];
addNewMove("Fire",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM_SLASHORANGE","Full Damage",1,0,40,"Fire I");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1.7;
_root.hackMove[30] = 0.4;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[29] = "FIREI1";
_root.hackMove[21] = 1;
_root.hackMove[13] = "FIREI";
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[17] = krinABC1[40] + _root.hackMove[2] * 100 + krinABC2[40] + krinABC3[40];
addNewMove("Fire",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM_SLASHORANGE","Full Damage",1,0,40,"Fire I");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1.8;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[30] = 0.4;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI1";
_root.hackMove[13] = "FIREI";
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[17] = krinABC1[40] + _root.hackMove[2] * 100 + krinABC2[40] + krinABC3[40];
addNewMove("Fire",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM_SLASHORANGE","Full Damage",1,0,40,"Fire I");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[30] = 0.4;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI1";
_root.hackMove[13] = "FIREI";
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[17] = krinABC1[40] + _root.hackMove[2] * 100 + krinABC2[40] + krinABC3[40];
addNewMove("Fire II",0,1,0,15,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,41,"Fire II");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 1;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[20] = 1;
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[13] = "FIREI";
_root.hackMove[17] = krinABC1[41] + _root.hackMove[2] * 100 + krinABC2[41];
addNewMove("High Fire II",0,1,0,15,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,42,"Fire II");
_root.hackMove[0] = "Fire";
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[31] = "ENHANCEDFLARE";
_root.hackMove[32] = "ENHANCEDFLARE";
_root.hackMove[40] = "FIREI55";
_root.hackMove[20] = 1;
_root.hackMove[13] = "FIREI";
_root.hackMove[17] = krinABC1[42] + _root.hackMove[2] * 100 + krinABC2[42];
addNewMove("Fire II",0,1,0,15,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,41,"Fire II");
_root.hackMove[0] = "Fire";
_root.hackMove[20] = 1;
_root.hackMove[2] = 1.3;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[21] = 1;
_root.hackMove[31] = "FIREI44";
_root.hackMove[32] = "FIREI55";
_root.hackMove[13] = "FIREI";
_root.hackMove[17] = krinABC1[41] + _root.hackMove[2] * 100 + krinABC2[41];
addNewMove("High Fire II",0,1,0,15,0,0,1,1,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,42,"Fire II");
_root.hackMove[0] = "Fire";
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[31] = "ENHANCEDFLARE";
_root.hackMove[32] = "ENHANCEDFLARE";
_root.hackMove[40] = "FIREI55";
_root.hackMove[20] = 1;
_root.hackMove[13] = "FIREI";
_root.hackMove[17] = krinABC1[42] + _root.hackMove[2] * 100 + krinABC2[42];
addNewMove("Blizzard",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SLASHBLUE","Full Damage",1,0,43,"Blizzard I");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[43] + _root.hackMove[2] * 100 + krinABC2[43];
addNewMove("Blizzard",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SLASHBLUE","Full Damage",1,0,43,"Blizzard I");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.6;
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[17] = krinABC1[43] + _root.hackMove[2] * 100 + krinABC2[43];
addNewMove("Blizzard",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SLASHBLUE","Full Damage",1,0,43,"Blizzard I");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.7;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[17] = krinABC1[43] + _root.hackMove[2] * 100 + krinABC2[43];
addNewMove("Blizzard",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SLASHBLUE","Full Damage",1,0,43,"Blizzard I");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.8;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[17] = krinABC1[43] + _root.hackMove[2] * 100 + krinABC2[43];
addNewMove("Blizzard II",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,44,"Blizzard II");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 0.9;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[44] + _root.hackMove[2] * 100 + krinABC2[44];
addNewMove("High Blizzard II",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,45,"Blizzard II");
_root.hackMove[0] = "Ice";
_root.hackMove[21] = 1;
_root.hackMove[2] = 1.2;
_root.hackMove[20] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[45] + _root.hackMove[2] * 100 + krinABC2[45];
addNewMove("Blizzard II",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,44,"Blizzard II");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.1;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[44] + _root.hackMove[2] * 100 + krinABC2[44];
addNewMove("High Blizzard II",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,45,"Blizzard II");
_root.hackMove[0] = "Ice";
_root.hackMove[21] = 1;
_root.hackMove[2] = 1.2;
_root.hackMove[20] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[45] + _root.hackMove[2] * 100 + krinABC2[45];
addNewMove("Fire III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,46,"Fire III");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.8;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[46] + _root.hackMove[2] * 100 + krinABC2[46];
addNewMove("Fire III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,46,"Fire III");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.9;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[46] + _root.hackMove[2] * 100 + krinABC2[46];
addNewMove("Fire III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,46,"Fire III");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[46] + _root.hackMove[2] * 100 + krinABC2[46];
addNewMove("Fire III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,46,"Fire III");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3.1;
_root.hackMove[33] = ["Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[21] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[46] + _root.hackMove[2] * 100 + krinABC2[46];
addNewMove("Blizzard III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,47,"Blizzard III");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2.6;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[47] + _root.hackMove[2] * 100 + krinABC2[47];
addNewMove("Blizzard III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,47,"Blizzard III");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2.7;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[21] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[47] + _root.hackMove[2] * 100 + krinABC2[47];
addNewMove("Blizzard III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,47,"Blizzard III");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2.8;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[21] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[47] + _root.hackMove[2] * 100 + krinABC2[47];
addNewMove("Blizzard III",0,1,0,20,0,1,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,47,"Blizzard III");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2.9;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[21] = 1;
_root.hackMove[29] = "BLIZZARDI44";
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[40] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[47] + _root.hackMove[2] * 100 + krinABC2[47];
addNewMove("Fire IV",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,48,"Fire IV");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 4;
_root.hackMove[7] = 2;
_root.hackMove[130] = "Blizzard IV";
_root.hackMove[103] = 1;
_root.hackMove[120] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
_root.hackMove[17] = krinABC1[48] + _root.hackMove[2] * 100 + krinABC2[48];
addNewMove("Fire IV",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,48,"Fire IV");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 5;
_root.hackMove[7] = 2;
_root.hackMove[130] = "Blizzard IV";
_root.hackMove[103] = 1;
_root.hackMove[120] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
_root.hackMove[17] = krinABC1[48] + _root.hackMove[2] * 100 + krinABC2[48];
addNewMove("Fire IV",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,48,"Fire IV");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3.3;
_root.hackMove[7] = 2;
_root.hackMove[17] = krinABC1[48] + _root.hackMove[2] * 100 + krinABC2[48];
addNewMove("Fire IV",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,48,"Fire IV");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3.5;
_root.hackMove[7] = 2;
_root.hackMove[17] = krinABC1[48] + _root.hackMove[2] * 100 + krinABC2[48];
addNewMove("Blizzard IV",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,49,"Blizzard IV");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 3;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
addNewMove("Blizzard IV",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,49,"Blizzard IV");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 3.05;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
addNewMove("Blizzard IV",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,49,"Blizzard IV");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 3.1;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
addNewMove("Blizzard IV",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM2","Full Damage",1,0,49,"Blizzard IV");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 3.15;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[49] + _root.hackMove[2] * 100 + krinABC2[49];
addNewMove("Flare",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,50,"Flare");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.5;
_root.hackMove[20] = 1;
_root.hackMove[130] = "Freeze";
_root.hackMove[103] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[120] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[21] = 1;
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[50] + _root.hackMove[2] * 100 + krinABC2[50];
addNewMove("Flare",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,50,"Flare");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[130] = "Freeze";
_root.hackMove[103] = 1;
_root.hackMove[120] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[50] + _root.hackMove[2] * 100 + krinABC2[50];
addNewMove("Flare",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,50,"Flare");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.6;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[20] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[21] = 1;
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[50] + _root.hackMove[2] * 100 + krinABC2[50];
addNewMove("Flare",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,50,"Flare");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.8;
_root.hackMove[33] = ["Fire","Ice"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 2;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[29] = "FIREI44";
_root.hackMove[13] = "FIREI";
_root.hackMove[40] = "FIREI55";
_root.hackMove[17] = krinABC1[50] + _root.hackMove[2] * 100 + krinABC2[50];
addNewMove("Freeze",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM1","Full Damage",1,0,51,"Freeze");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.2;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
addNewMove("Freeze",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM1","Full Damage",1,0,51,"Freeze");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
addNewMove("Freeze",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM1","Full Damage",1,0,51,"Freeze");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.4;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
addNewMove("Freeze",0,1,0,8,0,0,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM1","Full Damage",1,0,51,"Freeze");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "BLIZZARDIV";
_root.hackMove[17] = krinABC1[51] + _root.hackMove[2] * 100 + krinABC2[51];
addNewMove("Transpose",1,0,0,0,0,0,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM_DARK","Heal",1,0,53,"Transpose");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 0;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[17] = krinABC1[53];
addNewMove("Thunder II",0,1,0,4,0,6,1,1,"Shock","0xFFCC00","Krin.Lightningbolt","BOOM3","Full Damage",1,0,54,"Thunder II");
_root.hackMove[0] = "Lightning";
_root.hackMove[2] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[13] = "THUNDERII";
_root.hackMove[29] = "STUN1";
_root.hackMove[17] = krinABC1[54] + _root.hackMove[2] * 100 + krinABC2[54];
addNewMove("Thunder II",0,1,0,4,0,6,1,1,"Shock","0xFFCC00","Krin.Lightningbolt","BOOM3","Full Damage",1,0,54,"Thunder II");
_root.hackMove[0] = "Lightning";
_root.hackMove[2] = 0.6;
_root.hackMove[29] = "STUN1";
_root.hackMove[20] = 1;
_root.hackMove[13] = "THUNDERII";
_root.hackMove[17] = krinABC1[54] + _root.hackMove[2] * 100 + krinABC2[54];
addNewMove("Thunder II",0,1,0,4,0,6,1,1,"Shock","0xFFCC00","Krin.Lightningbolt","BOOM3","Full Damage",1,0,54,"Thunder II");
_root.hackMove[0] = "Lightning";
_root.hackMove[29] = "STUN1";
_root.hackMove[2] = 0.7;
_root.hackMove[20] = 1;
_root.hackMove[13] = "THUNDERII";
_root.hackMove[17] = krinABC1[54] + _root.hackMove[2] * 100 + krinABC2[54];
addNewMove("Thunder IV",0,1,0,4,0,6,1,1,"Shock","0xFFCC00","Krin.Lightningbolt","BOOM3","Full Damage",1,0,55,"Thunder IV");
_root.hackMove[0] = "Lightning";
_root.hackMove[2] = 0.75;
_root.hackMove[29] = "STUN1";
_root.hackMove[20] = 1;
_root.hackMove[13] = "THUNDERIV";
_root.hackMove[17] = krinABC1[54] + _root.hackMove[2] * 100 + krinABC2[54];
addNewMove("Manaward",1,0,0,0,0,5,1,1,"Shock","0xFF9900","","BOOM_DARK","Heal",1,0,56,"Manaward");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 0;
_root.hackMove[21] = 1;
_root.hackMove[13] = "Manaward";
_root.hackMove[17] = krinABC1[56];
MoveCount = 1200;
addNewMove("Riot Blade",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASH","Full Damage",1,0,57,"Riot Blade");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "RIOTBLADE";
_root.hackMove[103] = "Rage of a Guardian";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[57] + _root.hackMove[2] * 100 + krinABC2[57];
addNewMove("Riot Blade",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASH","Full Damage",1,0,57,"Riot Blade");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
_root.hackMove[13] = "RIOTBLADE";
_root.hackMove[103] = "Rage of a Guardian";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[57] + _root.hackMove[2] * 100 + krinABC2[57];
addNewMove("Riot Blade",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASH","Full Damage",1,0,57,"Riot Blade");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "RIOTBLADE";
_root.hackMove[103] = "Royal Authority";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[57] + _root.hackMove[2] * 100 + krinABC2[57];
addNewMove("Riot Blade",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASH","Full Damage",1,0,57,"Riot Blade");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 3;
_root.hackMove[13] = "RIOTBLADE";
_root.hackMove[103] = "Royal Authority";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[57] + _root.hackMove[2] * 100 + krinABC2[57];
addNewMove("Life",0,0,1,0,0,5,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_HEAL","Focus3",1,0,59,"FromNothingImoldLife");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[9] = 100;
_root.hackMove[154] = "NORMAL";
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[59] + _root.hackMove[4] + krinABC2[59] + "FromNothingImoldLife";
addNewMove("Rage of a Guardian",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASHORANGE","Full Damage",1,0,58,"Royal Authority");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
_root.hackMove[13] = "DIVINEMIGHT";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[58] + _root.hackMove[2] * 100 + krinABC2[58];
addNewMove("Rage of a Guardian",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASHORANGE","Full Damage",1,0,58,"Royal Authority");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.2;
_root.hackMove[13] = "DIVINEMIGHT";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[58] + _root.hackMove[2] * 100 + krinABC2[58];
addNewMove("Royal Authority",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASHORANGE","Full Damage",1,0,65,"Royal Authority");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.8;
_root.hackMove[13] = "DIVINEMIGHT";
_root.hackMove[29] = "ATONEMENT";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[58] + _root.hackMove[2] * 100 + krinABC2[58] + krinABC3[58];
addNewMove("Royal Authority",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASHORANGE","Full Damage",1,0,65,"Royal Authority");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 3;
_root.hackMove[13] = "DIVINEMIGHT";
_root.hackMove[29] = "ATONEMENT";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[58] + _root.hackMove[2] * 100 + krinABC2[58] + krinABC3[58];
addNewMove("Holy Spirit",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,59,"Holy Spirit");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[17] = krinABC1[59] + _root.hackMove[4] * 100 + krinABC2[59];
addNewMove("Holy Spirit",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,59,"Holy Spirit");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[17] = krinABC1[59] + _root.hackMove[4] * 100 + krinABC2[59];
addNewMove("Holy Spirit",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,59,"Holy Spirit");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3.2;
_root.hackMove[17] = krinABC1[59] + _root.hackMove[4] * 100 + krinABC2[59];
addNewMove("Holy Spirit",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,59,"Holy Spirit");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3.5;
_root.hackMove[17] = krinABC1[59] + _root.hackMove[4] * 100 + krinABC2[59];
addNewMove("Holy Circle",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,60,"Holy Circle");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1.33333333334;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[60] + _root.hackMove[4] * 100 + krinABC2[60];
addNewMove("Holy Circle",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,60,"Holy Circle");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1.66666666667;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[60] + _root.hackMove[4] * 100 + krinABC2[60];
addNewMove("Holy Circle",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,60,"Holy Circle");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[21] = 1;
_root.hackMove[4] = 2;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[60] + _root.hackMove[4] * 100 + krinABC2[60];
addNewMove("Holy Circle",0,1,0,10,0,1,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,60,"Holy Circle");
_root.hackMove[53] = 4;
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.1;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[60] + _root.hackMove[4] * 100 + krinABC2[60];
addNewMove("Break",0,1,0,0,0,3,1,2.5,"Melee","0xFF0000","Attack","BOOM1","Full Damage",1,0,61,"Hit3");
_root.hackMove[2] = 1;
_root.hackMove[17] = krinABC1[61];
_root.hackMove[13] = "STUN1";
addNewMove("Sheltron",1,0,0,10,0,6,2,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,62,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "SHELTRON";
_root.hackMove[17] = krinABC1[62];
addNewMove("Sheltron",1,0,0,10,0,6,2,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,62,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "SHELTRON2";
_root.hackMove[17] = krinABC2[62];
addNewMove("InterventionH",0,0,1,10,0,6,2,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,63,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "SHELTRON3";
_root.hackMove[17] = krinABC1[63];
addNewMove("InterventionH",0,0,1,10,0,6,2,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,63,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "SHELTRON4";
_root.hackMove[17] = krinABC2[63];
addNewMove("Atonement",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SPARK","Full Damage",1,0,64,"Hit2");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 10;
_root.hackMove[13] = "DIVINEMIGHT2";
_root.hackMove[21] = 1;
_root.hackMove[108] = "ATONEMENT";
_root.hackMove[17] = krinABC1[64] + _root.hackMove[2] * 100 + krinABC2[64];
addNewMove("Atonement",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SPARK","Full Damage",1,0,64,"Hit2");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 15;
_root.hackMove[13] = "DIVINEMIGHT2";
_root.hackMove[21] = 1;
_root.hackMove[108] = "ATONEMENT";
_root.hackMove[17] = krinABC1[64] + _root.hackMove[2] * 100 + krinABC2[64];
addNewMove("Living Dead",1,0,0,0,0,15,1,1,"Shock","0x6633CC","Heal","BOOM_DARK","Heal",1,0,66,"DeathSuspend");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "LIVINGDEAD";
_root.hackMove[17] = krinABC1[66] + krinABC2[66];
addNewMove("Blood Weapon",1,0,0,0,0,6,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,67,"PowerupOffense");
_root.hackMove[17] = krinABC1[67] + "20" + krinABC2[67] + "10" + krinABC3[67];
_root.hackMove[13] = "BLOODWEAPON";
_root.hackMove[0] = "Shadow";
addNewMove("Blood Weapon",1,0,0,0,0,6,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,67,"PowerupOffense");
_root.hackMove[17] = krinABC1[67] + "25" + krinABC2[67] + "15" + krinABC3[67];
_root.hackMove[13] = "BLOODWEAPON1";
_root.hackMove[0] = "Shadow";
addNewMove("Edge of Darkness",0,1,0,30,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,68,"Edge of Shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 3;
_root.hackMove[13] = "DARKSIDE";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[68] + _root.hackMove[2] * 100 + krinABC2[68];
addNewMove("Edge of Darkness",0,1,0,30,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,68,"Edge of Shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 3.5;
_root.hackMove[13] = "DARKSIDE";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[68] + _root.hackMove[2] * 100 + krinABC2[68];
addNewMove("Edge of Shadow",0,1,0,30,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,70,"Edge of Shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 4.6;
_root.hackMove[13] = "DARKSIDE";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[68] + _root.hackMove[2] * 100 + krinABC2[68];
addNewMove("Edge of Shadow",0,1,0,30,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,70,"Edge of Shadow");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 5.2;
_root.hackMove[13] = "DARKSIDE";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[68] + _root.hackMove[2] * 100 + krinABC2[68];
addNewMove("The Blackest Night",1,0,1,30,0,3,2,1,"Shock","0x6633CC","Heal","BOOM_SHIELD","Heal",1,0,69,"The Blackest Night");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "THEBLACKESTNIGHT";
_root.hackMove[17] = krinABC1[69];
addNewMove("Ten",1,1,0,0,0,0,1,1,"Shock","0x6633CC","Heal","BOOM_POWERUP","Heal",1,0,71,"Ten");
_root.hackMove[0] = "Earth";
_root.hackMove[31] = "DUDRA3";
_root.hackMove[32] = "DUDRA6";
_root.hackMove[54] = "DUDRA2";
_root.hackMove[55] = "DUDRA2";
_root.hackMove[13] = "DUDRA";
_root.hackMove[21] = 1;
_root.hackMove[141] = 1;
_root.hackMove[145] = 6;
_root.hackMove[17] = krinABC1[71];
addNewMove("Chi",1,1,0,0,0,0,1,1,"Shock","0x6633CC","Heal","BOOM_POWERUP","Heal",1,0,72,"Chi");
_root.hackMove[0] = "Earth";
_root.hackMove[31] = "DUDRA2";
_root.hackMove[32] = "DUDRA5";
_root.hackMove[54] = "DUDRA4";
_root.hackMove[55] = "DUDRA4";
_root.hackMove[13] = "DUDRA";
_root.hackMove[21] = 1;
_root.hackMove[141] = 1;
_root.hackMove[145] = 6;
_root.hackMove[17] = krinABC1[72];
addNewMove("Jin",1,1,0,0,0,0,1,1,"Shock","0x6633CC","Heal","BOOM_POWERUP","Heal",1,0,73,"Jin");
_root.hackMove[0] = "Earth";
_root.hackMove[31] = "DUDRA4";
_root.hackMove[54] = "DUDRA2";
_root.hackMove[32] = "DUDRA8";
_root.hackMove[55] = "DUDRA2";
_root.hackMove[13] = "DUDRA";
_root.hackMove[21] = 1;
_root.hackMove[141] = 1;
_root.hackMove[145] = 6;
_root.hackMove[17] = krinABC1[73];
addNewMove("Raiton",0,1,0,0,0,3,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,74,"Raiton");
_root.hackMove[0] = "Lightning";
_root.hackMove[6] = 6.5;
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA2";
_root.hackMove[17] = krinABC1[74];
addNewMove("Katon",0,1,0,0,0,3,1,3,"Ninjutsu","0xFFCC00","Krin.Electrobolt2","BOOM1","Full Damage",1,0,75,"Katon");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 3.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[33] = ["Earth","Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[17] = krinABC1[75];
addNewMove("Hyoton",0,1,0,0,0,0,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt2","BOOM2","Full Damage",1,0,76,"Hyoton");
_root.hackMove[0] = "Ice";
_root.hackMove[6] = 3.5;
_root.hackMove[13] = "STUN2";
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA4";
_root.hackMove[17] = krinABC1[76];
addNewMove("Huton",0,1,0,0,0,0,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt2","BOOM_SLASHGREEN","Full Damage",1,0,79,"Huton");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 2.4;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[29] = "STEALTH";
_root.hackMove[13] = "HUTON";
_root.hackMove[17] = krinABC1[79];
addNewMove("Second Wind",1,0,0,0,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,77,"Second Wind");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 5;
_root.hackMove[17] = krinABC1[77] + _root.hackMove[2] * 100 + krinABC2[77];
addNewMove("Bloodbath",1,0,0,0,0,6,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,78,"Bloodbath");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "BLOODBATH";
_root.hackMove[17] = krinABC1[78];
addNewMove("DREAMWITH2",0,1,0,0,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,80,"Assasinate");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2;
_root.hackMove[17] = krinABC1[80] + _root.hackMove[6] * 100 + krinABC2[80];
addNewMove("DREAMWITH2",0,1,0,0,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,80,"Assasinate");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.5;
_root.hackMove[17] = krinABC1[80] + _root.hackMove[6] * 100 + krinABC2[80];
addNewMove("DREAMWITH",0,1,0,0,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"DreamWithinaDream");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 1.25;
_root.hackMove[45] = 3;
_root.hackMove[17] = krinABC3[80] + _root.hackMove[6] * 100 + krinABC2[80];
addNewMove("DREAMWITH",0,1,0,0,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"DreamWithinaDream");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 1.75;
_root.hackMove[45] = 3;
_root.hackMove[17] = krinABC3[80] + _root.hackMove[6] * 100 + krinABC2[80];
addNewMove("Spinning Edge",0,1,0,-5,0,0,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,130,"Spinningedge");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 1.8;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[312] + (_root.hackMove[6] + 1) * 100 + krinABC2[312];
_root.hackMove[121] = krinABC1[313] + (_root.hackMove[6] + 2) * 100 + krinABC2[313];
_root.hackMove[103] = "Gust Slash";
_root.hackMove[130] = "Gust Slash";
_root.hackMove[131] = "Aeolian Edge";
_root.hackMove[17] = krinABC1[130] + _root.hackMove[6] * 100 + krinABC2[130];
addNewMove("Spinning Edge",0,1,0,-5,0,0,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,130,"Spinningedge");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.2;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[312] + (_root.hackMove[6] + 1) * 100 + krinABC2[312];
_root.hackMove[121] = krinABC1[313] + (_root.hackMove[6] + 2) * 100 + krinABC2[313];
_root.hackMove[103] = "Gust Slash";
_root.hackMove[130] = "Gust Slash";
_root.hackMove[131] = "Aeolian Edge";
_root.hackMove[17] = krinABC1[130] + _root.hackMove[6] * 100 + krinABC2[130];
addNewMove("Spinning Edge",0,1,0,-5,0,0,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,130,"Spinningedge");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.5;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[312] + (_root.hackMove[6] + 1) * 100 + krinABC2[312];
_root.hackMove[121] = krinABC1[313] + (_root.hackMove[6] + 2) * 100 + krinABC2[313];
_root.hackMove[103] = "Gust Slash";
_root.hackMove[130] = "Gust Slash";
_root.hackMove[131] = "Aeolian Edge";
_root.hackMove[17] = krinABC1[130] + _root.hackMove[6] * 100 + krinABC2[130];
addNewMove("Spinning Edge",0,1,0,-5,0,0,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,130,"Spinningedge");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3;
_root.hackMove[120] = krinABC1[312] + (_root.hackMove[6] + 1) * 100 + krinABC2[312];
_root.hackMove[121] = krinABC1[313] + (_root.hackMove[6] + 2) * 100 + krinABC2[313];
_root.hackMove[103] = "Gust Slash";
_root.hackMove[17] = krinABC1[130] + _root.hackMove[6] * 100 + krinABC2[130];
addNewMove("Armor Crush",0,1,0,-15,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,131,"Armor Crush");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.6;
_root.hackMove[21] = 1;
_root.hackMove[26] = "HUTON";
_root.hackMove[17] = krinABC1[131] + _root.hackMove[6] * 100 + krinABC2[131];
addNewMove("Armor Crush",0,1,0,-15,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,131,"Armor Crush");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.8;
_root.hackMove[21] = 1;
_root.hackMove[26] = "HUTON";
_root.hackMove[17] = krinABC1[131] + _root.hackMove[6] * 100 + krinABC2[131];
addNewMove("Armor Crush",0,1,0,-15,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,131,"Armor Crush");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3;
_root.hackMove[21] = 1;
_root.hackMove[26] = "HUTON";
_root.hackMove[17] = krinABC1[131] + _root.hackMove[6] * 100 + krinABC2[131];
addNewMove("Armor Crush",0,1,0,-15,0,2,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,131,"Armor Crush");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3.2;
_root.hackMove[21] = 1;
_root.hackMove[26] = "HUTON";
_root.hackMove[17] = krinABC1[131] + _root.hackMove[6] * 100 + krinABC2[131];
addNewMove("Mug",0,1,0,-40,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,132,"Hit3");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 1.5;
_root.hackMove[13] = "VULNERABLITY";
_root.hackMove[17] = krinABC1[132] + _root.hackMove[6] * 100 + krinABC2[132];
addNewMove("Hellfrog Medium",0,1,0,50,0,0,1,3,"Missile","0xFFCC00","Krin.Redbolt2","BOOM1","Full Damage",1,0,133,"Hellfrog Medium");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[133] + _root.hackMove[6] * 100 + krinABC2[133];
addNewMove("Hellfrog Medium",0,1,0,50,0,0,1,3,"Missile","0xFFCC00","Krin.Redbolt2","BOOM1","Full Damage",1,0,133,"Hellfrog Medium");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[133] + _root.hackMove[6] * 100 + krinABC2[133];
addNewMove("Hellfrog Medium",0,1,0,50,0,0,1,3,"Missile","0xFFCC00","Krin.Redbolt2","BOOM1","Full Damage",1,0,133,"Hellfrog Medium");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2.4;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[133] + _root.hackMove[6] * 100 + krinABC2[133];
addNewMove("Hellfrog Medium",0,1,0,50,0,0,1,3,"Missile","0xFFCC00","Krin.Redbolt2","BOOM1","Full Damage",1,0,133,"Hellfrog Medium");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 2.6;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[133] + _root.hackMove[6] * 100 + krinABC2[133];
addNewMove("Bhavacakra",0,1,0,50,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM1","Full Damage",1,0,134,"Bhavacakra");
_root.hackMove[0] = "Magic";
_root.hackMove[6] = 4.5;
_root.hackMove[17] = krinABC1[134] + _root.hackMove[6] * 100 + krinABC2[134];
addNewMove("Bhavacakra",0,1,0,50,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM1","Full Damage",1,0,134,"Bhavacakra");
_root.hackMove[0] = "Magic";
_root.hackMove[6] = 5;
_root.hackMove[17] = krinABC1[134] + _root.hackMove[6] * 100 + krinABC2[134];
addNewMove("Bhavacakra",0,1,0,50,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM1","Full Damage",1,0,134,"Bhavacakra");
_root.hackMove[0] = "Magic";
_root.hackMove[6] = 4.7;
_root.hackMove[17] = krinABC1[134] + _root.hackMove[6] * 100 + krinABC2[134];
addNewMove("Bhavacakra",0,1,0,50,0,0,1,3,"Melee","0xFFCC00","Attack","BOOM1","Full Damage",1,0,134,"Bhavacakra");
_root.hackMove[0] = "Magic";
_root.hackMove[6] = 4.9;
_root.hackMove[17] = krinABC1[134] + _root.hackMove[6] * 100 + krinABC2[134];
addNewMove("Shade Shift",1,0,0,0,0,6,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,135,"PowerupDefense");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "SHADESHIFT";
_root.hackMove[17] = krinABC1[135];
addNewMove("Fuma Shuriken",0,1,0,0,0,0,1,2,"Ninjutsu","0xFFCC00","Krin.Redbolt","BOOM_RED","Full Damage",1,0,137,"Fuma Shuriken");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 4.5;
_root.hackMove[108] = "DUDRA";
_root.hackMove[17] = krinABC1[137];
addNewMove("Misui",1,0,0,0,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,138,"Fuma Shuriken2");
_root.hackMove[0] = "Ice";
_root.hackMove[108] = "DUDRA4";
_root.hackMove[13] = "MISUI";
_root.hackMove[17] = krinABC1[138];
addNewMove("Doton",0,1,0,0,0,0,1,1,"Ninjutsu2","0xFFCC00","Attack","BOOM1","Heal",1,0,139,"Doton");
_root.hackMove[0] = "Earth";
_root.hackMove[20] = 1;
_root.hackMove[13] = "DOTON";
_root.hackMove[6] = 0;
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA4";
_root.hackMove[118] = "DUDRA5";
_root.hackMove[17] = krinABC1[139];
addNewMove("Suiton",0,1,0,0,0,0,1,1,"Ninjutsu2","0xFFCC00","Attack","BOOM_SLASHBLUE","Full Damage",1,0,140,"Fuma Shuriken3");
_root.hackMove[0] = "Ice";
_root.hackMove[21] = 1;
_root.hackMove[27] = 1;
_root.hackMove[13] = "SUITON";
_root.hackMove[29] = "STEALTH";
_root.hackMove[6] = 5;
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA2";
_root.hackMove[118] = "DUDRA8";
_root.hackMove[17] = krinABC1[140];
addNewMove("Stealth",1,0,0,0,0,6,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Fuma Shuriken5");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "STEALTH";
_root.hackMove[17] = krinABC1[141];
addNewMove("NINKI",0,1,0,-5,0,5,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,142,"Fuma Shuriken4");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2;
_root.hackMove[21] = 1;
_root.hackMove[13] = "STEALTH2";
_root.hackMove[17] = krinABC1[142] + _root.hackMove[6] * 100 + krinABC2[142];
addNewMove("NINKI",0,1,0,-5,0,5,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,142,"Fuma Shuriken4");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2.5;
_root.hackMove[13] = "STEALTH3";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[142] + _root.hackMove[6] * 100 + krinABC2[142];
addNewMove("NINKI",0,1,0,-5,0,5,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,142,"Fuma Shuriken4");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3;
_root.hackMove[13] = "STEALTH4";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[142] + _root.hackMove[6] * 100 + krinABC2[142];
addNewMove("NINKI",0,1,0,-5,0,5,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,142,"Fuma Shuriken4");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3.5;
_root.hackMove[21] = 1;
_root.hackMove[13] = "STEALTH5";
_root.hackMove[17] = krinABC1[142] + _root.hackMove[6] * 100 + krinABC2[142];
addNewMove("Donut",0,1,0,0,0,6,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,143,"Fuma Shuriken6");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "FEINT";
_root.hackMove[17] = krinABC1[143];
addNewMove("Cell Reformation",1,0,1,45,0,4,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,144,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.5;
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[144];
addNewMove("Cell Reformation",1,0,1,15,0,4,8,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,144,"Healing");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.5;
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[144];
addNewMove("Re-Energize",1,0,0,0,0,6,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 60;
_root.hackMove[150] = 40;
_root.hackMove[17] = krinABC1[25];
addNewMove("Re-Energize",1,0,0,0,0,6,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 50;
_root.hackMove[17] = krinABC1[25];
addNewMove("Claw",0,1,0,-10,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"Fuma Shuriken7");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 1;
_root.hackMove[45] = 4;
addNewMove("Sonic Howl",0,1,0,0,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM_SLASHORANGE","Full Damage",1,0,81,"Sonic Howl");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Ruby Glow",0,1,0,0,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM_SLASHORANGE","Full Damage",1,0,81,"Ruby Glow");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "RUBYGLOW";
addNewMove("Toxic Crunch",0,1,0,0,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"Toxic Crunch");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 1.5;
_root.hackMove[29] = "POISONZOMBIEC";
_root.hackMove[13] = "PHYSVUL";
addNewMove("Devour",0,1,0,100,0,10,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"Devour");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4.01;
addNewMove("Searing Ray",0,1,0,0,0,5,1,3,"Missile","0xFFCC00","Krin.Redbolt2","BOOM1","Full Damage",1,0,133,"Searing Ray");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 2;
_root.hackMove[13] = "VULNERABLITY2";
addNewMove("Wardens Wrath",0,1,0,0,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,81,"CH2");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Wardens Prepare",1,0,0,-1000,0,15,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"CH");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "WARDENS";
_root.hackMove[29] = "WARDENS2";
_root.hackMove[2] = 1;
_root.hackMove[40] = "WARDENS3";
_root.hackMove[17] = krinABC1[141];
addNewMove("Wardens Slash",0,1,0,0,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"CH3");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 3;
addNewMove("Wardens Slash",0,1,0,1000,0,14,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"CH3");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 6;
_root.hackMove[13] = "VULNERABLITY2";
addNewMove("Wardens Prepare",1,0,0,-500,0,5,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"CH4");
_root.hackMove[0] = "Fire";
_root.hackMove[13] = "WARDENS4";
addNewMove("Wardens Slash",0,1,0,-250,0,8,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"CH3");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
addNewMove("Wardens Fire",0,1,0,750,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"CH5");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 4;
_root.hackMove[13] = "WARDENS5";
addNewMove("Wardens Prepare",1,0,0,0,0,15,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"CH");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 1;
_root.hackMove[13] = "WARDENS6";
_root.hackMove[40] = "WARDENS3";
_root.hackMove[17] = krinABC1[141];
addNewMove("Wardens Slash2",0,1,0,1000,0,14,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"CH3");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 6;
_root.hackMove[13] = "WARDENS5";
addNewMove("Binding Cold",0,1,0,0,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM2","Full Damage",1,0,81,"Golbez2");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 2.5;
_root.hackMove[21] = 0;
_root.hackMove[13] = "BLEED";
_root.hackMove[20] = 1;
addNewMove("Crescent Blade",0,1,0,0,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHORANGE","Full Damage",1,0,81,"Golbez3");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 3;
_root.hackMove[13] = "VULNERABLITY2";
addNewMove("Azdajas Shadow",1,0,0,-150,0,99,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Golbez4");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "GOLBEZ";
_root.hackMove[29] = "GOLBEZ2";
_root.hackMove[17] = krinABC1[141];
addNewMove("Azdajas Shadow",1,0,0,-150,0,15,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Golbez4");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "GOLBEZ";
_root.hackMove[29] = "GOLBEZ2";
_root.hackMove[17] = krinABC1[141];
addNewMove("Shadow Crescent",0,1,0,150,0,8,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,81,"Golbez3");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 4;
_root.hackMove[13] = "VULNERABLITY2";
addNewMove("Black Fang",0,1,0,250,0,99,1,2,"Shock","0xFF66FF","Attack","BOOM_STAR_PURPLE","Full Damage",1,0,81,"Golbez5");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 1;
_root.hackMove[21] = 1;
_root.hackMove[45] = 6;
_root.hackMove[20] = 1;
addNewMove("Lightning Spark",0,1,0,0,0,8,1,2,"Melee","0xFF66FF","Attack","BOOM_STAR_PURPLE","Heal",1,0,81,"Golbez6");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 0;
_root.hackMove[13] = "LIGHTNINGSPARK";
addNewMove("Soul Grasp",0,1,0,150,0,8,1,2,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Soul Grasp");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[21] = 1;
_root.hackMove[45] = 4;
_root.hackMove[20] = 1;
addNewMove("Stack",0,1,0,-150,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP";
_root.hackMove[29] = "GOLBEZ2";
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[141];
addNewMove("Ultima",0,1,0,0,0,6,1,1,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Ultima");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "BLEED2";
_root.hackMove[20] = 1;
addNewMove("Silkspit",0,1,0,0,0,4,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,81,"Silkspit");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
_root.hackMove[21] = 0;
_root.hackMove[13] = "SILKSPIT";
_root.hackMove[20] = 1;
addNewMove("On The Soul",0,1,0,0,0,6,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"On The Soul");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[154] = "NORMAL";
addNewMove("Glaukopsis",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,81,"Glaukopis");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4.5;
_root.hackMove[13] = "VULNERABLITY2";
_root.hackMove[154] = "NORMAL";
addNewMove("Parthenos",1,0,0,0,0,6,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Parthenos");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[154] = "NORMAL";
_root.hackMove[13] = "PARTHENOS";
addNewMove("Soul Grasp",0,1,0,0,0,6,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Dialogos");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 6;
_root.hackMove[154] = "NORMAL";
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Palladion",0,1,0,-25,0,2,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,81,"Palladion");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[154] = "NORMAL";
_root.hackMove[21] = 1;
addNewMove("Laser Beam",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Laser Beam");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 4;
_root.hackMove[23] = "Lightning";
_root.hackMove[24] = 3;
_root.hackMove[154] = "NORMAL";
_root.hackMove[13] = "SHADOWRES";
_root.hackMove[15] = ["Lightning"];
_root.hackMove[16] = 3;
_root.hackMove[19] = 1;
addNewMove("Laser Beam",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Laser Beam");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4;
_root.hackMove[23] = "Shadow";
_root.hackMove[24] = 3;
_root.hackMove[154] = "NORMAL";
_root.hackMove[13] = "LIGHTNINGRES";
_root.hackMove[15] = ["Shadow"];
_root.hackMove[16] = 3;
_root.hackMove[19] = 1;
addNewMove("Laser Beam2",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"Laser Beam2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3;
_root.hackMove[154] = "NORMAL";
addNewMove("Palladion",0,1,0,100,0,99,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,81,"Palladion");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[154] = "NORMAL";
_root.hackMove[29] = "PALLADION";
_root.hackMove[13] = "PARTHENOS2";
addNewMove("Ultima",0,1,0,1000,0,15,1,1,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Mug");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 6;
_root.hackMove[154] = "NORMAL";
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Re-Energize",1,0,0,0,0,6,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 50;
_root.hackMove[13] = "STUN1";
_root.hackMove[17] = krinABC1[25];
addNewMove("Re-Energize",0,1,0,0,0,6,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 25;
_root.hackMove[13] = "STUN1";
_root.hackMove[29] = "POISONZOMBIE";
_root.hackMove[17] = krinABC1[25];
addNewMove("Blizzard",0,1,0,8,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SLASHBLUE","Full Damage",1,0,43,"Blizzard I");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[43] + _root.hackMove[2] * 100 + krinABC2[43];
addNewMove("Blizzard II",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Icebolt","BOOM2","Full Damage",1,0,44,"Blizzard II");
_root.hackMove[0] = "Ice";
_root.hackMove[2] = 0.9;
_root.hackMove[21] = 1;
_root.hackMove[33] = ["Fire"];
_root.hackMove[34] = 99;
_root.hackMove[35] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "BLIZZARDI";
_root.hackMove[32] = "BLIZZARDI44";
_root.hackMove[31] = "BLIZZARDI55";
_root.hackMove[17] = krinABC1[44] + _root.hackMove[2] * 100 + krinABC2[44];
addNewMove("SWAT Ray",0,1,0,30,0,7,8,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[20] = 1;
_root.hackMove[13] = "FIRESHOCK";
addNewMove("Re-Energize",1,0,0,0,0,6,1,1,"Shock","0x00FFFF","Krin.Icebolt","BOOM3","Focus",1,0,25,"ElectricHit");
_root.hackMove[0] = "Lightning";
_root.hackMove[9] = 100;
_root.hackMove[13] = "STUN1";
_root.hackMove[17] = krinABC1[25];
addNewMove("SWAT Ray",0,1,0,10,0,5,8,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[45] = 2;
addNewMove("Rage",1,0,1,3,0,14,1,0,"Shock","0xFF0000","Attack","BOOM_POWERUP","Heal",1,0,3,"PowerupOffense");
_root.hackMove[17] = krinABC1[3] + "20%" + krinABC2[3] + "4" + krinABC3[3];
_root.hackMove[13] = "RAGE1";
_root.hackMove[0] = "Fire";
_root.hackMove[20] = 1;
addNewMove("Water Regen",1,0,1,0,0,6,8,1,"Shock","0x66FFFF","Heal","BOOM_SHIELD","Heal",1,0,0,"Healing");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2;
_root.hackMove[20] = 1;
_root.hackMove[13] = "REGENSHAMAN";
addNewMove("Flare",0,1,0,50,0,10,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,50,"Flare");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 2.5;
_root.hackMove[20] = 1;
_root.hackMove[21] = 1;
_root.hackMove[29] = "SHATTER";
addNewMove("Zombie Poison",0,1,0,30,0,2,8,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 1.6;
_root.hackMove[13] = "POISONZOMBIE";
_root.hackMove[17] = "";
_root.hackMove[20] = 1;
addNewMove("SWAT Ray",0,1,0,10,0,5,8,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM1","Full Damage",1,0,0,"Explode");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2;
_root.hackMove[20] = 1;
_root.hackMove[45] = 2;
addNewMove("Toxic Crunch",0,1,0,0,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"Toxic Crunch");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 1.5;
_root.hackMove[13] = "VULNERABLITY2";
addNewMove("Fire IV2",0,1,0,8,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,48,"Fire IV");
_root.hackMove[0] = "Fire";
_root.hackMove[2] = 3.5;
_root.hackMove[17] = krinABC1[48] + _root.hackMove[2] * 100 + krinABC2[48];
addNewMove("Thunder IV",0,1,0,4,0,6,1,1,"Shock","0xFFCC00","Krin.Lightningbolt","BOOM3","Full Damage",1,0,55,"Thunder IV");
_root.hackMove[0] = "Lightning";
_root.hackMove[2] = 0.75;
_root.hackMove[29] = "STUN1";
_root.hackMove[20] = 1;
_root.hackMove[13] = "THUNDERIV";
_root.hackMove[17] = krinABC1[54] + _root.hackMove[2] * 100 + krinABC2[54];
addNewMove("Raiton",0,1,0,0,0,0,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,74,"Raiton");
_root.hackMove[0] = "Lightning";
_root.hackMove[6] = 6.5;
_root.hackMove[108] = "DUDRA";
_root.hackMove[13] = "RAIJUREADY";
_root.hackMove[21] = 1;
_root.hackMove[117] = "DUDRA2";
_root.hackMove[17] = krinABC1[74];
addNewMove("Raiton",0,1,0,0,0,0,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,74,"Raiton");
_root.hackMove[0] = "Lightning";
_root.hackMove[6] = 13;
_root.hackMove[108] = "DUDRA";
_root.hackMove[13] = "RAIJUREADY";
_root.hackMove[21] = 1;
_root.hackMove[117] = "DUDRA2";
_root.hackMove[17] = krinABC2[74];
addNewMove("Katon",0,1,0,0,0,0,1,3,"Ninjutsu","0xFFCC00","Krin.Electrobolt2","BOOM1","Full Damage",1,0,75,"Katon");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 3.5;
_root.hackMove[20] = 1;
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA3";
_root.hackMove[17] = krinABC1[75];
addNewMove("Goka Mekkyaku",0,1,0,0,0,0,1,3,"Ninjutsu","0xFFCC00","Krin.Electrobolt2","BOOM1","Full Damage",1,0,315,"Katon");
_root.hackMove[0] = "Fire";
_root.hackMove[6] = 6.5;
_root.hackMove[20] = 1;
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA3";
_root.hackMove[17] = krinABC2[75];
addNewMove("Bunshin",1,0,0,50,0,0,1,3,"Ninjutsu2","0xFFCC00","Krin.Electrobolt2","BOOM_SHIELD","Heal",1,0,145,"XAngriff");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 0;
_root.hackMove[21] = 1;
_root.hackMove[18] += " CD:9";
_root.hackMove[29] = "BUNSHIN";
_root.hackMove[103] = "Phantomkamaitachi";
_root.hackMove[17] = krinABC1[145];
MoveCount = 1500;
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2.2;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[130] = "Aero in Green";
_root.hackMove[131] = "Water in Blue";
_root.hackMove[120] = krinABC1[147] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[147];
_root.hackMove[121] = krinABC1[148] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[148];
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2.8;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[130] = "Aero in Green";
_root.hackMove[131] = "Water in Blue";
_root.hackMove[120] = krinABC1[147] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[147];
_root.hackMove[121] = krinABC1[148] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[148];
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3.4;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[147] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[147];
_root.hackMove[121] = krinABC1[148] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[148];
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[130] = "Aero in Green";
_root.hackMove[131] = "Water in Blue";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3.8;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[147] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[147];
_root.hackMove[121] = krinABC1[148] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[148];
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[130] = "Aero in Green";
_root.hackMove[131] = "Water in Blue";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 4.4;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[147] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[147];
_root.hackMove[121] = krinABC1[148] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[148];
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[130] = "Aero in Green";
_root.hackMove[131] = "Water in Blue";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Fireinred2",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,149,"Fireinred2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1.2;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[300] + (_root.hackMove[4] + 0.2) * 100 + krinABC2[300];
_root.hackMove[121] = krinABC1[301] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[301];
_root.hackMove[103] = "Aeroingreen2";
_root.hackMove[130] = "Aero II in Green";
_root.hackMove[131] = "Water II in Blue";
_root.hackMove[17] = krinABC1[149] + _root.hackMove[4] * 100 + krinABC2[149];
addNewMove("Fireinred2",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,149,"Fireinred2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1.4;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[300] + (_root.hackMove[4] + 0.2) * 100 + krinABC2[300];
_root.hackMove[121] = krinABC1[301] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[301];
_root.hackMove[103] = "Aeroingreen2";
_root.hackMove[130] = "Aero II in Green";
_root.hackMove[131] = "Water II in Blue";
_root.hackMove[17] = krinABC1[149] + _root.hackMove[4] * 100 + krinABC2[149];
addNewMove("Fireinred2",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,149,"Fireinred2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 1.6;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[300] + (_root.hackMove[4] + 0.2) * 100 + krinABC2[300];
_root.hackMove[121] = krinABC1[301] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[301];
_root.hackMove[20] = 1;
_root.hackMove[103] = "Aeroingreen2";
_root.hackMove[130] = "Aero II in Green";
_root.hackMove[131] = "Water II in Blue";
_root.hackMove[17] = krinABC1[149] + _root.hackMove[4] * 100 + krinABC2[149];
addNewMove("Holyinwhite",0,1,0,3,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,150,"Holyinwhite");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4.2;
_root.hackMove[20] = 1;
_root.hackMove[108] = "WHITEPAINT";
_root.hackMove[13] = "BLIND";
_root.hackMove[105] = 0.5;
_root.hackMove[17] = krinABC1[150] + _root.hackMove[4] * 100 + krinABC2[150];
addNewMove("Holyinwhite",0,1,0,3,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,150,"Holyinwhite");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4.6;
_root.hackMove[20] = 1;
_root.hackMove[108] = "WHITEPAINT";
_root.hackMove[13] = "BLIND";
_root.hackMove[105] = 0.5;
_root.hackMove[17] = krinABC1[150] + _root.hackMove[4] * 100 + krinABC2[150];
addNewMove("Holyinwhite",0,1,0,3,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,150,"Holyinwhite");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 5.2;
_root.hackMove[20] = 1;
_root.hackMove[108] = "WHITEPAINT";
_root.hackMove[13] = "BLIND";
_root.hackMove[105] = 0.5;
_root.hackMove[17] = krinABC1[150] + _root.hackMove[4] * 100 + krinABC2[150];
addNewMove("Subtractivepalette",1,0,0,0,0,0,1,3,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_POWERUP","Heal",1,0,152,"Subtractivepalette");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[21] = 1;
_root.hackMove[104] = -50;
_root.hackMove[29] = "SUBTRACTIVEPALETTE";
_root.hackMove[107] = "BLACKPAINT";
_root.hackMove[108] = "WHITEPAINT";
_root.hackMove[17] = krinABC1[152];
_root.hackMove[18] = " Palette Gauge Cost: 50";
addNewMove("Blizzardincyan",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,153,"Blizzardincyan");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 5.2;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[103] = "Stoneinyellow";
_root.hackMove[106] = 3;
_root.hackMove[130] = "Stone in Yellow";
_root.hackMove[131] = "Thunder in Magenta";
_root.hackMove[120] = krinABC1[302] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[302];
_root.hackMove[121] = krinABC1[303] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[303];
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[153] + _root.hackMove[4] * 100 + krinABC2[153];
addNewMove("Blizzardincyan",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,153,"Blizzardincyan");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 6.3;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[130] = "Stone in Yellow";
_root.hackMove[131] = "Thunder in Magenta";
_root.hackMove[120] = krinABC1[302] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[302];
_root.hackMove[121] = krinABC1[303] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[303];
_root.hackMove[103] = "Stoneinyellow";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[153] + _root.hackMove[4] * 100 + krinABC2[153];
addNewMove("Blizzardincyan",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,153,"Blizzardincyan");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 7;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[130] = "Stone in Yellow";
_root.hackMove[131] = "Thunder in Magenta";
_root.hackMove[120] = krinABC1[302] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[302];
_root.hackMove[121] = krinABC1[303] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[303];
_root.hackMove[103] = "Stoneinyellow";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[153] + _root.hackMove[4] * 100 + krinABC2[153];
addNewMove("Blizzardincyan",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,153,"Blizzardincyan");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 8;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[130] = "Stone in Yellow";
_root.hackMove[131] = "Thunder in Magenta";
_root.hackMove[120] = krinABC1[302] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[302];
_root.hackMove[121] = krinABC1[303] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[303];
_root.hackMove[103] = "Stoneinyellow";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[153] + _root.hackMove[4] * 100 + krinABC2[153];
addNewMove("Blizzardincyan2",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,154,"Blizzardincyan2");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[304] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[304];
_root.hackMove[121] = krinABC1[305] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[305];
_root.hackMove[20] = 1;
_root.hackMove[130] = "Stone II in Yellow";
_root.hackMove[131] = "Thunder II in Magenta";
_root.hackMove[103] = "Stoneinyellow2";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[154] + _root.hackMove[4] * 100 + krinABC2[154];
addNewMove("Blizzardincyan2",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,154,"Blizzardincyan2");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2.4;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[304] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[304];
_root.hackMove[121] = krinABC1[305] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[305];
_root.hackMove[20] = 1;
_root.hackMove[130] = "Stone II in Yellow";
_root.hackMove[131] = "Thunder II in Magenta";
_root.hackMove[103] = "Stoneinyellow2";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[154] + _root.hackMove[4] * 100 + krinABC2[154];
addNewMove("Blizzardincyan2",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,154,"Blizzardincyan2");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 2.6;
_root.hackMove[21] = 1;
_root.hackMove[157] = 1;
_root.hackMove[120] = krinABC1[304] + (_root.hackMove[4] + 0.4) * 100 + krinABC2[304];
_root.hackMove[121] = krinABC1[305] + (_root.hackMove[4] + 0.8) * 100 + krinABC2[305];
_root.hackMove[20] = 1;
_root.hackMove[130] = "Stone II in Yellow";
_root.hackMove[131] = "Thunder II in Magenta";
_root.hackMove[103] = "Stoneinyellow2";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[154] + _root.hackMove[4] * 100 + krinABC2[154];
addNewMove("Cometinblack",0,1,0,4,0,0,1,1,"Shock","0x9966CC","Krin.Firebolt","BOOM1","Full Damage",1,0,151,"Cometinblack");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 7.8;
_root.hackMove[20] = 1;
_root.hackMove[108] = "BLACKPAINT";
_root.hackMove[13] = "DAMAGEDOWN";
_root.hackMove[105] = 0.5;
_root.hackMove[17] = krinABC1[151] + _root.hackMove[4] * 100 + krinABC2[151];
addNewMove("Cometinblack",0,1,0,4,0,0,1,1,"Shock","0x9966CC","Krin.Firebolt","BOOM1","Full Damage",1,0,151,"Cometinblack");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 8.8;
_root.hackMove[20] = 1;
_root.hackMove[108] = "BLACKPAINT";
_root.hackMove[13] = "DAMAGEDOWN";
_root.hackMove[105] = 0.5;
_root.hackMove[17] = krinABC1[151] + _root.hackMove[4] * 100 + krinABC2[151];
addNewMove("Temperacoat",1,0,0,0,0,8,1,3,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_SHIELD","Heal",1,0,155,"Temperacoat");
_root.hackMove[0] = "Earth";
_root.hackMove[4] = 0;
_root.hackMove[13] = "TEMPERACOAT";
_root.hackMove[17] = krinABC1[155];
addNewMove("Temperagrassa",1,0,0,0,0,8,1,3,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_SHIELD","Heal",1,0,156,"Temperacoat");
_root.hackMove[0] = "Earth";
_root.hackMove[4] = 0;
_root.hackMove[20] = 1;
_root.hackMove[13] = "TEMPERACOAT";
_root.hackMove[17] = krinABC1[156];
addNewMove("Pommotif",1,0,0,0,0,0,1,1,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_POWERUP","Heal",1,0,157,"Pommotif");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[18] += " CD:6";
_root.hackMove[21] = 1;
_root.hackMove[103] = "Pommuse";
_root.hackMove[17] = krinABC1[157];
addNewMove("Hammermotif",1,0,0,0,0,0,1,1,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_POWERUP","Heal",1,0,158,"Pommotif");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[103] = "Hammer Stamp";
_root.hackMove[20] = 1;
_root.hackMove[18] += " CD:6";
_root.hackMove[7] = 10;
_root.hackMove[14] = 0.5;
_root.hackMove[17] = krinABC1[158];
addNewMove("Starryskymotif",1,0,0,0,0,0,1,1,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_POWERUP","Heal",1,0,159,"Starryskymotif");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[103] = "Starrymuse";
_root.hackMove[18] += " CD:12";
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[159];
addNewMove("Starprism",0,1,0,0,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,160,"Starprism");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 14;
_root.hackMove[111] = 4;
_root.hackMove[20] = 1;
_root.hackMove[108] = "STARSTRUCK";
_root.hackMove[105] = 0.4;
_root.hackMove[17] = krinABC1[160];
addNewMove("Lucid Dreaming",1,0,0,0,0,10,1,1,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM3","Heal",1,0,161,"PCT3");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[150] = 60;
_root.hackMove[13] = "LUCIDDREAMING";
_root.hackMove[17] = krinABC1[161];
addNewMove("Addle",0,1,0,0,0,6,1,1,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM3","Heal",1,0,162,"PCT2");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[13] = "ADDLE";
_root.hackMove[17] = krinABC1[162];
addNewMove("Aeroingreen",0,1,0,3,0,0,1,1,"Missile","0xFF9900","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,146,"Aeroingreen");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 2.6;
_root.hackMove[21] = 1;
_root.hackMove[103] = "Waterinblue";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Waterinblue",0,1,0,3,0,0,1,1,"Missile","0xFF9900","Krin.Icebolt","BOOM_SPARKBLUE","Full Damage",1,0,146,"Waterinblue");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[103] = "Fireinred";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
MoveCount = 1600;
addNewMove("Jolt",0,1,0,2,0,0,1,1,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM3","Full Damage",1,0,163,"Jolt");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 1.7;
_root.hackMove[113] = 6;
_root.hackMove[114] = 6;
_root.hackMove[17] = krinABC1[163] + _root.hackMove[4] * 100 + krinABC2[163];
addNewMove("Jolt2",0,1,0,2,0,0,1,1,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM3","Full Damage",1,0,164,"Jolt2");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 2.8;
_root.hackMove[113] = 6;
_root.hackMove[114] = 6;
_root.hackMove[17] = krinABC1[163] + _root.hackMove[4] * 100 + krinABC2[163];
addNewMove("Jolt3",0,1,0,2,0,0,1,1,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM3","Full Damage",1,0,165,"Jolt3");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 3.6;
_root.hackMove[113] = 6;
_root.hackMove[114] = 6;
_root.hackMove[17] = krinABC1[163] + _root.hackMove[4] * 100 + krinABC2[163];
addNewMove("Verthunder",0,1,0,3,0,4,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,166,"Verthunder");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 3;
_root.hackMove[13] = "VERFIRE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[113] = 18;
_root.hackMove[112] = 1;
_root.hackMove[17] = krinABC1[166] + _root.hackMove[4] * 100 + krinABC2[166];
addNewMove("Verthunder",0,1,0,3,0,4,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,166,"Verthunder");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 3.6;
_root.hackMove[13] = "VERFIRE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[113] = 18;
_root.hackMove[112] = 1;
_root.hackMove[17] = krinABC1[166] + _root.hackMove[4] * 100 + krinABC2[166];
addNewMove("Verthunder3",0,1,0,3,0,4,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,167,"Verthunder3");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4.4;
_root.hackMove[13] = "VERFIRE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[113] = 18;
_root.hackMove[112] = 1;
_root.hackMove[17] = krinABC1[166] + _root.hackMove[4] * 100 + krinABC2[166];
addNewMove("Veraero",0,1,0,3,0,4,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,168,"Veraero");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 3;
_root.hackMove[13] = "VERSTONE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[112] = 1;
_root.hackMove[114] = 18;
_root.hackMove[17] = krinABC1[168] + _root.hackMove[4] * 100 + krinABC2[168];
addNewMove("Veraero",0,1,0,3,0,4,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,168,"Veraero");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 3.6;
_root.hackMove[13] = "VERSTONE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[112] = 1;
_root.hackMove[114] = 18;
_root.hackMove[17] = krinABC1[168] + _root.hackMove[4] * 100 + krinABC2[168];
addNewMove("Veraero3",0,1,0,3,0,4,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,169,"Veraero3");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 4.4;
_root.hackMove[13] = "VERSTONE";
_root.hackMove[14] = 0.5;
_root.hackMove[21] = 1;
_root.hackMove[114] = 18;
_root.hackMove[112] = 1;
_root.hackMove[17] = krinABC1[168] + _root.hackMove[4] * 100 + krinABC2[168];
addNewMove("Verthunder2",0,1,0,4,0,0,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,170,"Verthunder2");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 1;
_root.hackMove[13] = "VERFIRE4";
_root.hackMove[20] = 1;
_root.hackMove[113] = 14;
_root.hackMove[17] = krinABC1[170] + _root.hackMove[4] * 100 + krinABC2[170];
addNewMove("Verthunder2",0,1,0,4,0,0,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,170,"Verthunder2");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 1.2;
_root.hackMove[13] = "VERFIRE4";
_root.hackMove[20] = 1;
_root.hackMove[113] = 14;
_root.hackMove[17] = krinABC1[170] + _root.hackMove[4] * 100 + krinABC2[170];
addNewMove("Verthunder2",0,1,0,4,0,0,1,1,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,170,"Verthunder2");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 1.4;
_root.hackMove[13] = "VERFIRE4";
_root.hackMove[20] = 1;
_root.hackMove[113] = 14;
_root.hackMove[17] = krinABC1[170] + _root.hackMove[4] * 100 + krinABC2[170];
addNewMove("Veraero2",0,1,0,3,0,0,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,171,"Veraero2");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 1;
_root.hackMove[20] = 1;
_root.hackMove[13] = "VERSTONE4";
_root.hackMove[114] = 14;
_root.hackMove[17] = krinABC1[171] + _root.hackMove[4] * 100 + krinABC2[171];
addNewMove("Veraero2",0,1,0,3,0,0,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,171,"Veraero2");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 1.2;
_root.hackMove[20] = 1;
_root.hackMove[13] = "VERSTONE4";
_root.hackMove[114] = 14;
_root.hackMove[17] = krinABC1[171] + _root.hackMove[4] * 100 + krinABC2[171];
addNewMove("Veraero2",0,1,0,3,0,0,1,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,171,"Veraero2");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 1.4;
_root.hackMove[20] = 1;
_root.hackMove[13] = "VERSTONE4";
_root.hackMove[114] = 14;
_root.hackMove[17] = krinABC1[171] + _root.hackMove[4] * 100 + krinABC2[171];
addNewMove("Scatter",0,1,0,4,0,4,1,1,"Shock","0x9966CC","KRIN.SHADOWSHOCK","BOOM1","Full Damage",1,0,172,"Scatter");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 1.2;
_root.hackMove[113] = 9;
_root.hackMove[20] = 1;
_root.hackMove[112] = 1;
_root.hackMove[114] = 9;
_root.hackMove[17] = krinABC1[172] + _root.hackMove[4] * 100 + krinABC2[172];
addNewMove("Impact",0,1,0,4,0,4,1,1,"Shock","0x9966CC","KRIN.SHADOWSHOCK","BOOM1","Full Damage",1,0,173,"Impact");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 2.1;
_root.hackMove[112] = 1;
_root.hackMove[113] = 9;
_root.hackMove[114] = 9;
_root.hackMove[20] = 1;
_root.hackMove[17] = krinABC1[172] + _root.hackMove[4] * 100 + krinABC2[172];
addNewMove("Riposte",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASHRED","Full Damage",1,0,174,"Riposte");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3;
_root.hackMove[113] = -20;
_root.hackMove[120] = krinABC1[306] + (_root.hackMove[4] + 0.6) * 100 + krinABC2[306];
_root.hackMove[121] = krinABC1[307] + (_root.hackMove[4] + 2.3) * 100 + krinABC2[307];
_root.hackMove[122] = krinABC1[308] + (_root.hackMove[4] + 3.2) * 100 + krinABC2[308];
_root.hackMove[123] = krinABC1[309] + (_root.hackMove[4] + 3.2) * 100 + krinABC2[309];
_root.hackMove[124] = krinABC1[310] + (_root.hackMove[4] + 4) * 100 + krinABC2[310];
_root.hackMove[126] = krinABC1[311] + (_root.hackMove[4] + 5) * 100 + krinABC2[311];
_root.hackMove[21] = 1;
_root.hackMove[114] = -20;
_root.hackMove[106] = 6;
_root.hackMove[125] = "Scorch";
_root.hackMove[127] = "Verflare";
_root.hackMove[128] = "Verholy";
_root.hackMove[129] = "Resolution";
_root.hackMove[130] = "Zwerchhau";
_root.hackMove[131] = "Redoublement";
_root.hackMove[18] = "Black and White Mana Cost: 20 (50 for the full combo)";
_root.hackMove[103] = "Zwerchhau";
_root.hackMove[17] = krinABC1[174] + _root.hackMove[4] * 100 + krinABC2[174];
addNewMove("Manafication",1,0,0,0,0,12,1,1,"Shock","0xFF9900","Attack","BOOM_POWERUP","Heal",1,0,175,"Manafication");
_root.hackMove[0] = "Fire";
_root.hackMove[13] = "MANAFICATION";
_root.hackMove[113] = 50;
_root.hackMove[114] = 50;
_root.hackMove[17] = krinABC1[175];
addNewMove("Embolden",1,0,0,0,0,0,1,1,"Shock","0x9966CC","Attack","BOOM_POWERUP","Heal",1,0,176,"Embolden");
_root.hackMove[0] = "Shadow";
_root.hackMove[13] = "EMBOLDEN";
_root.hackMove[20] = 1;
_root.hackMove[18] += " CD:12";
_root.hackMove[103] = "Veilofthorns";
_root.hackMove[17] = krinABC1[176];
addNewMove("Prefulgence",0,1,0,0,0,0,1,1,"Shock","0xFF9900","Attack","BOOM_DARK","Full Damage",1,0,178,"Prefulgence");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 12;
_root.hackMove[20] = 1;
_root.hackMove[108] = "MANAFICATION3";
_root.hackMove[105] = 0.65;
_root.hackMove[17] = krinABC1[178];
addNewMove("Vercure",1,0,1,5,0,0,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,177,"Vercure");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3.5;
_root.hackMove[15] = ["Physical","Magic","Ice","Fire","Lightning","Earth","Shadow","Poison"];
_root.hackMove[16] = 1;
_root.hackMove[19] = -1;
_root.hackMove[17] = krinABC1[177];
addNewMove("Acceleration",1,0,0,0,0,5,1,1,"Shock","0xFF9900","Attack","BOOM_POWERUP","Heal",1,0,179,"Acceleration");
_root.hackMove[0] = "Fire";
_root.hackMove[13] = "ACCELERATION";
_root.hackMove[29] = "ACCELERATION2";
_root.hackMove[17] = krinABC1[179];
addNewMove("Acceleration",1,0,0,0,0,0,1,1,"Shock","0xFF9900","Attack","BOOM_POWERUP","Heal",1,0,179,"Acceleration");
_root.hackMove[0] = "Fire";
_root.hackMove[13] = "ACCELERATION";
_root.hackMove[29] = "ACCELERATION2";
_root.hackMove[103] = "Acceleration";
_root.hackMove[17] = krinABC1[179];
addNewMove("Verfire",0,1,0,2,0,0,1,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM_SLASHORANGE","Full Damage",1,0,180,"Verfire");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3;
_root.hackMove[113] = 15;
_root.hackMove[13] = "VERFIRE2";
_root.hackMove[29] = "VERFIRE3";
_root.hackMove[108] = "VERFIRE";
_root.hackMove[17] = krinABC1[180] + _root.hackMove[4] * 100 + krinABC2[180] + _root.hackMove[4] * 100 + krinABC3[180];
addNewMove("Verfire",0,1,0,2,0,0,1,1,"Missile","0xFF9900","Krin.Electrobolt2","BOOM_SLASHORANGE","Full Damage",1,0,180,"Verfire");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3.8;
_root.hackMove[113] = 15;
_root.hackMove[13] = "VERFIRE2";
_root.hackMove[29] = "VERFIRE3";
_root.hackMove[108] = "VERFIRE";
_root.hackMove[17] = krinABC1[180] + _root.hackMove[4] * 100 + krinABC2[180] + _root.hackMove[4] * 100 + krinABC3[180];
addNewMove("Break",0,1,0,0,0,3,1,2,"Melee","0xFF0000","Attack","BOOM_SLASH","Full Damage",1,0,181,"Hit3");
_root.hackMove[2] = 0;
_root.hackMove[17] = krinABC1[181];
_root.hackMove[13] = "STUN1";
addNewMove("Zombie Poison",0,1,0,15,0,2,8,1,"Missile","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Poison";
_root.hackMove[2] = 2.6;
_root.hackMove[13] = "POISONZOMBIE";
_root.hackMove[17] = "";
_root.hackMove[103] = "Emergency Destruct";
addNewMove("Strike",0,1,0,0,0,0,8,1,"Melee","0xFFFFFF","Attack","BOOM_SPARK","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 1;
_root.hackMove[21] = 1;
_root.hackMove[13] = "VERAFOCUS";
_root.hackMove[17] = "Attack the target.";
MoveCount = 1700;
addNewMove("Bloody Scratch",0,1,0,0,0,25,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"Bloodyscratch");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("One-two-paw",1,0,0,0,0,25,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Onetwopaw");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[116] = -1;
_root.hackMove[13] = "ONETWOPAW";
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -2;
_root.hackMove[20] = 1;
_root.hackMove[59] = 0.5;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -3;
_root.hackMove[115] = 1;
_root.hackMove[20] = 1;
addNewMove("Biscuitmaker",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_DARK","Full Damage",1,0,81,"Biscuitmaker");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 6;
_root.hackMove[116] = -4;
addNewMove("Nine Lives",1,0,0,5,0,25,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,177,"PCT6");
_root.hackMove[0] = "Magic";
_root.hackMove[116] = -5;
_root.hackMove[13] = "NINELIVES";
addNewMove("One-two-paw",1,0,0,0,0,25,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Onetwopaw");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[116] = -6;
_root.hackMove[13] = "ONETWOPAW";
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -7;
_root.hackMove[20] = 1;
_root.hackMove[59] = 0.5;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -8;
_root.hackMove[20] = 1;
_root.hackMove[115] = 1;
addNewMove("Nine Lives",0,0,1,5,0,25,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,177,"PCT7");
_root.hackMove[0] = "Magic";
_root.hackMove[116] = -9;
_root.hackMove[103] = "Cooldown";
_root.hackMove[13] = "NINELIVES2";
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -10;
_root.hackMove[59] = 0.5;
_root.hackMove[20] = 1;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -11;
_root.hackMove[115] = 1;
_root.hackMove[20] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,25,1,1,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Clawful");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 12;
_root.hackMove[116] = -12;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Nine Lives",1,0,0,5,0,25,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,177,"PCT6");
_root.hackMove[0] = "Magic";
_root.hackMove[116] = -13;
_root.hackMove[13] = "NINELIVES";
addNewMove("One-two-paw",1,0,0,0,0,25,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"LOnetwopaw");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[116] = -14;
_root.hackMove[13] = "LONETWOPAW";
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -15;
_root.hackMove[20] = 1;
_root.hackMove[13] = "BLEED";
_root.hackMove[59] = 0.5;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -16;
_root.hackMove[20] = 1;
_root.hackMove[115] = 1;
addNewMove("Nine Lives",0,0,1,5,0,25,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,177,"PCT7");
_root.hackMove[0] = "Magic";
_root.hackMove[116] = -17;
_root.hackMove[13] = "NINELIVES3";
addNewMove("Stack",0,1,0,0,0,25,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP2";
_root.hackMove[20] = 1;
_root.hackMove[116] = -18;
_root.hackMove[21] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,25,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Grimalkingale");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 14;
_root.hackMove[116] = -19;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -19;
_root.hackMove[13] = "BLEED";
_root.hackMove[59] = 0.5;
_root.hackMove[20] = 1;
addNewMove("One-two-paw",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Onetwopaw2");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -20;
_root.hackMove[115] = 1;
_root.hackMove[20] = 1;
addNewMove("Predaceous Pounce",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Predaceouspounce");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[116] = -21;
_root.hackMove[13] = "BLEED5";
addNewMove("Predaceous Pounce",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Predaceouspounce");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[116] = -22;
_root.hackMove[13] = "BLEED5";
addNewMove("Predaceous Pounce",0,1,0,0,0,25,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Predaceouspounce");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[116] = -23;
_root.hackMove[13] = "BLEED5";
addNewMove("Fightorflight",1,0,0,0,0,6,1,1,"Shock","0x9966CC","Attack","BOOM_POWERUP","Heal",1,0,182,"Cometinblack2");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "FIGHTORFLIGHT";
_root.hackMove[17] = krinABC1[182];
addNewMove("Fightorflight",1,0,0,0,0,0,1,1,"Shock","0x9966CC","Attack","BOOM_POWERUP","Heal",1,0,182,"Cometinblack2");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "FIGHTORFLIGHT";
_root.hackMove[103] = "Goring Blade";
_root.hackMove[17] = krinABC1[182];
addNewMove("Mug",0,1,0,-40,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,132,"Hit3");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 1.5;
_root.hackMove[13] = "VULNERABLITY";
_root.hackMove[17] = krinABC1[132] + _root.hackMove[6] * 100 + krinABC2[132];
addNewMove("Dokumori",0,1,0,-40,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHGREEN","Full Damage",1,0,183,"Hit3");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 3;
_root.hackMove[67] = 1;
_root.hackMove[13] = "VULNERABLITY";
_root.hackMove[29] = "HIGI";
_root.hackMove[17] = krinABC1[132] + _root.hackMove[6] * 100 + krinABC2[183];
addNewMove("Trick Attack",0,1,0,0,0,10,1,2,"Melee","0xFF66FF","Attack","BOOM_DARK","Full Damage",1,0,184,"FF1");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 4;
_root.hackMove[13] = "TRICKATTACK";
_root.hackMove[17] = krinABC1[184] + _root.hackMove[6] * 100 + krinABC2[184];
addNewMove("Kunai\'s Bane",0,1,0,0,0,10,1,2,"Shock","0xFF66FF","Attack","BOOM_DARK","Full Damage",1,0,185,"FF2");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 6;
_root.hackMove[105] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[13] = "TRICKATTACK";
_root.hackMove[17] = krinABC3[184] + _root.hackMove[6] * 100 + krinABC4[184];
addNewMove("Fireinred",0,1,0,3,0,0,1,2,"Missile","0xFF9900","Krin.Firebolt","BOOM1","Full Damage",1,0,146,"Fireinred");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3.8;
_root.hackMove[21] = 1;
_root.hackMove[120] = "SUBTRACTIVEPALETTE";
_root.hackMove[103] = "Aeroingreen";
_root.hackMove[17] = krinABC1[146] + _root.hackMove[4] * 100 + krinABC2[146];
addNewMove("Blizzardincyan",0,1,0,4,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM2","Full Damage",1,0,153,"Blizzardincyan");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 6.5;
_root.hackMove[21] = 1;
_root.hackMove[119] = "SUBTRACTIVEPALETTE";
_root.hackMove[103] = "Stoneinyellow";
_root.hackMove[106] = 3;
_root.hackMove[18] += " Requires Subtractive Palette";
_root.hackMove[17] = krinABC1[153] + _root.hackMove[4] * 100 + krinABC2[153];
addNewMove("Riot Blade",0,1,0,0,0,0,1,1,"Melee","0xFF9900","Attack","BOOM_SLASH","Full Damage",1,0,57,"Riot Blade");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2.5;
_root.hackMove[13] = "RIOTBLADE";
_root.hackMove[103] = "Royal Authority";
_root.hackMove[21] = 1;
_root.hackMove[17] = krinABC1[57] + _root.hackMove[2] * 100 + krinABC2[57];
MoveCount = 1800;
addNewMove("Call Me Honey",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF5");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
addNewMove("Tempting Twist",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF4");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -1;
_root.hackMove[13] = "TEMPTINGTWIST";
addNewMove("Tempting Twist2",0,1,0,0,0,31,1,99,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"FF7");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4;
_root.hackMove[116] = -2;
_root.hackMove[13] = "BLEED6";
_root.hackMove[102] = "Melee";
_root.hackMove[133] = 99;
_root.hackMove[20] = 1;
addNewMove("Honey Beeline",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF4");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -3;
_root.hackMove[13] = "HONEYBEELINE";
addNewMove("Honey Beeline2",0,1,0,0,0,31,1,99,"Shock","0xFF66FF","Attack","BOOM_SLASH2","Full Damage",1,0,81,"FF6");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4;
_root.hackMove[116] = -4;
_root.hackMove[13] = "BLEED6";
_root.hackMove[134] = "Melee";
_root.hackMove[133] = 99;
_root.hackMove[20] = 1;
addNewMove("Honey B. Live",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF9");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 5;
_root.hackMove[116] = -5;
_root.hackMove[13] = "LOVE0";
_root.hackMove[29] = "HONEYBEELIVE";
_root.hackMove[20] = 1;
_root.hackMove[67] = 1;
addNewMove("Love Me Tender",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF11");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1;
_root.hackMove[21] = 1;
_root.hackMove[135] = 1;
_root.hackMove[116] = -6;
_root.hackMove[13] = "HONEYBEELIVE1";
_root.hackMove[20] = 1;
addNewMove("Blowkiss",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF14");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[116] = -7;
_root.hackMove[13] = "BLOWKISS";
addNewMove("Blowkiss",0,1,0,0,0,31,1,99,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"FF13");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 1.5;
_root.hackMove[21] = 1;
_root.hackMove[135] = 1;
_root.hackMove[116] = -8;
_root.hackMove[20] = 1;
addNewMove("Honey B. Final",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF12");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4;
_root.hackMove[116] = -9;
_root.hackMove[20] = 1;
_root.hackMove[135] = -4;
_root.hackMove[15] = ["Magic"];
_root.hackMove[16] = 99;
_root.hackMove[19] = 1;
addNewMove("Splash of Venom",1,0,0,0,0,31,1,1,"Shock","0x99FF00","Attack","BOOM_POWERUP","Heal",1,0,81,"FF17");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 0;
_root.hackMove[116] = -10;
_root.hackMove[13] = "SPLASHOFVENOM";
addNewMove("Tempting Twist3",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF4");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -11;
_root.hackMove[13] = "TEMPTINGTWIST";
addNewMove("Tempting Twist2",0,1,0,0,0,31,1,99,"Shock","0x99FF00","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"FF18");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4;
_root.hackMove[116] = -12;
_root.hackMove[13] = "BLEED6";
_root.hackMove[102] = "Melee";
_root.hackMove[133] = 99;
_root.hackMove[20] = 1;
addNewMove("Drop of Venom",1,0,0,0,0,31,1,1,"Shock","0x99FF00","Attack","BOOM_POWERUP","Heal",1,0,81,"FF17");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 0;
_root.hackMove[116] = -13;
_root.hackMove[13] = "DROPOFVENOM";
addNewMove("Honey Beeline",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF4");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[116] = -14;
_root.hackMove[13] = "HONEYBEELINE";
addNewMove("Honey Beeline2",0,1,0,0,0,31,1,99,"Shock","0xFF66FF","Attack","BOOM_SLASH2","Full Damage",1,0,81,"FF21");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4;
_root.hackMove[116] = -15;
_root.hackMove[13] = "BLEED6";
_root.hackMove[134] = "Melee";
_root.hackMove[133] = 99;
_root.hackMove[20] = 1;
addNewMove("Honey B. Live2",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF9");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 5;
_root.hackMove[116] = -16;
_root.hackMove[13] = "LOVE0";
_root.hackMove[29] = "HONEYBEELIVE3";
_root.hackMove[20] = 1;
_root.hackMove[67] = 1;
addNewMove("Love Me Tender2",0,1,0,0,0,31,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP3";
_root.hackMove[20] = 1;
_root.hackMove[116] = -17;
_root.hackMove[21] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF20");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 12;
_root.hackMove[21] = 1;
_root.hackMove[135] = 1;
_root.hackMove[116] = -18;
_root.hackMove[13] = "HONEYBEELIVE4";
_root.hackMove[20] = 1;
addNewMove("Tempting Twist3",1,0,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"FF4");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[116] = -20;
_root.hackMove[13] = "TEMPTINGTWIST";
addNewMove("Tempting Twist2",0,1,0,0,0,31,1,99,"Shock","0x99FF00","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"FF7");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[116] = -21;
_root.hackMove[13] = "BLEED6";
_root.hackMove[102] = "Melee";
_root.hackMove[135] = 1;
_root.hackMove[133] = 99;
_root.hackMove[20] = 1;
addNewMove("Honey B. Final2",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF12");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4;
_root.hackMove[116] = -22;
_root.hackMove[20] = 1;
_root.hackMove[135] = -4;
_root.hackMove[15] = ["Magic"];
_root.hackMove[16] = 99;
_root.hackMove[19] = 1;
addNewMove("Honeyed Breeze",0,1,0,0,0,31,1,6,"Missile","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,81,"FF26");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 6;
_root.hackMove[20] = 1;
_root.hackMove[136] = 0.334;
_root.hackMove[116] = -23;
addNewMove("Rotten Heart",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF5");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[137] = "BEELOVEDVENOMA";
_root.hackMove[116] = -24;
addNewMove("Call Me Honey2",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF5");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[116] = -26;
addNewMove("Call Me Honey3",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF5");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[116] = -28;
addNewMove("Call Me Honey4",0,1,0,0,0,31,1,1,"Shock","0xFF66FF","Attack","BOOM_SPARKBLUE","Full Damage",1,0,81,"FF5");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[116] = -30;
addNewMove("Foul",0,1,0,0,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,186,"Foul");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 8;
_root.hackMove[20] = 1;
_root.hackMove[108] = "POLYGOT";
_root.hackMove[105] = 0.4;
_root.hackMove[17] = krinABC1[186] + _root.hackMove[2] * 100 + krinABC2[186];
addNewMove("Foul",0,1,0,0,0,0,1,1,"Shock","0xFF9900","Krin.Firebolt","BOOM_SPARK","Full Damage",1,0,186,"Foul");
_root.hackMove[0] = "Shadow";
_root.hackMove[2] = 11;
_root.hackMove[20] = 1;
_root.hackMove[108] = "POLYGOT";
_root.hackMove[105] = 0.4;
_root.hackMove[17] = krinABC1[186] + _root.hackMove[2] * 100 + krinABC2[186];
addNewMove("Stone II",0,1,0,0,0,0,1,2,"Missile","0x5E503C","Krin.EARTHBOLT","BOOM_SPARK","Full Damage",1,0,1010,"Stone II");
_root.hackMove[0] = "Earth";
_root.hackMove[13] = "STONEFOCUS";
_root.hackMove[4] = 2.2;
_root.hackMove[21] = 1;
addNewMove("Cure",1,0,1,10,0,2,1,2,"Shock","0x5E503C","Attack","BOOM_HEAL","Heal",1,0,1010,"Healing");
_root.hackMove[0] = "Earth";
_root.hackMove[13] = "WATERREADY";
_root.hackMove[4] = 4.2;
_root.hackMove[21] = 1;
_root.hackMove[14] = 0.3;
addNewMove("Water",0,1,0,10,0,0,1,1.5,"Missile","0x3399FF","Krin.Iceball","BOOM_SLASHBLUE","Full Damage",1,0,0,"PoisonHit");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 4.4;
_root.hackMove[29] = "TORNADO";
_root.hackMove[13] = "DROWN";
_root.hackMove[67] = 1;
_root.hackMove[74] = 0.5;
_root.hackMove[97] = "DROWN2";
_root.hackMove[108] = "WATERREADY";
addNewMove("Aero II",0,1,0,20,0,4,1,1,"Shock","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,168,"Veraero");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 1.5;
_root.hackMove[74] = 0.25;
_root.hackMove[29] = "TORNADO";
_root.hackMove[13] = "AEROII";
_root.hackMove[67] = 1;
addNewMove("Tornado",0,1,0,20,0,4,1,1,"Shock","0x99FF00","Krin.Poisonbolt","BOOM_SLASHGREEN","Full Damage",1,0,168,"Veraero2");
_root.hackMove[0] = "Poison";
_root.hackMove[4] = 4;
_root.hackMove[105] = 0.5;
_root.hackMove[74] = 0.25;
_root.hackMove[29] = "CUREII";
_root.hackMove[13] = "TORNADO2";
_root.hackMove[67] = 1;
_root.hackMove[20] = 1;
_root.hackMove[108] = "TORNADO";
addNewMove("Cure II",1,0,1,20,0,0,1,2,"Shock","0x5E503C","Attack","BOOM_HEAL","Heal",1,0,1010,"Healing");
_root.hackMove[0] = "Earth";
_root.hackMove[13] = "WATERREADY";
_root.hackMove[4] = 8.2;
_root.hackMove[21] = 1;
_root.hackMove[14] = 1;
_root.hackMove[108] = "CUREII";
addNewMove("Strike",0,1,0,0,0,0,8,1,"Melee","0xFFFFFF","Attack","BOOM_SPARK","Full Damage",1,0,0,"Assasinate");
_root.hackMove[2] = 1.1;
_root.hackMove[21] = 1;
_root.hackMove[45] = 2;
_root.hackMove[13] = "STONEFOCUS2";
_root.hackMove[17] = "Attack the target.";
addNewMove("Decimation",0,1,0,10,0,3,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Slash");
_root.hackMove[0] = "Physical";
_root.hackMove[59] = 0.2;
addNewMove("Kill",0,1,0,30,0,8,1,1,"Melee","0xFF66FF","Attack","BOOM_RED","Full Damage",1,0,81,"Hit3");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 0;
_root.hackMove[115] = 1;
_root.hackMove[138] = -8;
addNewMove("Death awaits you",0,1,0,0,0,6,1,2,"Melee","0xFF66FF","Attack","BOOM_DARK","Full Damage",1,0,132,"Hit4");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 2;
_root.hackMove[13] = "DEATHAWAITS";
addNewMove("Kamikaze",0,1,0,0,0,99,8,1,"Shock","0xFF9900","Attack","BOOM_RED","Full Damage",1,0,0,"Golbez3");
_root.hackMove[0] = "Physical";
_root.hackMove[59] = 0.9;
_root.hackMove[13] = "STONEFOCUS3";
_root.hackMove[21] = 1;
_root.hackMove[20] = 1;
_root.hackMove[95] = 0.5;
addNewMove("Fire",0,1,0,0,0,0,1,2,"Missile","0xFF9900","Krin.ElectroBolt2","BOOM_SLASHORANGE","Full Damage",1,0,1010,"Fire I");
_root.hackMove[0] = "Fire";
_root.hackMove[13] = "STONEFOCUS";
_root.hackMove[4] = 2.2;
_root.hackMove[21] = 1;
_root.hackMove[116] = -2;
addNewMove("Blizzard",0,1,0,20,0,4,1,2,"Missile","0x3399FF","Krin.Icebolt","BOOM2","Full Damage",1,0,0,"IceShatter");
_root.hackMove[0] = "Ice";
_root.hackMove[4] = 4.4;
_root.hackMove[29] = "THUNDERREADY";
_root.hackMove[67] = 1;
_root.hackMove[74] = 0.5;
_root.hackMove[116] = -2;
_root.hackMove[97] = "FROZENALMOST";
addNewMove("Thunder",0,1,0,20,0,0,2,3,"Missile","0xFFCC00","Krin.Electrobolt","BOOM3","Full Damage",1,0,20,"ElectricHit");
_root.hackMove[2] = 2;
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 3.1;
_root.hackMove[29] = "METEORREADY";
_root.hackMove[67] = 1;
_root.hackMove[74] = 0.5;
_root.hackMove[116] = -2;
_root.hackMove[13] = "PARALYZE";
_root.hackMove[108] = "THUNDERREADY";
addNewMove("Meteor",0,1,0,20,0,4,1,1,"Shock","0x99FF00","Krin.Poisonbolt","BOOM1","Full Damage",1,0,168,"Explode");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 4;
_root.hackMove[105] = 0.5;
_root.hackMove[13] = "DAMAGEDOWN";
_root.hackMove[20] = 1;
_root.hackMove[116] = -2;
_root.hackMove[108] = "METEORREADY";
addNewMove("Cure",1,0,1,30,0,6,1,2,"Shock","0x5E503C","Attack","BOOM_HEAL","Heal",1,0,1010,"Healing");
_root.hackMove[0] = "Earth";
_root.hackMove[4] = 3.1;
_root.hackMove[20] = 1;
_root.hackMove[116] = -2;
addNewMove("Dead when we all die!",1,0,1,0,0,999,1,2,"Shock","0x5E503C","Attack","BOOM_POWERUP","Heal",1,0,1010,"DeathSuspend");
_root.hackMove[0] = "Earth";
_root.hackMove[4] = 0;
_root.hackMove[20] = 1;
_root.hackMove[13] = "LIVINGDEAD11";
_root.hackMove[29] = "LIVINGDEAD12";
addNewMove("Quick Strike",0,1,0,0,0,0,1,1.8000000000000005,"Melee","0xFF0000","Attack","","Full Damage",1,0,17,"Hit5");
_root.hackMove[2] = 0.5;
_root.hackMove[4] = 0.5;
_root.hackMove[6] = 0.5;
_root.hackMove[139] = "Melee";
addNewMove("Ninjutsu",0,1,0,0,0,0,1,1.8000000000000005,"Ninjutsu","0xFF0000","Attack","","Full Damage",1,0,314,"Hit5");
_root.hackMove[6] = 0;
_root.hackMove[120] = krinABC1[137];
_root.hackMove[121] = krinABC1[74];
_root.hackMove[122] = krinABC1[75];
_root.hackMove[123] = krinABC1[76];
_root.hackMove[124] = krinABC1[139];
_root.hackMove[126] = krinABC1[140];
_root.hackMove[143] = krinABC1[79];
_root.hackMove[125] = "Doton";
_root.hackMove[127] = "Katon";
_root.hackMove[128] = "Hyoton";
_root.hackMove[129] = "Suiton";
_root.hackMove[130] = "Fuma Shuriken";
_root.hackMove[131] = "Raiton";
_root.hackMove[142] = "Huton";
_root.hackMove[140] = "Ninjutsu";
_root.hackMove[144] = 1;
_root.hackMove[17] = krinABC1[314];
addNewMove("Hyosho Ranryu",0,1,0,0,0,0,1,3,"Ninjutsu","0xFFCC00","Krin.Icebolt","BOOM2","Full Damage",1,0,316,"Hyosho Ranryu");
_root.hackMove[0] = "Ice";
_root.hackMove[6] = 13;
_root.hackMove[13] = "STUN2";
_root.hackMove[108] = "DUDRA";
_root.hackMove[117] = "DUDRA4";
_root.hackMove[17] = krinABC1[316];
addNewMove("Kassatsu",1,0,0,0,0,9,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,317,"Kassatsu");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "KASSATSU";
_root.hackMove[17] = krinABC1[317];
addNewMove("Tenchijin",1,0,0,0,0,18,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,318,"Goka");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "TENCHIJIN";
_root.hackMove[17] = krinABC1[318];
addNewMove("Goad",0,0,1,0,0,8,1,1,"Shock","0x99FF00","Heal","BOOM_HEAL","Heal",1,0,319,"Goad");
_root.hackMove[0] = "Poison";
_root.hackMove[13] = "GOAD";
_root.hackMove[17] = krinABC1[319];
addNewMove("Fleeting Raiju",0,1,0,-10,0,0,1,2.5,"Melee","0xFF0000","Attack","BOOM3","Full Damage",1,0,320,"Fleetingraiju");
_root.hackMove[0] = "Lightning";
_root.hackMove[6] = 2;
_root.hackMove[4] = 4;
_root.hackMove[17] = krinABC1[320];
_root.hackMove[13] = "STUN1";
addNewMove("Shadow Fang",0,1,0,-10,0,7,1,2,"Melee","0xFF0000","Attack","BOOM_RED","Full Damage",1,0,321,"Shadowfang");
_root.hackMove[0] = "Physical";
_root.hackMove[6] = 2;
_root.hackMove[17] = krinABC1[321];
_root.hackMove[13] = "SHADOWFANG";
MoveCount = 1900;
addNewMove("Wrath of Zeus",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Wrathofzeus");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 12;
_root.hackMove[20] = 1;
_root.hackMove[96] = 0.2;
addNewMove("Wings",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Heal",1,0,81,"Wings");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -1;
_root.hackMove[96] = 0.2;
_root.hackMove[13] = "WINGS";
addNewMove("Electrifying Witchhunt",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Witchhunt");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -2;
_root.hackMove[2] = 3;
_root.hackMove[20] = 1;
_root.hackMove[96] = 0.2;
_root.hackMove[136] = 0.334;
_root.hackMove[110] = "PHYSICALVULNERABLITY";
addNewMove("Witchhuntprepare",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Blink1");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -3;
_root.hackMove[13] = "NEAR";
_root.hackMove[14] = 0.5;
_root.hackMove[96] = 0.2;
_root.hackMove[147] = "FAR";
addNewMove("Witchhunt",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Witchhunt");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -4;
_root.hackMove[2] = 3;
_root.hackMove[96] = 0.2;
_root.hackMove[13] = "PHYSICALVULNERABLITY2";
addNewMove("Witchhuntprepare",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Blink2");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -5;
_root.hackMove[96] = 0.2;
_root.hackMove[13] = "NEARFARNEAR";
_root.hackMove[14] = 0.5;
_root.hackMove[147] = "FARNEARFAR";
addNewMove("Witchhunt",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Witchhunt");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -6;
_root.hackMove[96] = 0.2;
_root.hackMove[2] = 3;
_root.hackMove[13] = "PHYSICALVULNERABLITY";
addNewMove("Witchhunt",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Witchhunt");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -7;
_root.hackMove[2] = 3;
_root.hackMove[96] = 0.2;
_root.hackMove[13] = "PHYSICALVULNERABLITY";
addNewMove("Witchhunt",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Witchhunt");
_root.hackMove[0] = "Physical";
_root.hackMove[116] = -8;
_root.hackMove[96] = 0.2;
_root.hackMove[2] = 3;
_root.hackMove[13] = "PHYSICALVULNERABLITY";
addNewMove("Electrope",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Electrope");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -9;
_root.hackMove[13] = "ELECTROPE";
_root.hackMove[148] = 1;
_root.hackMove[20] = 1;
_root.hackMove[96] = 0.2;
addNewMove("Witchgleam",0,0,1,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Heal",1,0,81,"Witchgleam");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -10;
_root.hackMove[2] = -0.1;
_root.hackMove[149] = 1;
_root.hackMove[96] = 0.2;
addNewMove("Witchgleam",0,0,1,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Heal",1,0,81,"Witchgleam");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -11;
_root.hackMove[2] = -0.1;
_root.hackMove[96] = 0.2;
_root.hackMove[149] = 1;
addNewMove("Sidewisespark2",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Sidewise");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -12;
_root.hackMove[13] = "SIDEWISESPARKL";
_root.hackMove[14] = 0.5;
_root.hackMove[147] = "SIDEWISESPARKR";
_root.hackMove[96] = 0.2;
addNewMove("Sidewisespark",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Sidewise2");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -13;
_root.hackMove[4] = 0;
_root.hackMove[20] = 1;
_root.hackMove[96] = 0.2;
addNewMove("Electrope Strike",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Electrope2");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -13;
_root.hackMove[4] = 2;
_root.hackMove[133] = 1;
_root.hackMove[20] = 1;
_root.hackMove[153] = 0.2;
_root.hackMove[13] = "LIGHTNINGVULNERABILITY";
_root.hackMove[108] = "ELECTROPE1";
addNewMove("Electrope Strike",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Electrope2");
_root.hackMove[0] = "Lightning";
_root.hackMove[116] = -13;
_root.hackMove[4] = 2;
_root.hackMove[20] = 1;
_root.hackMove[153] = 0.2;
_root.hackMove[133] = 1;
_root.hackMove[13] = "LIGHTNINGVULNERABILITY";
_root.hackMove[108] = "ELECTROPE2";
addNewMove("Stack",0,1,0,0,0,20,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP4";
_root.hackMove[20] = 1;
_root.hackMove[116] = -14;
_root.hackMove[96] = 0.2;
_root.hackMove[21] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Wickedstack");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 9;
_root.hackMove[20] = 1;
_root.hackMove[116] = -15;
_root.hackMove[45] = 5;
_root.hackMove[96] = 0.2;
addNewMove("Ion Cluster",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Magickbarrier");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 0;
_root.hackMove[20] = 1;
_root.hackMove[116] = -16;
_root.hackMove[13] = "NEGATRON";
_root.hackMove[14] = 0.5;
_root.hackMove[96] = 0.2;
_root.hackMove[147] = "POSITRON";
addNewMove("Ioncharge",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Ioncharge");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 0;
_root.hackMove[116] = -17;
_root.hackMove[149] = -2;
_root.hackMove[96] = 0.2;
_root.hackMove[153] = 0.2;
_root.hackMove[13] = "NEGATRON2";
addNewMove("Ioncharge",1,0,0,0,0,20,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Ioncharge");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 0;
_root.hackMove[116] = -17;
_root.hackMove[149] = -2;
_root.hackMove[96] = 0.2;
_root.hackMove[153] = 0.2;
_root.hackMove[13] = "POSITRON2";
addNewMove("Nega",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Ionbeam");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 4;
_root.hackMove[20] = 1;
_root.hackMove[133] = 1;
_root.hackMove[96] = 0.2;
_root.hackMove[116] = -18;
_root.hackMove[153] = 0.2;
_root.hackMove[152] = 1;
addNewMove("Pos",0,1,0,0,0,20,1,1,"Shock","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"Ionbeam");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4;
_root.hackMove[20] = 1;
_root.hackMove[133] = 1;
_root.hackMove[151] = 1;
_root.hackMove[153] = 0.2;
_root.hackMove[116] = -18;
addNewMove("Stack",0,1,0,0,0,2,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP5";
_root.hackMove[20] = 1;
_root.hackMove[95] = 0.2;
_root.hackMove[154] = "NORMAL";
_root.hackMove[21] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,2,1,1,"MissileD","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Ionbeam2");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4;
_root.hackMove[20] = 1;
_root.hackMove[95] = 0.2;
_root.hackMove[154] = "NORMAL";
_root.hackMove[108] = "SOULGRASP5";
_root.hackMove[45] = 10;
addNewMove("Stack",0,1,0,0,0,2,1,1,"Shock","0x99FF00","Heal","BOOM_POWERUP","Heal",1,0,141,"Stack Marker");
_root.hackMove[0] = "Magic";
_root.hackMove[13] = "SOULGRASP5";
_root.hackMove[20] = 1;
_root.hackMove[29] = "DAMAGEUP";
_root.hackMove[95] = 0.2;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
addNewMove("Soul Grasp",0,1,0,0,0,2,1,1,"MissileD","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Ionbeam2");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4;
_root.hackMove[20] = 1;
_root.hackMove[95] = 0.2;
_root.hackMove[154] = "HARD";
_root.hackMove[108] = "SOULGRASP5";
_root.hackMove[45] = 10;
MoveCount = 2000;
addNewMove("On The Soul",0,1,0,0,0,6,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"On The Soul");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
addNewMove("Glaukopsis",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM_DARK","Full Damage",1,0,81,"Glaukopis");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 4.5;
_root.hackMove[96] = 0.5;
_root.hackMove[13] = "VULNERABLITY2";
_root.hackMove[154] = "HARD";
addNewMove("Parthenos",1,0,0,0,0,6,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Heal",1,0,81,"Parthenos");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 0;
_root.hackMove[96] = 0.5;
_root.hackMove[154] = "HARD";
_root.hackMove[13] = "PARTHENOS";
addNewMove("Soul Grasp",0,1,0,0,0,6,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Dialogos");
_root.hackMove[0] = "Physical";
_root.hackMove[4] = 6;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
_root.hackMove[20] = 1;
addNewMove("Palladion",0,1,0,-25,0,2,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,81,"Palladion");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
addNewMove("Laser Beam",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Laser Beam");
_root.hackMove[0] = "Shadow";
_root.hackMove[4] = 4;
_root.hackMove[23] = "Lightning";
_root.hackMove[24] = 3;
_root.hackMove[154] = "HARD";
_root.hackMove[13] = "SHADOWRES";
_root.hackMove[15] = ["Lightning"];
_root.hackMove[16] = 3;
_root.hackMove[153] = 0.5;
_root.hackMove[19] = 1;
addNewMove("Laser Beam",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Magicbolt","BOOM1","Full Damage",1,0,81,"Laser Beam");
_root.hackMove[0] = "Lightning";
_root.hackMove[4] = 4;
_root.hackMove[23] = "Shadow";
_root.hackMove[24] = 3;
_root.hackMove[154] = "HARD";
_root.hackMove[13] = "LIGHTNINGRES";
_root.hackMove[15] = ["Shadow"];
_root.hackMove[153] = 0.5;
_root.hackMove[16] = 3;
_root.hackMove[19] = 1;
addNewMove("Laser Beam2",0,1,0,0,0,6,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"Laser Beam2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 3;
_root.hackMove[153] = 0.5;
_root.hackMove[154] = "HARD";
addNewMove("Palladion",0,1,0,100,0,99,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASH","Full Damage",1,0,81,"Palladion");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
_root.hackMove[154] = "HARD";
_root.hackMove[29] = "PALLADION";
_root.hackMove[13] = "PARTHENOS2";
addNewMove("Ultima",0,1,0,1000,0,15,1,1,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Mug");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 6;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
_root.hackMove[20] = 1;
addNewMove("Life",0,0,1,0,0,5,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_HEAL","Focus3",1,0,59,"FromNothingImoldLife");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[9] = 100;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
_root.hackMove[96] = 0.5;
_root.hackMove[20] = 1;
addNewMove("Life",0,0,1,0,0,999,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_HEAL","Heal",1,0,59,"Gaiachos2");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 0;
_root.hackMove[154] = "HARD";
_root.hackMove[146] = "Wickedtheme2";
_root.hackMove[156] = 1;
_root.hackMove[21] = 1;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
addNewMove("Ultima",0,1,0,0,0,13,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Ultima2");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.25;
_root.hackMove[21] = 1;
_root.hackMove[116] = -1;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
addNewMove("Palladion Grasp",0,1,0,0,0,13,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Palladiongrasp");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 5;
_root.hackMove[154] = "HARD";
_root.hackMove[13] = "PHYSICALVULNERABLITY3";
_root.hackMove[29] = "DPS";
_root.hackMove[67] = 1;
_root.hackMove[116] = -2;
_root.hackMove[95] = 0.5;
addNewMove("Palladion Grasp",0,1,0,0,0,13,1,1,"Melee","0xFF66FF","Attack","BOOM_SLASHRED","Full Damage",1,0,81,"Palladiongrasp");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 5;
_root.hackMove[154] = "HARD";
_root.hackMove[155] = 1;
_root.hackMove[116] = -3;
_root.hackMove[95] = 0.5;
addNewMove("Gaiachos",0,1,0,0,0,13,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Gaiachos");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[13] = "HOLYCHAIN";
_root.hackMove[116] = -4;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
addNewMove("Life",0,0,1,0,0,13,2,2,"Shock","0xFF66FF","Krin.Magicbolt","BOOM_HEAL","Focus3",1,0,59,"Denizens");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 5;
_root.hackMove[9] = 100;
_root.hackMove[154] = "HARD";
_root.hackMove[21] = 1;
_root.hackMove[95] = 0.5;
_root.hackMove[116] = -5;
_root.hackMove[20] = 1;
addNewMove("Auto Attack",0,1,0,0,0,13,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"LaserBeamU");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[116] = -6;
_root.hackMove[95] = 0.5;
_root.hackMove[154] = "HARD";
addNewMove("Ultima",0,1,0,0,0,13,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Ultima2");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.25;
_root.hackMove[21] = 1;
_root.hackMove[116] = -7;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
addNewMove("Laser Beam2",0,1,0,0,0,13,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"Laser Beam2");
_root.hackMove[0] = "Fire";
_root.hackMove[4] = 2.5;
_root.hackMove[20] = 1;
_root.hackMove[116] = -6;
_root.hackMove[154] = "HARD";
addNewMove("Caloric",0,1,0,0,0,13,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Caloric");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 3;
_root.hackMove[13] = "PYRE";
_root.hackMove[29] = "CALORIC";
_root.hackMove[147] = "ATMOS";
_root.hackMove[14] = 0.5;
_root.hackMove[116] = -8;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
addNewMove("Auto Attack",0,1,0,0,0,13,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"LaserBeamU");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[116] = -9;
_root.hackMove[95] = 0.5;
_root.hackMove[154] = "HARD";
addNewMove("Auto Attack",0,1,0,0,0,13,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"LaserBeamU");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[116] = -10;
_root.hackMove[95] = 0.5;
_root.hackMove[154] = "HARD";
addNewMove("Auto Attack",0,1,0,0,0,13,1,1,"Missile","0xFF66FF","Krin.Electrobolt2","BOOM1","Full Damage",1,0,81,"LaserBeamU");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2;
_root.hackMove[116] = -11;
_root.hackMove[95] = 0.5;
_root.hackMove[154] = "HARD";
addNewMove("Ultima",0,1,0,0,0,13,1,1,"Shock","0xFF66FF","Attack","BOOM3","Full Damage",1,0,81,"Ultima2");
_root.hackMove[0] = "Magic";
_root.hackMove[4] = 2.5;
_root.hackMove[21] = 1;
_root.hackMove[116] = -12;
_root.hackMove[95] = 0.5;
_root.hackMove[20] = 1;
_root.hackMove[154] = "HARD";
MoveCount = 2100;
addNewMove("Break",0,1,0,0,0,3,1,2,"Melee","0xFF0000","Attack","BOOM_SLASH","Full Damage",1,0,181,"Hit3");
_root.hackMove[2] = 1;
_root.hackMove[17] = "Deal damage equal to your strength and stun the target for one turn. Also you take 35% less damage for the next 3 turns.";
_root.hackMove[13] = "STUN1";
_root.hackMove[29] = "SUPRESSION2";
_root.hackMove[67] = 1;
addNewMove("Smash",0,1,0,15,0,6,8,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 2.45;
_root.hackMove[9] = 20;
_root.hackMove[17] = krinABC1[0] + "350%" + krinABC2[0] + "30" + krinABC3[0];
MoveCount = 2200;
addNewMove("Light and Darkness",1,0,0,0,0,5,1,1,"Shock","0xFF66FF","Attack","BOOM_POWERUP","Focus",1,0,81,"PowerupOffense");
_root.hackMove[0] = "Lightning";
_root.hackMove[13] = "LIGHTG";
_root.hackMove[14] = 0.5;
_root.hackMove[9] = 100;
_root.hackMove[120] = "LIGHTG";
_root.hackMove[160] = "DARKNESSG";
_root.hackMove[147] = "DARKNESSG";
_root.hackMove[96] = 0.2;
addNewMove("Edge of",0,1,0,20,0,5,1,2,"Melee","0xFF66FF","Attack","BOOM_SLASHORANGE","Full Damage",1,0,68,"Edge of Shadow");
_root.hackMove[0] = "Physical";
_root.hackMove[2] = 4;
_root.hackMove[119] = "LIGHTG";
_root.hackMove[159] = "LIGHTG";
addNewMove("Akh Morn",0,1,0,20,0,5,1,1,"Shock","0xFF66FF","Attack","BOOM1","Full Damage",1,0,81,"Akhmorn");
_root.hackMove[0] = "Magic";
_root.hackMove[2] = 4;
_root.hackMove[20] = 1;
_root.hackMove[119] = "LIGHTG";
_root.hackMove[159] = "LIGHTG";
addNewMove("Shield of",1,0,0,20,0,8,1,3,"Shock","0xFFCC00","Krin.Electrobolt2","BOOM_SHIELD","Heal",1,0,156,"The Blackest Night");
_root.hackMove[0] = "Earth";
_root.hackMove[2] = 0;
_root.hackMove[20] = 1;
_root.hackMove[119] = "LIGHTG";
_root.hackMove[159] = "LIGHTG";
addNewMove("Smash of",0,1,0,20,0,2,1,1,"Melee","0xFF0000","Attack","BOOM_SLASHORANGE","Full Damage",1,0,0,"Hit3");
_root.hackMove[2] = 2.75;
_root.hackMove[119] = "LIGHTG";
_root.hackMove[159] = "LIGHTG";
addNewMove("Bio",0,1,0,20,0,4,1,1,"Missile","0x9966CC","KRIN.SHADOWSHOCK","BOOM3","Full Damage",1,0,163,"PoisonHit");
_root.hackMove[0] = "Physical";
_root.hackMove[13] = "BIO";
_root.hackMove[2] = 0;
_root.hackMove[119] = "LIGHTG";
_root.hackMove[159] = "LIGHTG";
numberMatrixKrin = new Array();
numberMatrixKrin = ["Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine"];
numberSpacingKrin = 19;
numberDepthCyler = 1620;
KrinNumberShow = function(inputNumberK, tarKN, KNcolor)
{
   if(KNcolor == "HEAL")
   {
      KNcolor2 = 6749952;
   }
   else
   {
      for(i in elementMainArray)
      {
         if(elementMainArray[i] == KNcolor)
         {
            KNcolor2 = elementColorArray[i];
         }
      }
   }
   if(inputNumberK != "miss" && inputNumberK != "shield")
   {
      gKMP = 1;
      while(inputNumberK / gKMP >= 1)
      {
         gKMP *= 10;
      }
      gKMP /= 10;
      gKMPsteps = Math.round(Math.log(gKMP) / 2.302585092994046);
      inputNumberK2 = inputNumberK;
      totalLKrinN = _root.numberSpacingKrin * (gKMPsteps - 1);
      KrinNOffset = (- totalLKrinN) / 2 - 10;
   }
   _root.BATTLESCREEN.attachMovie("NumberFixer","NumberFixer" + _root.numberDepthCyler,_root.numberDepthCyler);
   _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler]._x = _root.BATTLESCREEN[tarKN]._x;
   _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler]._y = _root.BATTLESCREEN[tarKN]._y;
   if(inputNumberK != "miss" && inputNumberK != "shield")
   {
      if(_root.perKSuccess)
      {
         _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].gotoAndPlay("critical");
      }
      else
      {
         _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].gotoAndPlay("normal");
      }
      i = gKMPsteps;
      while(i > -1)
      {
         _root["digitKVar" + i] = Math.floor(inputNumberK2 / Math.pow(10,i));
         inputNumberK2 -= _root["digitKVar" + i] * Math.pow(10,i);
         _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher.attachMovie("NumberSetter","NumSet" + i,i);
         _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher["NumSet" + i]._x = KrinNOffset + (_root.numberSpacingKrin * gKMPsteps - _root.numberSpacingKrin * i);
         _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher["NumSet" + i].gotoAndStop(_root.numberMatrixKrin[_root["digitKVar" + i]]);
         var _loc5_ = new Color(_root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher["NumSet" + i].KN);
         _loc5_.setRGB(KNcolor2);
         i--;
      }
   }
   else if(inputNumberK == "miss")
   {
      _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].gotoAndPlay("miss");
      _loc5_ = new Color(_root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher.KN);
      _loc5_.setRGB(KNcolor2);
   }
   else
   {
      _root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].gotoAndPlay("shield");
      _loc5_ = new Color(_root.BATTLESCREEN["NumberFixer" + _root.numberDepthCyler].flasher.KN);
      _loc5_.setRGB(KNcolor2);
   }
   _root.numberDepthCyler += 1;
   if(_root.numberDepthCyler == 1640)
   {
      _root.numberDepthCyler = 1620;
   }
};
BarHolder = new Array();
BarHolder2 = new Array();
BarHolder3 = new Array();
BarHolder4 = new Array();
BarMatches = [];
BarMatches.push({stat:"PALETTEGAUGE",statMax:"PALETTEGAUGEMAX",barNumber:0,color:"0xFB95C8"});
BarMatches.push({stat:"BMANA",statMax:"BMANAMAX",barNumber:0,color:"0x664D80"});
BarMatches.push({stat:"WMANA",statMax:"WMANAMAX",barNumber:1,color:"0x68CBF4"});
BarHolderCustom = new Array();
lifeBarUpdate = function(PWLC)
{
   ghjul = _root["playerKrin" + PWLC];
   _root["p" + PWLC + "BAR"].inner.lifeNow = ghjul.LIFEN;
   _root["p" + PWLC + "BAR"].inner.lifeMax = ghjul.LIFEU;
   _root["p" + PWLC + "BAR"].inner.focusNow = ghjul.FOCUSN;
   _root["p" + PWLC + "BAR"].inner.focusMax = ghjul.FOCUSU;
   _root["p" + PWLC + "BAR"].inner.playerName = ghjul.playerName;
   if(ghjul.PALETTEGAUGE > 0)
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = "P-Gauge:" + ghjul.PALETTEGAUGE;
   }
   else if(ghjul.BMANA > 0 || ghjul.WMANA > 0)
   {
      if(ghjul.BMANA > 0)
      {
         _root["p" + PWLC + "BAR"].inner.focusMax20 = "B-Mana:" + ghjul.BMANA;
         if(ghjul.WMANA > 0)
         {
            _root["p" + PWLC + "BAR"].inner.focusMax20 = "B/W-Mana:" + ghjul.BMANA + "/" + ghjul.WMANA;
         }
      }
      else if(ghjul.WMANA > 0)
      {
         _root["p" + PWLC + "BAR"].inner.focusMax20 = "W-Mana:" + ghjul.WMANA;
      }
   }
   else
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = " ";
   }
   if(firstUpdate)
   {
      BarHolder[PWLC - 1] = ghjul.LIFEN;
      BarHolder2[PWLC - 1] = ghjul.FOCUSN;
      BarHolder3[PWLC - 1] = Math.round(ghjul.LIFEN / ghjul.LIFEU * 100);
      BarHolder4[PWLC - 1] = ghjul.LIFEU;
      LNUS = 0;
      FNUS = 0;
      wPerCentKrin = _root["p" + PWLC + "BAR"].inner.lifeNow / _root["p" + PWLC + "BAR"].inner.lifeMax;
      _root["p" + PWLC + "BAR"].inner2.lB.LBS.LCC.gotoAndStop(Math.round(wPerCentKrin * 100));
      _root["p" + PWLC + "BAR"].inner2.lB.LCC.gotoAndStop(Math.round(wPerCentKrin * 100));
      _root["p" + PWLC + "BAR"].inner2.lB2.LCC.gotoAndStop(Math.round(wPerCentKrin * 100));
      BarHolderCustom[PWLC - 1] = [];
      var _loc3_ = 0;
      while(_loc3_ < BarMatches.length)
      {
         BarHolderCustom[PWLC - 1][_loc3_] = 0;
         _loc3_ += 1;
      }
      _loc3_ = 0;
      while(_loc3_ < 2)
      {
         var _loc4_ = _root["p" + PWLC + "BAR"].inner2["extraBar" + _loc3_];
         _loc4_.fB.wsaver = _loc4_.fB._width;
         _loc4_.fB2.wsaver = _loc4_.fB2._width;
         _loc4_.fB3.wsaver = _loc4_.fB3._width;
         _loc4_.fB._width = 0;
         _loc4_.fB2._width = 0;
         _loc4_._visible = false;
         _loc3_ += 1;
      }
   }
   else
   {
      LNUS = ghjul.LIFEN - BarHolder[PWLC - 1];
      if(Math.round(ghjul.LIFEN / ghjul.LIFEU * 100) == BarHolder3[PWLC - 1])
      {
         LNUS = 0;
      }
      FNUS = ghjul.FOCUSN - BarHolder2[PWLC - 1];
      LNUSC = Math.sqrt(Math.pow(LNUS,2)) / ghjul.LIFEU;
      FNUSC = Math.sqrt(Math.pow(FNUS,2)) / ghjul.FOCUSU;
      if(_root.Krin.IronSkinner)
      {
         _root.Krin.IronSkinner = false;
         LNUSC = Math.abs(ghjul.LIFEN / ghjul.LIFEU - BarHolder[PWLC - 1] / BarHolder4[PWLC - 1]);
      }
      BarHolder[PWLC - 1] = ghjul.LIFEN;
      BarHolder2[PWLC - 1] = ghjul.FOCUSN;
      BarHolder4[PWLC - 1] = ghjul.LIFEU;
      BarHolder3[PWLC - 1] = Math.round(ghjul.LIFEN / ghjul.LIFEU * 100);
      _loc3_ = 0;
      while(_loc3_ < BarMatches.length)
      {
         var _loc5_ = BarMatches[_loc3_];
         var _loc6_ = ghjul[_loc5_.stat];
         var _loc7_ = BarHolderCustom[PWLC - 1][_loc3_];
         if(_loc6_ != _loc7_)
         {
            _loc4_ = _root["p" + PWLC + "BAR"].inner2["extraBar" + _loc5_.barNumber];
            _loc4_._visible = true;
            var _loc8_ = new Color(_loc4_.fB);
            _loc8_.setRGB(_loc5_.color);
            _loc8_ = new Color(_loc4_.fB2);
            _loc8_.setRGB(_loc5_.color);
            var _loc9_ = _loc6_ / ghjul[_loc5_.statMax];
            var _loc10_ = Math.abs(_loc6_ - _loc7_) / ghjul[_loc5_.statMax];
            if(_loc6_ - _loc7_ < 0)
            {
               _loc4_.fB._width = _loc4_.fB.wsaver * _loc9_;
            }
            _loc4_.fB3.attachMovie("LifeBarSmoother2","EBS",1);
            _loc8_ = new Color(_loc4_.fB3.EBS);
            _loc8_.setRGB(_loc5_.color);
            _loc4_.fB3.EBS._x = _loc4_.fB._width * 1.2710000000000006 - 1;
            _loc4_.fB3.EBS._width = _loc4_.fB.wsaver * 1.2710000000000006 * _loc10_;
            if(_loc6_ - _loc7_ > 0)
            {
               _loc4_.fB3.EBS.gotoAndPlay("healSmooth");
               _loc4_.fB3.EBS.wsaver = _loc4_.fB.wsaver * _loc9_;
            }
         }
         BarHolderCustom[PWLC - 1][_loc3_] = _loc6_;
         _loc3_ += 1;
      }
   }
   if(FNUS != 0)
   {
      wPerCentKrin2 = _root["p" + PWLC + "BAR"].inner.focusNow / _root["p" + PWLC + "BAR"].inner.focusMax;
      if(FNUS < 1)
      {
         _root["p" + PWLC + "BAR"].inner2.fB._width = _root["p" + PWLC + "BAR"].inner2.fB.wsaver * wPerCentKrin2;
      }
      _root["p" + PWLC + "BAR"].inner2.fB3.attachMovie("LifeBarSmoother2","LBS",1);
      _root["p" + PWLC + "BAR"].inner2.fB3.LBS._x = _root["p" + PWLC + "BAR"].inner2.fB._width * 1.2710000000000006 - 1;
      _root["p" + PWLC + "BAR"].inner2.fB3.LBS._width = _root["p" + PWLC + "BAR"].inner2.fB.wsaver * 1.2710000000000006 * FNUSC;
      if(FNUS > 0)
      {
         _root["p" + PWLC + "BAR"].inner2.fB3.LBS.gotoAndPlay("healSmooth");
         _root["p" + PWLC + "BAR"].inner2.fB3.LBS.wsaver = _root["p" + PWLC + "BAR"].inner2.lB.wsaver * wPerCentKrin2;
      }
   }
   if(LNUS != 0 || firstUpdate == true)
   {
      wPerCentKrin = _root["p" + PWLC + "BAR"].inner.lifeNow / _root["p" + PWLC + "BAR"].inner.lifeMax;
      if(LNUS < 1 || firstUpdate == true)
      {
         _root["p" + PWLC + "BAR"].inner2.lB._width = _root["p" + PWLC + "BAR"].inner2.lB.wsaver * wPerCentKrin;
      }
      if(firstUpdate != true)
      {
         _root["p" + PWLC + "BAR"].inner2.lB3.attachMovie("LifeBarSmoother","LBS",1);
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS._x = _root["p" + PWLC + "BAR"].inner2.lB._width * 1.2710000000000006 - 1;
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS._width = _root["p" + PWLC + "BAR"].inner2.lB.wsaver * 1.2710000000000006 * LNUSC;
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS.LCC.gotoAndStop(Math.round(wPerCentKrin * 100) + 1);
      }
      _root["p" + PWLC + "BAR"].inner2.lB.LCC.gotoAndStop(Math.round(wPerCentKrin * 100) + 1);
      _root["p" + PWLC + "BAR"].inner2.lB2.LCC.gotoAndStop(Math.round(wPerCentKrin * 100) + 1);
      if(ghjul.LIFEN == 0)
      {
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS.deadNow = true;
         addSound("Effects",ghjul.voiceDie);
      }
      if(LNUS > 0)
      {
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS.gotoAndPlay("healSmooth");
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS.stopper = Math.round(wPerCentKrin * 100) + 1;
         _root["p" + PWLC + "BAR"].inner2.lB3.LBS.wsaver = _root["p" + PWLC + "BAR"].inner2.lB.wsaver * wPerCentKrin;
      }
   }
};
perScript = function(PERCALKK, DEFCALKK, GGG)
{
   _root.KRRR();
   if(_root.KRSO < (PERCALKK + GGG[7]) * GGG[8] / DEFCALKK * 15)
   {
      _root.perKSuccess = true;
   }
   else
   {
      _root.perKSuccess = false;
   }
};
AImoveAdder = function(p)
{
   pg = _root["playerKrin" + p];
   if(pg.AIAD == false)
   {
      moveFilterA0 = new Array();
      moveFilterA1 = new Array();
      moveFilterA2 = new Array();
      parallelFilterA = new Array();
      parallelFilterA2 = new Array();
      parallelFilterA3 = new Array();
      for(var _loc3_ in pg.CDArrayA)
      {
         if(pg.CDArrayA[_loc3_] == 0)
         {
            moveFilterA0.push(pg.moveArrayA[_loc3_]);
            parallelFilterA.push(_loc3_);
         }
      }
      for(_loc3_ in moveFilterA0)
      {
         NOCONDITION = false;
         NOCONDITION2 = false;
         NOCONDITION3 = false;
         NOCONDITION4 = false;
         NOCONDITION5 = false;
         NOCONDITION6 = false;
         FOUNDA = false;
         FOUNDA2 = false;
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(pg.BUFFARRAYK[f].buffId == "CALORIC" && pg.BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION5 = true;
               x = 0;
               while(x < _root.maxBuffLimit)
               {
                  if(pg.BUFFARRAYK[x].buffId == "ATMOS" && pg.BUFFARRAYK[x].CD == 1)
                  {
                     NOCONDITION6 = true;
                     NOCONDITION5 = false;
                  }
                  x++;
               }
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "PHYSICALVULNERABLITY" && pg.BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "PHYSICALVULNERABLITY3" && pg.BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION4 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "FARNEARFAR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "POSITRON" && pg.BUFFARRAYK[f].CD == 3)
            {
               NOCONDITION3 = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "HOLYCHAIN" && pg.BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION4 = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "NEGATRON" && pg.BUFFARRAYK[f].CD == 3)
            {
               NOCONDITION3 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "SIDEWISESPARKL" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION2 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "SIDEWISESPARKR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION2 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "NEARFARNEAR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            f++;
         }
         if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][108] != 0 || _root["KRINABILITYB" + moveFilterA0[_loc3_]][120] != 0 || _root["KRINABILITYB" + moveFilterA0[_loc3_]][119] != 0)
         {
            f = 0;
            while(f < _root.maxBuffLimit)
            {
               if(pg.BUFFARRAYK[f].buffId == _root["KRINABILITYB" + moveFilterA0[_loc3_]][108] && pg.BUFFARRAYK[f].CD != 0)
               {
                  FOUNDA = true;
                  if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][108] == "ELECTROPE2" && pg.BUFFARRAYK[f].CD != 1 || _root["KRINABILITYB" + moveFilterA0[_loc3_]][108] == "ELECTROPE1" && pg.BUFFARRAYK[f].CD != 1)
                  {
                     FOUNDA = false;
                  }
                  break;
               }
               if(pg.BUFFARRAYK[f].buffId == _root["KRINABILITYB" + moveFilterA0[_loc3_]][119] && pg.BUFFARRAYK[f].CD != 0)
               {
                  FOUNDA2 = true;
                  break;
               }
               if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][159] != 0)
               {
                  if(pg.BUFFARRAYK[f].buffId == "LIGHTG" && pg.BUFFARRAYK[f].CD != 0)
                  {
                     FOUNDA2 = true;
                     break;
                  }
                  if(pg.BUFFARRAYK[f].buffId == "DARKNESSG" && pg.BUFFARRAYK[f].CD != 0)
                  {
                     FOUNDA2 = true;
                     break;
                  }
               }
               if(pg.BUFFARRAYK[f].buffId == _root["KRINABILITYB" + moveFilterA0[_loc3_]][120] && pg.BUFFARRAYK[f].CD != 0)
               {
                  FOUNDA2 = true;
                  break;
               }
               if(pg.BUFFARRAYK[f].buffId == _root["KRINABILITYB" + moveFilterA0[_loc3_]][160] && pg.BUFFARRAYK[f].CD != 0)
               {
                  FOUNDA2 = true;
                  break;
               }
               f++;
            }
         }
         if(NOCONDITION4 == false)
         {
            if(NOCONDITION6 == false || NOCONDITION6 == true && _root["KRINABILITY" + moveFilterA0[_loc3_]][10] == "Melee")
            {
               if(NOCONDITION5 == false || NOCONDITION5 == true && _root["KRINABILITY" + moveFilterA0[_loc3_]][10] != "Melee")
               {
                  if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][154] == _root.Krin.diff || _root["KRINABILITYB" + moveFilterA0[_loc3_]][154] == 0)
                  {
                     if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][20] == 1 && NOCONDITION3 == false || _root["KRINABILITYB" + moveFilterA0[_loc3_]][20] == 0)
                     {
                        if(_root["KRINABILITY" + moveFilterA0[_loc3_]][14] == "Full Damage" && NOCONDITION2 == true || NOCONDITION2 == false)
                        {
                           if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][153] <= _root["playerKrin" + 2].LIFEN / _root["playerKrin" + 2].LIFEU)
                           {
                              if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][95] >= pg.LIFEN / pg.LIFEU && _root["KRINABILITYB" + moveFilterA0[_loc3_]][96] <= pg.LIFEN / pg.LIFEU)
                              {
                                 if(_root["KRINABILITY" + moveFilterA0[_loc3_]][10] == pg.CONDITION3 || pg.CONDITION3 == 0)
                                 {
                                    if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][139] == _root["playerKrin" + 2].CONDITION2 && NOCONDITION == true || _root["KRINABILITYB" + moveFilterA0[_loc3_]][139] == _root["playerKrin" + 2].CONDITION || _root["KRINABILITYB" + moveFilterA0[_loc3_]][139] == 0)
                                    {
                                       if(_root["KRINABILITY" + moveFilterA0[_loc3_]][10] != _root["playerKrin" + 2].CONDITION && NOCONDITION == true || _root["KRINABILITY" + moveFilterA0[_loc3_]][10] == _root["playerKrin" + 2].CONDITION && NOCONDITION == false || _root["playerKrin" + 2].CONDITION == 0 || _root["playerKrin" + 2] == pg)
                                       {
                                          if(_root["KRINABILITY" + moveFilterA0[_loc3_]][10] == _root["playerKrin" + 2].CONDITION2 && NOCONDITION == true || _root["KRINABILITY" + moveFilterA0[_loc3_]][10] != _root["playerKrin" + 2].CONDITION2 && NOCONDITION == false || _root["playerKrin" + 2].CONDITION2 == 0 || _root["playerKrin" + 2] == pg)
                                          {
                                             if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][119] != 0 && FOUNDA2 == true || _root["KRINABILITYB" + moveFilterA0[_loc3_]][119] == 0 && FOUNDA2 == false)
                                             {
                                                if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][108] != 0 && FOUNDA == true || _root["KRINABILITYB" + moveFilterA0[_loc3_]][108] == 0 || _root["KRINABILITYB" + moveFilterA0[_loc3_]][107] != 0)
                                                {
                                                   if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][113] * -1 <= pg.BMANA && _root["KRINABILITYB" + moveFilterA0[_loc3_]][114] * -1 <= pg.WMANA)
                                                   {
                                                      if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][104] * -1 <= pg.PALETTEGAUGE)
                                                      {
                                                         if(_root["KRINABILITYB" + moveFilterA0[_loc3_]][116] + pg.TURN >= 0)
                                                         {
                                                            if(pg.FOCUSN >= _root["KRINABILITY" + moveFilterA0[_loc3_]][5] && pg.LIFEN > _root["KRINABILITY" + moveFilterA0[_loc3_]][6] + Math.round(pg.LIFEU * _root["KRINABILITY" + moveFilterA0[_loc3_]][16]))
                                                            {
                                                               moveFilterA1.push(moveFilterA0[_loc3_]);
                                                               parallelFilterA2.push(parallelFilterA[_loc3_]);
                                                            }
                                                         }
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      gMtYuIo = pg.teamSide;
      checkerForFriends = 0;
      if(_root["playerKrin" + gMtYuIo].active == true && gMtYuIo != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo;
      }
      if(_root["playerKrin" + (gMtYuIo + 2)].active == true && gMtYuIo + 2 != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo + 2;
      }
      if(_root["playerKrin" + (gMtYuIo + 4)].active == true && gMtYuIo + 4 != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo + 4;
      }
      for(_loc3_ in moveFilterA1)
      {
         if(_root["KRINABILITY" + moveFilterA1[_loc3_]][2] + _root["KRINABILITY" + moveFilterA1[_loc3_]][3] > 0 || checkerForFriends == 1)
         {
            moveFilterA2.push(moveFilterA1[_loc3_]);
            parallelFilterA3.push(parallelFilterA2[_loc3_]);
         }
      }
      moveFilterD0 = new Array();
      moveFilterD1 = new Array();
      moveFilterD2 = new Array();
      parallelFilterD = new Array();
      parallelFilterD2 = new Array();
      parallelFilterD3 = new Array();
      for(_loc3_ in pg.CDArrayD)
      {
         if(pg.CDArrayD[_loc3_] == 0)
         {
            moveFilterD0.push(pg.moveArrayD[_loc3_]);
            parallelFilterD.push(_loc3_);
         }
      }
      for(_loc3_ in moveFilterD0)
      {
         NOCONDITION = false;
         NOCONDITION2 = false;
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(pg.BUFFARRAYK[f].buffId == "ATMOS" && pg.BUFFARRAYK[f].CD == 1)
            {
               NOCONDITION2 = true;
            }
            if(pg.BUFFARRAYK[f].buffId == "PHYSICALVULNERABLITY" && pg.BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "FARNEARFAR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "DPS" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0 && NOCONDITION4 == false)
            {
               NOCONDITION2 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "SIDEWISESPARKL" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION2 = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "POSITRON" && pg.BUFFARRAYK[f].CD == 3)
            {
               NOCONDITION2 = true;
               break;
            }
            if(pg.BUFFARRAYK[f].buffId == "NEGATRON" && pg.BUFFARRAYK[f].CD == 3)
            {
               NOCONDITION2 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "SIDEWISESPARKR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION2 = true;
               break;
            }
            if(_root["playerKrin" + 2].BUFFARRAYK[f].buffId == "NEARFARNEAR" && _root["playerKrin" + 2].BUFFARRAYK[f].CD != 0)
            {
               NOCONDITION = true;
               break;
            }
            f++;
         }
         if(NOCONDITION2 == false)
         {
            if(_root["KRINABILITYB" + moveFilterD0[_loc3_]][150] >= pg.FOCUSN || _root["KRINABILITYB" + moveFilterD0[_loc3_]][150] == 0)
            {
               if(_root["KRINABILITY" + moveFilterD0[_loc3_]][10] == pg.CONDITION3 || pg.CONDITION3 == 0)
               {
                  if(_root["KRINABILITYB" + moveFilterD0[_loc3_]][95] >= pg.LIFEN / pg.LIFEU && _root["KRINABILITYB" + moveFilterD0[_loc3_]][96] <= pg.LIFEN / pg.LIFEU)
                  {
                     if(_root["KRINABILITY" + moveFilterD0[_loc3_]][10] == _root["playerKrin" + 2].CONDITION2 && NOCONDITION == true || _root["KRINABILITY" + moveFilterD0[_loc3_]][10] != _root["playerKrin" + 2].CONDITION2 && NOCONDITION == false || _root["playerKrin" + 2].CONDITION2 == 0 || _root["playerKrin" + 2] == pg)
                     {
                        if(_root["KRINABILITY" + moveFilterD0[_loc3_]][10] != _root["playerKrin" + 2].CONDITION && NOCONDITION == true || _root["KRINABILITY" + moveFilterD0[_loc3_]][10] == _root["playerKrin" + 2].CONDITION && NOCONDITION == false || _root["playerKrin" + 2].CONDITION == 0 || _root["playerKrin" + 2] == pg)
                        {
                           if(pg.FOCUSN >= _root["KRINABILITY" + moveFilterD0[_loc3_]][5] && pg.LIFEN > _root["KRINABILITY" + moveFilterD0[_loc3_]][6] + Math.round(pg.LIFEU * _root["KRINABILITY" + moveFilterD0[_loc3_]][16]))
                           {
                              moveFilterD1.push(moveFilterD0[_loc3_]);
                              parallelFilterD2.push(parallelFilterD[_loc3_]);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      gMtYuIo = pg.teamSide;
      checkerForFriends = 0;
      if(_root["playerKrin" + gMtYuIo].active == true && gMtYuIo != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo;
      }
      if(_root["playerKrin" + (gMtYuIo + 2)].active == true && gMtYuIo + 2 != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo + 2;
      }
      if(_root["playerKrin" + (gMtYuIo + 4)].active == true && gMtYuIo + 4 != p)
      {
         checkerForFriends = 1;
         numberLockKrin = gMtYuIo + 4;
      }
      for(_loc3_ in moveFilterD1)
      {
         if(_root["KRINABILITY" + moveFilterD1[_loc3_]][2] + _root["KRINABILITY" + moveFilterD1[_loc3_]][3] > 0 || checkerForFriends == 1)
         {
            moveFilterD2.push(moveFilterD1[_loc3_]);
            parallelFilterD3.push(parallelFilterD2[_loc3_]);
         }
      }
      AIATTACKMODE = true;
      ScriptEnderKAIA = false;
      if(moveFilterA2.length == 0)
      {
         ScriptEnderKAIA = true;
         AIATTACKMODE = false;
      }
      if(moveFilterD2.length == 0)
      {
         ScriptEnderKAIA = true;
      }
      LifeFullAIChecker = 0;
      LifeFullAITotal = 0;
      if(_root["playerKrin" + gMtYuIo].active)
      {
         LifeFullAITotal += _root["playerKrin" + gMtYuIo].LIFEU;
         LifeFullAIChecker += _root["playerKrin" + gMtYuIo].LIFEU - (_root["playerKrin" + gMtYuIo].LIFEN + _root.healedThisTurn[gMtYuIo]);
      }
      if(_root["playerKrin" + (gMtYuIo + 2)].active)
      {
         LifeFullAITotal += _root["playerKrin" + (gMtYuIo + 2)].LIFEU;
         LifeFullAIChecker += _root["playerKrin" + (gMtYuIo + 2)].LIFEU - (_root["playerKrin" + (gMtYuIo + 2)].LIFEN + _root.healedThisTurn[gMtYuIo + 2]);
      }
      if(_root["playerKrin" + (gMtYuIo + 4)].active)
      {
         LifeFullAITotal += _root["playerKrin" + (gMtYuIo + 4)].LIFEU;
         LifeFullAIChecker += _root["playerKrin" + (gMtYuIo + 4)].LIFEU - (_root["playerKrin" + (gMtYuIo + 4)].LIFEN + _root.healedThisTurn[gMtYuIo + 4]);
      }
      if(!ScriptEnderKAIA)
      {
         LifeAICR = (1 - LifeFullAIChecker / LifeFullAITotal) * 100;
         if(LifeAICR <= pg.LifeBoundary1)
         {
            if(LifeAICR <= pg.LifeBoundary2)
            {
               AIATTACKMODE = false;
            }
            else
            {
               _root.KRRR();
               if(pg.Aggression >= _root.KRSO)
               {
                  AIATTACKMODE = true;
               }
               else
               {
                  AIATTACKMODE = false;
               }
            }
         }
      }
      if(AIATTACKMODE == true)
      {
         MoveSelectBits = 100 / moveFilterA2.length;
         _root.KRRR();
         counterFilter = Math.ceil(_root.KRSO / MoveSelectBits) - 1;
         if(counterFilter < 0)
         {
            counterFilter = 0;
         }
         selectedMoveToMake = moveFilterA2[counterFilter];
         CDtoPUT = parallelFilterA3[counterFilter];
      }
      else
      {
         MoveSelectBits = 100 / moveFilterD2.length;
         _root.KRRR();
         counterFilter = Math.ceil(_root.KRSO / MoveSelectBits) - 1;
         if(counterFilter < 0)
         {
            counterFilter = 0;
         }
         selectedMoveToMake = moveFilterD2[counterFilter];
         CDtoPUT = parallelFilterD3[counterFilter];
      }
      krinAITargetChecked = 0;
      if(_root["KRINABILITY" + selectedMoveToMake][2] == 1)
      {
         krinAITargetChecked = p;
      }
      if(_root["KRINABILITY" + selectedMoveToMake][3] == 1)
      {
         aliveEnemies = new Array();
         gMtYuIo = pg.teamSide;
         weakestEnemyNow = 0;
         if(pg.CONDITION4 != 0 && (_root["playerKrin" + (7 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION4 || _root["playerKrin" + (7 - gMtYuIo)].active == false) && (_root["playerKrin" + (5 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION4 || _root["playerKrin" + (5 - gMtYuIo)].active == false) && (_root["playerKrin" + (3 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION4 || _root["playerKrin" + (3 - gMtYuIo)].active == false))
         {
            pg.CONDITION4 = 0;
         }
         if(pg.CONDITION5 != 0 && (_root["playerKrin" + (7 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION5 || _root["playerKrin" + (7 - gMtYuIo)].active == false) && (_root["playerKrin" + (5 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION5 || _root["playerKrin" + (5 - gMtYuIo)].active == false) && (_root["playerKrin" + (3 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION5 || _root["playerKrin" + (3 - gMtYuIo)].active == false))
         {
            pg.CONDITION5 = 0;
         }
         HIGHESTDPS1 = false;
         HIGHESTDPS2 = false;
         HIGHESTDPS3 = false;
         if((_root["playerKrin" + (7 - gMtYuIo)].active == false && _root["playerKrin" + (5 - gMtYuIo)].active == true || _root["playerKrin" + (5 - gMtYuIo)].active == false && _root["playerKrin" + (7 - gMtYuIo)].active == true) && _root["playerKrin" + (3 - gMtYuIo)].active == true)
         {
            if(_root["playerKrin" + (5 - gMtYuIo)].active == true)
            {
               if(_root["playerKrin" + (3 - gMtYuIo)].DPS >= _root["playerKrin" + (5 - gMtYuIo)].DPS)
               {
                  HIGHESTDPS3 = true;
               }
               if(_root["playerKrin" + (3 - gMtYuIo)].DPS <= _root["playerKrin" + (5 - gMtYuIo)].DPS)
               {
                  HIGHESTDPS2 = true;
               }
            }
            if(_root["playerKrin" + (7 - gMtYuIo)].active == true)
            {
               if(_root["playerKrin" + (3 - gMtYuIo)].DPS >= _root["playerKrin" + (7 - gMtYuIo)].DPS)
               {
                  HIGHESTDPS3 = true;
               }
               if(_root["playerKrin" + (3 - gMtYuIo)].DPS <= _root["playerKrin" + (7 - gMtYuIo)].DPS)
               {
                  HIGHESTDPS1 = true;
               }
            }
         }
         if(_root["playerKrin" + (5 - gMtYuIo)].active == true && _root["playerKrin" + (7 - gMtYuIo)].active == true && _root["playerKrin" + (3 - gMtYuIo)].active == true)
         {
            if(_root["playerKrin" + (7 - gMtYuIo)].DPS >= _root["playerKrin" + (5 - gMtYuIo)].DPS && _root["playerKrin" + (7 - gMtYuIo)].DPS >= _root["playerKrin" + (3 - gMtYuIo)].DPS)
            {
               HIGHESTDPS1 = true;
            }
            if(_root["playerKrin" + (5 - gMtYuIo)].DPS >= _root["playerKrin" + (7 - gMtYuIo)].DPS && _root["playerKrin" + (5 - gMtYuIo)].DPS >= _root["playerKrin" + (3 - gMtYuIo)].DPS)
            {
               HIGHESTDPS2 = true;
            }
            if(_root["playerKrin" + (3 - gMtYuIo)].DPS >= _root["playerKrin" + (7 - gMtYuIo)].DPS && _root["playerKrin" + (3 - gMtYuIo)].DPS >= _root["playerKrin" + (5 - gMtYuIo)].DPS)
            {
               HIGHESTDPS3 = true;
            }
         }
         if(_root["playerKrin" + (5 - gMtYuIo)].active == false && _root["playerKrin" + (7 - gMtYuIo)].active == false && _root["playerKrin" + (3 - gMtYuIo)].active == true || _root["playerKrin" + (3 - gMtYuIo)].active == false && _root["playerKrin" + (7 - gMtYuIo)].active == false && _root["playerKrin" + (5 - gMtYuIo)].active == true || _root["playerKrin" + (5 - gMtYuIo)].active == false && _root["playerKrin" + (3 - gMtYuIo)].active == false && _root["playerKrin" + (7 - gMtYuIo)].active == true)
         {
            HIGHESTDPS1 = true;
            HIGHESTDPS2 = true;
            HIGHESTDPS3 = true;
         }
         if((_root["KRINABILITYB" + selectedMoveToMake][155] == 1 && HIGHESTDPS1 == true || _root["KRINABILITYB" + selectedMoveToMake][155] == 0) && _root["playerKrin" + (7 - gMtYuIo)].active == true && _root["playerKrin" + (7 - gMtYuIo)].IGNORE == 0 && (_root["playerKrin" + (7 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION4 || pg.CONDITION4 == 0) && (_root["playerKrin" + (7 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION5 || pg.CONDITION5 == 0))
         {
            aliveEnemies.push(7 - gMtYuIo);
            weakestEnemyNow = 7 - gMtYuIo;
         }
         if((_root["KRINABILITYB" + selectedMoveToMake][155] == 1 && HIGHESTDPS2 == true || _root["KRINABILITYB" + selectedMoveToMake][155] == 0) && _root["playerKrin" + (5 - gMtYuIo)].active == true && _root["playerKrin" + (5 - gMtYuIo)].IGNORE == 0 && (_root["playerKrin" + (5 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION4 || pg.CONDITION4 == 0) && (_root["playerKrin" + (5 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION5 || pg.CONDITION5 == 0))
         {
            aliveEnemies.push(5 - gMtYuIo);
            if(_root["playerKrin" + (5 - gMtYuIo)].LIFEN < _root["playerKrin" + weakestEnemyNow].LIFEN || weakestEnemyNow == 0)
            {
               weakestEnemyNow = 5 - gMtYuIo;
            }
         }
         if((_root["KRINABILITYB" + selectedMoveToMake][155] == 1 && HIGHESTDPS3 == true || _root["KRINABILITYB" + selectedMoveToMake][155] == 0) && _root["playerKrin" + (3 - gMtYuIo)].active == true && _root["playerKrin" + (3 - gMtYuIo)].IGNORE == 0 && (_root["playerKrin" + (3 - gMtYuIo)].abilityhistoryIDKM[10] == pg.CONDITION4 || pg.CONDITION4 == 0) && (_root["playerKrin" + (3 - gMtYuIo)].abilityhistoryIDKM[10] != pg.CONDITION5 || pg.CONDITION5 == 0))
         {
            aliveEnemies.push(3 - gMtYuIo);
            if(_root["playerKrin" + (3 - gMtYuIo)].LIFEN < _root["playerKrin" + weakestEnemyNow].LIFEN || weakestEnemyNow == 0)
            {
               weakestEnemyNow = 3 - gMtYuIo;
            }
         }
         _root.KRRR();
         if(_root.KRSO < pg.FocusAggression)
         {
            krinAITargetChecked = weakestEnemyNow;
         }
         else
         {
            MoveSelectBits2 = 100 / aliveEnemies.length;
            _root.KRRR();
            counterFilter1 = Math.ceil(_root.KRSO / MoveSelectBits2) - 1;
            if(counterFilter1 < 0)
            {
               counterFilter1 = 0;
            }
            krinAITargetChecked = aliveEnemies[counterFilter1];
         }
      }
      if(_root["KRINABILITY" + selectedMoveToMake][4] == 1 && (krinAITargetChecked == 0 || krinAITargetChecked == p))
      {
         if(_root["playerKrin" + gMtYuIo].active)
         {
            krinAITargetChecked = gMtYuIo;
         }
         IDKC = _root["playerKrin" + p];
         IDKM2 = _root["KRINABILITYB" + selectedMoveToMake];
         healGuesserK = IDKM2[10] * ((IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKC.FOCUSN * IDKM2[11] + IDKM2[9]);
         if(_root["playerKrin" + (gMtYuIo + 2)].active)
         {
            if(_root["playerKrin" + krinAITargetChecked].LIFEN == _root["playerKrin" + krinAITargetChecked].LIFEU || (_root["playerKrin" + (gMtYuIo + 2)].LIFEN + _root.healedThisTurn[gMtYuIo + 2]) / _root["playerKrin" + (gMtYuIo + 2)].LIFEU <= (_root["playerKrin" + gMtYuIo].LIFEN + _root.healedThisTurn[gMtYuIo]) / _root["playerKrin" + gMtYuIo].LIFEU)
            {
               if(_root["playerKrin" + (gMtYuIo + 2)].LIFEN + _root.healedThisTurn[gMtYuIo + 2] <= _root["playerKrin" + krinAITargetChecked].LIFEN + _root.healedThisTurn[krinAITargetChecked])
               {
               }
               krinAITargetChecked = gMtYuIo + 2;
               if(_root["playerKrin" + krinAITargetChecked].LIFEN == _root["playerKrin" + krinAITargetChecked].LIFEU)
               {
               }
            }
         }
         if(_root["playerKrin" + (gMtYuIo + 4)].active)
         {
            if(_root["playerKrin" + krinAITargetChecked].LIFEN == _root["playerKrin" + krinAITargetChecked].LIFEU || (_root["playerKrin" + (gMtYuIo + 4)].LIFEN + _root.healedThisTurn[gMtYuIo + 4]) / _root["playerKrin" + (gMtYuIo + 4)].LIFEU <= (_root["playerKrin" + krinAITargetChecked].LIFEN + _root.healedThisTurn[krinAITargetChecked]) / _root["playerKrin" + krinAITargetChecked].LIFEU)
            {
               if(_root["playerKrin" + (gMtYuIo + 4)].LIFEN + _root.healedThisTurn[gMtYuIo + 4] <= _root["playerKrin" + krinAITargetChecked].LIFEN + _root.healedThisTurn[krinAITargetChecked])
               {
               }
               krinAITargetChecked = gMtYuIo + 4;
               if(_root["playerKrin" + krinAITargetChecked].LIFEN == _root["playerKrin" + krinAITargetChecked].LIFEU)
               {
               }
            }
         }
         _root.healedThisTurn[krinAITargetChecked] += healGuesserK;
      }
      if(_root["KRINABILITY" + selectedMoveToMake][4] == 1 && _root["KRINABILITY" + selectedMoveToMake][2] == 0 && _root["KRINABILITYB" + selectedMoveToMake][149] == 0)
      {
         krinAITargetChecked = numberLockKrin;
      }
      if(_root["KRINABILITYB" + selectedMoveToMake][149] == 1)
      {
         RandomNumber = Math.random();
         if(RandomNumber < 0.5)
         {
            krinAITargetChecked = gMtYuIo + 2;
         }
         else
         {
            krinAITargetChecked = gMtYuIo + 4;
         }
      }
      NEGATIV = false;
      POSITIV = false;
      while(f < _root.maxBuffLimit)
      {
         if(pg.BUFFARRAYK[f].buffId == "NEGATRON" && pg.BUFFARRAYK[f].CD == 3)
         {
            NEGATIV = true;
            break;
         }
         if(pg.BUFFARRAYK[f].buffId == "POSITRON" && pg.BUFFARRAYK[f].CD == 3)
         {
            POSITIV = true;
            break;
         }
         f++;
      }
      if(NEGATIV == true)
      {
         krinAITargetChecked = 7 - gMtYuIo;
      }
      if(POSITIV == true)
      {
         krinAITargetChecked = 5 - gMtYuIo;
      }
      if(selectedMoveToMake == undefined)
      {
         _root.krinAddMove(p,p,0);
      }
      else if(aliveEnemies.length == 0)
      {
         _root.krinAddMove(p,p,0);
      }
      else
      {
         if(AIATTACKMODE == true)
         {
            pg.CDArrayA[CDtoPUT] = _root["KRINABILITY" + selectedMoveToMake][7];
         }
         else
         {
            pg.CDArrayD[CDtoPUT] = _root["KRINABILITY" + selectedMoveToMake][7];
         }
         if(krinAITargetChecked == 0)
         {
            krinAITargetChecked = aliveEnemies[counterFilter1];
            trace("counterFilter1 = " + counterFilter1);
         }
         _root.krinAddMove(p,krinAITargetChecked,selectedMoveToMake);
      }
   }
};
_root.maxBuffLimit = 40;
addNewBuffKrin("FATALFLAW",_root.KrinLang[KLangChoosen].AU[30],"Earth");
_root.hackMove2[3] = -0.15;
_root.hackMove2[5] = -0.15;
_root.hackMove2[7] = -0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[30];
addNewBuffKrin("DARKREGEN",_root.KrinLang[KLangChoosen].AU[29],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[14] = -1000;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[29];
addNewBuffKrin("DOCTOR",_root.KrinLang[KLangChoosen].AU[27],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[10] = 2000;
_root.hackMove2[12] = 7000;
_root.hackMove2[20] = 0;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[27];
addNewBuffKrin("FATE",_root.KrinLang[KLangChoosen].AU[28],"Shadow");
_root.hackMove2[16] = 1;
_root.hackMove2[14] = 9999;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[28];
addNewBuffKrin("IGNITE",_root.KrinLang[KLangChoosen].AU[26],"Fire");
_root.hackMove2[16] = 9;
_root.hackMove2[14] = 50;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[26];
addNewBuffKrin("BLACKOUT",_root.KrinLang[KLangChoosen].AU[25],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[25];
addNewBuffKrin("DECAY",_root.KrinLang[KLangChoosen].AU[24],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[14] = 34;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[24];
addNewBuffKrin("REGENSHAMAN",_root.KrinLang[KLangChoosen].AU[23],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[23];
addNewBuffKrin("WASHED",_root.KrinLang[KLangChoosen].AU[22],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[22];
addNewBuffKrin("WASHED2",_root.KrinLang[KLangChoosen].AU[22],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "This unit deals 40% less damage.";
addNewBuffKrin("WASHED3",_root.KrinLang[KLangChoosen].AU[22],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "This unit deals 80% less damage.";
addNewBuffKrin("REGENFOC",_root.KrinLang[KLangChoosen].AU[21],"Lightning");
_root.hackMove2[16] = 9;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[21];
addNewBuffKrin("SPEEDUP",_root.KrinLang[KLangChoosen].AU[20],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[7] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[20];
addNewBuffKrin("COLDSOUL",_root.KrinLang[KLangChoosen].AU[19],"Ice");
_root.hackMove2[16] = 3;
_root.hackMove2[7] = -0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[19];
addNewBuffKrin("FIRESHOCK",_root.KrinLang[KLangChoosen].AU[18],"Fire");
_root.hackMove2[16] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[18];
addNewBuffKrin("SUBVERSION",_root.KrinLang[KLangChoosen].AU[17],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[26] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[17];
addNewBuffKrin("SHATTER",_root.KrinLang[KLangChoosen].AU[15],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[21] = -12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[15];
addNewBuffKrin("SHATTER2",_root.KrinLang[KLangChoosen].AU[15],"Ice");
_root.hackMove2[16] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[21] = -12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[15];
addNewBuffKrin("SHATTER3",_root.KrinLang[KLangChoosen].AU[15],"Ice");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[15];
addNewBuffKrin("BURNING",_root.KrinLang[KLangChoosen].AU[14],"Fire");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[14];
addNewBuffKrin("VOID1",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 3;
_root.hackMove2[12] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("VOID2",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 5;
_root.hackMove2[12] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("VOID3",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 7;
_root.hackMove2[12] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("VOID4",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 9;
_root.hackMove2[12] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("VOID5",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 11;
_root.hackMove2[12] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("VOIDMOB",_root.KrinLang[KLangChoosen].AU[16],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.3;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 11;
_root.hackMove2[12] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[16];
addNewBuffKrin("MAGICWOUND",_root.KrinLang[KLangChoosen].AU[12],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[13] = 0.17;
_root.hackMove2[21] = -7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[12];
addNewBuffKrin("INTERVENTION1",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 60;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.17;
_root.hackMove2[29] = -0.17;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION2",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 100;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.17;
_root.hackMove2[29] = -0.17;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION3",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 150;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.18;
_root.hackMove2[29] = -0.18;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION4",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 200;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.18;
_root.hackMove2[29] = -0.18;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION5",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 260;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.19;
_root.hackMove2[29] = -0.19;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION6",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 320;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.19;
_root.hackMove2[29] = -0.19;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION7",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 380;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.2;
_root.hackMove2[29] = -0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION8",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 440;
_root.hackMove2[28] = -0.2;
_root.hackMove2[14] = -7;
_root.hackMove2[29] = -0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION9",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 500;
_root.hackMove2[14] = -7;
_root.hackMove2[28] = -0.21;
_root.hackMove2[29] = -0.21;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("INTERVENTION10",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 600;
_root.hackMove2[28] = -0.21;
_root.hackMove2[14] = -7;
_root.hackMove2[29] = -0.21;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("POISONZOMBIE",_root.KrinLang[KLangChoosen].AU[11],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.33000000000000007;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[11];
addNewBuffKrin("BIO","Gligus Poison","Poison");
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "This unit is rotting away, taking damage equal to 200% of the casters strength.";
addNewBuffKrin("POWERUP",_root.KrinLang[KLangChoosen].AU[10],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[10];
addNewBuffKrin("LIGHTG","Light","Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[23] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "Gligus infused himself with Lightning! All of his attacks now deal Lightning damage.";
addNewBuffKrin("DARKNESSG","Darkness","Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[23] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "Gligus infused himself with Darkness! All of his attacks now deal Shadow damage.";
addNewBuffKrin("SUPRESSION",_root.KrinLang[KLangChoosen].AU[9],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.7000000000000001;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[9];
addNewBuffKrin("SUPRESSION2",_root.KrinLang[KLangChoosen].AU[9],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.3500000000000001;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "Reduces damage from incoming attacks by 35% for three turns.";
addNewBuffKrin("WOUND1",_root.KrinLang[KLangChoosen].AU[0],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 4;
_root.hackMove2[28] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[0];
addNewBuffKrin("WOUND2",_root.KrinLang[KLangChoosen].AU[0],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 0.12;
_root.hackMove2[14] = 8;
_root.hackMove2[28] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[0];
addNewBuffKrin("WOUND3",_root.KrinLang[KLangChoosen].AU[0],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 0.15;
_root.hackMove2[14] = 12;
_root.hackMove2[28] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[0];
addNewBuffKrin("STUN1",_root.KrinLang[KLangChoosen].AU[1],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[1];
addNewBuffKrin("RAGE1",_root.KrinLang[KLangChoosen].AU[2],"Fire");
_root.hackMove2[16] = 7;
_root.hackMove2[2] = 4;
_root.hackMove2[3] = 0.2;
_root.hackMove2[4] = 4;
_root.hackMove2[5] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[2];
addNewBuffKrin("RAGE2",_root.KrinLang[KLangChoosen].AU[2],"Fire");
_root.hackMove2[16] = 7;
_root.hackMove2[2] = 8;
_root.hackMove2[3] = 0.25;
_root.hackMove2[4] = 8;
_root.hackMove2[5] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[2];
addNewBuffKrin("RAGE3",_root.KrinLang[KLangChoosen].AU[2],"Fire");
_root.hackMove2[16] = 7;
_root.hackMove2[2] = 12;
_root.hackMove2[3] = 0.3;
_root.hackMove2[4] = 12;
_root.hackMove2[5] = 0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[2];
addNewBuffKrin("RAGE4",_root.KrinLang[KLangChoosen].AU[2],"Fire");
_root.hackMove2[16] = 7;
_root.hackMove2[2] = 12;
_root.hackMove2[3] = 0.3;
_root.hackMove2[4] = 12;
_root.hackMove2[5] = 0.3;
_root.hackMove2[6] = 0.3;
_root.hackMove2[7] = 0.3;
_root.hackMove2[8] = 0.3;
_root.hackMove2[9] = 0.3;
_root.hackMove2[10] = 0.3;
_root.hackMove2[11] = 0.3;
_root.hackMove2[12] = 0.3;
_root.hackMove2[13] = 0.3;
_root.hackMove2[14] = 0.3;
_root.hackMove2[15] = 0.3;
_root.hackMove2[16] = 0.3;
_root.hackMove2[17] = 0.3;
_root.hackMove2[18] = 0.3;
_root.hackMove2[19] = 0.3;
_root.hackMove2[20] = 0.3;
_root.hackMove2[21] = 0.3;
_root.hackMove2[22] = 0.3;
_root.hackMove2[23] = 0.3;
_root.hackMove2[24] = 0.3;
_root.hackMove2[25] = 0.3;
_root.hackMove2[26] = 0.3;
_root.hackMove2[27] = 0.3;
_root.hackMove2[28] = 0.3;
_root.hackMove2[29] = 0.3;
_root.hackMove2[30] = 0.3;
_root.hackMove2[31] = 0.3;
_root.hackMove2[32] = 0.3;
_root.hackMove2[33] = 0.3;
_root.hackMove2[34] = 0.3;
_root.hackMove2[35] = 0.3;
_root.hackMove2[36] = 0.3;
_root.hackMove2[37] = 0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[2];
addNewBuffKrin("IRONSKIN1",_root.KrinLang[KLangChoosen].AU[3],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = 1;
_root.hackMove2[8] = 100;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[3];
addNewBuffKrin("IRONSKIN2",_root.KrinLang[KLangChoosen].AU[3],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = 1;
_root.hackMove2[8] = 150;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[3];
addNewBuffKrin("IRONSKIN3",_root.KrinLang[KLangChoosen].AU[3],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = 1;
_root.hackMove2[8] = 200;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[3];
addNewBuffKrin("IRONSKIN4",_root.KrinLang[KLangChoosen].AU[3],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = 1;
_root.hackMove2[8] = 250;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[3];
addNewBuffKrin("IRONSKIN5",_root.KrinLang[KLangChoosen].AU[3],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = 1;
_root.hackMove2[8] = 300;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[3];
addNewBuffKrin("REGEN1",_root.KrinLang[KLangChoosen].AU[4],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[15] = 2;
_root.hackMove2[28] = -0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[4];
addNewBuffKrin("BLOCK1",_root.KrinLang[KLangChoosen].AU[5],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[19] = 1000000;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[5];
addNewBuffKrin("SOLIDITY1",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.03;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("SOLIDITY2",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.06;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("SOLIDITY3",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.09;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("SOLIDITY4",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.12;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("SOLIDITY5",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("DESTROYERS1",_root.KrinLang[KLangChoosen].AU[63],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[56] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[63];
addNewBuffKrin("DESTROYERS2",_root.KrinLang[KLangChoosen].AU[63],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[56] = 0.35;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[63];
addNewBuffKrin("DESTROYERS3",_root.KrinLang[KLangChoosen].AU[63],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[56] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[63];
addNewBuffKrin("DESTROYERS4",_root.KrinLang[KLangChoosen].AU[63],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[56] = 0.45;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[63];
addNewBuffKrin("DESTROYERS5",_root.KrinLang[KLangChoosen].AU[63],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[56] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[63];
addNewBuffKrin("BRUTALITY1",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[11] = 0.02;
_root.hackMove2[172] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("BRUTALITY2",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[11] = 0.04;
_root.hackMove2[172] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("BRUTALITY3",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[11] = 0.06;
_root.hackMove2[172] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("BRUTALITY4",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[11] = 0.08;
_root.hackMove2[172] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("BRUTALITY5",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[11] = 0.1;
_root.hackMove2[172] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION1",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -3;
_root.hackMove2[15] = -3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION2",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -7;
_root.hackMove2[15] = -4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION3",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -11;
_root.hackMove2[15] = -5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION4",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -15;
_root.hackMove2[15] = -6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION5",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -20;
_root.hackMove2[15] = -7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION6",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -25;
_root.hackMove2[15] = -8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION7",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -30;
_root.hackMove2[15] = -9;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION8",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -35;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION9",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -40;
_root.hackMove2[15] = -11;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("REGENERATION10",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[14] = -45;
_root.hackMove2[15] = -12;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("ENDURANCE1",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.04;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("ENDURANCE2",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.08;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("ENDURANCE3",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.12;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("ENDURANCE4",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.16;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("ENDURANCE5",_root.KrinLang[KLangChoosen].AU[6],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[6];
addNewBuffKrin("CRIPPLE1",_root.KrinLang[KLangChoosen].AU[7],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[7] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[7];
addNewBuffKrin("CRIPPLE2",_root.KrinLang[KLangChoosen].AU[7],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[7] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[7];
addNewBuffKrin("CRIPPLE3",_root.KrinLang[KLangChoosen].AU[7],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[7] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[7];
addNewBuffKrin("SUNDER1",_root.KrinLang[KLangChoosen].AU[8],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[3] = -0.12;
_root.hackMove2[13] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[8];
addNewBuffKrin("SUNDER2",_root.KrinLang[KLangChoosen].AU[8],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[3] = -0.14;
_root.hackMove2[13] = 0.14;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[8];
addNewBuffKrin("SUNDER3",_root.KrinLang[KLangChoosen].AU[8],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[3] = -0.16;
_root.hackMove2[13] = 0.16;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[8];
addNewBuffKrin("SUNDER4",_root.KrinLang[KLangChoosen].AU[8],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[3] = -0.18;
_root.hackMove2[13] = 0.18;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[8];
addNewBuffKrin("SUNDER5",_root.KrinLang[KLangChoosen].AU[8],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[3] = -0.2;
_root.hackMove2[13] = 0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[8];
addNewBuffKrin("POISON","Frozen","Ice");
_root.hackMove2[16] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "Target is stunned.";
addNewBuffKrin("BURNS","Burning","Fire");
_root.hackMove2[16] = 5;
_root.hackMove2[14] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "Target is burning for " + _root.hackMove2[14] + " damage every turn.";
addNewBuffKrin("REGEN","Blessing of Light","Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[19] = 200;
_root.hackMove2[25] = "Target is being healed every turn.";
addNewBuffKrin("INTERVENTION11",_root.KrinLang[KLangChoosen].AU[13],"Lightning");
_root.hackMove2[16] = 8;
_root.hackMove2[19] = 700;
_root.hackMove2[28] = -0.25;
_root.hackMove2[14] = -8;
_root.hackMove2[29] = -0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[13];
addNewBuffKrin("POISONZOMBIE2",_root.KrinLang[KLangChoosen].AU[31],"Poison");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.6;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[31];
addNewBuffKrin("POISONZOMBIE3",_root.KrinLang[KLangChoosen].AU[32],"Poison");
_root.hackMove2[16] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[32];
addNewBuffKrin("POISONZOMBIE4",_root.KrinLang[KLangChoosen].AU[33],"Poison");
_root.hackMove2[16] = 9;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[33];
addNewBuffKrin("POISONZOMBIE5",_root.KrinLang[KLangChoosen].AU[34],"Poison");
_root.hackMove2[16] = 8;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.9;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[34];
addNewBuffKrin("POISONZOMBIE6",_root.KrinLang[KLangChoosen].AU[35],"Poison");
_root.hackMove2[16] = 7;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[35];
addNewBuffKrin("FROSTZOMBIE",_root.KrinLang[KLangChoosen].AU[37],"Ice");
_root.hackMove2[16] = 7;
_root.hackMove2[27] = 1;
_root.hackMove2[7] = -0.2;
_root.hackMove2[28] = 0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[37];
addNewBuffKrin("FROSTGHOST",_root.KrinLang[KLangChoosen].AU[38],"Ice");
_root.hackMove2[16] = 7;
_root.hackMove2[27] = 1;
_root.hackMove2[7] = -0.3;
_root.hackMove2[28] = 0.6;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[38];
addNewBuffKrin("FIRESHOCK2",_root.KrinLang[KLangChoosen].AU[36],"Fire");
_root.hackMove2[16] = 2;
_root.hackMove2[28] = 0.6;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[36];
addNewBuffKrin("FIREZPCI",_root.KrinLang[KLangChoosen].AU[39],"Fire");
_root.hackMove2[16] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.22;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[39];
addNewBuffKrin("FIREZPCI2",_root.KrinLang[KLangChoosen].AU[40],"Fire");
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[8] = 100;
_root.hackMove2[28] = 0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[40];
addNewBuffKrin("FIREZPCI3",_root.KrinLang[KLangChoosen].AU[41],"Fire");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[3] = -0.16;
_root.hackMove2[28] = 0.45;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[41];
addNewBuffKrin("COSMIC",_root.KrinLang[KLangChoosen].AU[42],"Magic");
_root.hackMove2[16] = 9;
_root.hackMove2[29] = 0.4;
_root.hackMove2[13] = 0.1;
_root.hackMove2[14] = 11;
_root.hackMove2[12] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[42];
addNewBuffKrin("COSMIC2",_root.KrinLang[KLangChoosen].AU[43],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 1;
_root.hackMove2[13] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[43];
addNewBuffKrin("COSMIC3",_root.KrinLang[KLangChoosen].AU[44],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[14] = 500;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[44];
addNewBuffKrin("COSMIC4",_root.KrinLang[KLangChoosen].AU[45],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 1.5;
_root.hackMove2[11] = 0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[45];
addNewBuffKrin("JUSTICEBEDONE",BUFF_NAME[346],"Magic");
_root.hackMove2[36] = 0.3;
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[346];
addNewBuffKrin("C1",_root.KrinLang[KLangChoosen].AU[392],"Magic");
_root.hackMove2[13] = 0.05;
_root.hackMove2[29] = 0.3;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[392] + _root.hackMove2[29] * 100 + _root.KrinLang[KLangChoosen].AUX2[392] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX3[392];
addNewBuffKrin("CV1",_root.KrinLang[KLangChoosen].AU[392],"Magic");
_root.hackMove2[13] = 0.1;
_root.hackMove2[29] = 0.45;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[392] + _root.hackMove2[29] * 100 + _root.KrinLang[KLangChoosen].AUX2[392] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX3[392];
addNewBuffKrin("CV11",_root.KrinLang[KLangChoosen].AU[392],"Magic");
_root.hackMove2[13] = 0.15;
_root.hackMove2[29] = 0.6;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[392] + _root.hackMove2[29] * 100 + _root.KrinLang[KLangChoosen].AUX2[392] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX3[392];
addNewBuffKrin("CV111",_root.KrinLang[KLangChoosen].AU[392],"Magic");
_root.hackMove2[13] = 0.2;
_root.hackMove2[29] = 0.65;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[392] + _root.hackMove2[29] * 100 + _root.KrinLang[KLangChoosen].AUX2[392] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX3[392];
addNewBuffKrin("C2",_root.KrinLang[KLangChoosen].AU[393],"Magic");
_root.hackMove2[24] = -0.1;
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[393] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[393] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[393];
addNewBuffKrin("CV2",_root.KrinLang[KLangChoosen].AU[393],"Magic");
_root.hackMove2[24] = -0.15;
_root.hackMove2[28] = 0.4;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[393] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[393] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[393];
addNewBuffKrin("CV22",_root.KrinLang[KLangChoosen].AU[393],"Magic");
_root.hackMove2[24] = -0.2;
_root.hackMove2[28] = 0.5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[393] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[393] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[393];
addNewBuffKrin("CV222",_root.KrinLang[KLangChoosen].AU[393],"Magic");
_root.hackMove2[24] = -0.25;
_root.hackMove2[28] = 0.75;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[393] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[393] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[393];
addNewBuffKrin("C3",_root.KrinLang[KLangChoosen].AU[394],"Magic");
_root.hackMove2[39] = 2.5;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[394];
addNewBuffKrin("C33",_root.KrinLang[KLangChoosen].AU[394],"Magic");
_root.hackMove2[39] = 3;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[399];
addNewBuffKrin("C4",_root.KrinLang[KLangChoosen].AU[395],"Magic");
_root.hackMove2[39] = 0.5;
_root.hackMove2[38] = 0.5;
_root.hackMove2[29] = -1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[395];
addNewBuffKrin("C44",_root.KrinLang[KLangChoosen].AU[395],"Magic");
_root.hackMove2[39] = 1;
_root.hackMove2[38] = 1;
_root.hackMove2[29] = -1.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[400];
addNewBuffKrin("C5",_root.KrinLang[KLangChoosen].AU[396],"Magic");
_root.hackMove2[28] = -1;
_root.hackMove2[47] = 0.2;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[396];
addNewBuffKrin("C55",_root.KrinLang[KLangChoosen].AU[396],"Magic");
_root.hackMove2[28] = -1.5;
_root.hackMove2[47] = 0.25;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[401];
addNewBuffKrin("C6",_root.KrinLang[KLangChoosen].AU[397],"Magic");
_root.hackMove2[29] = -0.5;
_root.hackMove2[38] = 1;
_root.hackMove2[47] = 0.25;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[397];
addNewBuffKrin("C66",_root.KrinLang[KLangChoosen].AU[397],"Magic");
_root.hackMove2[29] = -1;
_root.hackMove2[38] = 1.25;
_root.hackMove2[47] = 0.35;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[402];
addNewBuffKrin("C7",_root.KrinLang[KLangChoosen].AU[398],"Magic");
_root.hackMove2[39] = 5;
_root.hackMove2[38] = 5;
_root.hackMove2[23] = -0.2;
_root.hackMove2[14] = -150;
_root.hackMove2[16] = 99;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[398];
addNewBuffKrin("C8",_root.KrinLang[KLangChoosen].AU[403],"Magic");
_root.hackMove2[11] = 0.25;
_root.hackMove2[13] = 0.5;
_root.hackMove2[23] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 7;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[403];
addNewBuffKrin("C88",_root.KrinLang[KLangChoosen].AU[403],"Magic");
_root.hackMove2[11] = 0.4;
_root.hackMove2[13] = 0.4;
_root.hackMove2[23] = 0.7;
_root.hackMove2[16] = 5;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[404];
addNewBuffKrin("C888",_root.KrinLang[KLangChoosen].AU[403],"Magic");
_root.hackMove2[11] = 0.5;
_root.hackMove2[13] = 0.25;
_root.hackMove2[23] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[405];
addNewBuffKrin("ENERGYDRAIN",_root.KrinLang[KLangChoosen].AU[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[83] + _root.hackMove2[15] + _root.KrinLang[KLangChoosen].AUX2[83];
addNewBuffKrin("ENERGYDRAIN2",_root.KrinLang[KLangChoosen].AU[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[83] + _root.hackMove2[15] + _root.KrinLang[KLangChoosen].AUX2[83];
addNewBuffKrin("ENERGYDRAIN3",_root.KrinLang[KLangChoosen].AU[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[83] + _root.hackMove2[15] + _root.KrinLang[KLangChoosen].AUX2[83];
addNewBuffKrin("ENERGYDRAIN4",_root.KrinLang[KLangChoosen].AU[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[83] + _root.hackMove2[15] + _root.KrinLang[KLangChoosen].AUX2[83];
addNewBuffKrin("C11",_root.KrinLang[KLangChoosen].AU[406],"Magic");
_root.hackMove2[13] = 0.25;
_root.hackMove2[29] = 0.6;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[406] + _root.hackMove2[29] * 100 + _root.KrinLang[KLangChoosen].AUX2[406] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX3[392];
addNewBuffKrin("C12",_root.KrinLang[KLangChoosen].AU[407],"Magic");
_root.hackMove2[24] = -0.3;
_root.hackMove2[28] = 0.5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[407] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[407];
addNewBuffKrin("C9",_root.KrinLang[KLangChoosen].AU[408],"Magic");
_root.hackMove2[3] = -0.25;
_root.hackMove2[5] = -0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[408];
addNewBuffKrin("C13",_root.KrinLang[KLangChoosen].AU[409],"Magic");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = "Unit is stunned and cannot act also taking 25% extra damage from all sources.";
addNewBuffKrin("C14",_root.KrinLang[KLangChoosen].AU[412],"Magic");
_root.hackMove2[29] = -1.25;
_root.hackMove2[28] = -1.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[412];
addNewBuffKrin("C15",_root.KrinLang[KLangChoosen].AU[412],"Magic");
_root.hackMove2[29] = -2;
_root.hackMove2[28] = -2;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[413];
addNewBuffKrin("C16",_root.KrinLang[KLangChoosen].AU[410],"Magic");
_root.hackMove2[39] = 2.5;
_root.hackMove2[38] = 2.5;
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[410];
addNewBuffKrin("C17",_root.KrinLang[KLangChoosen].AU[410],"Magic");
_root.hackMove2[39] = 4;
_root.hackMove2[38] = 4;
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.4;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[411];
addNewBuffKrin("C18",_root.KrinLang[KLangChoosen].AU[414],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 0.3;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[414] + _root.hackMove2[7] * 100 + _root.KrinLang[KLangChoosen].AUX2[414];
addNewBuffKrin("C20",_root.KrinLang[KLangChoosen].AU[415],"Magic");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -1.5;
_root.hackMove2[28] = -1.5;
_root.hackMove2[47] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[415];
addNewBuffKrin("C21",_root.KrinLang[KLangChoosen].AU[415],"Magic");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -1.75;
_root.hackMove2[28] = -1.75;
_root.hackMove2[47] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[416];
addNewBuffKrin("FORCEOFJUSTICE2",_root.KrinLang[KLangChoosen].AU[339],"Magic");
_root.hackMove2[5] = 0.2;
_root.hackMove2[3] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[417];
addNewBuffKrin("FORCEOFJUSTICE3",_root.KrinLang[KLangChoosen].AU[339],"Magic");
_root.hackMove2[5] = 0.25;
_root.hackMove2[3] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[418];
addNewBuffKrin("FORCEOFJUSTICE4",_root.KrinLang[KLangChoosen].AU[339],"Magic");
_root.hackMove2[5] = 0.3;
_root.hackMove2[3] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[419];
addNewBuffKrin("FORCEOFJUSTICE5",_root.KrinLang[KLangChoosen].AU[339],"Magic");
_root.hackMove2[5] = 0.4;
_root.hackMove2[3] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[420];
addNewBuffKrin("C222",_root.KrinLang[KLangChoosen].AU[421],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[13] = -1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[421];
addNewBuffKrin("C23",_root.KrinLang[KLangChoosen].AU[422],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[28] = -0.5;
_root.hackMove2[29] = -0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[422];
addNewBuffKrin("PREPARED","Prepared","Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -50;
addNewBuffKrin("OVERDRIVE1","","Magic");
_root.hackMove2[16] = -1;
_root.hackMove2[48] = 0.5;
addNewBuffKrin("CHARGEDBLOOD1","","Magic");
_root.hackMove2[49] = 500;
_root.hackMove2[15] = -10;
_root.hackMove2[13] = 0.05;
_root.hackMove2[16] = -1;
addNewBuffKrin("CHARGEDBLOOD2","","Magic");
_root.hackMove2[49] = 1000;
_root.hackMove2[13] = 0.2;
_root.hackMove2[15] = -20;
_root.hackMove2[16] = -1;
addNewBuffKrin("CHARGEDBLOOD3","","Magic");
_root.hackMove2[49] = 1500;
_root.hackMove2[13] = 0.2;
_root.hackMove2[15] = -40;
_root.hackMove2[16] = -1;
addNewBuffKrin("CHARGEDBLOOD4","","Magic");
_root.hackMove2[49] = 1900;
_root.hackMove2[15] = -75;
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = -1;
addNewBuffKrin("ENVENOM67",_root.KrinLang[KLangChoosen].AU[46],"Poison");
_root.hackMove2[16] = 8;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[46] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[46];
addNewBuffKrin("ENVENOM67A",_root.KrinLang[KLangChoosen].AU[46],"Poison");
_root.hackMove2[16] = 8;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.6;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[46] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[46];
addNewBuffKrin("ENVENOM67B",_root.KrinLang[KLangChoosen].AU[46],"Poison");
_root.hackMove2[16] = 8;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[46] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[46];
addNewBuffKrin("ENVENOM67C",_root.KrinLang[KLangChoosen].AU[46],"Poison");
_root.hackMove2[16] = 8;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[46] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[46];
addNewBuffKrin("POISONDEFENSE",_root.KrinLang[KLangChoosen].AU[47],"Poison");
_root.hackMove2[24] = -0.1;
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[47] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[47] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[47];
addNewBuffKrin("POISONDEFENSE2",_root.KrinLang[KLangChoosen].AU[47],"Poison");
_root.hackMove2[24] = -0.15;
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[47] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[47] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[47];
addNewBuffKrin("POISONDEFENSE3",_root.KrinLang[KLangChoosen].AU[47],"Poison");
_root.hackMove2[24] = -0.18;
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[47] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[47] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[47];
addNewBuffKrin("POISONDEFENSE4",_root.KrinLang[KLangChoosen].AU[47],"Poison");
_root.hackMove2[24] = -0.2;
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[47] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[47] + _root.hackMove2[24] * -100 + _root.KrinLang[KLangChoosen].AUX3[47];
addNewBuffKrin("SHADOWBLEND1",_root.KrinLang[KLangChoosen].AU[48],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 1;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[48] + _root.hackMove2[7] * 100 + _root.KrinLang[KLangChoosen].AUX2[48];
addNewBuffKrin("SHADOWBLEND2",_root.KrinLang[KLangChoosen].AU[48],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 2;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[48] + _root.hackMove2[7] * 100 + _root.KrinLang[KLangChoosen].AUX2[48];
addNewBuffKrin("SHADOWBLEND3",_root.KrinLang[KLangChoosen].AU[48],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 3;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[48] + _root.hackMove2[7] * 100 + _root.KrinLang[KLangChoosen].AUX2[48];
addNewBuffKrin("SHADOWBLEND4",_root.KrinLang[KLangChoosen].AU[48],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 4;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[48] + _root.hackMove2[7] * 100 + _root.KrinLang[KLangChoosen].AUX2[48];
addNewBuffKrin("AWARENESS1",_root.KrinLang[KLangChoosen].AU[49],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.2;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[49] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[49];
addNewBuffKrin("AWARENESS2",_root.KrinLang[KLangChoosen].AU[49],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.35;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[49] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[49];
addNewBuffKrin("AWARENESS3",_root.KrinLang[KLangChoosen].AU[49],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.5;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[49] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[49];
addNewBuffKrin("AWARENESS4",_root.KrinLang[KLangChoosen].AU[49],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.6500000000000001;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[49] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[49];
addNewBuffKrin("SHADSHI",_root.KrinLang[KLangChoosen].AU[50],"Shadow");
_root.hackMove2[38] = 0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[50] + _root.hackMove2[38] * 100 + _root.KrinLang[KLangChoosen].AUX2[50];
addNewBuffKrin("SHADSHI2",_root.KrinLang[KLangChoosen].AU[50],"Shadow");
_root.hackMove2[38] = 0.7;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[50] + _root.hackMove2[38] * 100 + _root.KrinLang[KLangChoosen].AUX2[50];
addNewBuffKrin("SHADSHI3",_root.KrinLang[KLangChoosen].AU[50],"Shadow");
_root.hackMove2[38] = 0.9;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[50] + _root.hackMove2[38] * 100 + _root.KrinLang[KLangChoosen].AUX2[50];
addNewBuffKrin("SHADSHI4",_root.KrinLang[KLangChoosen].AU[50],"Shadow");
_root.hackMove2[38] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[50] + _root.hackMove2[38] * 100 + _root.KrinLang[KLangChoosen].AUX2[50];
addNewBuffKrin("IMPAIR1",_root.KrinLang[KLangChoosen].AU[51],"Physical");
_root.hackMove2[13] = 0.06;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[51] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX2[51];
addNewBuffKrin("IMPAIR2",_root.KrinLang[KLangChoosen].AU[51],"Physical");
_root.hackMove2[13] = 0.09;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[51] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX2[51];
addNewBuffKrin("IMPAIR3",_root.KrinLang[KLangChoosen].AU[51],"Physical");
_root.hackMove2[13] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[51] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX2[51];
addNewBuffKrin("IMPAIR4",_root.KrinLang[KLangChoosen].AU[51],"Physical");
_root.hackMove2[13] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[51] + _root.hackMove2[13] * 100 + _root.KrinLang[KLangChoosen].AUX2[51];
addNewBuffKrin("BLOODRUSH1",_root.KrinLang[KLangChoosen].AU[52],"Physical");
_root.hackMove2[11] = 0.06;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[52] + _root.hackMove2[11] * 100 + _root.KrinLang[KLangChoosen].AUX2[52];
addNewBuffKrin("BLOODRUSH2",_root.KrinLang[KLangChoosen].AU[52],"Physical");
_root.hackMove2[11] = 0.09;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[52] + _root.hackMove2[11] * 100 + _root.KrinLang[KLangChoosen].AUX2[52];
addNewBuffKrin("BLOODRUSH3",_root.KrinLang[KLangChoosen].AU[52],"Physical");
_root.hackMove2[11] = 0.12;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[52] + _root.hackMove2[11] * 100 + _root.KrinLang[KLangChoosen].AUX2[52];
addNewBuffKrin("BLOODRUSH4",_root.KrinLang[KLangChoosen].AU[52],"Physical");
_root.hackMove2[11] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[52] + _root.hackMove2[11] * 100 + _root.KrinLang[KLangChoosen].AUX2[52];
addNewBuffKrin("REGULATE1",_root.KrinLang[KLangChoosen].AU[53],"Ice");
_root.hackMove2[15] = -5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[53] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[53];
addNewBuffKrin("REGULATE2",_root.KrinLang[KLangChoosen].AU[53],"Ice");
_root.hackMove2[15] = -8;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[53] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[53];
addNewBuffKrin("REGULATE3",_root.KrinLang[KLangChoosen].AU[53],"Ice");
_root.hackMove2[15] = -11;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[53] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[53];
addNewBuffKrin("FIREI",_root.KrinLang[KLangChoosen].AU[54],"Fire");
_root.hackMove2[23] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[51] = 1;
_root.hackMove2[27] = 3;
_root.hackMove2[53] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[54] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[54];
addNewBuffKrin("FIREI44",_root.KrinLang[KLangChoosen].AU[54],"Fire");
_root.hackMove2[23] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 3;
_root.hackMove2[51] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[54] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[54];
addNewBuffKrin("FIREI55",_root.KrinLang[KLangChoosen].AU[54],"Fire");
_root.hackMove2[23] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 3;
_root.hackMove2[51] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[54] + _root.hackMove2[23] * 100 + _root.KrinLang[KLangChoosen].AUX2[54];
addNewBuffKrin("FIREI1",_root.KrinLang[KLangChoosen].AU[55],"Fire");
_root.hackMove2[20] = 1;
_root.hackMove2[55] = -20;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[55];
addNewBuffKrin("BLIZZARDI",_root.KrinLang[KLangChoosen].AU[56],"Ice");
_root.hackMove2[11] = -0.5;
_root.hackMove2[15] = -32;
_root.hackMove2[20] = 2;
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[56] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[56];
addNewBuffKrin("BLIZZARDI44",_root.KrinLang[KLangChoosen].AU[56],"Ice");
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[50] = 2;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[56] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[56];
addNewBuffKrin("BLIZZARDI55",_root.KrinLang[KLangChoosen].AU[56],"Ice");
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[50] = 3;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[56] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[56];
addNewBuffKrin("BLIZZARDIV",_root.KrinLang[KLangChoosen].AU[57],"Fire");
_root.hackMove2[52] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 2;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[57];
addNewBuffKrin("NOMANA",_root.KrinLang[KLangChoosen].AU[58],"Fire");
_root.hackMove2[15] = 100;
_root.hackMove2[20] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[58] + _root.hackMove2[15] * -1 + _root.KrinLang[KLangChoosen].AUX2[58];
addNewBuffKrin("ENHANCEDFLARE",_root.KrinLang[KLangChoosen].AU[58],"Fire");
_root.hackMove2[54] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[58];
addNewBuffKrin("THUNDERII",_root.KrinLang[KLangChoosen].AU[60],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[60] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[60];
addNewBuffKrin("THUNDERIV",_root.KrinLang[KLangChoosen].AU[61],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[61] + _root.hackMove2[28] * 100 + _root.KrinLang[KLangChoosen].AUX2[61];
addNewBuffKrin("Manaward",_root.KrinLang[KLangChoosen].AU[62],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[41] = 0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[62];
addNewBuffKrin("FIREI2",_root.KrinLang[KLangChoosen].AU[55],"Fire");
_root.hackMove2[20] = 1;
_root.hackMove2[57] = -20;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[55];
addNewBuffKrin("RIOTBLADE",_root.KrinLang[KLangChoosen].AU[64],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[64];
addNewBuffKrin("DIVINEMIGHT",_root.KrinLang[KLangChoosen].AU[66],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[99] = 2;
_root.hackMove2[5] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[66];
addNewBuffKrin("TANKSTANCE1","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.2;
_root.hackMove2[3] = 0.2;
_root.hackMove2[9] = 0.2;
_root.hackMove2[20] = 1;
addNewBuffKrin("SHELTRON",_root.KrinLang[KLangChoosen].AU[68],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = -1.25;
_root.hackMove2[13] = -0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[68];
addNewBuffKrin("SHELTRON2",_root.KrinLang[KLangChoosen].AU[68],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = -2.5;
_root.hackMove2[13] = -0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[69];
addNewBuffKrin("SHELTRON3",_root.KrinLang[KLangChoosen].AU[69],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = -1.25;
_root.hackMove2[13] = -0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[68];
addNewBuffKrin("SHELTRON4",_root.KrinLang[KLangChoosen].AU[69],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = -2.5;
_root.hackMove2[13] = -0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[69];
addNewBuffKrin("ATONEMENT",_root.KrinLang[KLangChoosen].AU[70],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[70];
addNewBuffKrin("DIVINEMIGHT2",_root.KrinLang[KLangChoosen].AU[70],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -30;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[70];
addNewBuffKrin("LIVINGDEAD",_root.KrinLang[KLangChoosen].AU[71],"Shadow");
_root.hackMove2[164] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[71];
addNewBuffKrin("SUPERHEALTH1","","Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 111;
addNewBuffKrin("DUALCAST1","","Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[157] = "DUALCAST";
addNewBuffKrin("DUALCAST",_root.KrinLang[KLangChoosen].AU[127],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[158] = -4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[127];
addNewBuffKrin("DARKSIDE",_root.KrinLang[KLangChoosen].AU[72],"Shadow");
_root.hackMove2[16] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = 0.1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[72];
addNewBuffKrin("BLOODWEAPON",_root.KrinLang[KLangChoosen].AU[73],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[15] = -10;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[73];
addNewBuffKrin("BLOODWEAPON1",_root.KrinLang[KLangChoosen].AU[73],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[15] = -15;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX2[73];
addNewBuffKrin("THEBLACKESTNIGHT",_root.KrinLang[KLangChoosen].AU[74],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[41] = 0.31;
_root.hackMove2[155] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[74];
addNewBuffKrin("DUDRA",_root.KrinLang[KLangChoosen].AU[75],"Earth");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[75];
addNewBuffKrin("KASSATSU",_root.KrinLang[KLangChoosen].AU[188],"Magic");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[188];
addNewBuffKrin("TEN",_root.KrinLang[KLangChoosen].AU[190],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[190];
addNewBuffKrin("CHI",_root.KrinLang[KLangChoosen].AU[191],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[191];
addNewBuffKrin("JIN",_root.KrinLang[KLangChoosen].AU[192],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[192];
addNewBuffKrin("TENCHIJIN",_root.KrinLang[KLangChoosen].AU[189],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[177] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[189];
addNewBuffKrin("DUDRA2",_root.KrinLang[KLangChoosen].AU[77],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[77];
addNewBuffKrin("DUDRA3",_root.KrinLang[KLangChoosen].AU[76],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[76];
addNewBuffKrin("DUDRA4",_root.KrinLang[KLangChoosen].AU[110],"Ice");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[110];
addNewBuffKrin("DUDRA5",_root.KrinLang[KLangChoosen].AU[79],"Earth");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[79];
addNewBuffKrin("DUDRA6",_root.KrinLang[KLangChoosen].AU[78],"Earth");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[63] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[78];
addNewBuffKrin("DUDRA7",_root.KrinLang[KLangChoosen].AU[75],"Earth");
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[61] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[75];
addNewBuffKrin("DUDRA8",_root.KrinLang[KLangChoosen].AU[87],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[60] = 1;
_root.hackMove2[63] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[87];
addNewBuffKrin("STUN2",_root.KrinLang[KLangChoosen].AU[1],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[1];
addNewBuffKrin("HUTON",_root.KrinLang[KLangChoosen].AU[111],"Poison");
_root.hackMove2[16] = 15;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 0.25;
_root.hackMove2[35] = 0.5;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[111];
addNewBuffKrin("BLOODBATH",_root.KrinLang[KLangChoosen].AU[80],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[57] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[80];
addNewBuffKrin("BLOODBATH2",_root.KrinLang[KLangChoosen].AU[80],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[58] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX2[80];
addNewBuffKrin("SHADESHIFT",_root.KrinLang[KLangChoosen].AU[81],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[41] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[81];
addNewBuffKrin("VULNERABLITY",_root.KrinLang[KLangChoosen].AU[82],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[32] = 1;
_root.hackMove2[13] = 0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[82];
addNewBuffKrin("TRICKATTACK",_root.KrinLang[KLangChoosen].AU[148],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[32] = 1;
_root.hackMove2[13] = 0.25;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[148];
addNewBuffKrin("FLEET1","","Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[6] = 0.2;
addNewBuffKrin("MISUI",_root.KrinLang[KLangChoosen].AU[84],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -50;
_root.hackMove2[23] = 1.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[84];
addNewBuffKrin("HIGI",_root.KrinLang[KLangChoosen].AU[147],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[162] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[147];
addNewBuffKrin("DOTON",_root.KrinLang[KLangChoosen].AU[85],"Earth");
_root.hackMove2[16] = 8;
_root.hackMove2[30] = 1.6;
_root.hackMove2[6] = -0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[85];
addNewBuffKrin("SUITON",_root.KrinLang[KLangChoosen].AU[86],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[30] = -2;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[86];
addNewBuffKrin("SHUKIHO1","","Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[15] = -5;
addNewBuffKrin("HOLLOWNOZUCHI1","","Earth");
_root.hackMove2[16] = -1;
_root.hackMove2[178] = 0.5;
_root.hackMove2[32] = 1;
addNewBuffKrin("MELEEMASTERY1","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[23] = 0.5;
addNewBuffKrin("STEALTH",_root.KrinLang[KLangChoosen].AU[88],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[6] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[88];
addNewBuffKrin("STEALTH2",_root.KrinLang[KLangChoosen].AU[89],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[40] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[89] + _root.hackMove2[40] * 100 + _root.KrinLang[KLangChoosen].AUX2[89];
addNewBuffKrin("STEALTH3",_root.KrinLang[KLangChoosen].AU[89],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[40] = 2.5;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[89] + _root.hackMove2[40] * 100 + _root.KrinLang[KLangChoosen].AUX2[89];
addNewBuffKrin("STEALTH4",_root.KrinLang[KLangChoosen].AU[89],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[40] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[89] + _root.hackMove2[40] * 100 + _root.KrinLang[KLangChoosen].AUX2[89];
addNewBuffKrin("STEALTH5",_root.KrinLang[KLangChoosen].AU[89],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[40] = 3.5;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[89] + _root.hackMove2[40] * 100 + _root.KrinLang[KLangChoosen].AUX2[89];
addNewBuffKrin("FEINT",_root.KrinLang[KLangChoosen].AU[90],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[90];
addNewBuffKrin("PARALYZE",_root.KrinLang[KLangChoosen].AU[183],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[7] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[183];
addNewBuffKrin("VULNERABLITY2",_root.KrinLang[KLangChoosen].AU[91],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[91];
addNewBuffKrin("DEATHAWAITS",_root.KrinLang[KLangChoosen].AU[177],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[13] = 0.35;
_root.hackMove2[173] = "DAMAGEDOWN2";
_root.hackMove2[28] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.75;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[177];
addNewBuffKrin("POISONZOMBIEC",_root.KrinLang[KLangChoosen].AU[92],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[28] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[92];
addNewBuffKrin("PHYSVUL",_root.KrinLang[KLangChoosen].AU[93],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[24] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[93];
addNewBuffKrin("RUBYGLOW",_root.KrinLang[KLangChoosen].AU[94],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[38] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[94];
addNewBuffKrin("WARDENS",_root.KrinLang[KLangChoosen].AU[95],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[41] = 0.07;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[95];
addNewBuffKrin("GOLBEZ",_root.KrinLang[KLangChoosen].AU[100],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[23] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[100];
addNewBuffKrin("WARDENS6",_root.KrinLang[KLangChoosen].AU[98],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[41] = 0.05;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[98];
addNewBuffKrin("WARDENS3",_root.KrinLang[KLangChoosen].AU[95],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[95];
addNewBuffKrin("WARDENS4",_root.KrinLang[KLangChoosen].AU[96],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[23] = 0.51;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[96];
addNewBuffKrin("WARDENS5",_root.KrinLang[KLangChoosen].AU[97],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[11] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[97];
addNewBuffKrin("DAMAGEDOWNVERA",_root.KrinLang[KLangChoosen].AU[139],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[11] = -0.25;
_root.hackMove2[13] = 0.25;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[139];
addNewBuffKrin("WARDENS2",_root.KrinLang[KLangChoosen].AU[98],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 900;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[98];
addNewBuffKrin("BLEED",_root.KrinLang[KLangChoosen].AU[99],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[28] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[99];
addNewBuffKrin("SHADOWFANG",_root.KrinLang[KLangChoosen].AU[200],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[28] = 0.9;
_root.hackMove2[30] = 0.45;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[200];
addNewBuffKrin("BLEED5",_root.KrinLang[KLangChoosen].AU[145],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[145];
addNewBuffKrin("BLEED6",_root.KrinLang[KLangChoosen].AU[150],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[150];
addNewBuffKrin("TEMPTINGTWIST",_root.KrinLang[KLangChoosen].AU[149],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[165] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[149];
addNewBuffKrin("SPLASHOFVENOM",_root.KrinLang[KLangChoosen].AU[161],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[168] = 3;
_root.hackMove2[169] = "POISONVULNERABLITY";
_root.hackMove2[170] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[161];
addNewBuffKrin("DROPOFVENOM",_root.KrinLang[KLangChoosen].AU[162],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[168] = 12;
_root.hackMove2[169] = "POISONVULNERABLITY";
_root.hackMove2[170] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[162];
addNewBuffKrin("SIDEWISESPARKR",_root.KrinLang[KLangChoosen].AU[213],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[168] = 12;
_root.hackMove2[169] = "LIGHTNINGVULNERABILITY";
_root.hackMove2[170] = 2;
_root.hackMove2[81] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[213];
addNewBuffKrin("SIDEWISESPARKL",_root.KrinLang[KLangChoosen].AU[214],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[168] = 3;
_root.hackMove2[81] = 1;
_root.hackMove2[169] = "LIGHTNINGVULNERABILITY";
_root.hackMove2[170] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[214];
addNewBuffKrin("HONEYBEELINE",_root.KrinLang[KLangChoosen].AU[151],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[166] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[151];
addNewBuffKrin("HONEYBEELIVE",_root.KrinLang[KLangChoosen].AU[152],"Magic");
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[152];
addNewBuffKrin("HONEYBEELIVE1",_root.KrinLang[KLangChoosen].AU[153],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[167] = 1;
_root.hackMove2[116] = 3;
_root.hackMove2[109] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[153];
addNewBuffKrin("HONEYBEELIVE3",_root.KrinLang[KLangChoosen].AU[152],"Magic");
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[152];
addNewBuffKrin("BEELOVEDVENOMA",_root.KrinLang[KLangChoosen].AU[165],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[171] = 2.5;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[165];
addNewBuffKrin("HONEYBEELIVE4",_root.KrinLang[KLangChoosen].AU[164],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[167] = 1;
_root.hackMove2[116] = 6;
_root.hackMove2[109] = 6;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[164];
addNewBuffKrin("BLOWKISS",_root.KrinLang[KLangChoosen].AU[159],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[159];
addNewBuffKrin("LOVE0",_root.KrinLang[KLangChoosen].AU[158],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[158];
addNewBuffKrin("CALORIC","Close Caloric","Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[187] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "This buff starts with 1 Stack. If you move or take damage by any fire attack, you get one stack. If you have 5 stacks your entire team dies.";
addNewBuffKrin("ATMOS","Atmosfaction","Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[186] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "When this debuff expires your partner dies except if you move at the end of the duration.";
addNewBuffKrin("PYRE","Pyrefaction","Fire");
_root.hackMove2[16] = 2;
_root.hackMove2[185] = 3.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "When this debuff expires you will die except if you dont move at the end of the duration.";
addNewBuffKrin("LOVE1",_root.KrinLang[KLangChoosen].AU[154],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = 0.2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[154];
addNewBuffKrin("LOVE2",_root.KrinLang[KLangChoosen].AU[155],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = 0.4;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[155];
addNewBuffKrin("NEGATRON",_root.KrinLang[KLangChoosen].AU[218],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[183] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[218];
addNewBuffKrin("POSITRON",_root.KrinLang[KLangChoosen].AU[217],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[184] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[217];
addNewBuffKrin("ELECTROPE",_root.KrinLang[KLangChoosen].AU[208],"Lightning");
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[182] = "ELECTROPED2";
_root.hackMove2[32] = 1;
_root.hackMove2[81] = -2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[208];
addNewBuffKrin("ELECTROPE1",_root.KrinLang[KLangChoosen].AU[209],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[182] = "ELECTROPED1";
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[209];
addNewBuffKrin("NEGATRON2",_root.KrinLang[KLangChoosen].AU[220],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[182] = "NEGATRON3";
_root.hackMove2[32] = 1;
_root.hackMove2[81] = -2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[220];
addNewBuffKrin("POSITRON2",_root.KrinLang[KLangChoosen].AU[219],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[182] = "POSITRON3";
_root.hackMove2[32] = 1;
_root.hackMove2[81] = -2;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[219];
addNewBuffKrin("ELECTROPED1",_root.KrinLang[KLangChoosen].AU[211],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[181] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[211];
addNewBuffKrin("ELECTROPED2",_root.KrinLang[KLangChoosen].AU[212],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[181] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[212];
addNewBuffKrin("NEGATRON3",_root.KrinLang[KLangChoosen].AU[221],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[181] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[221];
addNewBuffKrin("POSITRON3",_root.KrinLang[KLangChoosen].AU[222],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[181] = 4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[222];
addNewBuffKrin("ELECTROPE2",_root.KrinLang[KLangChoosen].AU[210],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[210];
addNewBuffKrin("LOVE3",_root.KrinLang[KLangChoosen].AU[156],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[156];
addNewBuffKrin("LOVE4",_root.KrinLang[KLangChoosen].AU[157],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[29] = 3;
_root.hackMove2[168] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[157];
addNewBuffKrin("GOLBEZ2",_root.KrinLang[KLangChoosen].AU[98],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 150;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[98];
addNewBuffKrin("PALLADION",_root.KrinLang[KLangChoosen].AU[98],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 900;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[98];
addNewBuffKrin("PARTHENOS2",_root.KrinLang[KLangChoosen].AU[109],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[15] = 1000;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[109];
addNewBuffKrin("LIGHTNINGSPARK",_root.KrinLang[KLangChoosen].AU[101],"Lightning");
_root.hackMove2[16] = 1;
_root.hackMove2[57] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[101];
addNewBuffKrin("HOLYCHAIN","Burning Chains","Fire");
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "You are chained! Unable to use any melee attacks!";
addNewBuffKrin("LIGHTNINGSPARK2",_root.KrinLang[KLangChoosen].AU[101],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[58] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX2[101];
addNewBuffKrin("SOULGRASP",_root.KrinLang[KLangChoosen].AU[104],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[104];
addNewBuffKrin("SOULGRASP2",_root.KrinLang[KLangChoosen].AU[144],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[144];
addNewBuffKrin("SOULGRASP3",_root.KrinLang[KLangChoosen].AU[166],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[166];
addNewBuffKrin("SOULGRASP4",_root.KrinLang[KLangChoosen].AU[216],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[216];
addNewBuffKrin("SOULGRASP5",_root.KrinLang[KLangChoosen].AU[223],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[223];
addNewBuffKrin("BLEED2",_root.KrinLang[KLangChoosen].AU[103],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[103];
addNewBuffKrin("SILKSPIT",_root.KrinLang[KLangChoosen].AU[105],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[6] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[105];
addNewBuffKrin("SHADOWRES",_root.KrinLang[KLangChoosen].AU[106],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[24] = -0.8;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[106];
addNewBuffKrin("PHYSICALVULNERABLITY",_root.KrinLang[KLangChoosen].AU[201],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[24] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[201];
addNewBuffKrin("PHYSICALVULNERABLITY2",_root.KrinLang[KLangChoosen].AU[201],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[24] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[201];
addNewBuffKrin("PHYSICALVULNERABLITY3",_root.KrinLang[KLangChoosen].AU[201],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[24] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[201];
addNewBuffKrin("NEAR",_root.KrinLang[KLangChoosen].AU[204],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[179] = "Melee";
_root.hackMove2[165] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[204];
addNewBuffKrin("NEARFARNEAR",_root.KrinLang[KLangChoosen].AU[205],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[179] = "Melee";
_root.hackMove2[165] = "Melee";
_root.hackMove2[141] = "NEARFARNEAR2";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[205];
addNewBuffKrin("NEARFARNEAR2",_root.KrinLang[KLangChoosen].AU[206],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[180] = "Melee";
_root.hackMove2[166] = "Melee";
_root.hackMove2[141] = "NEARFARNEAR3";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[206];
addNewBuffKrin("NEARFARNEAR3",_root.KrinLang[KLangChoosen].AU[206],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[179] = "Melee";
_root.hackMove2[165] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[206];
addNewBuffKrin("FAR",_root.KrinLang[KLangChoosen].AU[203],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[180] = "Melee";
_root.hackMove2[166] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[203];
addNewBuffKrin("FARNEARFAR",_root.KrinLang[KLangChoosen].AU[207],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[180] = "Melee";
_root.hackMove2[166] = "Melee";
_root.hackMove2[141] = "FARNEARFAR2";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[207];
addNewBuffKrin("FARNEARFAR2",_root.KrinLang[KLangChoosen].AU[206],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[179] = "Melee";
_root.hackMove2[165] = "Melee";
_root.hackMove2[141] = "FARNEARFAR3";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[206];
addNewBuffKrin("FARNEARFAR3",_root.KrinLang[KLangChoosen].AU[206],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[180] = "Melee";
_root.hackMove2[166] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[206];
addNewBuffKrin("POISONVULNERABLITY",_root.KrinLang[KLangChoosen].AU[163],"Poison");
_root.hackMove2[16] = 1;
_root.hackMove2[24] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[163];
addNewBuffKrin("LIGHTNINGVULNERABILITY",_root.KrinLang[KLangChoosen].AU[215],"Lightning");
_root.hackMove2[16] = 1;
_root.hackMove2[24] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[215];
addNewBuffKrin("LIGHTNINGRES",_root.KrinLang[KLangChoosen].AU[107],"Lightning");
_root.hackMove2[16] = 7;
_root.hackMove2[24] = -0.8;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[107];
addNewBuffKrin("PARTHENOS",_root.KrinLang[KLangChoosen].AU[108],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[13] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[108];
addNewBuffKrin("BUNSHIN",_root.KrinLang[KLangChoosen].AU[115],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[13] = -0.25;
_root.hackMove2[163] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[115];
addNewBuffKrin("WHITEPAINT",_root.KrinLang[KLangChoosen].AU[116],"Magic");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[116];
addNewBuffKrin("DPS","DPS","Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "This unit is will target the unit who dealt the most damage this turn.";
addNewBuffKrin("WINGS",_root.KrinLang[KLangChoosen].AU[202],"Magic");
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[202];
addNewBuffKrin("RAIJUREADY",_root.KrinLang[KLangChoosen].AU[193],"Lightning");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[193];
addNewBuffKrin("POLYGOT",_root.KrinLang[KLangChoosen].AU[167],"Shadow");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[167];
addNewBuffKrin("BLACKPAINT",_root.KrinLang[KLangChoosen].AU[117],"Shadow");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[117];
addNewBuffKrin("SUBTRACTIVEPALETTE",_root.KrinLang[KLangChoosen].AU[118],"Magic");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[188] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[118];
addNewBuffKrin("BLIND",_root.KrinLang[KLangChoosen].AU[119],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[77] = -26;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[119];
addNewBuffKrin("DAMAGEDOWN",_root.KrinLang[KLangChoosen].AU[120],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[120];
addNewBuffKrin("DAMAGEDOWN2",_root.KrinLang[KLangChoosen].AU[168],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[168];
addNewBuffKrin("DMGDOWNS","Shadow Mark","Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[11] = -0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "This units damage done is decreased by 20%.";
addNewBuffKrin("BIODMG","Weakness","Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "The Lightning and Poison combined weakened this unit! Damage done decreased by 30%.";
addNewBuffKrin("BIOBREACH","Breached","Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[24] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = "The Shadow and Poison combined opened this units weakspots! Shadow Defense decreased by 30%.";
addNewBuffKrin("SUPERSTUN",_root.KrinLang[KLangChoosen].AU[1],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[1];
addNewBuffKrin("TEMPERACOAT",_root.KrinLang[KLangChoosen].AU[121],"Earth");
_root.hackMove2[16] = 5;
_root.hackMove2[155] = 1;
_root.hackMove2[41] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[121];
addNewBuffKrin("DARKSHIELD","Shield of Darkness","Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[155] = 1;
_root.hackMove2[41] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "You are shieleded for 20% of your maximum HP.";
addNewBuffKrin("LIGHTSHIELD","Shield of Light","Lightning");
_root.hackMove2[16] = 5;
_root.hackMove2[28] = -2;
_root.hackMove2[41] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "You are shieleded for 20% of your maximum HP and you regenerate HP each turn equal to 200% of the caster\'s strength.";
addNewBuffKrin("DARKSHIELD2","Shield of Darkness","Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = "Whenever you deal damage your allies are healed an equal amount.";
addNewBuffKrin("STARRYMUSE",_root.KrinLang[KLangChoosen].AU[122],"Magic");
_root.hackMove2[16] = 6;
_root.hackMove2[11] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[122];
addNewBuffKrin("STARSTRUCK",_root.KrinLang[KLangChoosen].AU[123],"Magic");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[123];
addNewBuffKrin("STARRYMUSE2",_root.KrinLang[KLangChoosen].AU[124],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[3] = 0.75;
_root.hackMove2[7] = 0.75;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[124];
addNewBuffKrin("LUCIDDREAMING",_root.KrinLang[KLangChoosen].AU[125],"Magic");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = -6;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[125];
addNewBuffKrin("GOAD",_root.KrinLang[KLangChoosen].AU[194],"Poison");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[194];
addNewBuffKrin("HONEYBEEPOWER",_root.KrinLang[KLangChoosen].AU[160],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[11] = 0.1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[160];
addNewBuffKrin("DAMAGEUP",_root.KrinLang[KLangChoosen].AU[224],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[11] = 0.05;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[224];
addNewBuffKrin("DAMAGEUPL","Holyness","Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[11] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "Gligus damage is increased by 20% and damage taken is decreased by 20%.";
addNewBuffKrin("VERAFOCUS",_root.KrinLang[KLangChoosen].AU[125],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -30;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[125];
addNewBuffKrin("STONEFOCUS",_root.KrinLang[KLangChoosen].AU[125],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -20;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[125];
addNewBuffKrin("STONEFOCUS2",_root.KrinLang[KLangChoosen].AU[125],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[125];
addNewBuffKrin("STONEFOCUS3",_root.KrinLang[KLangChoosen].AU[185],"Magic");
_root.hackMove2[16] = 1;
_root.hackMove2[28] = 999999999;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[185];
addNewBuffKrin("ADDLE",_root.KrinLang[KLangChoosen].AU[126],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[126];
addNewBuffKrin("EMBOLDEN",_root.KrinLang[KLangChoosen].AU[128],"Physical");
_root.hackMove2[16] = 7;
_root.hackMove2[11] = 0.35;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[128];
addNewBuffKrin("FIGHTORFLIGHT",_root.KrinLang[KLangChoosen].AU[146],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[11] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[146];
addNewBuffKrin("MANAFICATION",_root.KrinLang[KLangChoosen].AU[129],"Shadow");
_root.hackMove2[16] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[11] = 0.2;
_root.hackMove2[153] = 6;
_root.hackMove2[159] = "MANAFICATION3";
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[129];
addNewBuffKrin("MANAFICATION3",_root.KrinLang[KLangChoosen].AU[130],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[130];
addNewBuffKrin("ONETWOPAW",_root.KrinLang[KLangChoosen].AU[140],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[140];
addNewBuffKrin("NINELIVES",_root.KrinLang[KLangChoosen].AU[141],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[141];
addNewBuffKrin("NINELIVES2",_root.KrinLang[KLangChoosen].AU[142],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[142];
addNewBuffKrin("NINELIVES3",_root.KrinLang[KLangChoosen].AU[142],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[142];
addNewBuffKrin("LONETWOPAW",_root.KrinLang[KLangChoosen].AU[143],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[143];
addNewBuffKrin("VERFIRE",_root.KrinLang[KLangChoosen].AU[133],"Fire");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[133];
addNewBuffKrin("VERFIRE2",_root.KrinLang[KLangChoosen].AU[136],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 1.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[136];
addNewBuffKrin("VERFIRE4",_root.KrinLang[KLangChoosen].AU[184],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.9;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[184];
addNewBuffKrin("VERFIRE3",_root.KrinLang[KLangChoosen].AU[135],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[3] = -0.3;
_root.hackMove2[7] = -0.3;
_root.hackMove2[5] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[135];
addNewBuffKrin("VERSTONE",_root.KrinLang[KLangChoosen].AU[134],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[134];
addNewBuffKrin("VERSTONE2",_root.KrinLang[KLangChoosen].AU[137],"Earth");
_root.hackMove2[16] = 4;
_root.hackMove2[38] = 3.8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[137];
addNewBuffKrin("VERSTONE3",_root.KrinLang[KLangChoosen].AU[138],"Earth");
_root.hackMove2[16] = 4;
_root.hackMove2[11] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[138];
addNewBuffKrin("VERSTONE4",_root.KrinLang[KLangChoosen].AU[185],"Earth");
_root.hackMove2[16] = 4;
_root.hackMove2[11] = -0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[185];
addNewBuffKrin("ACCELERATION",_root.KrinLang[KLangChoosen].AU[131],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[158] = -4;
_root.hackMove2[160] = 0.5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[131];
addNewBuffKrin("ACCELERATION2",_root.KrinLang[KLangChoosen].AU[132],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[161] = "Grand Impact";
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[132];
addNewBuffKrin("WATERREADY",_root.KrinLang[KLangChoosen].AU[170],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[170];
addNewBuffKrin("THUNDERREADY",_root.KrinLang[KLangChoosen].AU[180],"Lightning");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[180];
addNewBuffKrin("METEORREADY",_root.KrinLang[KLangChoosen].AU[182],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[182];
addNewBuffKrin("TORNADO",_root.KrinLang[KLangChoosen].AU[171],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[171];
addNewBuffKrin("CUREII",_root.KrinLang[KLangChoosen].AU[172],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[172];
addNewBuffKrin("TORNADO2",_root.KrinLang[KLangChoosen].AU[173],"Poison");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = 1.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[173];
addNewBuffKrin("AEROII",_root.KrinLang[KLangChoosen].AU[174],"Poison");
_root.hackMove2[16] = 12;
_root.hackMove2[29] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[174];
addNewBuffKrin("DROWN",_root.KrinLang[KLangChoosen].AU[175],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = 0.25;
_root.hackMove2[144] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[175];
addNewBuffKrin("DROWN2",_root.KrinLang[KLangChoosen].AU[176],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[29] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[176];
addNewBuffKrin("FROZEN",_root.KrinLang[KLangChoosen].AU[181],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[13] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[181];
addNewBuffKrin("FROZENALMOST",_root.KrinLang[KLangChoosen].AU[179],"Ice");
_root.hackMove2[16] = 1;
_root.hackMove2[174] = "Melee";
_root.hackMove2[175] = "Melee";
_root.hackMove2[176] = "FROZEN";
_root.hackMove2[20] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[179];
addNewBuffKrin("LIVINGDEAD11",_root.KrinLang[KLangChoosen].AU[178],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[178];
addNewBuffKrin("LIVINGDEAD12",_root.KrinLang[KLangChoosen].AU[178],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[164] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX1[178];
addMoveForPlayer = function(txvd)
{
   if(menuMode)
   {
      if(UITmouseHold == 0)
      {
         Krin.moveMatrix[txvd] = 0;
      }
      else
      {
         tracer = 0;
         o = 0;
         while(o < 8)
         {
            if(Krin.moveMatrix[o] == UITmouseHold)
            {
               tracer++;
            }
            o++;
         }
         if(tracer < _root["KRINABILITY" + UITmouseHold][8])
         {
            Krin.moveMatrix[txvd] = UITmouseHold;
         }
         else
         {
            KrinCombatText.combatTexter = _root.KrinLang[KLangChoosen].SKILLERROR;
            KrinCombatText.play();
         }
         UITmouseHold = 0;
      }
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
      KRINMENU.KrinCreateAbilityMatrix();
   }
   else
   {
      checkPassforKrinMove = true;
      rovnrevbnr = _root["playerKrin" + Krin.playerNumber];
      mAry5 = _root["KRINABILITY" + _root.Krin.moveMatrix[txvd]];
      mAry6 = _root["KRINABILITYB" + _root.Krin.moveMatrix[txvd]];
      FIRECHECK = false;
      BLIZZARDCHECK = false;
      BLIZZARDCHECK2 = false;
      FIRE = mAry5[5];
      f = 0;
      while(f < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][50] == 3 && mAry6[0] == "Ice" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][50] == 1 && mAry6[0] == "Fire" && mAry5[0] != "Flare" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][55] == -20 && mAry5[0] == "Fire III" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] -= 20;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][51] == 1 && mAry6[0] == "Ice" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][52] > 0 && mAry6[0] == "Fire" % BLIZZARDCHECK == false && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            if(mAry5[0] != "Flare")
            {
               mAry5[5] *= 0.5;
            }
            if(mAry5[0] == "Flare")
            {
               mAry5[5] = rovnrevbnr.FOCUSN * 0.66;
            }
            BLIZZARDCHECK = true;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][51] == 1 && mAry6[0] == "Fire" && FIRECHECK == false && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 2;
            if(mAry5[0] == "Flare")
            {
               mAry5[5] = rovnrevbnr.FOCUSN;
            }
            FIRECHECK = true;
         }
         f++;
      }
      if(rovnrevbnr.FOCUSN < mAry5[5] && mAry5[0] != "Flare" && mAry5[0] != "Fire IV")
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Focus.";
      }
      if(mAry5[0] == "Subtractivepalette")
      {
         if(rovnrevbnr.PALETTEGAUGE >= mAry6[104] * -1)
         {
            checkPassforKrinMove = true;
         }
         else if(rovnrevbnr.PALETTEGAUGE < mAry6[104] * -1)
         {
            checkPassforKrinMove = false;
         }
         KrinCombatText.combatTexter = "You cannot use this move because you don\'t have filled your Palette Gauge enough.";
      }
      if(mAry5[0] == "Fire IV" || mAry5[0] == "Flare")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.FOCUSN < mAry5[5] || rovnrevbnr.BUFFARRAYK[f].buffId == "FIREI" && rovnrevbnr.BUFFARRAYK[f].CD != 0 || rovnrevbnr.BUFFARRAYK[f].buffId == "BLIZZARDI" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Focus or because you dont have Astral Fire on.";
            f++;
         }
      }
      if(mAry5[0] == "Atonement")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "ATONEMENT" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[10] == "Melee")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "HOLYCHAIN" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you are chained.";
               break;
            }
            f++;
         }
      }
      if(mAry5[0] == "Fireinred")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Aero in Green")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Fireinred2")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Aero II in Green")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Water II in Blue")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Water in BLue")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Starprism")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "STARSTRUCK" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you dont have Starstruck.";
            f++;
         }
      }
      if(mAry5[0] == "Trick Attack" || mAry5[0] == "Kunai\'s Bane")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "STEALTH" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you dont have Starstruck.";
            f++;
         }
      }
      if(mAry5[0] == "Fireinred2")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have subtractive pallete active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Tenchijin")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "KASSATSU" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you have kassatsu active.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Ten")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "TEN" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you already used Ten.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Chi")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "CHI" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you already used Chi.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Jin")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "JIN" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = false;
               KrinCombatText.combatTexter = "You cannot use this move because you already used Jin.";
               break;
            }
            checkPassforKrinMove = true;
            f++;
         }
      }
      if(mAry5[0] == "Blizzardincyan")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Prefulgence")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "MANAFICATION3" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Stoneinyellow")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Thunderinmagenta")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry6[108] == "VERFIRE" || mAry6[108] == "VERSTONE")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "VERFIRE" && rovnrevbnr.BUFFARRAYK[f].CD != 0 || rovnrevbnr.BUFFARRAYK[f].buffId == "VERSTONE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Blizzardincyan2")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Stoneinyellow2")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Thunderinmagenta2")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "SUBTRACTIVEPALETTE" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry5[0] == "Holyinwhite")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "WHITEPAINT" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you have no white paint.";
            f++;
         }
      }
      if(mAry5[0] == "Foul")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "POLYGOT" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you have no polygot.";
            f++;
         }
      }
      if(mAry5[0] == "Cometinblack")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "BLACKPAINT" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you have no black paint.";
            f++;
         }
      }
      if(mAry5[0] == "Misui")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "DUDRA4" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you are not ready to use it.";
            f++;
         }
      }
      if(mAry6[140] == "Ninjutsu")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.BUFFARRAYK[f].buffId == "DUDRA" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you dont have any dudras.";
            f++;
         }
      }
      if(mAry5[0] == "Blizzard IV" || mAry5[0] == "Freeze")
      {
         f = 0;
         while(f < _root.maxBuffLimit)
         {
            if(rovnrevbnr.FOCUSN < mAry5[5] || rovnrevbnr.BUFFARRAYK[f].buffId == "BLIZZARDI" && rovnrevbnr.BUFFARRAYK[f].CD != 0 || rovnrevbnr.BUFFARRAYK[f].buffId == "FIREI" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
            {
               checkPassforKrinMove = true;
               break;
            }
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Focus or because you dont have Umbral Ice on.";
            f++;
         }
      }
      if(rovnrevbnr.FOCUSN == 0 && mAry5[0] == "Flare")
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Focus.";
      }
      if(Krin.abilityCoolDown[txvd] > 0)
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "This move is not ready yet.";
      }
      if(Krin.abilityCoolDown[txvd] + rovnrevbnr.TURN < 0)
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "This move is not ready yet.";
      }
      if(rovnrevbnr.LIFEN <= mAry5[6] + Math.round(rovnrevbnr.LIFEU * mAry5[16]))
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Health.";
      }
      if(rovnrevbnr.TENCHIJIN > 0 && mAry6[141] == 0)
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "You cannot use this move because you are currently in Ten Chi Jin Mode.";
      }
      if(mAry5[_root.theEnemyToMoveVS2] == 0)
      {
         checkPassforKrinMove = false;
         KrinCombatText.combatTexter = "You cannot use this move on that target.";
      }
      f = 0;
      while(f < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][50] == 3 && mAry6[0] == "Ice" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][50] == 1 && mAry6[0] == "Fire" && mAry5[0] != "Flare" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][55] == 1 && mAry5[0] == "Fire III" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][51] == 1 && mAry6[0] == "Ice" && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 0;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][52] > 0 && mAry6[0] == "Fire" % BLIZZARDCHECK == false && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            if(mAry5[0] != "Flare")
            {
               mAry5[5] *= 0.5;
            }
            if(mAry5[0] == "Flare")
            {
               mAry5[5] = rovnrevbnr.FOCUSN * 0.66;
            }
            BLIZZARDCHECK = true;
         }
         if(_root["KRINBUFF" + rovnrevbnr.BUFFARRAYK[f].buffId][51] == 1 && mAry6[0] == "Fire" && FIRECHECK == false && rovnrevbnr.BUFFARRAYK[f].CD != 0)
         {
            mAry5[5] *= 2;
            if(mAry5[0] == "Flare")
            {
               mAry5[5] = rovnrevbnr.FOCUSN;
            }
            FIRECHECK = true;
         }
         f++;
      }
      if(mAry6[113] < 0 && mAry6[114] < 0)
      {
         if(mAry6[113] * -1 >= rovnrevbnr.BMANA || mAry6[114] * -1 >= rovnrevbnr.WMANA)
         {
            checkPassforKrinMove = false;
            KrinCombatText.combatTexter = "You cannot use this move because you don\'t have enough Black and White Mana.";
         }
      }
      mAry5[5] = FIRE;
      if(checkPassforKrinMove)
      {
         if(mAry5[14] == "Heal" || mAry5[10] == "DispelF")
         {
            _root.healedThisTurn[_root.theEnemyToMoveVS] += mAry6[10] * ((rovnrevbnr.STRENGTHU + mAry6[1]) * mAry6[2] + (rovnrevbnr.MAGICU + mAry6[3]) * mAry6[4] + (rovnrevbnr.SPEEDU + mAry6[5]) * mAry6[6] + rovnrevbnr.FOCUSN * mAry6[11] + mAry6[9]);
         }
         _root.moveCoolDownBreaker = txvd;
         if(Krin.singlePlayer)
         {
            _root.krinAddMove(Krin.playerNumber,_root.theEnemyToMoveVS,_root.Krin.moveMatrix[txvd]);
            if(_root.turnBasedKrin)
            {
               _root.moveChoosen = true;
            }
         }
         else
         {
            SERNINA = Krin.playerNumber;
            SERNINB = _root.theEnemyToMoveVS;
            SERNINC = _root.Krin.moveMatrix[txvd];
         }
         _root.selector._visible = false;
         _root.krinToMove._visible = true;
         _root.krinToMove2._visible = true;
         _root.krinToMove.gotoAndStop(mAry5[0]);
         _root.krinToMove.toolTipTitle = mAry5[0];
         _root.krinToMove.toolTip = "You will use this ability on " + _root["playerKrin" + _root.theEnemyToMoveVS].playerName + ". Click to cancel this ability.";
         _root.moveToMakeGGTT = _root.Krin.moveMatrix[txvd];
         for(u in _root.elementMainArray)
         {
            if(_root.elementMainArray[u] == _root["KRINABILITYB" + _root.Krin.moveMatrix[txvd]][0])
            {
               KNcolor3 = _root.elementColorArray[u];
               _root.krinToMove.KNcolor2 = KNcolor3;
            }
         }
         var _loc3_ = new Color(_root.krinToMove.moveColor);
         _loc3_.setRGB(KNcolor3);
         moveSelectBoomer.play();
      }
      else
      {
         KrinCombatText.gotoAndPlay("GO");
      }
   }
};
createUnitKrinCount = 0;
createNewUnitKrin = function(a, b, c, d, e, f, g, h, i, j)
{
   createUnitKrinCount++;
   _root["KNU" + createUnitKrinCount] = new Array();
   _root["KNU" + createUnitKrinCount].movesA = new Array();
   _root["KNU" + createUnitKrinCount].movesD = new Array();
   _root["KNU" + createUnitKrinCount].movesABS = new Array();
   _root["KNU" + createUnitKrinCount].agressionArray = new Array();
   _root["KNU" + createUnitKrinCount].PER = new Array();
   _root["KNU" + createUnitKrinCount].DEF = new Array();
   _root["KNU" + createUnitKrinCount][0] = a;
   _root["KNU" + createUnitKrinCount][1] = b;
   _root["KNU" + createUnitKrinCount][2] = c;
   _root["KNU" + createUnitKrinCount][3] = d;
   _root["KNU" + createUnitKrinCount][4] = e;
   _root["KNU" + createUnitKrinCount][5] = f;
   _root["KNU" + createUnitKrinCount][6] = g;
   _root["KNU" + createUnitKrinCount][7] = h;
   _root["KNU" + createUnitKrinCount][8] = i;
   _root["KNU" + createUnitKrinCount][9] = j;
   jesivie = _root["KNU" + createUnitKrinCount];
   _root["KNU" + createUnitKrinCount].model = new Array();
   _root["KNU" + createUnitKrinCount].equipment = new Array();
   _root["KNU" + createUnitKrinCount].model = ["MODEL1","ONE","ONE","M"];
   _root["KNU" + createUnitKrinCount].equipment = [0,0,0,0,0,0,0];
   _root["KNU" + createUnitKrinCount].skinSetter = 0;
   _root["KNU" + createUnitKrinCount].IGNORE = 0;
   _root["KNU" + createUnitKrinCount].IGNORETURN = false;
   _root["KNU" + createUnitKrinCount].stunresist = 0;
   _root["KNU" + createUnitKrinCount].slowresist = 0;
   _root["KNU" + createUnitKrinCount].voiceHit = new Array();
};
createNewUnitKrin("Dreadnaught",45,2.5,15,1.5,0,0,10,1.2,100);
jesivie.movesA = [2200,2201,2202,2203,2204];
jesivie.movesD = [2205];
jesivie.agressionArray = [50,90,60,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Templar",23,4.200000000000002,12,1.2,8,0.8,8,1,100);
jesivie.movesA = [1733,1212,1222];
jesivie.movesD = [31,1218,1220];
jesivie.agressionArray = [50,90,60,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Phantom",30,4,14,1.4000000000000001,0,0,16,1.6,100);
jesivie.movesA = [1243,1248,1728,1271,1222];
jesivie.movesD = [1240,1267];
jesivie.agressionArray = [50,90,60,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Phaser",20,1.6,10,1.1,20,1.6,10,1.1,100);
jesivie.movesA = [1731,1732,1508,1511,1519,1846];
jesivie.movesD = [1522,31,1527];
jesivie.agressionArray = [50,90,60,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Templar",20,1.45,14,2.2,8,1.0500000000000005,8,1.0500000000000005,100);
jesivie.movesA = [1627,523,1628];
jesivie.movesD = [512,511,1274,1275];
jesivie.agressionArray = [30,90,75,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.voiceHit = ["DuxHit1","DuxHit2","DuxHit3"];
jesivie.voiceDie = "DuxDie";
createNewUnitKrin("Metabii",5,1,6,1.4000000000000001,6,1.4000000000000001,6,1.3000000000000005,100);
jesivie.movesA = [500];
jesivie.movesD = [501];
jesivie.agressionArray = [100,101,101,100];
jesivie.model = ["MODEL1","METABII","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,12,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Louis the Blind",0.1,1,8,0.5,8,0.5,0,10,100);
jesivie.movesA = [0];
jesivie.movesD = [0];
jesivie.agressionArray = [50,90,60,40];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.model = ["MODEL1","MAN","BART","M"];
jesivie.equipment = [0,11,0,4,8,0,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "LouisDie";
createNewUnitKrin("Zombie",6,1.7,9,1.7,6,1.7,3,1,100);
jesivie.movesA = [500,502];
jesivie.movesD = [0];
jesivie.agressionArray = [100,100,99,100];
jesivie.model = ["MODEL1","ZOMBIE","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,12,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("ZPCI Assault",7,1,2,1,2,1,7,1,100);
jesivie.movesA = [500,503,1313];
jesivie.movesD = [0];
jesivie.agressionArray = [50,85,60,100];
jesivie.model = ["MODEL1","USA1","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA1";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("ZPCI Medic",7,1,1,1,1,1,7,1,150);
jesivie.movesA = [503,1313];
jesivie.movesD = [504];
jesivie.agressionArray = [50,90,80,100];
jesivie.model = ["MODEL1","USA1","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA1";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("ZPCI Captain",9,1,1,1,1,1,7,1,100);
jesivie.movesA = [500,503,505,1313];
jesivie.movesD = [];
jesivie.agressionArray = [50,85,60,100];
jesivie.model = ["MODEL1","USA3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,14,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Ghost Samurai",30,2,12,2,12,2,8,1.5,130);
jesivie.movesA = [500,506,524,573];
jesivie.movesD = [504];
jesivie.agressionArray = [50,50,30,25];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,30,0];
jesivie.skinSetter = "SAMURAI";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Ghost Assassin",5,4,12,3,12,3,20,6,60);
jesivie.movesA = [500,502,1242];
jesivie.movesD = [507];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "NINJA";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Frost Zombie",15,0.9000000000000002,15,0.9000000000000002,15,0.9000000000000002,15,0.9000000000000002,100);
jesivie.movesA = [500,502,506,522,572,1314];
jesivie.movesD = [70];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","ZOMBIE","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,12,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Sensei Ishiguro",200,4,35,4.5,35,4.5,15,2,350);
jesivie.movesA = [506,524,524,522,524,524,501,522,500,573];
jesivie.movesD = [504];
jesivie.agressionArray = [50,95,75,25];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,32,0];
jesivie.skinSetter = "SAMURAI2";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("ZPCI Hunter",15,1.8000000000000005,15,1.8000000000000005,15,1.8000000000000005,15,1.8000000000000005,120);
jesivie.movesA = [500,503,505];
jesivie.movesD = [504];
jesivie.agressionArray = [50,85,60,100];
jesivie.model = ["MODEL1","USA3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA4";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("GSG9 Assault",9,1.5,9,1.5,9,1.5,9,1.5,80);
jesivie.movesA = [500,503];
jesivie.movesD = [];
jesivie.agressionArray = [50,85,60,25];
jesivie.model = ["MODEL1","USA3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "GER";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Shaman of Death",25,7,4,2,19,13,13,5,190);
jesivie.movesA = [96,73,529,565,565,1320];
jesivie.movesD = [31];
jesivie.agressionArray = [70,60,30,75];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,74,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Shaman of Life",24,9,9,5,17,8,19,5,250);
jesivie.movesA = [508,513,500,566,1321];
jesivie.movesD = [504,514,515];
jesivie.agressionArray = [30,85,75,50];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,72,0];
jesivie.skinSetter = "SHAMAN2";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Shaman of Blades",45,10,22,14,9,5,13,6,190);
jesivie.movesA = [500,2,6,20,566];
jesivie.movesD = [533];
jesivie.agressionArray = [50,75,40,65];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,70,70];
jesivie.skinSetter = "SHAMAN1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Rock Golem",42,9,17,12,10,10,10,3,100);
jesivie.movesA = [62,9,7,2,500,501,516,566];
jesivie.movesD = [];
jesivie.agressionArray = [50,80,60,25];
jesivie.model = ["MODEL1","MAN3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
createNewUnitKrin("Totem",10,3,10,4,10,4,10,4,300);
jesivie.movesA = [81,71];
jesivie.movesD = [31];
jesivie.agressionArray = [50,95,75,25];
jesivie.model = ["MODEL2","","",""];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,0,0];
createNewUnitKrin("Rockstar",70,10,30,15,0,0,10,4,250);
jesivie.movesA = [62,9,7,2,500,501,38,516];
jesivie.movesD = [70,14];
jesivie.agressionArray = [50,30,25,25];
jesivie.model = ["MODEL1","MAN3","","M"];
jesivie.PER = [75,25,25,25,25,75,25,25];
jesivie.DEF = [70,70,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
jesivie.skinSetter = "ROCKSTAR";
createNewUnitKrin("Devourer",20,8,15,6,0,0,10,3,100);
jesivie.movesA = [500,502];
jesivie.movesD = [];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","ZOMBIE1","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("ZPCI Elite",75,8,13,6,13,6,13,6,100);
jesivie.movesA = [500,503,505,1319];
jesivie.movesD = [504];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Baron Brixius",4500,12,32,8,32,8,18,8,380);
jesivie.movesA = [517,518,3,3,3];
jesivie.movesD = [507];
jesivie.agressionArray = [50,50,30,65];
jesivie.model = ["MODEL1","ZOMBIE2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,77,0];
jesivie.voiceHit = ["BaronHit1","BaronHit2","BaronHit3"];
jesivie.voiceDie = "BaronDie";
createNewUnitKrin("Galiant the Paladin",60,4,25,4,25,4,20,7,250);
jesivie.movesA = [500];
jesivie.movesD = [511,504,521];
jesivie.agressionArray = [50,75,30,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [9000,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA5";
jesivie.voiceHit = ["GaliantHit1","GaliantHit2","GaliantHit3"];
jesivie.voiceDie = "GaliantDie";
createNewUnitKrin("Elite Medic",80,8,8,10,10,10,10,5,150);
jesivie.movesA = [574,502,503];
jesivie.movesD = [504,504,504,515,561,576];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "MEDIC";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("ZPCI Sniper",35,10,10,10,10,10,10,5,100);
jesivie.movesA = [505,501,560,562,574,575];
jesivie.movesD = [];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA4";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Shaman Controller",20,10,15,8,15,8,12,4,150);
jesivie.movesA = [500,73];
jesivie.movesD = [504,514,515];
jesivie.agressionArray = [50,90,80,15];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,72,0];
jesivie.skinSetter = "SHAMAN1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Shaman Survivor",20,8,15,6,0,0,10,3,100);
jesivie.movesA = [500,2,6,20];
jesivie.movesD = [26,508];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Zombie Ambassador",50,8,15,6,0,0,10,3,150);
jesivie.movesA = [500,502,1323,1275];
jesivie.movesD = [];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","ZOMBIE1","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Vendetta the Breaker",30,8,8,8,15,10,10,6,450);
jesivie.movesA = [96,73,11,508,1320,1322];
jesivie.movesD = [31];
jesivie.agressionArray = [70,60,30,75];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,79,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Argalla the Mender",60,10,10,10,10,10,12,6,250);
jesivie.movesA = [508,513,500];
jesivie.movesD = [504,514,515,1321];
jesivie.agressionArray = [30,85,75,50];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,78,0];
jesivie.skinSetter = "SHAMAN2";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Dokebi the Striker",60,5,5,5,5,5,5,5,200);
jesivie.movesA = [500,2,6,20,565,564,1269];
jesivie.movesD = [28,508];
jesivie.agressionArray = [50,75,40,65];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,76,76];
jesivie.skinSetter = "SHAMAN1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Galiant the Paladin",150,8,15,6,15,6,10,3,4000);
jesivie.movesA = [501,505,81,500,2101,2101,2101,1324];
jesivie.movesD = [520,521];
jesivie.agressionArray = [50,50,40,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA5";
jesivie.voiceHit = ["GaliantHit1","GaliantHit2","GaliantHit3"];
jesivie.voiceDie = "GaliantDie";
createNewUnitKrin("Ignition",1100,0,100,0,230,0,120,0,450);
jesivie.movesA = [500];
jesivie.movesD = [527,526,525];
jesivie.agressionArray = [50,101,101,15];
jesivie.model = ["MODEL1","MAN2","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,0,0];
jesivie.skinSetter = "SHAMAN4";
createNewUnitKrin("Omen",40000,0,200,0,50,0,120,0,500);
jesivie.movesA = [69,68,8,502,9];
jesivie.movesD = [528];
jesivie.agressionArray = [50,101,101,15];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,30,0];
jesivie.skinSetter = "SAMURAI3";
createNewUnitKrin("Doctor Herregods",125000,0,275,0,150,0,70,0,400);
jesivie.movesA = [80,69,104];
jesivie.movesD = [530];
jesivie.agressionArray = [0,99.00001000007614,99,15];
jesivie.model = ["MODEL1","MAN","BART","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,35,36,37,38,7,0];
createNewUnitKrin("Sinjid\'s Shadow",3500,0,180,0,180,0,210,0,100);
jesivie.movesA = [532,69,62,9,12,507];
jesivie.movesD = [531];
jesivie.agressionArray = [50,101,101,15];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,33];
jesivie.skinSetter = "SINJID";
createNewUnitKrin("Illusion",30,4,10,3,10,3,10,1.5,250);
jesivie.movesA = [508,83,80,96,99,69,5,8,62];
jesivie.movesD = [93,31];
jesivie.agressionArray = [50,80,40,15];
jesivie.model = ["MODEL1","GHOST","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,12,0];
createNewUnitKrin("Royal Courier",100,5,20,5,20,5,20,3,100);
jesivie.movesA = [69,503,505];
jesivie.movesD = [504,70];
jesivie.agressionArray = [50,60,40,15];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA2";
createNewUnitKrin("Shadow\'s Shadow",200,4,5,4,5,4,5,4,100);
jesivie.movesA = [69,509];
jesivie.movesD = [515,88];
jesivie.agressionArray = [50,80,50,15];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,33];
jesivie.skinSetter = "SINJID";
createNewUnitKrin("Friend\'s Gate",1000,20,4,4,4,4,4,8,10000);
jesivie.movesA = [539,540,541,542];
jesivie.movesD = [538,543];
jesivie.agressionArray = [50,75,30,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["GaliantHit1","GaliantHit2","GaliantHit3"];
jesivie.voiceDie = "GaliantDie";
createNewUnitKrin("POISON attacker",350,20,8,4,4,4,4,4,100);
jesivie.movesA = [544,545,546,547,548,549];
jesivie.movesD = [550,550];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","ZOMBIE1","","M"];
jesivie.PER = [25,25,25,25,25,25,25,45];
jesivie.DEF = [25,25,25,25,25,25,25,45];
jesivie.equipment = [0,0,0,0,0,81,0];
jesivie.skinSetter = "USA2";
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Poison Zombie",25,8,2,2,2,2,2,5,200);
jesivie.movesA = [544,545,546,547,548,549];
jesivie.movesD = [550,550];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","ZOMBIE","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Human Warden",435,20,55,8,55,8,15,5,300);
jesivie.movesA = [544,544,544,544,544,544,2];
jesivie.movesD = [550,550];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA1";
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Old Prison Guard",25,10,25,2,25,2,15,5,200);
jesivie.movesA = [9,9,9,2,3,4,5,4,4,4,549];
jesivie.movesD = [10,10,10,500];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,405,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA1";
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Old Prison Chief",55,10,20,2,20,2,20,5,200);
jesivie.movesA = [9,4,4,4,4,5,549];
jesivie.movesD = [10,10,10,10,88,88,500];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,400,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA1";
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("Old Prison Chief",1575,40,35,3,35,3,35,5,200);
jesivie.movesA = [9,558,9,9,9,9,9,551,551,551,551,551,551,551,549,551];
jesivie.movesD = [10,10,88,88,552];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,615,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,14,0];
jesivie.skinSetter = "USA4";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("ZPCI Sniper",1,1,1,1,1,1,1,1,1);
jesivie.movesA = [1];
jesivie.movesD = [];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,95];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["ZombieHit1","ZombieHit2","ZombieHit1"];
jesivie.voiceDie = "ZombieDie";
createNewUnitKrin("The Beginning of the End",2000,20,20,20,20,20,20,10,500);
jesivie.movesA = [549,553,554,555];
jesivie.movesD = [556,557];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [125,125,125,125,125,125,125,195];
jesivie.DEF = [125,725,125,125,125,125,125,125];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["BaronHit1","BaronHit2","BaronHit3"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("ZPCI Slow",50,10,10,5,5,5,10,3,200);
jesivie.movesA = [577,578,579,574];
jesivie.movesD = [520];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Daniela\'s Will",2500,5,5,5,5,5,5,5,100);
jesivie.movesA = [580,582,583,584,549];
jesivie.movesD = [585];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [125,35,125,125,125,125,125,125];
jesivie.DEF = [125,725,125,125,125,125,125,125];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "FINAL2";
jesivie.IGNORETURN = true;
jesivie.voiceHit = ["ZPCIHit1","BaronHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Old Alcatraz Prisoner",150,8,15,4,15,4,30,7,100);
jesivie.movesA = [1000,1005,1017,1,1109];
jesivie.movesD = [1009,1013];
jesivie.agressionArray = [50,40,45,30];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "NINJA";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Old Alcatraz Prisoner",250,8,15,4,15,4,15,7,100);
jesivie.movesA = [1100,1104,1116,1124,1108,1112];
jesivie.movesD = [1120];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Old Alcatraz Prisoner",250,8,15,4,15,4,15,7,300);
jesivie.movesA = [1125,1128,1131,1135,1139];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Tireless One",250,8,15,4,15,4,15,7,300);
jesivie.movesA = [1204];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL5","MAN","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Servant",1,8,15,4,15,4,15,7,101);
jesivie.movesA = [500];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["ShamanHit1","ShamanHit2","ShamanHit1"];
jesivie.voiceDie = "ShamanDie";
createNewUnitKrin("Proto Guardian",2200,11,7,11,7,11,7,10,100);
jesivie.movesA = [1282,1277,1278,1279,1280,1281];
jesivie.movesD = [];
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL5","WOLF","","M"];
jesivie.PER = [100,100,100,100,100,100,100,100,100];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.skinSetter = "";
jesivie.equipment = [0,0,0,0,0,0,0];
jesivie.voiceHit = ["hit_monster1","hit_monster2","hit_monster3"];
jesivie.voiceDie = "dead_monster";
createNewUnitKrin("The Oldest One",2500,11,7,11,7,11,7,10,100);
jesivie.movesA = [1283,1284,1285,1286,1287,1288,1289,1290,1291];
jesivie.movesD = [];
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [100,100,100,100,100,100,100,100,100];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.skinSetter = "JASON2";
jesivie.equipment = [0,0,0,0,0,14,14];
jesivie.voiceHit = ["hit_monster1","hit_monster2","hit_monster3"];
jesivie.voiceDie = "dead_monster";
createNewUnitKrin("Dark Knight",2500,11,7,11,7,11,7,10,100);
jesivie.movesA = [500,1292,1293,1294,1295,1296,1297,1298];
jesivie.movesD = [];
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [100,100,100,100,100,100,100,100,100];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.skinSetter = "USA2";
jesivie.equipment = [0,0,0,0,0,14,14];
jesivie.voiceHit = ["GaliantHit1","GaliantHit2","GaliantHit3"];
jesivie.voiceDie = "GaliantDie";
createNewUnitKrin("Ceyda",2500,11,10,11,10,11,7,20,100);
jesivie.movesA = [1299,1300,1301,1302,500];
jesivie.movesD = [];
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL1","FIVE","FIVE","M"];
jesivie.PER = [100,100,100,100,100,100,100,100,100];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Daniela\'s Will",3500,10,10,10,10,10,10,10,100);
jesivie.movesA = [1204,1303,1304,1305,1306,1307,1312,1311,2000,2001,2002,2003,2004,2008,2009,2011,2010,2012,2013,2014,2015,2016,2017,2018,2023,2020,2021,2022,2024];
jesivie.movesD = [];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [85,85,85,85,85,85,85,85];
jesivie.IGNORETURN = true;
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "FINAL2";
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Danielas Creation",200,7,10,7,10,7,10,7,101);
jesivie.movesA = [1308,1310,2005,2007,2019];
jesivie.movesD = [];
jesivie.IGNORE = 1;
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL1","FIVE","FIVE","M"];
jesivie.PER = [65,65,65,65,65,65,65,65];
jesivie.IGNORETURN = true;
jesivie.DEF = [65,65,65,65,65,65,65,65];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Danielas Creation",200,7,10,7,10,7,10,7,101);
jesivie.movesA = [1309,1310,2006,2007,2019];
jesivie.movesD = [];
jesivie.IGNORE = 1;
jesivie.agressionArray = [50,10,1,75,15];
jesivie.IGNORETURN = true;
jesivie.model = ["MODEL1","FIVE","FIVE","M"];
jesivie.PER = [65,65,65,65,65,65,65,65];
jesivie.DEF = [65,65,65,65,65,65,65,65];
jesivie.equipment = [0,0,0,0,0,80,0];
jesivie.skinSetter = "SHAMAN3";
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Ghost Magician",20,2,12,2,12,2,8,1.5,50);
jesivie.movesA = [1315,1316];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,30,25];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,74,0];
jesivie.skinSetter = "SAMURAI";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("ZPCI Special Hunter",110,3,30,2,30,2,15,1.8000000000000005,120);
jesivie.movesA = [500,503,505,1317,1318,1319];
jesivie.movesD = [504];
jesivie.agressionArray = [50,85,60,100];
jesivie.model = ["MODEL1","USA3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA4";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Ghost Ninja",110,4,12,3,12,3,20,6,100);
jesivie.movesA = [1243,1245,1253,1254];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,45,30];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [75,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,33,0];
jesivie.skinSetter = "NINJA";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Rock Golem",100,9,17,12,10,10,10,3,1000);
jesivie.movesA = [62,9,7,2,500,501,1217,1218];
jesivie.movesD = [];
jesivie.agressionArray = [50,80,60,25];
jesivie.model = ["MODEL1","MAN3","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,81,0];
createNewUnitKrin("ZPCI Elite",100,8,13,6,13,6,13,6,100);
jesivie.movesA = [1227,1224,1231,503,505,1319];
jesivie.movesD = [504];
jesivie.agressionArray = [50,80,60,65];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,13,0];
jesivie.skinSetter = "USA3";
jesivie.voiceHit = ["ZPCIHit1","ZPCIHit2","ZPCIHit1"];
jesivie.voiceDie = "Die1";
createNewUnitKrin("Galiants Watchdog",100,11,7,11,7,11,7,10,100);
jesivie.movesA = [1325];
jesivie.movesD = [];
jesivie.agressionArray = [50,10,1,75,15];
jesivie.model = ["MODEL5","WOLF","","M"];
jesivie.PER = [100,100,100,100,100,100,100,100,100];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.skinSetter = "";
jesivie.equipment = [0,0,0,0,0,0,0];
jesivie.voiceHit = ["hit_monster1","hit_monster2","hit_monster3"];
jesivie.voiceDie = "dead_monster";
createNewUnitKrin("Ghost Magician",700,12,12,12,12,12,18,11.5,500);
jesivie.movesA = [1326,1327];
jesivie.movesD = [];
jesivie.agressionArray = [50,50,30,25];
jesivie.model = ["MODEL1","","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [25,25,25,25,25,25,25,25];
jesivie.equipment = [0,0,0,0,0,74,0];
jesivie.skinSetter = "SAMURAI";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Black Cat",3500,10,10,10,10,10,10,10,100);
jesivie.movesA = [1700,1701,1702,1703,1704,1705,1706,1707,1708,1709,1712,1713,1714,1715,1716,1717,1718,1719,1722,1723,1724];
jesivie.movesD = [];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [85,85,85,85,85,85,85,85];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,0,0];
jesivie.skinSetter = "FINAL3";
jesivie.stunresist = 1;
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Copy Cat",9500,10,10,10,10,10,10,10,199);
jesivie.movesA = [1710,1711,1720,1721];
jesivie.movesD = [];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [85,85,85,85,85,85,85,85];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,0,0];
jesivie.skinSetter = "FINAL3";
jesivie.stunresist = 1;
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
jesivie.IGNORE = 1;
createNewUnitKrin("Honey B. Lovely",4300,10.1,10.1,10.1,10.1,10.1,10.1,10.1,100);
jesivie.movesA = [1800,1801,1802,1803,1804,1805,1806,1807,1808,1809,1810,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,1822,1823,1824,1825,1826];
jesivie.movesD = [];
jesivie.agressionArray = [50,35,25,25];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [85,85,85,25,25,25,25,25];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,77,0];
jesivie.skinSetter = "FINAL2";
jesivie.stunresist = 1;
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Channeler",2200,10.1,10.1,10.1,12,12,10.1,10.1,100);
jesivie.movesA = [1831,1832,1833,1834];
jesivie.movesD = [1829,1830];
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [65,65,65,65,65,65,65,65];
jesivie.equipment = [0,0,0,0,0,84,86];
jesivie.skinSetter = "FINAL4";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Terminator",3000,10.1,10,10,10.1,10.1,10.1,10.1,100);
jesivie.movesA = [1836,1837,1838,1839];
jesivie.movesD = [1835];
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [65,65,65,65,65,65,65,65];
jesivie.equipment = [0,0,0,0,0,82,0];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Dark Channeler",1500,10.1,10.1,10.1,12,12,10.1,10.1,100);
jesivie.movesA = [1841,1842,1843,1844,1845];
jesivie.movesD = [1840];
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,84,87];
jesivie.skinSetter = "FINAL4";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Wicked Thunder",5500,10.1,10.1,10.1,10.1,10.1,10.1,10.2,100);
jesivie.movesA = [1900,1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1918,1916,1917,1923,1924,1925,1926];
jesivie.movesD = [];
jesivie.stunresist = 1;
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,87,87];
jesivie.skinSetter = "USA5";
jesivie.voiceHit = ["hit_fel1","hit_fel2","hit_fel3"];
jesivie.voiceDie = "dead_fel";
createNewUnitKrin("Wicked Thunders adds",99900,10.1,10.1,10.1,10.1,10.1,10.1,10.1,199);
jesivie.movesA = [1914,1915,1919,1921];
jesivie.movesD = [];
jesivie.IGNORE = 2;
jesivie.stunresist = 1;
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,87,87];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
createNewUnitKrin("Wicked Thunders adds",99900,10.1,10.1,10.1,10.1,10.1,10.1,10.1,100);
jesivie.movesA = [1914,1915,1920,1922];
jesivie.movesD = [];
jesivie.IGNORE = 2;
jesivie.stunresist = 1;
jesivie.agressionArray = [90,95,0,0];
jesivie.model = ["MODEL1","MAN","","M"];
jesivie.PER = [25,25,25,25,25,25,25,25];
jesivie.DEF = [100,100,100,100,100,100,100,100,100];
jesivie.equipment = [0,0,0,0,0,87,87];
jesivie.skinSetter = "FINAL1";
jesivie.voiceHit = ["GhostHit1","GhostHit2","GhostHit3"];
jesivie.voiceDie = "GhostDie";
battleCreationID = 0;
createNewBattle = function()
{
   battleCreationID++;
   _root["KBR" + battleCreationID] = new Object();
   rengi = _root["KBR" + battleCreationID];
   rengi.players = new Array();
   rengi.players = [0,1,0,2,0];
   rengi.playersLevels = [1,1,1,1,1];
   rengi.phases = new Array();
   rengi.speeches = new Array();
   rengi.itemDrops = new Array();
   rengi.itemRare = new Array();
   rengi.itemRareDropper = 0;
   rengi.winDate = -1;
   rengi.timeLock = false;
   rengi.winDateCondition = 0;
   rengi.absoluteStart = 0;
};
createNewBattle();
rengi.players = [6,-1,0,-2,0];
rengi.playersLevels = [5,2,3,4,5];
rengi.itemDrops.push({ID:2,CHANCE:40});
rengi.itemRare.push(2);
rengi.itemRare.push(1);
rengi.itemRareDropper = 1;
rengi.speeches.push({player:5,turnTime:5,turnTime2:0,say:"agrgra",timeToSay:5,voiceOver:"v_1"});
rengi.speeches.sortOn([turnTime,turnTime2],Array.NUMERIC);
sayBayK = _root.KrinLang[KLangChoosen].BATTLESPEECH;
createNewBattle();
rengi.players = [6,0,0,7,0];
rengi.playersLevels = [1,0,0,99,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[0],timeToSay:4.5,voiceOver:"v_1"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[1],timeToSay:5});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[2],timeToSay:3.7});
rengi.speeches.push({player:0,turnTime:0,turnTime2:3,say:sayBayK[3],timeToSay:6.5});
rengi.speeches.push({player:0,turnTime:0,turnTime2:4,say:sayBayK[4],timeToSay:5.5});
rengi.speeches.push({player:1,turnTime:2,turnTime2:0,say:sayBayK[5],timeToSay:1.5,voiceOver:"v_2"});
rengi.speeches.push({player:5,turnTime:2,turnTime2:1,say:sayBayK[6],timeToSay:3.5});
rengi.speeches.push({player:0,turnTime:2,turnTime2:2,say:sayBayK[7],timeToSay:5});
rengi.speeches.push({player:0,turnTime:2,turnTime2:3,say:sayBayK[8],timeToSay:5});
rengi.speeches.push({player:5,turnTime:4,turnTime2:0,say:sayBayK[9],timeToSay:5,voiceOver:"v_3"});
rengi.speeches.sortOn([turnTime,turnTime2],Array.NUMERIC);
rengi.absoluteStart = 1;
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [6,0,0,7,0];
rengi.playersLevels = [2,0,0,99,0];
rengi.speeches.push({player:1,turnTime:1,turnTime2:0,say:sayBayK[10],timeToSay:6,voiceOver:"v_4"});
rengi.speeches.push({player:5,turnTime:1,turnTime2:1,say:sayBayK[11],timeToSay:3});
rengi.speeches.push({player:1,turnTime:1,turnTime2:2,say:sayBayK[12],timeToSay:1.5});
rengi.speeches.push({player:5,turnTime:1,turnTime2:3,say:sayBayK[13],timeToSay:4.5});
rengi.speeches.sortOn([turnTime,turnTime2],Array.NUMERIC);
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [6,0,6,7,0];
rengi.playersLevels = [2,0,1,99,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[14],timeToSay:3,voiceOver:"v_5"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[15],timeToSay:1});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[16],timeToSay:6});
rengi.itemDrops.push({ID:9,CHANCE:100});
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [0,0,8,7,6];
rengi.playersLevels = [0,0,1,99,2];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[17],timeToSay:3.600000000000001,voiceOver:"v_6"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[18],timeToSay:2.4});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[19],timeToSay:3.5});
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [8,0,8,7,0];
rengi.playersLevels = [2,0,2,99,0];
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[21],timeToSay:3,voiceOver:"v_7"});
rengi.speeches.push({player:5,turnTime:6,turnTime2:0,say:sayBayK[22],timeToSay:3,voiceOver:"v_8"});
rengi.players = [6,0,8,7,6];
rengi.playersLevels = [2,0,2,99,2];
rengi.speeches.sortOn([turnTime,turnTime2],Array.NUMERIC);
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [11,0,9,7,10];
rengi.playersLevels = [5,0,5,0,5];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[23],timeToSay:3.7,voiceOver:"v_9"});
rengi.speeches.push({player:2,turnTime:0,turnTime2:1,say:sayBayK[24],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[25],timeToSay:1});
rengi.speeches.push({player:1,turnTime:1,turnTime2:0,say:sayBayK[26],timeToSay:4,voiceOver:"v_10"});
rengi.speeches.push({player:6,turnTime:1,turnTime2:1,say:sayBayK[27],timeToSay:2.3000000000000003});
rengi.speeches.push({player:2,turnTime:1,turnTime2:2,say:sayBayK[28],timeToSay:5});
rengi.itemRare.push(13);
rengi.itemRare.push(14);
rengi.itemRareDropper = 1;
rengi.absoluteStart = 2;
rengi.ZoneBG = "WHITE NOVEMBER";
rengi.SkyBG = "SEA";
createNewBattle();
rengi.players = [14,0,0,0,0];
rengi.playersLevels = [3,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[29],timeToSay:3.3000000000000003,voiceOver:"v2_1"});
rengi.speeches.push({player:2,turnTime:0,turnTime2:1,say:sayBayK[30],timeToSay:2});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[31],timeToSay:2});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [17,0,17,0,17];
rengi.playersLevels = [4,0,4,0,4];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[33],timeToSay:3,voiceOver:"v2_2"});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [12,0,67,0,0];
rengi.playersLevels = [4,0,3,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[35],timeToSay:3,voiceOver:"v2_3"});
rengi.itemDrops.push({ID:32,CHANCE:3});
rengi.itemRare.push(15);
rengi.itemRare.push(17);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [13,0,0,0,0];
rengi.playersLevels = [4,0,0,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[37],timeToSay:3,voiceOver:"v2_4"});
rengi.itemDrops.push({ID:32,CHANCE:3});
rengi.itemDrops.push({ID:20,CHANCE:50});
rengi.itemDrops.push({ID:21,CHANCE:50});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [16,0,17,-2,17];
rengi.playersLevels = [5,0,2,0,2];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[42],timeToSay:2.5,voiceOver:"v2_6"});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[43],timeToSay:5});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[44],timeToSay:3});
rengi.speeches.push({player:4,turnTime:0,turnTime2:3,say:sayBayK[45],timeToSay:3});
rengi.itemRare.push(25);
rengi.itemRare.push(28);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [14,0,14,-2,0];
rengi.playersLevels = [5,0,4,0,0];
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [68,0,0,-2,0];
rengi.playersLevels = [5,0,0,0,0];
rengi.itemRare.push(25);
rengi.itemRare.push(28);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [12,0,13,-2,67];
rengi.playersLevels = [6,0,6,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[47],timeToSay:3,voiceOver:"v2_7"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[48],timeToSay:3});
rengi.speeches.push({player:4,turnTime:0,turnTime2:2,say:sayBayK[49],timeToSay:6});
rengi.speeches.push({player:5,turnTime:0,turnTime2:3,say:sayBayK[50],timeToSay:2.5});
rengi.itemDrops.push({ID:32,CHANCE:3});
rengi.itemDrops.push({ID:20,CHANCE:50});
rengi.itemDrops.push({ID:21,CHANCE:50});
rengi.itemRare.push(15);
rengi.itemRare.push(17);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [69,0,0,-2,0];
rengi.playersLevels = [6,0,6,0,6];
rengi.itemDrops.push({ID:32,CHANCE:5});
rengi.itemRare.push(15);
rengi.itemRare.push(17);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [15,-1,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[52],timeToSay:8,voiceOver:"v2_8"});
rengi.itemDrops.push({ID:32,CHANCE:5});
rengi.itemRare.push(39);
rengi.itemRare.push(40);
rengi.itemRare.push(41);
rengi.itemRare.push(42);
rengi.itemRare.push(43);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [20,0,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[55],timeToSay:2.5,voiceOver:"v3_1"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[56],timeToSay:2});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[57],timeToSay:2.3000000000000003});
rengi.speeches.push({player:1,turnTime:0,turnTime2:3,say:sayBayK[58],timeToSay:1.3000000000000005});
rengi.speeches.push({player:2,turnTime:0,turnTime2:4,say:sayBayK[59],timeToSay:4});
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [30,0,21,-2,0];
rengi.playersLevels = [7,0,7,0,0];
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [24,0,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[60],timeToSay:4.5,voiceOver:"v3_2"});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[61],timeToSay:1.5});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[62],timeToSay:3});
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [18,0,22,-2,0];
rengi.playersLevels = [8,0,7,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[67],timeToSay:3,voiceOver:"v3_3"});
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [70,0,0,-2,0];
rengi.playersLevels = [7,0,6,0,0];
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [23,0,0,-2,0];
rengi.playersLevels = [8,0,0,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[68],timeToSay:3.8000000000000003,voiceOver:"v3_4"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[69],timeToSay:1.9000000000000001});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[70],timeToSay:1.7});
rengi.speeches.push({player:1,turnTime:0,turnTime2:3,say:sayBayK[71],timeToSay:2});
rengi.itemRare.push(75);
rengi.itemRare.push(77);
rengi.itemRare.push(78);
rengi.itemRare.push(79);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [19,0,21,-2,22];
rengi.playersLevels = [8,0,8,0,8];
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [24,0,24,-2,0];
rengi.playersLevels = [8,0,9,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[63],timeToSay:4,voiceOver:"v3_5"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[64],timeToSay:3.2});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[65],timeToSay:4});
rengi.speeches.push({player:1,turnTime:0,turnTime2:3,say:sayBayK[66],timeToSay:3});
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [25,0,0,-2,0];
rengi.playersLevels = [11,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[74],timeToSay:2,voiceOver:"v3_6"});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [18,0,20,-2,0];
rengi.playersLevels = [9,0,9,0,0];
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRareDropper = 2;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [19,0,20,-2,0];
rengi.playersLevels = [9,0,9,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[75],timeToSay:3,voiceOver:"v3_7"});
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRareDropper = 2;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [33,0,34,-2,35];
rengi.playersLevels = [10,0,10,0,10];
rengi.speeches.push({player:6,turnTime:0,turnTime2:0,say:sayBayK[76],timeToSay:2.4,voiceOver:"v3_8"});
rengi.speeches.push({player:4,turnTime:0,turnTime2:1,say:sayBayK[77],timeToSay:2.8000000000000003});
rengi.speeches.push({player:2,turnTime:0,turnTime2:2,say:sayBayK[78],timeToSay:3.3000000000000003});
rengi.speeches.push({player:1,turnTime:0,turnTime2:3,say:sayBayK[79],timeToSay:3});
rengi.itemRare.push(76);
rengi.itemRare.push(77);
rengi.itemRare.push(78);
rengi.itemRare.push(79);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [31,0,22,-2,0];
rengi.playersLevels = [10,0,10,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[80],timeToSay:5,voiceOver:"v3_9"});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [24,0,24,-2,24];
rengi.playersLevels = [10,0,10,0,10];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[72],timeToSay:5,voiceOver:"v3_10"});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[73],timeToSay:4.5});
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [71,0,0,-2,0];
rengi.playersLevels = [11,0,11,0,0];
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [32,0,0,-2,0];
rengi.playersLevels = [11,0,0,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[81],timeToSay:2.8000000000000003,voiceOver:"v3_11"});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[101],timeToSay:2});
rengi.speeches.push({player:2,turnTime:2,turnTime2:0,say:sayBayK[102],timeToSay:3.5,voiceOver:"v3_12"});
rengi.speeches.push({player:1,turnTime:2,turnTime2:1,say:sayBayK[103],timeToSay:3});
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:81,CHANCE:85});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [29,0,28,-2,53];
rengi.playersLevels = [11,0,11,0,11];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[82],timeToSay:3.2,voiceOver:"v3_13"});
rengi.speeches.push({player:4,turnTime:0,turnTime2:1,say:sayBayK[83],timeToSay:4});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[107],timeToSay:3});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [26,27,0,-2,0];
rengi.playersLevels = [12,12,0,0,0];
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[84],timeToSay:10,voiceOver:"v3_14"});
rengi.speeches.push({player:3,turnTime:0,turnTime2:1,say:sayBayK[85],timeToSay:4});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[93],timeToSay:4});
rengi.speeches.push({player:3,turnTime:4,turnTime2:0,say:sayBayK[86],timeToSay:3,voiceOver:"v3_15"});
rengi.itemRare.push(75);
rengi.itemRare.push(76);
rengi.itemRare.push(77);
rengi.itemRare.push(78);
rengi.itemRare.push(79);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [36,-1,72,-2,0];
rengi.playersLevels = [12,0,12,0,0];
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[87],timeToSay:3.5,voiceOver:"v3_16",guyShow:"Veradux"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[88],timeToSay:2.5});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[89],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:3,say:sayBayK[92],timeToSay:4});
rengi.speeches.push({player:2,turnTime:1,turnTime2:0,say:sayBayK[90],timeToSay:3,voiceOver:"v3_17"});
rengi.speeches.push({player:2,turnTime:1,turnTime2:1,say:sayBayK[91],timeToSay:3});
rengi.itemDrops.push({ID:80,CHANCE:15});
rengi.itemRare.push(121);
rengi.itemRare.push(122);
rengi.itemRare.push(123);
rengi.itemRare.push(124);
rengi.itemRare.push(125);
rengi.itemRareDropper = 1;
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [60,-1,0,-2,0];
rengi.playersLevels = [13,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[111],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[112],timeToSay:3,guyShow:"Veradux"});
rengi.itemDrops.push({ID:150,CHANCE:15});
rengi.itemDrops.push({ID:155,CHANCE:15});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
createNewBattle();
rengi.players = [61,-1,0,-2,0];
rengi.playersLevels = [13,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[113],timeToSay:3});
rengi.speeches.push({player:2,turnTime:0,turnTime2:1,say:sayBayK[114],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:2,say:sayBayK[115],timeToSay:3,guyShow:"Veradux"});
rengi.itemDrops.push({ID:150,CHANCE:35});
rengi.itemDrops.push({ID:155,CHANCE:35});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
createNewBattle();
rengi.players = [62,-1,0,-2,0];
rengi.playersLevels = [14,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[116],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[117],timeToSay:3,guyShow:"Veradux"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[118],timeToSay:3});
rengi.itemDrops.push({ID:150,CHANCE:35});
rengi.itemDrops.push({ID:155,CHANCE:35});
rengi.itemDrops.push({ID:153,CHANCE:65});
rengi.itemDrops.push({ID:156,CHANCE:65});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
createNewBattle();
rengi.players = [63,-1,0,-2,0];
rengi.playersLevels = [14,0,0,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[119],timeToSay:3});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[120],timeToSay:3,guyShow:"Veradux"});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[121],timeToSay:3});
rengi.itemDrops.push({ID:150,CHANCE:35});
rengi.itemDrops.push({ID:155,CHANCE:35});
rengi.itemDrops.push({ID:153,CHANCE:65});
rengi.itemDrops.push({ID:156,CHANCE:65});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
createNewBattle();
rengi.players = [64,-1,65,-2,66];
rengi.playersLevels = [15,0,14,0,14];
rengi.phases.push({player:2,life:0,endGame:true,winOrLose:1});
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[122],timeToSay:3});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[123],timeToSay:3});
rengi.speeches.push({player:2,turnTime:0,turnTime2:2,say:sayBayK[125],timeToSay:3});
rengi.speeches.push({player:2,turnTime:0,turnTime2:3,say:sayBayK[126],timeToSay:3});
rengi.speeches.push({player:2,turnTime:0,turnTime2:4,say:sayBayK[127],timeToSay:3});
rengi.itemDrops.push({ID:150,CHANCE:35});
rengi.itemDrops.push({ID:155,CHANCE:35});
rengi.itemDrops.push({ID:153,CHANCE:65});
rengi.itemDrops.push({ID:156,CHANCE:65});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
createNewBattle();
rengi.players = [74,-1,75,-2,0];
rengi.playersLevels = [15,0,15,0,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [76,-1,0,-2,0];
rengi.playersLevels = [15,0,0,0,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [78,-1,79,-2,77];
rengi.playersLevels = [15,0,15,0,15];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [80,-1,81,-2,82];
rengi.playersLevels = [15,0,15,0,15];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [38,-1,0,-2,0];
rengi.playersLevels = [19,0,0,0,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.timeLock = true;
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [39,-1,0,-2,0];
rengi.playersLevels = [22,0,0,0,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [40,-1,43,-2,43];
rengi.playersLevels = [25,25,0,25,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.timeLock = true;
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
rengi.absoluteStart = 1;
createNewBattle();
rengi.players = [44,-1,0,-2,0];
rengi.playersLevels = [26,25,0,25,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [45,-1,0,-2,0];
rengi.playersLevels = [26,0,0,0,0];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[108],timeToSay:4});
rengi.players = [46,-1,0,-2,46];
rengi.playersLevels = [26,0,0,0,26];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.speeches.push({player:5,turnTime:0,turnTime2:0,say:sayBayK[94],timeToSay:4});
rengi.players = [46,-1,46,-2,46];
rengi.playersLevels = [26,0,26,0,26];
rengi.itemDrops.push({ID:119,CHANCE:100});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[95],timeToSay:4});
rengi.speeches.push({player:2,turnTime:0,turnTime2:1,say:sayBayK[96],timeToSay:4});
rengi.players = [47,-1,0,-2,0];
rengi.playersLevels = [27,0,26,0,26];
rengi.itemDrops.push({ID:126,CHANCE:100});
rengi.itemDrops.push({ID:127,CHANCE:100});
rengi.itemDrops.push({ID:128,CHANCE:100});
rengi.itemDrops.push({ID:129,CHANCE:100});
rengi.itemDrops.push({ID:130,CHANCE:100});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [48,-1,48,-2,0];
rengi.playersLevels = [28,0,27,0,26];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [48,-1,48,-2,48];
rengi.playersLevels = [28,0,28,0,28];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [49,-1,48,-2,0];
rengi.playersLevels = [28,0,28,0,28];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [49,-1,48,-2,49];
rengi.playersLevels = [28,0,28,0,28];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [49,-1,49,-2,49];
rengi.playersLevels = [28,0,28,0,28];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [50,-1,0,-2,0];
rengi.playersLevels = [29,0,0,0,0];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[97],timeToSay:4});
rengi.speeches.push({player:2,turnTime:0,turnTime2:1,say:sayBayK[98],timeToSay:4});
rengi.speeches.push({player:2,turnTime:10,turnTime2:0,say:sayBayK[99],timeToSay:4});
rengi.speeches.push({player:2,turnTime:15,turnTime2:0,say:sayBayK[100],timeToSay:4});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [51,5,0,0,0];
rengi.playersLevels = [1,1,0,0,0];
rengi.itemDrops.push({ID:132,CHANCE:100});
rengi.itemDrops.push({ID:131,CHANCE:100});
rengi.itemDrops.push({ID:133,CHANCE:100});
rengi.itemDrops.push({ID:149,CHANCE:100});
rengi.itemDrops.push({ID:148,CHANCE:100});
rengi.itemDrops.push({ID:146,CHANCE:100});
rengi.itemDrops.push({ID:147,CHANCE:100});
rengi.itemDrops.push({ID:144,CHANCE:100});
rengi.itemDrops.push({ID:145,CHANCE:100});
rengi.itemDrops.push({ID:141,CHANCE:100});
rengi.speeches.push({player:2,turnTime:0,turnTime2:0,say:sayBayK[104],timeToSay:4});
rengi.speeches.push({player:1,turnTime:0,turnTime2:1,say:sayBayK[105],timeToSay:4});
rengi.speeches.push({player:2,turnTime:0,turnTime2:2,say:sayBayK[106],timeToSay:4});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [52,-1,0,-2,0];
rengi.playersLevels = [30,0,0,0,0];
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [55,-1,0,-2,0];
rengi.playersLevels = [30,0,30,0,0];
rengi.speeches.push({player:1,turnTime:0,turnTime2:0,say:sayBayK[107],timeToSay:4});
rengi.speeches.push({player:5,turnTime:0,turnTime2:1,say:sayBayK[108],timeToSay:4});
rengi.speeches.push({player:1,turnTime:0,turnTime2:2,say:sayBayK[109],timeToSay:4});
rengi.speeches.push({player:2,turnTime:0,turnTime2:3,say:sayBayK[110],timeToSay:4});
rengi.itemDrops.push({ID:126,CHANCE:10});
rengi.itemDrops.push({ID:127,CHANCE:10});
rengi.itemDrops.push({ID:128,CHANCE:10});
rengi.itemDrops.push({ID:129,CHANCE:10});
rengi.itemDrops.push({ID:130,CHANCE:10});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "NIGHT";
battleCreationID = 1000;
createNewBattle();
rengi.players = [13,-1,0,-2,0];
rengi.playersLevels = [3,0,0,0,0];
rengi.itemDrops.push({ID:32,CHANCE:5});
rengi.itemDrops.push({ID:20,CHANCE:30});
rengi.itemDrops.push({ID:21,CHANCE:30});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [12,-1,0,-2,0];
rengi.playersLevels = [3,0,0,0,0];
rengi.itemDrops.push({ID:32,CHANCE:5});
rengi.itemDrops.push({ID:15,CHANCE:30});
rengi.itemDrops.push({ID:17,CHANCE:30});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [16,-1,0,-2,0];
rengi.playersLevels = [3,0,0,0,0];
rengi.itemDrops.push({ID:32,CHANCE:5});
rengi.itemDrops.push({ID:25,CHANCE:30});
rengi.itemDrops.push({ID:28,CHANCE:30});
rengi.ZoneBG = "SHORE";
rengi.SkyBG = "NIGHT";
createNewBattle();
rengi.players = [18,-1,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.itemRare.push(49);
rengi.itemRare.push(50);
rengi.itemRare.push(51);
rengi.itemRare.push(53);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:79,CHANCE:8});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [19,-1,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.itemRare.push(55);
rengi.itemRare.push(56);
rengi.itemRare.push(57);
rengi.itemRare.push(58);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:78,CHANCE:8});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [20,-1,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.itemRare.push(44);
rengi.itemRare.push(45);
rengi.itemRare.push(46);
rengi.itemRare.push(47);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:75,CHANCE:8});
rengi.itemDrops.push({ID:76,CHANCE:8});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [21,-1,0,-2,0];
rengi.playersLevels = [7,0,0,0,0];
rengi.itemRare.push(59);
rengi.itemRare.push(60);
rengi.itemRare.push(62);
rengi.itemRare.push(63);
rengi.itemRareDropper = 1;
rengi.itemDrops.push({ID:77,CHANCE:8});
rengi.ZoneBG = "PLAINS";
rengi.SkyBG = "DAY";
createNewBattle();
rengi.players = [41,-1,41,-2,41];
rengi.playersLevels = ["X",0,"X",0,"X"];
rengi.itemDrops.push({ID:120,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [42,-1,0,-2,0];
rengi.playersLevels = ["X",0,0,0,0];
rengi.itemDrops.push({ID:114,CHANCE:100});
rengi.ZoneBG = "PLAINS2";
rengi.SkyBG = "DAY2";
createNewBattle();
rengi.players = [73,-1,0,-2,0];
rengi.playersLevels = ["X",0,0,0,0];
rengi.itemDrops.push({ID:150,CHANCE:15});
rengi.itemDrops.push({ID:155,CHANCE:15});
rengi.ZoneBG = "JUNGLE2";
rengi.SkyBG = "JUNGLE";
krinAddNewUnit = function(a)
{
   if(Krin.friendArrayX[_root["KBR" + Krin.BattlePick].players[a - 2] + 2] > 0 || _root["KBR" + Krin.BattlePick].players[a - 2] > 0)
   {
      KRS = new Array();
      r = 0;
      while(r < 100)
      {
         KRS[r] = random(100);
         r++;
      }
      KRSC = 0;
      modVar1 = 1;
      if(Krin.diff == "HARD")
      {
         modVar1 = 1.1;
      }
      else
      {
         modVar1 = 1;
      }
      plerBFEU = _root["KBR" + Krin.BattlePick].players[a - 2];
      beubUBv = _root["KNU" + plerBFEU];
      poeHBeihv = _root["KBR" + Krin.BattlePick].playersLevels[a - 2];
      if(poeHBeihv == "X")
      {
         poeHBeihv = Krin.Level;
      }
      if(plerBFEU != 0)
      {
         shtName.voiceHit = new Array();
         kityru = 0;
         while(kityru < 3)
         {
            shtName.voiceHit[kityru] = beubUBv.voiceHit[kityru];
            kityru++;
         }
         shtName.voiceDie = beubUBv.voiceDie;
         shtName.active = true;
         shtName.AION = true;
         shtName.AIAD = false;
         shtName.moveArrayA = new Array();
         shtName.CDArrayA = new Array();
         shtName.moveArrayD = new Array();
         shtName.CDArrayD = new Array();
         if(_root["KBR" + Krin.BattlePick].players[a - 2] > 0)
         {
            shtName.plevel = poeHBeihv;
            for(eojwenv in beubUBv.movesA)
            {
               shtName.moveArrayA[eojwenv] = beubUBv.movesA[eojwenv];
               shtName.CDArrayA[eojwenv] = 0;
            }
            for(eojwenv in beubUBv.movesD)
            {
               shtName.moveArrayD[eojwenv] = beubUBv.movesD[eojwenv];
               shtName.CDArrayD[eojwenv] = 0;
            }
            shtName.Aggression = beubUBv.agressionArray[0];
            shtName.LifeBoundary1 = beubUBv.agressionArray[1];
            shtName.LifeBoundary2 = beubUBv.agressionArray[2];
            shtName.FocusAggression = beubUBv.agressionArray[3];
            shtName.playerName = beubUBv[0];
            shtName.STRENGTHU = shtName.STRENGTH = modVar1 * (beubUBv[3] + poeHBeihv * beubUBv[4]);
            shtName.SPEEDU = shtName.SPEED = modVar1 * (beubUBv[7] + poeHBeihv * beubUBv[8]);
            shtName.MAGICU = shtName.MAGIC = modVar1 * (beubUBv[5] + poeHBeihv * beubUBv[6]);
            shtName.FOCUSU = shtName.FOCUSN = shtName.FOCUS = beubUBv[9];
            shtName.LIFEN = shtName.LIFEU = shtName.LIFE = Math.round(modVar1 * (beubUBv[1] + poeHBeihv * beubUBv[2]) * 8);
            shtName.IGNORE = beubUBv.IGNORE;
            shtName.IGNORETURN = beubUBv.IGNORETURN;
            shtName.STUNRESIST = beubUBv.stunresist;
            shtName.model = [beubUBv.model[0],beubUBv.model[1],beubUBv.model[2],beubUBv.model[3]];
            if(beubUBv.skinSetter == 0)
            {
               balhKrinnner = 0;
            }
            else
            {
               thte = 0;
               while(thte < 5)
               {
                  shtName.equip[thte] = beubUBv.skinSetter;
                  thte++;
               }
               balhKrinnner = 5;
            }
            thte = balhKrinnner;
            while(thte < 7)
            {
               if(beubUBv.equipment[thte] != 0)
               {
                  shtName.equip[thte] = _root["KRINITEM" + beubUBv.equipment[thte]].looks;
               }
               else
               {
                  shtName.equip[thte] = 0;
               }
               thte++;
            }
            shtName.PER.Physical = shtName.PERU.Physical = beubUBv.PER[0] + poeHBeihv * 5;
            shtName.PER.Magic = shtName.PERU.Magic = beubUBv.PER[1] + poeHBeihv * 5;
            shtName.PER.Ice = shtName.PERU.Ice = beubUBv.PER[2] + poeHBeihv * 5;
            shtName.PER.Fire = shtName.PERU.Fire = beubUBv.PER[3] + poeHBeihv * 5;
            shtName.PER.Lightning = shtName.PERU.Lightning = beubUBv.PER[4] + poeHBeihv * 5;
            shtName.PER.Earth = shtName.PERU.Earth = beubUBv.PER[5] + poeHBeihv * 5;
            shtName.PER.Shadow = shtName.PERU.Shadow = beubUBv.PER[6] + poeHBeihv * 5;
            shtName.PER.Poison = shtName.PERU.Poison = beubUBv.PER[7] + poeHBeihv * 5;
            shtName.DEF.Physical = shtName.DEFU.Physical = beubUBv.DEF[0] + poeHBeihv * 5;
            shtName.DEF.Magic = shtName.DEFU.Magic = beubUBv.DEF[1] + poeHBeihv * 5;
            shtName.DEF.Ice = shtName.DEFU.Ice = beubUBv.DEF[2] + poeHBeihv * 5;
            shtName.DEF.Fire = shtName.DEFU.Fire = beubUBv.DEF[3] + poeHBeihv * 5;
            shtName.DEF.Lightning = shtName.DEFU.Lightning = beubUBv.DEF[4] + poeHBeihv * 5;
            shtName.DEF.Earth = shtName.DEFU.Earth = beubUBv.DEF[5] + poeHBeihv * 5;
            shtName.DEF.Shadow = shtName.DEFU.Shadow = beubUBv.DEF[6] + poeHBeihv * 5;
            shtName.DEF.Poison = shtName.DEFU.Poison = beubUBv.DEF[7] + poeHBeihv * 5;
         }
         else
         {
            dbrtbre = Krin.friendArray[Krin.friendArrayX[_root["KBR" + Krin.BattlePick].players[a - 2] + 2]];
            if(dbrtbre != -1)
            {
               Krin.friendlySlotsFFTT.push(dbrtbre);
               for(eojwenv in _root["KNU" + _root.Krin.ClassStats[dbrtbre]].movesA)
               {
                  shtName.moveArrayA[eojwenv] = _root["KNU" + _root.Krin.ClassStats[dbrtbre]].movesA[eojwenv];
                  shtName.CDArrayA[eojwenv] = 0;
               }
               for(eojwenv in _root["KNU" + _root.Krin.ClassStats[dbrtbre]].movesD)
               {
                  shtName.moveArrayD[eojwenv] = _root["KNU" + _root.Krin.ClassStats[dbrtbre]].movesD[eojwenv];
                  shtName.CDArrayD[eojwenv] = 0;
               }
               shtName.Aggression = Krin["agArray" + dbrtbre][0];
               shtName.LifeBoundary1 = Krin["agArray" + dbrtbre][1];
               shtName.LifeBoundary2 = Krin["agArray" + dbrtbre][2];
               shtName.FocusAggression = Krin["agArray" + dbrtbre][3];
               shtName.playerName = Krin.NameSets[dbrtbre];
               shtName.plevel = _root.Krin.LevelStats[dbrtbre];
               shtName.LIFEN = shtName.LIFEU = shtName.LIFE = Math.round(_root.Krin["StatSets" + dbrtbre][0] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[dbrtbre]][1] + _root["KNU" + _root.Krin.ClassStats[dbrtbre]][2] * _root.Krin.LevelStats[dbrtbre])) * 8;
               shtName.STRENGTHU = shtName.STRENGTH = Math.round(_root.Krin["StatSets" + dbrtbre][1] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[dbrtbre]][3] + _root["KNU" + _root.Krin.ClassStats[dbrtbre]][4] * _root.Krin.LevelStats[dbrtbre]));
               shtName.MAGICU = shtName.MAGIC = Math.round(_root.Krin["StatSets" + dbrtbre][2] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[dbrtbre]][5] + _root["KNU" + _root.Krin.ClassStats[dbrtbre]][6] * _root.Krin.LevelStats[dbrtbre]));
               shtName.SPEEDU = shtName.SPEED = Math.round(_root.Krin["StatSets" + dbrtbre][3] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[dbrtbre]][7] + _root["KNU" + _root.Krin.ClassStats[dbrtbre]][8] * _root.Krin.LevelStats[dbrtbre]));
               shtName.FOCUSU = shtName.FOCUSN = Math.round(_root.Krin["StatSets" + dbrtbre][4] + Math.ceil(_root["KNU" + _root.Krin.ClassStats[dbrtbre]][9]));
               shtName.model = ["MODEL1",Krin.skinArray[Krin.SkinSet[dbrtbre]],Krin.hairArray[Krin.HairSet[dbrtbre]],Krin.gArray[Krin.GSet[dbrtbre]]];
               if(Krin.skinSetArray[dbrtbre] == 0)
               {
                  balhKrinnner = 0;
               }
               else
               {
                  thte = 0;
                  while(thte < 5)
                  {
                     shtName.equip[thte] = Krin.skinSetArray[dbrtbre];
                     thte++;
                  }
                  balhKrinnner = 5;
               }
               kityru = 0;
               while(kityru < 3)
               {
                  shtName.voiceHit[kityru] = _root["KNU" + Krin.ClassStats[dbrtbre]].voiceHit[kityru];
                  kityru++;
               }
               shtName.voiceDie = _root["KNU" + Krin.ClassStats[dbrtbre]].voiceDie;
               thte = balhKrinnner;
               while(thte < 7)
               {
                  if(Krin["equipArray" + dbrtbre][thte] != 0)
                  {
                     shtName.equip[thte] = _root["KRINITEM" + Krin["equipArray" + dbrtbre][thte]].looks;
                  }
                  else
                  {
                     shtName.equip[thte] = 0;
                  }
                  thte++;
               }
               shtName.PER.Physical = shtName.PERU.Physical = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][0];
               shtName.PER.Magic = shtName.PERU.Magic = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][1];
               shtName.PER.Ice = shtName.PERU.Ice = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][2];
               shtName.PER.Fire = shtName.PERU.Fire = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][3];
               shtName.PER.Lightning = shtName.PERU.Lightning = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][4];
               shtName.PER.Earth = shtName.PERU.Earth = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][5];
               shtName.PER.Shadow = shtName.PERU.Shadow = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][6];
               shtName.PER.Poison = shtName.PERU.Poison = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["PerSets" + dbrtbre][7];
               shtName.DEF.Physical = shtName.DEFU.Physical = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][0];
               shtName.DEF.Magic = shtName.DEFU.Magic = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][1];
               shtName.DEF.Ice = shtName.DEFU.Ice = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][2];
               shtName.DEF.Fire = shtName.DEFU.Fire = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][3];
               shtName.DEF.Lightning = shtName.DEFU.Lightning = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][4];
               shtName.DEF.Earth = shtName.DEFU.Earth = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][5];
               shtName.DEF.Shadow = shtName.DEFU.Shadow = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][6];
               shtName.DEF.Poison = shtName.DEFU.Poison = 25 + _root.Krin.LevelStats[dbrtbre] * 5 + Krin["DefSets" + dbrtbre][7];
            }
            else
            {
               shtName.active = false;
            }
         }
      }
   }
};
Krin.itemArray = new Array();
i = 0;
while(i < 37)
{
   Krin.itemArray[i] = 0;
   i++;
}
Krin.mouseItem = 0;
itemKrinIDnow = -1;
allClearKrinItem = function()
{
   Krin.HealthUP = 0;
   Krin.StrengthUP = 0;
   Krin.MagicUP = 0;
   Krin.SpeedUP = 0;
   Krin.FocusUP = 0;
   Krin.PIU = new Array();
   Krin.DIU = new Array();
   Krin.PIU = [0,0,0,0,0,0,0,0];
   Krin.DIU = [0,0,0,0,0,0,0,0];
};
allClearKrinItem();
createNewItemKrin = function(a, b, c, d, e, f)
{
   itemKrinIDnow++;
   _root["KRINITEM" + itemKrinIDnow] = new Array();
   _root["KRINITEM" + itemKrinIDnow][0] = KrinLang[KLangChoosen].ITEMNAME[itemKrinIDnow];
   _root["KRINITEM" + itemKrinIDnow].gotoSTOP = a;
   _root["KRINITEM" + itemKrinIDnow][1] = b;
   _root["KRINITEM" + itemKrinIDnow][2] = c;
   _root["KRINITEM" + itemKrinIDnow][3] = d;
   _root["KRINITEM" + itemKrinIDnow][4] = e;
   _root["KRINITEM" + itemKrinIDnow][5] = f;
   _root["KRINITEM" + itemKrinIDnow].statUpdater = new Array();
   _root["KRINITEM" + itemKrinIDnow].statUpdaterP = new Array();
   _root["KRINITEM" + itemKrinIDnow].statUpdaterD = new Array();
   for(enivbwei in Krin.PIU)
   {
      _root["KRINITEM" + itemKrinIDnow].statUpdaterP[enivbwei] = Krin.PIU[enivbwei];
      _root["KRINITEM" + itemKrinIDnow].statUpdaterD[enivbwei] = Krin.DIU[enivbwei];
   }
   _root["KRINITEM" + itemKrinIDnow].statUpdater = [Krin.HealthUP,Krin.StrengthUP,Krin.MagicUP,Krin.SpeedUP,Krin.FocusUP];
   _root["KRINITEM" + itemKrinIDnow].toolTip = KrinLang[KLangChoosen].ITEMSAY[itemKrinIDnow];
   _root["KRINITEM" + itemKrinIDnow].toolTipAlt = new Array();
   gghhjjuu = _root["KRINITEM" + itemKrinIDnow];
   if(b > 1)
   {
      _root["KRINITEM" + itemKrinIDnow].looks = "NINJA";
      if(d > 0)
      {
         evenivew = " " + KrinLang[KLangChoosen].CLASS[d - 1];
      }
      else
      {
         evenivew = "";
      }
      _root["KRINITEM" + itemKrinIDnow].req = KrinLang[KLangChoosen].MENU[0] + e + evenivew + " " + KrinLang[KLangChoosen].ITEMSS[b - 2];
      for(z in gghhjjuu.statUpdater)
      {
         if(gghhjjuu.statUpdater[z] > 0)
         {
            gghhjjuu.toolTipAlt.push(KrinLang[KLangChoosen].SYSTEM[z] + " +" + gghhjjuu.statUpdater[z]);
         }
      }
      for(z in gghhjjuu.statUpdaterP)
      {
         if(gghhjjuu.statUpdaterP[z] > 0)
         {
            gghhjjuu.toolTipAlt.push(KrinLang[KLangChoosen].ELEMENTS[z] + " " + KrinLang[KLangChoosen].SYSTEM[5] + " +" + gghhjjuu.statUpdaterP[z]);
         }
      }
      for(z in gghhjjuu.statUpdaterD)
      {
         if(gghhjjuu.statUpdaterD[z] > 0)
         {
            gghhjjuu.toolTipAlt.push(KrinLang[KLangChoosen].ELEMENTS[z] + " " + KrinLang[KLangChoosen].SYSTEM[6] + " +" + gghhjjuu.statUpdaterD[z]);
         }
      }
   }
};
createNewItemKrin("None",0,"Common",0,0,50);
createNewItemKrin("Tool",0,"Uncommon",-1,0,60);
Krin.HealthUP = 5;
Krin.MagicUP = 4;
Krin.SpeedUP = 3;
Krin.StrengthUP = 5;
Krin.PIU[0] = 12;
Krin.DIU[3] = 12;
Krin.DIU[0] = 9;
createNewItemKrin("Sword",2,"Rare",0,1,50);
allClearKrinItem();
Krin.HealthUP = 4;
Krin.StrengthUP = 8;
Krin.PIU[0] = 6;
Krin.DIU[3] = 3;
Krin.DIU[0] = 3;
createNewItemKrin("Mace",7,"Uncommon",0,1,50);
gghhjjuu.looks = "SWORD1";
allClearKrinItem();
Krin.StrengthUP = 1;
createNewItemKrin("Jeans",5,"Common",0,1,7);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.StrengthUP = 2;
createNewItemKrin("Broken Pipe",7,"Common",0,1,10);
gghhjjuu.looks = "PIPE";
allClearKrinItem();
Krin.StrengthUP = 6;
createNewItemKrin("Fire Axe",7,"Common",0,1,40);
gghhjjuu.looks = "FIREAXE";
allClearKrinItem();
Krin.StrengthUP = 4;
createNewItemKrin("Crow Bar",7,"Common",0,1,30);
gghhjjuu.looks = "CROWBAR";
allClearKrinItem();
Krin.SpeedUP = 1;
createNewItemKrin("Converse All Stars",6,"Common",0,1,9);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.StrengthUP = 1;
createNewItemKrin("Engineering Gloves",4,"Common",0,1,12);
gghhjjuu.looks = "ENGINEERINGGLOVES";
allClearKrinItem();
Krin.SpeedUP = 1;
Krin.StrengthUP = 1;
createNewItemKrin("Navy Boots",6,"Common",0,1,12);
gghhjjuu.looks = "NAVY";
allClearKrinItem();
Krin.HealthUP = 1;
createNewItemKrin("White T-Shirt",3,"Common",0,1,12);
gghhjjuu.looks = "SHIRT";
allClearKrinItem();
createNewItemKrin("Stick",7,"Common",0,1,12);
gghhjjuu.looks = "STICK";
allClearKrinItem();
Krin.StrengthUP = 3;
Krin.MagicUP = 11;
Krin.PIU[1] = 5;
createNewItemKrin("M4",7,"Uncommon",0,3,50);
gghhjjuu.looks = "M4";
allClearKrinItem();
Krin.StrengthUP = 11;
Krin.MagicUP = 3;
Krin.PIU[0] = 5;
createNewItemKrin("Swat Sword",7,"Uncommon",0,3,50);
gghhjjuu.looks = "SWATSWORD";
allClearKrinItem();
Krin.StrengthUP = 1;
Krin.MagicUP = 2;
Krin.HealthUP = 3;
Krin.DIU[2] = 16;
Krin.DIU[6] = 8;
createNewItemKrin("Helmet of Peril",2,"Common",0,4,63);
gghhjjuu.looks = "SAMURAI";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.MagicUP = 1;
Krin.HealthUP = 3;
Krin.DIU[2] = 8;
Krin.DIU[6] = 16;
createNewItemKrin("Handguards of Destiny",4,"Common",0,4,43);
gghhjjuu.looks = "SAMURAI";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.MagicUP = 2;
Krin.HealthUP = 3;
Krin.DIU[2] = 20;
Krin.DIU[6] = 20;
createNewItemKrin("Armor of the Fallen",3,"Uncommon",0,4,109);
gghhjjuu.looks = "SAMURAI";
allClearKrinItem();
Krin.StrengthUP = 1;
Krin.MagicUP = 2;
Krin.HealthUP = 3;
Krin.DIU[2] = 16;
Krin.DIU[6] = 8;
createNewItemKrin("Ornate Leggings",5,"Common",0,4,63);
gghhjjuu.looks = "SAMURAI";
allClearKrinItem();
Krin.StrengthUP = 1;
Krin.MagicUP = 2;
Krin.HealthUP = 3;
Krin.DIU[2] = 8;
Krin.DIU[6] = 16;
createNewItemKrin("Dark Steel Boots",6,"Common",0,4,42);
gghhjjuu.looks = "SAMURAI";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.SpeedUP = 4;
Krin.PIU[0] = 4;
createNewItemKrin("Ghostly Mask",2,"Common",0,4,42);
gghhjjuu.looks = "NINJA";
allClearKrinItem();
Krin.StrengthUP = 3;
Krin.SpeedUP = 4;
Krin.PIU[0] = 7;
createNewItemKrin("Assasin\'s Tunic",3,"Common",0,4,102);
gghhjjuu.looks = "NINJA";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.SpeedUP = 4;
Krin.PIU[0] = 4;
createNewItemKrin("Shadow Leggings",5,"Common",0,4,63);
gghhjjuu.looks = "NINJA";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.SpeedUP = 4;
Krin.DIU[0] = 4;
createNewItemKrin("Stealth Strider Boots",6,"Common",0,4,42);
gghhjjuu.looks = "NINJA";
allClearKrinItem();
Krin.StrengthUP = 2;
Krin.SpeedUP = 4;
Krin.DIU[0] = 4;
createNewItemKrin("Reflex Gloves",4,"Common",0,4,42);
gghhjjuu.looks = "NINJA";
allClearKrinItem();
Krin.MagicUP = 2;
Krin.HealthUP = 2;
Krin.SpeedUP = 2;
Krin.StrengthUP = 1;
createNewItemKrin("Hunter\'s Helm",2,"Common",0,4,63);
gghhjjuu.looks = "USA4";
allClearKrinItem();
Krin.MagicUP = 3;
Krin.HealthUP = 2;
Krin.SpeedUP = 1;
Krin.StrengthUP = 1;
createNewItemKrin("Hunter\'s Handguards",4,"Common",0,4,42);
gghhjjuu.looks = "USA4";
allClearKrinItem();
Krin.MagicUP = 3;
Krin.HealthUP = 1;
Krin.SpeedUP = 2;
Krin.StrengthUP = 1;
createNewItemKrin("Hunter\'s Leggings",5,"Common",0,4,109);
gghhjjuu.looks = "USA4";
allClearKrinItem();
Krin.MagicUP = 4;
Krin.HealthUP = 2;
Krin.SpeedUP = 3;
Krin.StrengthUP = 2;
createNewItemKrin("Hunter\'s Body Armor",3,"Uncommon",0,4,109);
gghhjjuu.looks = "USA4";
allClearKrinItem();
Krin.MagicUP = 3;
Krin.HealthUP = 2;
Krin.SpeedUP = 1;
Krin.StrengthUP = 2;
createNewItemKrin("Hunter\'s Boots",6,"Common",0,4,42);
gghhjjuu.looks = "USA4";
allClearKrinItem();
Krin.SpeedUP = 2;
Krin.StrengthUP = 12;
createNewItemKrin("Ghostly Katana",7,"Common",0,5,109);
gghhjjuu.looks = "KATANA";
allClearKrinItem();
Krin.SpeedUP = 2;
Krin.MagicUP = 12;
createNewItemKrin("Pulse Rifle",7,"Common",0,5,109);
gghhjjuu.looks = "M4";
allClearKrinItem();
Krin.StrengthUP = 15;
Krin.PIU[0] = 38;
createNewItemKrin("Blade of Moon-Struck Horrors",7,"Rare",0,7,150);
gghhjjuu.looks = "MOON";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.StrengthUP = 4;
createNewItemKrin("Swift Blade",8,"Common",3,5,109);
gghhjjuu.looks = "SWIFT";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.MagicUP = 4;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[0] = 15;
Krin.DIU[1] = 15;
createNewItemKrin("ZPCI Med-Head",2,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.MagicUP = 4;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[2] = 15;
Krin.DIU[3] = 15;
createNewItemKrin("ZPCI Med-Chest",3,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.MagicUP = 4;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[4] = 15;
Krin.DIU[5] = 15;
createNewItemKrin("ZPCI Med-Gloves",4,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.MagicUP = 4;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[6] = 15;
Krin.DIU[7] = 15;
createNewItemKrin("ZPCI Med-Legs",5,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 4;
Krin.MagicUP = 4;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[0] = 15;
Krin.DIU[1] = 15;
createNewItemKrin("ZPCI Med-Feet",6,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 3;
Krin.MagicUP = 3;
Krin.HealthUP = 2;
Krin.StrengthUP = 3;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Sensei-Head",2,"Rare",0,5,80);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.SpeedUP = 3;
Krin.MagicUP = 2;
Krin.HealthUP = 2;
Krin.StrengthUP = 3;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Sensei-Chest",3,"Rare",0,5,80);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.SpeedUP = 3;
Krin.MagicUP = 3;
Krin.HealthUP = 2;
Krin.StrengthUP = 2;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Sensei-Gloves",4,"Rare",0,5,80);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.SpeedUP = 2;
Krin.MagicUP = 3;
Krin.HealthUP = 4;
Krin.StrengthUP = 4;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Sensei-Legs",5,"Rare",0,5,80);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.SpeedUP = 3;
Krin.MagicUP = 3;
Krin.HealthUP = 2;
Krin.StrengthUP = 2;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Sensei-Feet",6,"Rare",0,5,80);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.SpeedUP = 10;
Krin.StrengthUP = 4;
Krin.PIU[0] = 28;
createNewItemKrin("Melee-Shammy-Head",2,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN1";
allClearKrinItem();
Krin.SpeedUP = 6;
Krin.HealthUP = 6;
Krin.StrengthUP = 6;
createNewItemKrin("Melee-Shammy-Body",3,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN1";
allClearKrinItem();
Krin.SpeedUP = 10;
Krin.StrengthUP = 9;
Krin.PIU[0] = 28;
createNewItemKrin("Melee-Shammy-Hands",4,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN1";
allClearKrinItem();
Krin.SpeedUP = 9;
Krin.HealthUP = 4;
Krin.StrengthUP = 2;
Krin.PIU[0] = 22;
createNewItemKrin("Melee-Shammy-Legs",5,"Common",0,8,512);
gghhjjuu.looks = "SHAMAN1";
allClearKrinItem();
Krin.SpeedUP = 11;
Krin.StrengthUP = 4;
Krin.PIU[0] = 12;
createNewItemKrin("Melee-Shammy-Feet",6,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN1";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.MagicUP = 9;
Krin.PIU[1] = 27;
createNewItemKrin("Magic-Shammy-Head",2,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN3";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.MagicUP = 9;
Krin.PIU[2] = 27;
createNewItemKrin("Magic-Shammy-Body",3,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN3";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.MagicUP = 10;
Krin.PIU[1] = 13;
Krin.PIU[2] = 13;
createNewItemKrin("Magic-Shammy-Hands",4,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN3";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.MagicUP = 9;
Krin.PIU[1] = 32;
createNewItemKrin("Magic-Shammy-Leg",5,"Common",0,8,512);
gghhjjuu.looks = "SHAMAN3";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.MagicUP = 9;
Krin.PIU[2] = 32;
createNewItemKrin("Magic-Shammy-Feet",6,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN3";
allClearKrinItem();
Krin.HealthUP = 9;
Krin.StrengthUP = 4;
Krin.MagicUP = 5;
Krin.PIU[4] = 17;
createNewItemKrin("Heal-Shammy-Head",2,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN2";
allClearKrinItem();
Krin.HealthUP = 7;
Krin.StrengthUP = 4;
Krin.MagicUP = 5;
Krin.PIU[4] = 17;
createNewItemKrin("Heal-Shammy-Body",3,"Common",0,10,512);
gghhjjuu.looks = "SHAMAN2";
allClearKrinItem();
Krin.HealthUP = 9;
Krin.StrengthUP = 4;
Krin.MagicUP = 6;
createNewItemKrin("Heal-Shammy-Hands",4,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN2";
allClearKrinItem();
Krin.HealthUP = 5;
Krin.StrengthUP = 4;
Krin.MagicUP = 5;
Krin.PIU[4] = 9;
createNewItemKrin("Heal-Shammy-Leg",5,"Common",0,8,512);
gghhjjuu.looks = "SHAMAN2";
allClearKrinItem();
Krin.HealthUP = 8;
Krin.StrengthUP = 5;
Krin.MagicUP = 4;
Krin.PIU[4] = 17;
createNewItemKrin("Heal-Shammy-Feet",6,"Common",0,8,240);
gghhjjuu.looks = "SHAMAN2";
allClearKrinItem();
Krin.HealthUP = 7;
Krin.StrengthUP = 9;
Krin.PIU[0] = 7;
createNewItemKrin("Knight-Head",2,"Common",1,10,512);
gghhjjuu.looks = "SURVIVOR";
allClearKrinItem();
Krin.HealthUP = 5;
Krin.StrengthUP = 11;
Krin.PIU[0] = 7;
createNewItemKrin("Knight-Body",3,"Common",1,10,512);
gghhjjuu.looks = "SURVIVOR";
allClearKrinItem();
Krin.HealthUP = 8;
Krin.StrengthUP = 7;
Krin.PIU[0] = 7;
createNewItemKrin("Knight-Hands",4,"Common",1,8,240);
gghhjjuu.looks = "SURVIVOR";
allClearKrinItem();
Krin.HealthUP = 4;
Krin.StrengthUP = 12;
Krin.PIU[0] = 13;
createNewItemKrin("Knight-Leg",5,"Common",1,8,512);
gghhjjuu.looks = "SURVIVOR";
allClearKrinItem();
Krin.HealthUP = 9;
Krin.StrengthUP = 8;
Krin.PIU[0] = 13;
createNewItemKrin("Knight-Feet",6,"Common",1,8,240);
gghhjjuu.looks = "SURVIVOR";
allClearKrinItem();
Krin.HealthUP = 5;
Krin.SpeedUP = 2;
Krin.DIU[0] = 46;
Krin.DIU[5] = 46;
createNewItemKrin("Survivor-Head",2,"Common",0,7,99);
gghhjjuu.looks = "KNIGHT";
allClearKrinItem();
Krin.HealthUP = 5;
Krin.SpeedUP = 2;
Krin.DIU[0] = 46;
Krin.DIU[5] = 46;
createNewItemKrin("Survivor-Body",3,"Common",0,7,99);
gghhjjuu.looks = "KNIGHT";
allClearKrinItem();
Krin.HealthUP = 4;
Krin.SpeedUP = 3;
Krin.DIU[0] = 46;
Krin.DIU[5] = 46;
createNewItemKrin("Survivor-Hands",4,"Common",0,7,99);
gghhjjuu.looks = "KNIGHT";
allClearKrinItem();
Krin.HealthUP = 4;
Krin.SpeedUP = 3;
Krin.DIU[0] = 46;
Krin.DIU[5] = 46;
createNewItemKrin("Survivor-Leg",5,"Common",0,7,99);
gghhjjuu.looks = "KNIGHT";
allClearKrinItem();
Krin.HealthUP = 4;
Krin.SpeedUP = 3;
Krin.DIU[0] = 46;
Krin.DIU[5] = 46;
createNewItemKrin("Survivor-Feet",6,"Common",0,7,99);
gghhjjuu.looks = "KNIGHT";
allClearKrinItem();
Krin.SpeedUP = 11;
Krin.PIU[0] = 50;
createNewItemKrin("Vendor-Shank",7,"Common",0,7,512);
gghhjjuu.looks = "SHANK";
allClearKrinItem();
Krin.SpeedUP = 11;
Krin.PIU[0] = 50;
createNewItemKrin("Vendor-Shank2",8,"Common",3,7,512);
gghhjjuu.looks = "SHANK";
allClearKrinItem();
Krin.StrengthUP = 18;
Krin.HealthUP = 12;
createNewItemKrin("Vendor-Sword",7,"Common",1,7,1024);
gghhjjuu.looks = "BROAD";
allClearKrinItem();
Krin.StrengthUP = 8;
Krin.MagicUP = 8;
Krin.PIU[4] = 50;
createNewItemKrin("Vendor-Mace",7,"Common",0,7,512);
gghhjjuu.looks = "SPELLMACE";
allClearKrinItem();
Krin.HealthUP = 10;
Krin.DIU[0] = 40;
createNewItemKrin("Vendor-Shield",8,"Common",2,7,512);
gghhjjuu.looks = "SHIELD2";
allClearKrinItem();
Krin.MagicUP = 16;
Krin.PIU[1] = 25;
Krin.PIU[3] = 25;
createNewItemKrin("Vendor-Staff",7,"Common",0,7,1024);
gghhjjuu.looks = "SPELLSTAFF";
allClearKrinItem();
Krin.SpeedUP = 15;
Krin.PIU[0] = 60;
createNewItemKrin("Vendor-Shank",7,"Common",0,8,512);
gghhjjuu.looks = "SHAMANKNIFE";
allClearKrinItem();
Krin.SpeedUP = 15;
Krin.PIU[0] = 60;
createNewItemKrin("Vendor-Shank2",8,"Common",3,8,512);
gghhjjuu.looks = "SHAMANKNIFE";
allClearKrinItem();
Krin.StrengthUP = 18;
Krin.HealthUP = 16;
createNewItemKrin("Vendor-Sword",7,"Common",1,8,1024);
gghhjjuu.looks = "SHAMANSWORD";
allClearKrinItem();
Krin.StrengthUP = 12;
Krin.MagicUP = 12;
Krin.PIU[4] = 60;
createNewItemKrin("Vendor-Mace",7,"Common",0,8,512);
gghhjjuu.looks = "SHAMANMED";
allClearKrinItem();
Krin.MagicUP = 24;
Krin.PIU[1] = 35;
Krin.PIU[3] = 35;
createNewItemKrin("Vendor-Staff",7,"Common",0,8,1024);
gghhjjuu.looks = "SHAMANMAGIC";
allClearKrinItem();
Krin.MagicUP = 16;
Krin.StrengthUP = 16;
Krin.SpeedUP = 16;
Krin.HealthUP = 16;
Krin.PIU[0] = 25;
Krin.PIU[4] = 25;
createNewItemKrin("Galiant\'s Sword",7,"Common",0,12,1024);
gghhjjuu.looks = "PALADINSWORD";
allClearKrinItem();
Krin.StrengthUP = 2;
createNewItemKrin("Stone Club",7,"Common",0,10,200);
gghhjjuu.looks = "CLUB";
allClearKrinItem();
Krin.StrengthUP = 50;
Krin.HealthUP = 30;
Krin.PIU[0] = 20;
createNewItemKrin("Warrior 2H",7,"Common",1,10,4000);
gghhjjuu.looks = "UBER1";
allClearKrinItem();
Krin.StrengthUP = 25;
Krin.HealthUP = 15;
Krin.PIU[0] = 10;
createNewItemKrin("Guardian 2H",7,"Common",0,10,2000);
gghhjjuu.looks = "UBER11";
allClearKrinItem();
Krin.MagicUP = 50;
Krin.FocusUP = 50;
Krin.PIU[4] = 50;
Krin.PIU[2] = 50;
createNewItemKrin("1H Magic",7,"Common",0,10,2000);
gghhjjuu.looks = "UBER3";
allClearKrinItem();
Krin.StrengthUP = 30;
Krin.MagicUP = 50;
Krin.HealthUP = 30;
Krin.PIU[4] = 25;
Krin.PIU[0] = 25;
createNewItemKrin("1H Magic (Guardian)",7,"Common",0,10,2000);
gghhjjuu.looks = "UBER4";
allClearKrinItem();
Krin.PIU[3] = 300;
Krin.FocusUP = 50;
createNewItemKrin("1H Lantern",8,"Common",4,10,2000);
gghhjjuu.looks = "UBER9";
allClearKrinItem();
Krin.MagicUP = 40;
Krin.FocusUP = 30;
createNewItemKrin("1H Lantern2",8,"Common",4,10,2000);
gghhjjuu.looks = "UBER10";
allClearKrinItem();
Krin.PIU[1] = 100;
Krin.FocusUP = 50;
createNewItemKrin("1H Latern3",8,"Common",4,10,2000);
gghhjjuu.looks = "UBER8";
allClearKrinItem();
Krin.StrengthUP = 25;
Krin.PIU[0] = 50;
Krin.PIU[4] = 50;
createNewItemKrin("1H Shield",8,"Common",2,10,2000);
gghhjjuu.looks = "UBER6";
allClearKrinItem();
Krin.FocusUP = 20;
Krin.HealthUP = 30;
Krin.MagicUP = 15;
Krin.StrengthUP = 15;
createNewItemKrin("1H Shield2",8,"Common",2,10,2000);
gghhjjuu.looks = "UBER7";
allClearKrinItem();
Krin.FocusUP = 50;
Krin.HealthUP = 65;
createNewItemKrin("1H Shield3",8,"Common",2,10,2000);
gghhjjuu.looks = "UBER5";
allClearKrinItem();
Krin.StrengthUP = 10;
Krin.PIU[0] = 50;
Krin.SpeedUP = 30;
createNewItemKrin("Assasin Weapon",7,"Common",0,10,2000);
gghhjjuu.looks = "UBER2";
allClearKrinItem();
Krin.StrengthUP = 10;
Krin.PIU[0] = 50;
Krin.SpeedUP = 30;
createNewItemKrin("Assasin Weapon 2",8,"Common",3,10,2000);
gghhjjuu.looks = "UBER2";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 60;
Krin.SpeedUP = 50;
Krin.PIU[0] = 40;
Krin.PIU[2] = 40;
Krin.PIU[3] = 40;
createNewItemKrin("Warrior-Head",2,"Rare",1,13,10000);
gghhjjuu.looks = "FINAL1";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 60;
Krin.SpeedUP = 50;
Krin.PIU[0] = 40;
Krin.PIU[2] = 40;
Krin.PIU[3] = 40;
createNewItemKrin("Warrior-Body",3,"Rare",1,15,10000);
gghhjjuu.looks = "FINAL1";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 60;
Krin.SpeedUP = 50;
Krin.PIU[0] = 40;
Krin.PIU[2] = 40;
Krin.PIU[3] = 40;
createNewItemKrin("Warrior-Hands",4,"Rare",1,14,10000);
gghhjjuu.looks = "FINAL1";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 60;
Krin.SpeedUP = 50;
Krin.PIU[0] = 40;
Krin.PIU[2] = 40;
Krin.PIU[3] = 40;
createNewItemKrin("Warrior-Leg",5,"Rare",1,14,10000);
gghhjjuu.looks = "FINAL1";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 60;
Krin.SpeedUP = 50;
Krin.PIU[0] = 40;
Krin.PIU[2] = 40;
Krin.PIU[3] = 40;
createNewItemKrin("Warrior-Feet",6,"Rare",1,15,10000);
gghhjjuu.looks = "FINAL1";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 40;
Krin.MagicUP = 40;
Krin.SpeedUP = 40;
Krin.FocusUP = 10;
Krin.PIU[1] = 20;
createNewItemKrin("Guardian-Head",2,"Rare",2,13,10000);
gghhjjuu.looks = "FINAL4";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 40;
Krin.MagicUP = 40;
Krin.SpeedUP = 40;
Krin.FocusUP = 10;
Krin.PIU[1] = 20;
createNewItemKrin("Guardian-Body",3,"Rare",2,15,10000);
gghhjjuu.looks = "FINAL4";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 40;
Krin.MagicUP = 40;
Krin.SpeedUP = 40;
Krin.FocusUP = 10;
Krin.PIU[1] = 20;
createNewItemKrin("Guardian-Hands",4,"Rare",2,14,10000);
gghhjjuu.looks = "FINAL4";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 40;
Krin.MagicUP = 40;
Krin.SpeedUP = 40;
Krin.FocusUP = 10;
Krin.PIU[1] = 20;
createNewItemKrin("Guardian-Leg",5,"Rare",2,14,10000);
gghhjjuu.looks = "FINAL4";
allClearKrinItem();
Krin.HealthUP = 60;
Krin.StrengthUP = 40;
Krin.MagicUP = 40;
Krin.SpeedUP = 40;
Krin.FocusUP = 10;
Krin.PIU[1] = 20;
createNewItemKrin("Guardian-Feet",6,"Rare",2,15,10000);
gghhjjuu.looks = "FINAL4";
allClearKrinItem();
Krin.HealthUP = 50;
Krin.SpeedUP = 70;
Krin.FocusUP = 25;
Krin.PIU[0] = 50;
createNewItemKrin("Assassin-Head",2,"Rare",3,13,10000);
gghhjjuu.looks = "FINAL3";
allClearKrinItem();
Krin.HealthUP = 50;
Krin.SpeedUP = 70;
Krin.FocusUP = 25;
Krin.PIU[0] = 50;
createNewItemKrin("Assassin-Body",3,"Rare",3,15,10000);
gghhjjuu.looks = "FINAL3";
allClearKrinItem();
Krin.HealthUP = 50;
Krin.SpeedUP = 70;
Krin.FocusUP = 25;
Krin.PIU[0] = 50;
createNewItemKrin("Assassin-Hands",4,"Rare",3,14,10000);
gghhjjuu.looks = "FINAL3";
allClearKrinItem();
Krin.HealthUP = 50;
Krin.SpeedUP = 70;
Krin.FocusUP = 25;
Krin.PIU[0] = 50;
createNewItemKrin("Assassin-Leg",5,"Rare",3,14,10000);
gghhjjuu.looks = "FINAL3";
allClearKrinItem();
Krin.HealthUP = 50;
Krin.SpeedUP = 70;
Krin.FocusUP = 25;
Krin.PIU[0] = 50;
createNewItemKrin("Assassin-Feet",6,"Rare",3,15,10000);
gghhjjuu.looks = "FINAL3";
allClearKrinItem();
Krin.HealthUP = 45;
Krin.MagicUP = 60;
Krin.StrengthUP = 15;
Krin.SpeedUP = 50;
Krin.FocusUP = 10;
createNewItemKrin("Gunslinger-Head",2,"Rare",4,13,10000);
gghhjjuu.looks = "FINAL2";
allClearKrinItem();
Krin.HealthUP = 45;
Krin.MagicUP = 60;
Krin.StrengthUP = 15;
Krin.SpeedUP = 50;
Krin.FocusUP = 10;
createNewItemKrin("Gunslinger-Body",3,"Rare",4,15,10000);
gghhjjuu.looks = "FINAL2";
allClearKrinItem();
Krin.HealthUP = 45;
Krin.MagicUP = 60;
Krin.StrengthUP = 15;
Krin.SpeedUP = 50;
Krin.FocusUP = 10;
createNewItemKrin("Gunslinger-Hands",4,"Rare",4,14,10000);
gghhjjuu.looks = "FINAL2";
allClearKrinItem();
Krin.HealthUP = 45;
Krin.MagicUP = 60;
Krin.StrengthUP = 15;
Krin.SpeedUP = 50;
Krin.FocusUP = 10;
createNewItemKrin("Gunslinger-Leg",5,"Rare",4,14,10000);
gghhjjuu.looks = "FINAL2";
allClearKrinItem();
Krin.HealthUP = 45;
Krin.MagicUP = 60;
Krin.StrengthUP = 15;
Krin.SpeedUP = 50;
Krin.FocusUP = 10;
createNewItemKrin("Gunslinger-Feet",6,"Rare",4,15,10000);
gghhjjuu.looks = "FINAL2";
allClearKrinItem();
createNewItemKrin("Convoy Package",0,"Rare",-1,0,8000);
allClearKrinItem();
createNewItemKrin("Zombie Fingers",0,"Common",-1,0,15);
allClearKrinItem();
createNewItemKrin("ZPCI Dog-Tag",0,"Common",-1,0,20);
allClearKrinItem();
createNewItemKrin("Broken Totem",0,"Common",-1,0,50);
allClearKrinItem();
createNewItemKrin("Tool",0,"Common",-1,0,20);
allClearKrinItem();
createNewItemKrin("Champion\'s Trophy",0,"Rare",-1,0,40000);
allClearKrinItem();
createNewItemKrin("Ghost Medallion",0,"Uncommon",-1,0,2000);
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 8;
Krin.MagicUP = 12;
Krin.FocusUP = 15;
Krin.PIU[7] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Head",2,"Rare",0,10,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 8;
Krin.MagicUP = 12;
Krin.FocusUP = 15;
Krin.PIU[7] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Body",3,"Rare",0,10,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 8;
Krin.MagicUP = 12;
Krin.FocusUP = 15;
Krin.PIU[7] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Hands",4,"Rare",0,10,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 8;
Krin.MagicUP = 12;
Krin.FocusUP = 15;
Krin.PIU[7] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Leg",5,"Rare",0,10,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 8;
Krin.MagicUP = 12;
Krin.FocusUP = 15;
Krin.PIU[7] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Feet",6,"Rare",0,10,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 12;
Krin.SpeedUP = 8;
Krin.StrengthUP = 18;
Krin.MagicUP = 12;
Krin.PIU[1] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Head",2,"Rare",0,20,300);
gghhjjuu.looks = "USA1";
allClearKrinItem();
Krin.HealthUP = 32;
Krin.SpeedUP = 18;
Krin.StrengthUP = 28;
Krin.MagicUP = 32;
Krin.PIU[1] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Body",3,"Rare",0,20,300);
gghhjjuu.looks = "USA1";
allClearKrinItem();
Krin.HealthUP = 32;
Krin.SpeedUP = 18;
Krin.StrengthUP = 24;
Krin.MagicUP = 22;
Krin.PIU[1] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Hands",4,"Rare",0,20,300);
gghhjjuu.looks = "USA1";
allClearKrinItem();
Krin.HealthUP = 32;
Krin.SpeedUP = 28;
Krin.StrengthUP = 28;
Krin.MagicUP = 22;
Krin.PIU[1] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Leg",5,"Rare",0,20,300);
gghhjjuu.looks = "USA1";
allClearKrinItem();
Krin.HealthUP = 22;
Krin.SpeedUP = 38;
Krin.StrengthUP = 28;
Krin.MagicUP = 22;
Krin.PIU[1] = 100;
Krin.PIU[4] = 15;
createNewItemKrin("Paladin-Feet",6,"Rare",0,20,300);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.HealthUP = 72;
Krin.SpeedUP = 78;
Krin.StrengthUP = 78;
Krin.MagicUP = 72;
createNewItemKrin("Jeans",5,"Common",0,21,7);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.StrengthUP = 72;
Krin.SpeedUP = 78;
Krin.StrengthUP = 78;
Krin.MagicUP = 72;
createNewItemKrin("Broken Pipe",7,"Common",0,21,10);
gghhjjuu.looks = "PIPE";
allClearKrinItem();
Krin.StrengthUP = 70;
Krin.HealthUP = 72;
Krin.SpeedUP = 78;
createNewItemKrin("White T-Shirt",3,"Common",0,21,12);
gghhjjuu.looks = "SHIRT";
allClearKrinItem();
Krin.HealthUP = 72;
Krin.SpeedUP = 78;
createNewItemKrin("ZPCI Med-Head",2,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[2] = 15;
Krin.DIU[3] = 15;
createNewItemKrin("ZPCI Med-Chest",3,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[4] = 15;
Krin.DIU[5] = 15;
createNewItemKrin("ZPCI Med-Gloves",4,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[6] = 15;
Krin.DIU[7] = 15;
createNewItemKrin("ZPCI Med-Legs",5,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[0] = 15;
Krin.DIU[1] = 15;
createNewItemKrin("ZPCI Med-Feet",6,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 73;
Krin.MagicUP = 73;
Krin.HealthUP = 72;
Krin.StrengthUP = 73;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Converse All Stars",6,"Common",0,1,9);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.SpeedUP = 74;
createNewItemKrin("Converse All Stars",6,"Common",0,1,9);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.SpeedUP = 74;
createNewItemKrin("Converse All Stars",6,"Common",0,1,9);
gghhjjuu.looks = "JEANS";
allClearKrinItem();
Krin.StrengthUP = 75;
Krin.PIU[0] = 380;
createNewItemKrin("Pulse Rifle",7,"Common",0,5,109);
gghhjjuu.looks = "M4";
allClearKrinItem();
Krin.StrengthUP = 75;
Krin.PIU[0] = 380;
createNewItemKrin("ZPCI Med-Head",2,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[2] = 15;
Krin.DIU[3] = 15;
createNewItemKrin("ZPCI Med-Legs",5,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[0] = 15;
Krin.DIU[1] = 15;
createNewItemKrin("ZPCI Med-Feet",6,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 73;
Krin.MagicUP = 73;
Krin.HealthUP = 72;
Krin.StrengthUP = 73;
Krin.DIU[0] = 13;
Krin.PIU[1] = 13;
createNewItemKrin("Pulse Rifle",7,"Common",0,5,109);
gghhjjuu.looks = "M4";
allClearKrinItem();
Krin.StrengthUP = 75;
Krin.PIU[0] = 380;
createNewItemKrin("ZPCI Med-Chest",3,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[4] = 15;
Krin.DIU[5] = 15;
createNewItemKrin("ZPCI Med-Gloves",4,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.SpeedUP = 74;
Krin.MagicUP = 74;
Krin.HealthUP = 74;
Krin.StrengthUP = 74;
Krin.DIU[6] = 15;
Krin.DIU[7] = 15;
createNewItemKrin("ZPCI Med-Head",2,"Uncommon",5,5,40);
gghhjjuu.looks = "MEDIC";
allClearKrinItem();
Krin.MagicUP = 30;
Krin.HealthUP = 50;
Krin.SpeedUP = 40;
Krin.StrengthUP = 20;
createNewItemKrin("Hunter\'s Helm",2,"Common",0,10,250);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.MagicUP = 30;
Krin.HealthUP = 50;
Krin.SpeedUP = 40;
Krin.StrengthUP = 20;
createNewItemKrin("Hunter\'s Handguards",4,"Common",0,10,250);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.MagicUP = 30;
Krin.HealthUP = 50;
Krin.SpeedUP = 40;
Krin.StrengthUP = 20;
createNewItemKrin("Hunter\'s Leggings",5,"Common",0,10,250);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.MagicUP = 30;
Krin.HealthUP = 50;
Krin.SpeedUP = 40;
Krin.StrengthUP = 20;
createNewItemKrin("Hunter\'s Body Armor",3,"Uncommon",0,10,250);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.MagicUP = 30;
Krin.HealthUP = 50;
Krin.SpeedUP = 40;
Krin.StrengthUP = 20;
createNewItemKrin("Hunter\'s Boots",6,"Common",0,10,250);
gghhjjuu.looks = "USA5";
allClearKrinItem();
Krin.MagicUP = 50;
Krin.HealthUP = 30;
Krin.SpeedUP = 20;
Krin.StrengthUP = 40;
createNewItemKrin("Sensei-Head",2,"Common",0,10,250);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.MagicUP = 40;
Krin.HealthUP = 40;
Krin.SpeedUP = 20;
Krin.StrengthUP = 40;
createNewItemKrin("Sensei-Chest",3,"Uncommon",0,10,250);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.MagicUP = 50;
Krin.HealthUP = 30;
Krin.SpeedUP = 20;
Krin.StrengthUP = 40;
createNewItemKrin("Sensei-Gloves",4,"Common",0,10,250);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.MagicUP = 40;
Krin.HealthUP = 40;
Krin.SpeedUP = 20;
Krin.StrengthUP = 40;
createNewItemKrin("Sensei-Legs",5,"Common",0,10,250);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.MagicUP = 50;
Krin.HealthUP = 30;
Krin.SpeedUP = 20;
Krin.StrengthUP = 40;
createNewItemKrin("Sensei-Feet",6,"Common",0,10,250);
gghhjjuu.looks = "SAMURAI2";
allClearKrinItem();
Krin.StrengthUP = 40;
Krin.HealthUP = 15;
Krin.SpeedUP = 15;
createNewItemKrin("Destroyer Sword",7,"Rare",1,8,500);
gghhjjuu.looks = "SHAMANSWORD";
allClearKrinItem();
Krin.StrengthUP = 35;
Krin.MagicUP = 35;
Krin.SpeedUP = 15;
Krin.HealthUP = 30;
Krin.PIU[7] = 25;
Krin.PIU[4] = 25;
Krin.PIU[3] = 25;
Krin.PIU[2] = 25;
Krin.PIU[1] = 25;
Krin.PIU[0] = 25;
createNewItemKrin("1H Magic (Guardian)",7,"Rare",2,8,500);
gghhjjuu.looks = "UBER4";
allClearKrinItem();
Krin.SpeedUP = 40;
Krin.HealthUP = 20;
createNewItemKrin("Vendor-Shank2",8,"Rare",3,8,500);
gghhjjuu.looks = "SHAMANKNIFE";
allClearKrinItem();
Krin.MagicUP = 50;
Krin.HealthUP = 15;
Krin.SpeedUP = 15;
createNewItemKrin("Gunslinger",7,"Rare",4,8,500);
gghhjjuu.looks = "SPELLSTAFF";
allClearKrinItem();
Krin.ClassStats = new Array();
Krin.LevelStats = new Array();
Krin.NameSets = new Array();
Krin.ExpSets = new Array();
Krin.friendArray = new Array();
Krin.SkinSet = new Array();
Krin.HairSet = new Array();
Krin.GSet = new Array();
Krin.friendArray = [0,-1,-1,-1,-1,-1];
Krin.skinArray = new Array();
Krin.hairArray = new Array();
Krin.gArray = new Array();
Krin.skinArray = ["ONE","TWO","THREE","FOUR","FIVE","SIX"];
Krin.hairArray = ["","ONE","TWO","THREE","FOUR","FIVE","SIX"];
Krin.gArray = ["M","F"];
Krin.friendArrayX = new Array();
Krin.friendArrayX = [1,2];
Krin.skinSetArray = new Array();
Krin.agMode = new Array();
i = 0;
while(i < 6)
{
   Krin["equipArray" + i] = new Array();
   Krin["StatSets" + i] = new Array();
   Krin["StatSets" + i] = [0,0,0,0,0];
   Krin["PerSets" + i] = new Array();
   Krin["PerSets" + i] = [0,0,0,0,0,0,0,0];
   Krin["DefSets" + i] = new Array();
   Krin["DefSets" + i] = [0,0,0,0,0,0,0,0];
   Krin["equipArray" + i] = [0,0,0,0,0,0,0];
   Krin.ClassStats[i] = 0;
   Krin.LevelStats[i] = 0;
   Krin.NameSets[i] = 0;
   Krin.ExpSets[i] = 0;
   Krin.SkinSet[i] = 0;
   Krin.HairSet[i] = 0;
   Krin.GSet[i] = 0;
   Krin.skinSetArray[i] = 0;
   Krin["agArray" + i] = new Array();
   Krin["agArray" + i] = [25,88,78,55];
   Krin.agMode[i] = 2;
   i++;
}
Krin.NameSets[0] = "Sonny";
Krin.ClassStats[0] = 1;
Krin.LevelStats[0] = 1;
Krin.ExpStats[0] = 0;
Krin.HairSet[0] = 1;
Krin.equipArray0 = [0,0,0,4,8,5,0];
Krin.StatSets0 = [0,5,0,3,0];
Krin.NameSets[1] = "Veradux";
Krin.ClassStats[1] = 5;
Krin.LevelStats[1] = 6;
Krin.ExpStats[1] = 0;
Krin.SkinSet[1] = 1;
Krin.HairSet[1] = 2;
Krin.DefSets1 = [30,30,15,15,15,15,15,15];
Krin.StatSets1 = [20,20,34,22,0];
Krin.equipArray1 = [34,35,36,37,38,31,0];
Krin.NameSets[2] = "Amber";
Krin.ClassStats[2] = 3;
Krin.LevelStats[2] = 12;
Krin.ExpStats[2] = 0;
Krin.GSet[2] = 1;
Krin.SkinSet[2] = 2;
Krin.HairSet[2] = 6;
Krin.NameSets[3] = "Gligus";
Krin.ClassStats[3] = 1;
Krin.LevelStats[3] = 12;
Krin.ExpStats[3] = 0;
Krin.SkinSet[3] = 3;
Krin.HairSet[3] = 0;
Krin.NameSets[4] = "Teco";
Krin.ClassStats[4] = 2;
Krin.LevelStats[4] = 12;
Krin.ExpStats[4] = 0;
Krin.SkinSet[4] = 4;
Krin.HairSet[4] = 4;
Krin.NameSets[5] = "Catelin";
Krin.ClassStats[5] = 4;
Krin.LevelStats[5] = 12;
Krin.GSet[5] = 1;
Krin.SkinSet[5] = 5;
Krin.HairSet[5] = 5;
krinSetShop = function(id)
{
   if(id == 0)
   {
      Krin.dropArray = [6,7,10,11,0,0,0,0,0,0,0,0,0,0,0];
   }
   if(id == 1)
   {
      Krin.dropArray = [27,29,23,22,24,31,26,19,18,16,30,33,0,0,0];
   }
   if(id == 2)
   {
      Krin.dropArray = [64,65,66,67,68,69,70,71,72,73,74,61,48,52,54];
   }
   if(id == 3)
   {
      Krin.dropArray = [82,83,84,85,86,87,88,89,90,91,92,93,0,0,0];
   }
   if(id == 4)
   {
      Krin.dropArray = [94,95,96,97,98,99,100,101,102,103,0,0,0,0,0];
   }
   if(id == 5)
   {
      Krin.dropArray = [104,105,106,107,108,109,110,111,112,113,0,0,0,0,0];
   }
   if(id == 6)
   {
      Krin.dropArray = [151,152,154,157,158,159,0,0,0,0,0,0,0,0,0];
   }
};
var danielas_slot1 = SharedObject.getLocal("danielas_slot1","/");
var danielas_slot2 = SharedObject.getLocal("danielas_slot2","/");
var danielas_slot3 = SharedObject.getLocal("danielas_slot3","/");
var danielas_slot4 = SharedObject.getLocal("danielas_slot4","/");
krinHandleData = function(slotNum)
{
   k_slotter = _root["danielas_slot" + slotNum];
   originalSaveDataKeys = ["respecSet","lastDay2","lastDay1","qual","autoSaver","graphics","sound","sectionIn","progressLevelOn","Euro","Class","Level","skillPoints","statPoints","Exp","STRENGTH","MAGIC","FOCUS","SPEED","LIFE","diff"];
   achivementSingleDataKeys = ["highestZoneDefeated","numberOfRespecUsed","numberOfTrainingUsed","topDamagePhysical","topDamageElemental"];
   saveArray1 = originalSaveDataKeys.concat(achivementSingleDataKeys);
   saveArray2 = ["bgElementsInteracted","agArray0","agArray1","agArray2","agArray3","agArray4","agArray5","agMode","moveMatrix","moveMatrix2","moveMatrix2Limit","talentMainArray","skillAdderMatrix","skillAdderMatrixOld","buffAdderMatrix","itemArray","friendArray","LevelStats","equipArray0","equipArray1","equipArray2","equipArray3","equipArray4","equipArray5","PerSets0","PerSets1","PerSets2","PerSets3","PerSets4","PerSets5","DefSets0","DefSets1","DefSets2","DefSets3","DefSets4","DefSets5","StatSets5","StatSets0","StatSets1","StatSets2","StatSets3","StatSets4","friendArrayX","ExpSets","ClassStats"];
   if(Krin.dataMode == "save")
   {
      classId = Krin.Class;
      playerClassName = _root.KrinLang[KLangChoosen].CLASS[classId];
      savedUserName = "Lvl " + Krin.Level + " " + playerClassName;
      k_slotter.data.nameUser = savedUserName;
      trace("Saving Slot: " + slotNum + " " + savedUserName);
      for(krinf in saveArray1)
      {
         k_slotter.data[saveArray1[krinf]] = _root.Krin[saveArray1[krinf]];
      }
      for(krinh in elementMainArray)
      {
         k_slotter.data.PER = new Object();
         k_slotter.data.PER[elementMainArray[krinh]] = _root.Krin.PER[elementMainArray[krinh]];
         k_slotter.data.DEF = new Object();
         k_slotter.data.DEF[elementMainArray[krinh]] = _root.Krin.DEF[elementMainArray[krinh]];
      }
      for(krinf in saveArray2)
      {
         k_slotter.data[saveArray2[krinf]] = new Array();
         for(kring in _root.Krin[saveArray2[krinf]])
         {
            k_slotter.data[saveArray2[krinf]][kring] = _root.Krin[saveArray2[krinf]][kring];
         }
      }
   }
   else
   {
      Krin.tutSpeecher = true;
      Krin.progressFight = false;
      for(krinf in saveArray1)
      {
         _root.Krin[saveArray1[krinf]] = k_slotter.data[saveArray1[krinf]];
      }
      for(krinh in elementMainArray)
      {
         _root.Krin.PER[elementMainArray[krinh]] = k_slotter.data.PER[elementMainArray[krinh]];
         _root.Krin.DEF[elementMainArray[krinh]] = k_slotter.data.DEF[elementMainArray[krinh]];
      }
      for(krinf in saveArray2)
      {
         for(kring in k_slotter.data[saveArray2[krinf]])
         {
            if(k_slotter.data[saveArray2[krinf]][kring] != undefined)
            {
               _root.Krin[saveArray2[krinf]][kring] = k_slotter.data[saveArray2[krinf]][kring];
            }
         }
      }
      loadTalents(Krin.Class);
   }
   k_slotter.flush();
};
krinNavSpeech = function(speechIDKrin)
{
   if(_root.Krin.PauseForScreen != true)
   {
      _root.Krin.PauseForScreen = true;
      _root.krinNavHideUI(1);
   }
};
krinNavHideUI = function(whatToDo)
{
   if(_root.Krin.PauseForScreen == false)
   {
      _root.krinNavFadeSpeech._visible = true;
      _root.Krin.PauseForScreen = true;
      navTitle = _root.KrinLang[KLangChoosen].NAVTITLE[whatToDo];
      navText = _root.KrinLang[KLangChoosen].NAVTEXT[whatToDo];
   }
   else
   {
      _root.krinNavFadeSpeech._visible = false;
      _root.Krin.PauseForScreen = false;
      navTitle = "";
      navText = "";
   }
};
pggKKuuIIoo = 0;
Krin.bEr = 3;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 4;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 5;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 10;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 16;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 20;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
Krin.bEr = 33;
Krin.progressSpeech[Krin.bEr] = new Array();
Krin.progressSpeech[Krin.bEr][0] = _root.KrinLang[KLangChoosen].NAVTITLE2[pggKKuuIIoo];
Krin.progressSpeech[Krin.bEr][1] = _root.KrinLang[KLangChoosen].NAVTEXT2[pggKKuuIIoo];
pggKKuuIIoo++;
krinNavTutSpeech = function()
{
   if(Krin.tutSpeecher == false)
   {
      Krin.tutSpeecher = true;
      if(Krin.progressSpeech[Krin.progressLevelOn] != 0)
      {
         _root.krinNavFadeSpeech._visible = true;
         _root.Krin.PauseForScreen = true;
         navTitle = Krin.progressSpeech[Krin.progressLevelOn][0];
         navText = Krin.progressSpeech[Krin.progressLevelOn][1];
      }
   }
};
