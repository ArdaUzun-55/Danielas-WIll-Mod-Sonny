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
         if(KrinPVar01 == 1)
         {
            trace("ADDED in CONDITION 1");
         }
      }
      else
      {
         adder = 6;
         if(KrinPVar01 == 1)
         {
            trace("ADDED in CONDITION 2");
         }
      }
   }
   moveBox = adder + _root["playerKrin" + playerID].teamAdder;
   if(KrinPVar01 == 1)
   {
      trace("move BOX " + moveBox);
   }
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
               this.inner.gotoAndPlay(attackType);
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
function krinBoltMake2(shooter, hitter, tColorKrin, projectileModel, boomType, thetimes)
{
   _root.boltMakerCounter += 1;
   _root.BATTLESCREEN.attachMovie(projectileModel,"t" + _root.boltMakerCounter,600 + _root.boltMakerCounter);
   _root.BATTLESCREEN["t" + _root.boltMakerCounter]._x = shooter._x;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter]._y = shooter._y - 15;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].boltMakerCounter = _root.boltMakerCounter;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].boltx = _root.BATTLESCREEN["t" + _root.boltMakerCounter]._x;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].bolty = _root.BATTLESCREEN["t" + _root.boltMakerCounter]._y;
   _root.BATTLESCREEN["t" + _root.boltMakerCounter].SpeedConst = _root.krinBoltSpeed2;
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
      xLPiece = (this.targetMC._x - this.boltx) / _root.krinBoltTime2;
      yLPiece = (this.targetMC._y - this.bolty) / _root.krinBoltTime2;
      this._x += xLPiece * this.SpeedConst;
      this._y += yLPiece * this.SpeedConst;
      this.SpeedConst *= _root.krinBoltIncrease2;
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
         if(thetimes > 1)
         {
            JI = 0;
            while(JI < thetimes)
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
krinBoltTime2 = 15;
krinBoltSpeed2 = 1;
krinBoltIncrease2 = 1.1500000000000001;
krinMeleeAttackCD2 = 15;
krinMeleeAttackEndCD2 = 30;
krinBoltTime = 60;
krinBoltSpeed = 1;
krinBoltIncrease = 1.1500000000000001;
krinBodyMove = 10;
krinMeleeAttackCD = 15;
krinMeleeAttackEndCD = 15;
_root.zoomRatioNEW = 0.4;
KrinSettings = new Object();
_root.boltMakerCounter = 0;
