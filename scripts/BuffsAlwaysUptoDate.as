function addNewBuffKrin(a, b, c)
{
   _root["KRINBUFF" + a] = new Array();
   _root["KRINBUFF" + a][0] = b;
   _root["KRINBUFF" + a][1] = c;
   i = 2;
   while(i < 151)
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
      num = ignoreDefense * (100 + mTarget.plevel * 15) / (mTarget.DEFU[element] * mTarget.DEFENSE);
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
         if(mTarget.LIFEN == 0 && mTarget.LIVINGDEAD == 0)
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
function buffTicker(ukcb3)
{
   _root.buffTickChecker = false;
   totalDmgCalcZ = 0;
   totalFocusCalcZ = ukcb3.DOTTICKERARRAY[10];
   totalDmgCalcZ += ukcb3.DOTTICKERARRAY[9] * ukcb3.HEALMOD_PLUS * ukcb3.HEALMOD_MINUS * ukcb3.IHOT;
   if(totalDmgCalcZ > 0)
   {
      totalDmgCalcZ = 0;
   }
   _root.perKSuccess = false;
   colorChGERUU = 0;
   colorChGERUU2 = 0;
   colorToBe = "Physical";
   vyy = 0;
   while(vyy < 9)
   {
      esogneribhf = Math.ceil((1 + ukcb3.IDMG2) * ukcb3.IDMGP2 * ukcb3.IDOT * (ukcb3.DOTTICKERARRAY[vyy] * ((100 + ukcb3.plevel * 15) / ukcb3.DEFU[elementMainArray[vyy]])));
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
            ukcb3.NODAMAGE = false;
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
   if(ukcb3.FOCUSN < 0)
   {
      ukcb3.FOCUSN = 0;
   }
   if(ukcb3.LIFEN <= 0 && ukcb3.LIVINGDEAD == 0)
   {
      ukcb3.LIFEN = 0;
      ukcb3.FOCUSN = 0;
      _root.BATTLESCREEN["player" + ukcb3.playerID].inner.gotoAndPlay("dead");
      ukcb3.active = false;
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
   else if(ukcb3.LIFEN <= 0 && ukcb3.LIVINGDEAD < 0)
   {
      f = 0;
      while(f < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + ukcb3.BUFFARRAYK[f].buffId][146] != 0 && ukcb3.BUFFARRAYK[f].CD != 0)
         {
            _root.applyBuffKrin(ukcb3,_root["KRINBUFF" + ukcb3.BUFFARRAYK[f].buffId][146],1,ukcb3);
         }
         f++;
      }
      ukcb3.LIFEN = ukcb3.LIFEU;
      ukcb3.LIVINGDEAD += 1;
      if(ukcb3.LIVINGDEAD == 0)
      {
         _root.applyBuffKrin(ukcb3,"FURYPASSIVE2",1,ukcb3);
         _root.applyBuffKrin(ukcb3,"FURYPASSIVE3",1,ukcb3);
         _root.addSound("Effects","Fury");
      }
   }
   applyChangesKrin(ukcb3);
}
function applyBuffKrin(ukcb2, bn, iftbc, ukcb4, debuffValue, limo)
{
   bffker = _root["KRINBUFF" + bn];
   ukcb2.STUN += iftbc * bffker[17];
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
   ukcb2.BLOODYFURY += iftbc * bffker[128];
   ukcb2.CRITMODIFIER += iftbc * bffker[134];
   ukcb2.SLOWRESIST += iftbc * bffker[80];
   ukcb2.IGNORE += iftbc * bffker[81];
   ukcb2.DEFENSE += iftbc * bffker[82];
   ukcb2.LIVINGDEAD += iftbc * bffker[145];
   if(iftbc < 0 && bffker[140] != 0)
   {
      ukcb2.AINEXTATTACK = 0;
   }
   if(iftbc > 0 && bffker[140] != 0)
   {
      ukcb2.AINEXTATTACK = bffker[140];
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
   ukcb2.DOTTICKERARRAY[10] += iftbc * Math.round(bffker[15] * SLOWMOD);
   i = 0;
   while(i < 9)
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
            ukcb2.DOTTICKERARRAY[9] += changerUEOIHN;
         }
         else
         {
            ukcb2.DOTTICKERARRAY[i] += changerUEOIHN;
         }
      }
      i++;
   }
}
function applyChangesKrin(ukcb)
{
   epy = ukcb.changeArray;
   ukcb.STRENGTH += Math.ceil(ukcb.STRENGTHN * (1 + epy[1]));
   ukcb.STRENGTHN = 0;
   ukcb.MAGIC += Math.ceil(ukcb.MAGICN * (1 + epy[3]));
   ukcb.MAGICN = 0;
   ukcb.SPEED += Math.ceil(ukcb.SPEEDN * (1 + epy[5]));
   ukcb.SPEEDN = 0;
   ukcb.STRENGTHU = Math.ceil((ukcb.STRENGTH + epy[0]) * (1 + epy[1]));
   ukcb.MAGICU = Math.ceil((ukcb.MAGIC + epy[2]) * (1 + epy[3]));
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
      ukcb.FOCUSU = ukcb.FOCUS + ukcb.FOCUSCHANGE;
      ukcb.FOCUSN = ukcb.FOCUSU;
      ukcb.FOCUSCHANGE = 0;
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
   while(i < 9)
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
   while(i < 9)
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
   if(ukcb.FILTERSBUFFARRAY[21] > 0)
   {
      statusOfM = "WEREWOLF";
   }
   if(ukcb.FILTERSBUFFARRAY[20] > 0)
   {
      statusOfM = "PRIEST3";
   }
   if(ukcb.FILTERSBUFFARRAY[22] > 0)
   {
      statusOfM = "PRIESTB";
   }
   if(ukcb.FILTERSBUFFARRAY[23] > 0)
   {
      statusOfM = "VILECLAW";
   }
   if(ukcb.FILTERSBUFFARRAY[24] > 0)
   {
      statusOfM = "RANIMUTATE";
   }
   if(ukcb.FILTERSBUFFARRAY[17] > 0)
   {
      statusOfM = "FROSTTERROR";
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
}
function changeForm(changeTo, p_id)
{
   if(changeTo == "BARON")
   {
      dressChar("BARON",p_id,"","MODEL1","ZOMBIE2","M","","XADER2","");
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
   else if(changeTo == "FROSTTERROR")
   {
      dressChar("FROSTTERROR",p_id,"FROST","MODEL1","Frost","M","FROST","FROST","FROST");
   }
   else if(changeTo == "PRIEST3")
   {
      dressChar("PRIEST3",p_id,"PRIEST3","MODEL1","PRIEST3","M","","COUNCILSTAFF","NONE");
   }
   else if(changeTo == "PRIESTB")
   {
      dressChar("PRIESTB",p_id,"PRIESTB","MODEL1","PRIESTB","M","","APOSTLESWORD2","NONE");
   }
   else if(changeTo == "VILECLAW")
   {
      dressChar("",p_id,"","MODELVILECLAW","","M","","","NONE");
   }
   else if(changeTo == "RANIMUTATE")
   {
      dressChar("RANIMUTATE",p_id,"RANIMUTATE","MODEL1","RANIMUTATE","F","","NONE","NONE");
   }
   if(_root["playerKrin" + p_id].STUN)
   {
      _root.BATTLESCREEN["player" + p_id].inner.gotoAndPlay("stun2");
   }
}
function checkStatus(mCaster, mTarget, mAry2, mAry1)
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
   q = 0;
   while(q < _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][132] > 0 && mAry1[14] != "Heal" && mCaster.BUFFARRAYK[q].CD != 0)
      {
         differenceForSH = 0;
         mTarget.BLEED -= _root["KRINBUFF" + mCaster.BUFFARRAYK[q].buffId][132];
      }
      q++;
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
   if(mTarget.LIFEN <= 0 && mTarget.LIVINGDEAD == 0)
   {
      mTarget.LIFEN = 0;
      mTarget.FOCUSN = 0;
      _root.BATTLESCREEN["player" + mTarget.playerID].inner.gotoAndPlay("dead");
      mTarget.active = false;
      wefvergrervw = 1;
      while(wefvergrervw < 7)
      {
         if(mTarget.playerID == _root.Krin.playerNumber)
         {
            if(arenaMode == false)
            {
               _root["KrinSelector" + wefvergrervw]._x = -300;
               _root["KrinSelector" + wefvergrervw]._y = -300;
            }
         }
         if(_root["KrinSelector" + wefvergrervw].TargetEr == mTarget.playerID)
         {
            _root["KrinSelector" + wefvergrervw]._x = -300;
            _root["KrinSelector" + wefvergrervw]._y = -300;
         }
         wefvergrervw++;
      }
      _root.krinAddMove(mTarget.playerID,mTarget.playerID,0);
   }
   else if(mTarget.LIFEN <= 0 && mTarget.LIVINGDEAD < 0)
   {
      f = 0;
      while(f < _root.maxBuffLimit)
      {
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[f].buffId][146] != 0 && mTarget.BUFFARRAYK[f].CD != 0)
         {
            _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mTarget.BUFFARRAYK[f].buffId][146],1,mCaster);
         }
         f++;
      }
      mTarget.LIFEN = mTarget.LIFEU;
      mTarget.LIVINGDEAD += 1;
      if(mTarget.LIVINGDEAD == 0)
      {
         _root.applyBuffKrin(mTarget,"FURYPASSIVE2",1,mCaster);
         _root.applyBuffKrin(mTarget,"FURYPASSIVE3",1,mCaster);
         _root.addSound("Effects","Fury");
      }
      _root.applyChangesKrin(mTarget);
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
   if(mTarget.LIFEN / mTarget.LIFEU < mAry2[65])
   {
      mAry2[45] = 3;
   }
   if(mAry2[76] > 0 && mCaster.NODAMAGE == true)
   {
      mAry2[2] *= 2;
      mAry2[4] *= 2;
   }
   f = 0;
   while(f < _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][70] != 0 && mCaster.BUFFARRAYK[f].CD != 0)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[f].buffId][70],1,mCaster);
         _root.applyChangesKrin(mCaster);
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
            _root.applyChangesKrin(mCaster);
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
   if(mCaster.SPEEDU >= mTarget.SPEEDU && mAry2[85] > 2 && mAry2[85] < 7)
   {
      SE = mAry2[85] - 2;
      mAry2[13] = "SNAKEHEAL" + SE;
   }
   x = 0;
   while(x < _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124] > 0 && (mAry1[0] == _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][125] || mAry1[0] == "Bloodflame Slash") && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mAry2[2] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124];
         if(mAry2[2] == 0 && mAry1[0] != "Bloodflame Slash")
         {
            mAry2[6] *= _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][124];
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
}
function checkBuff(mCaster, mTarget, mAry2, mAry1, FIRE5)
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
   DER = true;
   UN = false;
   x = 0;
   while(x < _root.maxBuffLimit)
   {
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
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][88] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][85] < mCaster.LIFEN / mCaster.LIFEU)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][88],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][114] != 0 && mCaster.BUFFARRAYK[x].CD != 0 && _root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][85] > mCaster.LIFEN / mCaster.LIFEU)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][114],1,mCaster);
      }
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][87] > 0 && mCaster.BUFFARRAYK[x].CD > 0)
      {
         mCaster.BUFFARRAYK[x].CD = 0;
         _root.applyBuffKrin(mCaster,mCaster.BUFFARRAYK[x].buffId,-1,0,mCaster.BUFFARRAYK[x].buffValue,x);
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
         if(_root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][81] < -1 && mTarget.BUFFARRAYK[x].CD != 0)
         {
            G = 0;
            while(G < 3)
            {
               _root["playerKrin" + (mCaster.teamSide + G * 2)].LIFEN -= mTarget.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][81];
               _root.KrinNumberShow(mTarget.STRENGTHU * _root["KRINBUFF" + mTarget.BUFFARRAYK[x].buffId][81] * -1,_root["playerKrin" + (mCaster.teamSide + G * 2)].playerID,"HEAL");
               _root.lifeBarUpdate(_root["playerKrin" + (mCaster.teamSide + G * 2)].playerID);
               G++;
            }
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
               _root.applyBuffKrin(mTarget,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][139],1,mTarget);
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
function checkAbilities(mCaster, mTarget, mAry2, mAry1, FIRE2, FIRE3, FIRE4, FIRE5, FIRE6)
{
   if(mAry2[69] > 0 || mAry2[68] > 0)
   {
      mAry2[2] = FIRE2;
      mAry2[4] = FIRE3;
      mAry2[7] = 0;
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
   if(mAry2[20] > FIRE6)
   {
      mAry2[20] = FIRE6;
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
   if(mAry2[60] > 0 || mAry2[63] > 0)
   {
      mAry2[20] = 0;
      mAry2[45] = 1;
   }
}
function checkBuffAoe(mCaster, mTarget, mAry2, mAry1)
{
}
function checkBuffStun(mCaster, mTarget, mAry2, mAry1)
{
   x = 0;
   while(x < _root.maxBuffLimit)
   {
      if(_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][115] != 0 && mCaster.BUFFARRAYK[x].CD != 0)
      {
         _root.applyBuffKrin(mCaster,_root["KRINBUFF" + mCaster.BUFFARRAYK[x].buffId][115],1,mCaster);
         _root.applyChangesKrin(mCaster);
      }
      x++;
   }
}
_root.maxBuffLimit = 50;
BUFF_NAME = _root.KrinLang[KLangChoosen].AU;
BUFF_DESC1 = _root.KrinLang[KLangChoosen].AUX1;
BUFF_DESC2 = _root.KrinLang[KLangChoosen].AUX2;
BUFF_DESC3 = _root.KrinLang[KLangChoosen].AUX3;
BUFF_DESC4 = _root.KrinLang[KLangChoosen].AUX4;
addNewBuffKrin("TWINGUARDIANS",BUFF_NAME[385],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[19] = 5000;
_root.hackMove2[14] = -300;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[385];
addNewBuffKrin("FIRESAM",BUFF_NAME[386],"Fire");
_root.hackMove2[16] = 99;
_root.hackMove2[15] = -12;
_root.hackMove2[12] = -5000;
_root.hackMove2[14] = -300;
_root.hackMove2[25] = BUFF_DESC1[386];
addNewBuffKrin("FIRESAM2",BUFF_NAME[387],"Fire");
_root.hackMove2[16] = 15;
_root.hackMove2[14] = 50;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[387];
addNewBuffKrin("FINAL_FLAWED",BUFF_NAME[388],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[14] = 600;
_root.hackMove2[13] = 10;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[388];
addNewBuffKrin("FINAL_RESTRAINT",BUFF_NAME[389],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[10] = -4300;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[389];
addNewBuffKrin("FINAL_SALV",BUFF_NAME[390],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[14] = -8000;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[390];
addNewBuffKrin("FINAL_WRATH",BUFF_NAME[391],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[10] = 5000;
_root.hackMove2[12] = -10000;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 19;
_root.hackMove2[25] = BUFF_DESC1[391];
addNewBuffKrin("FATE",BUFF_NAME[376],"Physical");
_root.hackMove2[16] = 9;
_root.hackMove2[14] = 666;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[376];
addNewBuffKrin("SHELLAURA",BUFF_NAME[377],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[13] = -0.9500000000000001;
_root.hackMove2[36] = 0.9500000000000001;
_root.hackMove2[25] = BUFF_DESC1[377];
addNewBuffKrin("DARKOMEN",BUFF_NAME[378],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[12] = 700;
_root.hackMove2[10] = 9999;
_root.hackMove2[25] = BUFF_DESC1[378];
addNewBuffKrin("PREFATE",BUFF_NAME[379],"Poison");
_root.hackMove2[16] = 9;
_root.hackMove2[27] = 1;
_root.hackMove2[48] = 15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[379];
addNewBuffKrin("APPREHEND",BUFF_NAME[380],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[380];
addNewBuffKrin("PURSUIT",BUFF_NAME[381],"Ice");
_root.hackMove2[7] = 2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[381];
addNewBuffKrin("SOLIDEVIDENCE",BUFF_NAME[382],"Physical");
_root.hackMove2[46] = 2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[382];
addNewBuffKrin("INVESTIGATE",BUFF_NAME[383],"Shadow");
_root.hackMove2[12] = 200;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[383];
addNewBuffKrin("PERSECUTE",BUFF_NAME[384],"Ice");
_root.hackMove2[14] = 500;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[384];
addNewBuffKrin("BESEATED",BUFF_NAME[335],"Magic");
_root.hackMove2[13] = 1.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[335];
addNewBuffKrin("AMEND",BUFF_NAME[374],"Magic");
_root.hackMove2[15] = -700;
_root.hackMove2[16] = 99;
_root.hackMove2[25] = BUFF_DESC1[374];
addNewBuffKrin("VETO",BUFF_NAME[373],"Magic");
_root.hackMove2[19] = 3000;
_root.hackMove2[14] = -300;
_root.hackMove2[16] = 99;
_root.hackMove2[25] = BUFF_DESC1[373];
addNewBuffKrin("FORCEOFLAW",BUFF_NAME[338],"Magic");
_root.hackMove2[7] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[338] + _root.hackMove2[7] * 100 + BUFF_DESC2[338];
addNewBuffKrin("FORCEOFJUSTICE",BUFF_NAME[339],"Magic");
_root.hackMove2[5] = 0.3;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[339] + _root.hackMove2[5] * 100 + BUFF_DESC2[339];
addNewBuffKrin("INCONTEMPT",BUFF_NAME[340],"Magic");
_root.hackMove2[29] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[340] + _root.hackMove2[29] * 100 + BUFF_DESC2[340];
addNewBuffKrin("SPEAKINGPRIVILAGES",BUFF_NAME[341],"Magic");
_root.hackMove2[11] = 1.5;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[341];
addNewBuffKrin("CONDEMN",BUFF_NAME[342],"Magic");
_root.hackMove2[29] = 0.5;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[342] + _root.hackMove2[29] * 100 + BUFF_DESC2[342];
addNewBuffKrin("SENTENCE",BUFF_NAME[343],"Magic");
_root.hackMove2[11] = -0.8;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[343];
addNewBuffKrin("JUDGESHAMMER",BUFF_NAME[344],"Magic");
_root.hackMove2[9] = -0.15;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[344] + _root.hackMove2[9] * -100 + BUFF_DESC2[344];
addNewBuffKrin("JUSTICEDONE",BUFF_NAME[345],"Magic");
_root.hackMove2[29] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[345];
addNewBuffKrin("JUSTICEBEDONE",BUFF_NAME[346],"Magic");
_root.hackMove2[36] = 0.3;
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[346];
addNewBuffKrin("MAYORSENVOY",BUFF_NAME[347],"Shadow");
_root.hackMove2[3] = 10;
_root.hackMove2[5] = 10;
_root.hackMove2[7] = 10;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[347];
addNewBuffKrin("DISLOYALTY",BUFF_NAME[348],"Magic");
_root.hackMove2[29] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[348] + _root.hackMove2[29] * 100 + BUFF_DESC2[348];
addNewBuffKrin("PLEBIAN",BUFF_NAME[349],"Physical");
_root.hackMove2[13] = -0.2;
_root.hackMove2[36] = 0.8;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[349];
addNewBuffKrin("SERVILE",BUFF_NAME[350],"Physical");
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[350] + _root.hackMove2[7] * -100 + BUFF_DESC2[350];
addNewBuffKrin("HONORDUTY",BUFF_NAME[351],"Physical");
_root.hackMove2[11] = 0.3;
_root.hackMove2[13] = -0.2;
_root.hackMove2[15] = -5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[351];
addNewBuffKrin("EXECUTIVEORDER",BUFF_NAME[352],"Physical");
_root.hackMove2[23] = -0.2;
_root.hackMove2[24] = -0.6;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[352];
addNewBuffKrin("STEWARD",BUFF_NAME[353],"Shadow");
_root.hackMove2[39] = 5;
_root.hackMove2[11] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[353];
addNewBuffKrin("PRESTIGE",BUFF_NAME[375],"Magic");
_root.hackMove2[10] = 5000;
_root.hackMove2[16] = 15;
_root.hackMove2[25] = BUFF_DESC1[375];
addNewBuffKrin("DONUTS",BUFF_NAME[355],"Magic");
_root.hackMove2[33] = -0.03;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[355] + _root.hackMove2[33] * -100 + BUFF_DESC2[355];
addNewBuffKrin("SWEEPCLEAN",BUFF_NAME[356],"Magic");
_root.hackMove2[15] = -10;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[356] + _root.hackMove2[15] * -1 + BUFF_DESC2[356];
addNewBuffKrin("SECURITYMEASURES",BUFF_NAME[357],"Magic");
_root.hackMove2[46] = -0.4;
_root.hackMove2[35] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[357] + _root.hackMove2[35] * 100 + BUFF_DESC2[357];
addNewBuffKrin("FREEZEPOLICE",BUFF_NAME[358],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[358];
addNewBuffKrin("PLANNEDASSAULT",BUFF_NAME[359],"Physical");
_root.hackMove2[28] = 0.6;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[359] + _root.hackMove2[28] * 100 + BUFF_DESC2[359];
addNewBuffKrin("PREPARATION",BUFF_NAME[360],"Earth");
_root.hackMove2[11] = 4;
_root.hackMove2[16] = 4;
_root.hackMove2[31] = 18;
_root.hackMove2[25] = BUFF_DESC1[360] + _root.hackMove2[11] * 100 + BUFF_DESC2[360];
addNewBuffKrin("HEAVYGUNS",BUFF_NAME[361],"Earth");
_root.hackMove2[13] = 4;
_root.hackMove2[16] = 4;
_root.hackMove2[31] = 8;
_root.hackMove2[25] = BUFF_DESC1[361] + _root.hackMove2[13] * 100 + BUFF_DESC2[361];
addNewBuffKrin("COVERFIRE2",BUFF_NAME[362],"Fire");
_root.hackMove2[28] = 1.1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[362] + _root.hackMove2[28] * 100 + BUFF_DESC2[362];
addNewBuffKrin("SEEKDESTROY",BUFF_NAME[363],"Physical");
_root.hackMove2[23] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[363] + _root.hackMove2[23] * 100 + BUFF_DESC2[363];
addNewBuffKrin("MAYORENRAGE",BUFF_NAME[364],"Earth");
_root.hackMove2[11] = 1.5;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 7;
_root.hackMove2[25] = BUFF_DESC1[364];
addNewBuffKrin("TEAMSACRIFICE",BUFF_NAME[365],"Lightning");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[35] = 3;
_root.hackMove2[11] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[365];
addNewBuffKrin("BLOCKHEALING",BUFF_NAME[366],"Lightning");
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 18;
_root.hackMove2[25] = BUFF_DESC1[366];
addNewBuffKrin("BLOCKDAMAGE",BUFF_NAME[367],"Lightning");
_root.hackMove2[11] = -0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[13] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[31] = 8;
_root.hackMove2[25] = BUFF_DESC1[367];
addNewBuffKrin("MAGISTRATE",BUFF_NAME[368],"Lightning");
_root.hackMove2[15] = -7;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[368] + _root.hackMove2[15] * -1 + BUFF_DESC2[368];
addNewBuffKrin("JUSTICE",BUFF_NAME[369],"Lightning");
_root.hackMove2[5] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[24] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[369] + _root.hackMove2[5] * 100 + BUFF_DESC2[369];
addNewBuffKrin("PEACE",BUFF_NAME[370],"Lightning");
_root.hackMove2[29] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[370];
addNewBuffKrin("UNITY",BUFF_NAME[371],"Lightning");
_root.hackMove2[46] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[371];
addNewBuffKrin("EQUALITY",BUFF_NAME[372],"Lightning");
_root.hackMove2[47] = -0.9000000000000002;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[372];
addNewBuffKrin("BLEED",BUFF_NAME[300],"Physical");
_root.hackMove2[28] = 1.1300000000000001;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[300] + _root.hackMove2[28] * 100 + BUFF_DESC2[300];
addNewBuffKrin("RABIES",BUFF_NAME[301],"Physical");
_root.hackMove2[3] = 0.3;
_root.hackMove2[5] = -0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[301] + _root.hackMove2[3] * 100 + BUFF_DESC2[301];
addNewBuffKrin("OVEREXERTION",BUFF_NAME[302],"Physical");
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[302] + _root.hackMove2[13] * 100 + BUFF_DESC2[302];
addNewBuffKrin("DEBILITATED",BUFF_NAME[303],"Physical");
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[303];
addNewBuffKrin("CARETAKER",BUFF_NAME[304],"Magic");
_root.hackMove2[28] = -1.3000000000000005;
_root.hackMove2[15] = -10;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.75;
_root.hackMove2[25] = BUFF_DESC1[304];
addNewBuffKrin("SIC",BUFF_NAME[305],"Magic");
_root.hackMove2[11] = 0.35000000000000003;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[305];
addNewBuffKrin("WHIPLASH",BUFF_NAME[306],"Physical");
_root.hackMove2[28] = 0.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[306] + _root.hackMove2[28] * 100 + BUFF_DESC2[306];
addNewBuffKrin("PUNISH",BUFF_NAME[307],"Physical");
_root.hackMove2[36] = 0.35000000000000003;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[307];
addNewBuffKrin("CHARGING",BUFF_NAME[308],"Fire");
_root.hackMove2[15] = -12;
_root.hackMove2[16] = 3;
_root.hackMove2[9] = -0.02;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[308];
addNewBuffKrin("SHIELDSTR",BUFF_NAME[309],"Magic");
_root.hackMove2[38] = 40;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[309];
addNewBuffKrin("SHIELDMG",BUFF_NAME[310],"Magic");
_root.hackMove2[39] = 20;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[310];
addNewBuffKrin("IRONFIST",BUFF_NAME[311],"Physical");
_root.hackMove2[3] = -0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[311] + _root.hackMove2[3] * -100 + BUFF_DESC2[311];
addNewBuffKrin("SPIRITFIST",BUFF_NAME[312],"Magic");
_root.hackMove2[5] = -0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[312] + _root.hackMove2[5] * -100 + BUFF_DESC2[312];
addNewBuffKrin("ANALYSIS",BUFF_NAME[313],"Magic");
_root.hackMove2[12] = 120;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[313];
addNewBuffKrin("BURNING",BUFF_NAME[314],"Fire");
_root.hackMove2[30] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[314] + _root.hackMove2[30] * -100 + BUFF_DESC2[314];
addNewBuffKrin("DISTRACT",BUFF_NAME[315],"Physical");
_root.hackMove2[15] = 20;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[315] + _root.hackMove2[15] + BUFF_DESC2[315] + _root.hackMove2[24] * -100 + BUFF_DESC3[315];
addNewBuffKrin("ICHLOROFORM",BUFF_NAME[316],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = 3;
_root.hackMove2[24] = -0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[316];
addNewBuffKrin("IDIGITALIS",BUFF_NAME[317],"Poison");
_root.hackMove2[30] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[317] + _root.hackMove2[30] * 100 + BUFF_DESC2[317];
addNewBuffKrin("IRICIN",BUFF_NAME[318],"Poison");
_root.hackMove2[7] = -0.4;
_root.hackMove2[9] = -0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[318] + _root.hackMove2[7] * -100 + BUFF_DESC2[318] + _root.hackMove2[9] * -100 + BUFF_DESC3[318];
addNewBuffKrin("ICYANIDE",BUFF_NAME[319],"Poison");
_root.hackMove2[45] = 0.04;
_root.hackMove2[37] = -0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[319] + _root.hackMove2[45] * 100 + BUFF_DESC2[319] + _root.hackMove2[37] * -100 + BUFF_DESC3[319];
addNewBuffKrin("IANTIDOTE",BUFF_NAME[320],"Poison");
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[320];
addNewBuffKrin("SPBODYARMOUR",BUFF_NAME[321],"Physical");
_root.hackMove2[13] = -0.25;
_root.hackMove2[24] = 0.3;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.6;
_root.hackMove2[25] = BUFF_DESC1[321];
addNewBuffKrin("SPASSAULTTACTICS",BUFF_NAME[322],"Physical");
_root.hackMove2[11] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[322] + _root.hackMove2[11] * 100 + BUFF_DESC2[322];
addNewBuffKrin("SPFORCEFULENTRY",BUFF_NAME[323],"Physical");
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[13] = 0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[323];
addNewBuffKrin("SPEXPOSE",BUFF_NAME[324],"Physical");
_root.hackMove2[11] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[324] + _root.hackMove2[11] * 100 + BUFF_DESC2[324];
addNewBuffKrin("PFIRSTAID",BUFF_NAME[325],"Physical");
_root.hackMove2[33] = -0.08;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[325];
addNewBuffKrin("PSURPRISESHOT",BUFF_NAME[326],"Physical");
_root.hackMove2[7] = -0.7000000000000001;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[326];
addNewBuffKrin("PPEPPERSPRAY",BUFF_NAME[327],"Poison");
_root.hackMove2[3] = -0.5;
_root.hackMove2[5] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[327] + _root.hackMove2[3] * -100 + BUFF_DESC2[327];
addNewBuffKrin("PNIGHTSTICK",BUFF_NAME[328],"Physical");
_root.hackMove2[28] = 1.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[328];
addNewBuffKrin("PSETUP",BUFF_NAME[329],"Physical");
_root.hackMove2[46] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[329] + _root.hackMove2[46] * 100 + BUFF_DESC2[329];
addNewBuffKrin("SPERFECTAIM",BUFF_NAME[330],"Physical");
_root.hackMove2[11] = 1.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[330];
addNewBuffKrin("SSHRAPNEL",BUFF_NAME[331],"Fire");
_root.hackMove2[45] = 0.04;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[331];
addNewBuffKrin("SRECOVERY",BUFF_NAME[332],"Physical");
_root.hackMove2[46] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[332];
addNewBuffKrin("SCOVERFIRE",BUFF_NAME[333],"Physical");
_root.hackMove2[11] = -0.7000000000000001;
_root.hackMove2[48] = -0.7000000000000001;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[333];
addNewBuffKrin("SHUTOFF",BUFF_NAME[334],"Physical");
_root.hackMove2[13] = 6;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[334];
addNewBuffKrin("BURNINGACID",BUFF_NAME[209],"Fire");
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[209] + _root.hackMove2[24] * -100 + BUFF_DESC2[209];
addNewBuffKrin("EPIN",BUFF_NAME[210],"Poison");
_root.hackMove2[35] = 0.15;
_root.hackMove2[11] = 0.15;
_root.hackMove2[44] = 1.2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[210] + _root.hackMove2[35] * 100 + BUFF_DESC2[210] + _root.hackMove2[44] * 100 + BUFF_DESC3[210];
addNewBuffKrin("HEARTATTACK",BUFF_NAME[211],"Physical");
_root.hackMove2[46] = 3;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[211] + _root.hackMove2[46] * 100 + BUFF_DESC2[211];
addNewBuffKrin("POTENTTOXIN",BUFF_NAME[212],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = -0.9000000000000002;
_root.hackMove2[36] = 0.9000000000000002;
_root.hackMove2[45] = 0.7000000000000001;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[212] + _root.hackMove2[45] * 10 + BUFF_DESC2[212];
addNewBuffKrin("FIREBURN",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("JUGULARGRASP",BUFF_NAME[180],"Physical");
_root.hackMove2[24] = -0.8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[180] + _root.hackMove2[24] * -100 + BUFF_DESC2[180];
addNewBuffKrin("PITY2",BUFF_NAME[181],"Magic");
_root.hackMove2[11] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[181] + _root.hackMove2[11] * -100 + BUFF_DESC2[181];
addNewBuffKrin("APPLETHROW",BUFF_NAME[182],"Poison");
_root.hackMove2[29] = 1.2;
_root.hackMove2[7] = -0.6;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[182] + _root.hackMove2[29] * 100 + BUFF_DESC2[182];
addNewBuffKrin("ROACHVITALITY",BUFF_NAME[183],"Poison");
_root.hackMove2[33] = -0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[183] + _root.hackMove2[33] * -100 + BUFF_DESC2[183];
addNewBuffKrin("FLOWERPOWER",BUFF_NAME[184],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[184];
addNewBuffKrin("PERFUME",BUFF_NAME[185],"Poison");
_root.hackMove2[42] = 0.7000000000000001;
_root.hackMove2[43] = 0.7000000000000001;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[24] = -0.25;
_root.hackMove2[25] = BUFF_DESC1[185] + _root.hackMove2[42] * 100 + BUFF_DESC2[185];
addNewBuffKrin("PEACEANDLOVE",BUFF_NAME[186],"Poison");
_root.hackMove2[13] = -0.75;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[186] + _root.hackMove2[13] * -100 + BUFF_DESC2[186];
addNewBuffKrin("GOODTRIP",BUFF_NAME[187],"Poison");
_root.hackMove2[15] = -15;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[33] = -0.15;
_root.hackMove2[25] = BUFF_DESC1[187];
addNewBuffKrin("BADTRIP",BUFF_NAME[188],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[17] = 1;
_root.hackMove2[25] = BUFF_DESC1[188];
addNewBuffKrin("FEELDAREGGAE",BUFF_NAME[189],"Magic");
_root.hackMove2[35] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[189];
addNewBuffKrin("TIEDYE",BUFF_NAME[190],"Poison");
_root.hackMove2[26] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = -0.5;
_root.hackMove2[36] = 0.5;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[190];
addNewBuffKrin("BANANALURE",BUFF_NAME[191],"Magic");
_root.hackMove2[11] = -0.3;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[191] + _root.hackMove2[11] * -100 + BUFF_DESC2[191];
addNewBuffKrin("SPIRE",BUFF_NAME[192],"Earth");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[192];
addNewBuffKrin("VULPESDOLOSUS",BUFF_NAME[193],"Physical");
_root.hackMove2[13] = -0.9500000000000001;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[193];
addNewBuffKrin("FOXFORM",BUFF_NAME[208],"Physical");
_root.hackMove2[31] = 16;
_root.hackMove2[9] = 10;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[208];
addNewBuffKrin("LUPINEBLEED",BUFF_NAME[194],"Physical");
_root.hackMove2[28] = 1.2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[194] + _root.hackMove2[28] * 100 + BUFF_DESC2[194];
addNewBuffKrin("INFECTEDWOUND",BUFF_NAME[195],"Poison");
_root.hackMove2[36] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[195] + _root.hackMove2[36] * 100 + BUFF_DESC2[195];
addNewBuffKrin("CUNNINGGAMBIT",BUFF_NAME[196],"Physical");
_root.hackMove2[3] = 0.3;
_root.hackMove2[9] = -0.35000000000000003;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[196];
addNewBuffKrin("HOLYHANDGRENADEOFANTIOCH",BUFF_NAME[197],"Magic");
_root.hackMove2[13] = 4;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[197];
addNewBuffKrin("FUZZYINSIDE",BUFF_NAME[198],"Magic");
_root.hackMove2[47] = 0.2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[198] + _root.hackMove2[47] * 100 + BUFF_DESC2[198];
addNewBuffKrin("VICIOUSPAWS",BUFF_NAME[199],"Physical");
_root.hackMove2[7] = -0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[199] + _root.hackMove2[7] * -100 + BUFF_DESC2[199];
addNewBuffKrin("FAILINGCOURAGE",BUFF_NAME[200],"Magic");
_root.hackMove2[42] = 0.4500000000000001;
_root.hackMove2[16] = 5;
_root.hackMove2[43] = 0.4500000000000001;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[200];
addNewBuffKrin("INCONSPICUOUS",BUFF_NAME[201],"Physical");
_root.hackMove2[23] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[201] + _root.hackMove2[23] * -100 + BUFF_DESC2[201];
addNewBuffKrin("WEREWOLF",BUFF_NAME[202],"Poison");
_root.hackMove2[10] = 6000;
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 21;
_root.hackMove2[25] = BUFF_DESC1[202];
addNewBuffKrin("RAKE",BUFF_NAME[203],"Physical");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[203] + _root.hackMove2[28] * 100 + BUFF_DESC2[203];
addNewBuffKrin("CANINEINSTINCTS",BUFF_NAME[204],"Physical");
_root.hackMove2[3] = 0.25;
_root.hackMove2[7] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[204];
addNewBuffKrin("HOWLOFTHEANCESTORS",BUFF_NAME[205],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[205];
addNewBuffKrin("IRONJAWS",BUFF_NAME[206],"Ice");
_root.hackMove2[13] = 0.15;
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[206] + _root.hackMove2[7] * -100 + BUFF_DESC2[206];
addNewBuffKrin("WICKEDCLAWS",BUFF_NAME[207],"Ice");
_root.hackMove2[24] = -0.1;
_root.hackMove2[37] = -0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[207];
addNewBuffKrin("SUPRESSION",BUFF_NAME[156],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.7000000000000001;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[156];
addNewBuffKrin("BLADESHIELD",BUFF_NAME[117],"Physical");
_root.hackMove2[40] = 10;
_root.hackMove2[135] = "BLADESHIELD2";
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[117];
addNewBuffKrin("COLDSTEEL",BUFF_NAME[116],"Physical");
_root.hackMove2[36] = 0.9500000000000001;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[116];
addNewBuffKrin("SERIOUS",BUFF_NAME[115],"Physical");
_root.hackMove2[11] = 0.5;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[115];
addNewBuffKrin("KNIFEFACE",BUFF_NAME[114],"Physical");
_root.hackMove2[7] = 0.5;
_root.hackMove2[15] = 10;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[114];
addNewBuffKrin("DOCSHELL",BUFF_NAME[113],"Shadow");
_root.hackMove2[11] = 0.2;
_root.hackMove2[13] = 2;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[113];
addNewBuffKrin("MUTATION",BUFF_NAME[112],"Physical");
_root.hackMove2[11] = 1.3000000000000005;
_root.hackMove2[16] = 99;
_root.hackMove2[15] = -40;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 9;
_root.hackMove2[25] = BUFF_DESC1[112];
addNewBuffKrin("ICYDOOM",BUFF_NAME[92],"Ice");
_root.hackMove2[3] = 0.4;
_root.hackMove2[5] = 0.4;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[92];
addNewBuffKrin("LIQUIDVEINS",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.2;
_root.hackMove2[35] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[88] + _root.hackMove2[46] * 100 + BUFF_DESC2[88];
addNewBuffKrin("ICYBLOOD",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("RECUPERATE",BUFF_NAME[90],"Ice");
_root.hackMove2[33] = -0.14;
_root.hackMove2[3] = -0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[5] = -0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[90];
addNewBuffKrin("SOULSTRIKE",BUFF_NAME[72],"Ice");
_root.hackMove2[28] = 0.6;
_root.hackMove2[30] = 0.6;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[72] + _root.hackMove2[28] * 100 + BUFF_DESC2[72];
addNewBuffKrin("ICYRAGE",BUFF_NAME[73],"Ice");
_root.hackMove2[48] = 0.33000000000000007;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[73] + _root.hackMove2[48] * 100 + BUFF_DESC2[73];
addNewBuffKrin("SANCTIFIEDARMOUR",BUFF_NAME[74],"Physical");
_root.hackMove2[13] = -0.2;
_root.hackMove2[35] = 0.3;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[74] + _root.hackMove2[13] * -100 + BUFF_DESC2[74] + _root.hackMove2[35] * 100 + BUFF_DESC3[74];
addNewBuffKrin("BLOCK",BUFF_NAME[75],"Physical");
_root.hackMove2[38] = 4.5;
_root.hackMove2[19] = 10;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[75] + _root.hackMove2[38] * 100 + BUFF_DESC2[75];
addNewBuffKrin("BLOODOFTHEENEMY",BUFF_NAME[76],"Physical");
_root.hackMove2[35] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[76] + _root.hackMove2[35] * 100 + BUFF_DESC2[76];
addNewBuffKrin("AGGRAVATE",BUFF_NAME[77],"Physical");
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[77];
addNewBuffKrin("DISARM",BUFF_NAME[78],"Physical");
_root.hackMove2[11] = -0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[78];
addNewBuffKrin("GUARDIAN",BUFF_NAME[79],"Physical");
_root.hackMove2[38] = 20;
_root.hackMove2[19] = 10;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[79];
addNewBuffKrin("MEND",BUFF_NAME[80],"Magic");
_root.hackMove2[29] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[80] + _root.hackMove2[29] * -100 + BUFF_DESC2[80];
addNewBuffKrin("LIGHTSWILL",BUFF_NAME[81],"Magic");
_root.hackMove2[37] = 0.25;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[81] + _root.hackMove2[37] * 100 + BUFF_DESC2[81];
addNewBuffKrin("PRAYER",BUFF_NAME[82],"Physical");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[82] + _root.hackMove2[15] * -1 + BUFF_DESC2[82];
addNewBuffKrin("ENERGYDRAIN",BUFF_NAME[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[83] + _root.hackMove2[15] + BUFF_DESC2[83];
addNewBuffKrin("ZAP",BUFF_NAME[84],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[84] + _root.hackMove2[15] * -1 + BUFF_DESC2[84];
addNewBuffKrin("HEAVYBURNS",BUFF_NAME[85],"Fire");
_root.hackMove2[13] = 1;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[85] + _root.hackMove2[13] * 100 + BUFF_DESC2[85];
addNewBuffKrin("DOOM",BUFF_NAME[86],"Shadow");
_root.hackMove2[36] = 0.7000000000000001;
_root.hackMove2[16] = 3;
_root.hackMove2[29] = 1.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[86] + _root.hackMove2[36] * 100 + BUFF_DESC2[86];
addNewBuffKrin("ENERGYPHASE",BUFF_NAME[87],"Lightning");
_root.hackMove2[11] = 1;
_root.hackMove2[13] = 1;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[87] + _root.hackMove2[11] * 100 + BUFF_DESC2[87];
addNewBuffKrin("SHADOWFEEDBACK",BUFF_NAME[72],"Shadow");
_root.hackMove2[33] = -0.15;
_root.hackMove2[16] = 1;
_root.hackMove2[25] = BUFF_DESC1[72];
addNewBuffKrin("SHADOWINFUSION",BUFF_NAME[71],"Shadow");
_root.hackMove2[15] = -15;
_root.hackMove2[29] = 0.3;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[71];
addNewBuffKrin("WRAITHFORM",BUFF_NAME[70],"Lightning");
_root.hackMove2[7] = 4;
_root.hackMove2[16] = 5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[31] = 14;
_root.hackMove2[25] = BUFF_DESC1[70];
addNewBuffKrin("RETROGRADED",BUFF_NAME[69],"Shadow");
_root.hackMove2[26] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[69];
addNewBuffKrin("ECHOEDSCREAMS1",BUFF_NAME[45],"Shadow");
_root.hackMove2[13] = 0.06;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[45] + _root.hackMove2[13] * 100 + BUFF_DESC2[45];
addNewBuffKrin("ECHOEDSCREAMS2",BUFF_NAME[45],"Shadow");
_root.hackMove2[13] = 0.12;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[45] + _root.hackMove2[13] * 100 + BUFF_DESC2[45];
addNewBuffKrin("ECHOEDSCREAMS3",BUFF_NAME[45],"Shadow");
_root.hackMove2[13] = 0.18;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[45] + _root.hackMove2[13] * 100 + BUFF_DESC2[45];
addNewBuffKrin("ECHOEDSCREAMS4",BUFF_NAME[45],"Shadow");
_root.hackMove2[13] = 0.24;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[45] + _root.hackMove2[13] * 100 + BUFF_DESC2[45];
addNewBuffKrin("PLACEBO1",BUFF_NAME[46],"Shadow");
_root.hackMove2[3] = -0.04;
_root.hackMove2[5] = -0.04;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[46] + _root.hackMove2[3] * -100 + BUFF_DESC2[46];
addNewBuffKrin("PLACEBO2",BUFF_NAME[46],"Shadow");
_root.hackMove2[3] = -0.07;
_root.hackMove2[5] = -0.07;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[46] + _root.hackMove2[3] * -100 + BUFF_DESC2[46];
addNewBuffKrin("PLACEBO3",BUFF_NAME[46],"Shadow");
_root.hackMove2[3] = -0.1;
_root.hackMove2[5] = -0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[46] + _root.hackMove2[3] * -100 + BUFF_DESC2[46];
addNewBuffKrin("PLACEBO4",BUFF_NAME[46],"Shadow");
_root.hackMove2[3] = -0.13;
_root.hackMove2[5] = -0.13;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[46] + _root.hackMove2[3] * -100 + BUFF_DESC2[46];
addNewBuffKrin("PARALYSIS1",BUFF_NAME[47],"Shadow");
_root.hackMove2[7] = -0.06;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[47] + _root.hackMove2[7] * -100 + BUFF_DESC2[47];
addNewBuffKrin("PARALYSIS2",BUFF_NAME[47],"Shadow");
_root.hackMove2[7] = -0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[47] + _root.hackMove2[7] * -100 + BUFF_DESC2[47];
addNewBuffKrin("PARALYSIS3",BUFF_NAME[47],"Shadow");
_root.hackMove2[7] = -0.14;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[47] + _root.hackMove2[7] * -100 + BUFF_DESC2[47];
addNewBuffKrin("PARALYSIS4",BUFF_NAME[47],"Shadow");
_root.hackMove2[7] = -0.18;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[47] + _root.hackMove2[7] * -100 + BUFF_DESC2[47];
addNewBuffKrin("SCHADENFREUDE1",BUFF_NAME[48],"Shadow");
_root.hackMove2[29] = -0.6;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[48] + _root.hackMove2[29] * -100 + BUFF_DESC2[48];
addNewBuffKrin("SCHADENFREUDE2",BUFF_NAME[48],"Shadow");
_root.hackMove2[29] = -0.8;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[48] + _root.hackMove2[29] * -100 + BUFF_DESC2[48];
addNewBuffKrin("SCHADENFREUDE3",BUFF_NAME[48],"Shadow");
_root.hackMove2[29] = -1;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[48] + _root.hackMove2[29] * -100 + BUFF_DESC2[48];
addNewBuffKrin("SCHADENFREUDE4",BUFF_NAME[48],"Shadow");
_root.hackMove2[29] = -1.2;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[48] + _root.hackMove2[29] * -100 + BUFF_DESC2[48];
addNewBuffKrin("EMPOWERED1",BUFF_NAME[49],"Physical");
_root.hackMove2[11] = 0.15;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[49] + _root.hackMove2[11] * 100 + BUFF_DESC2[49];
addNewBuffKrin("EMPOWERED2",BUFF_NAME[49],"Physical");
_root.hackMove2[11] = 0.22;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 11;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[49] + _root.hackMove2[11] * 100 + BUFF_DESC2[49];
addNewBuffKrin("EMPOWERED3",BUFF_NAME[49],"Physical");
_root.hackMove2[11] = 0.29000000000000004;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 13;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[49] + _root.hackMove2[11] * 100 + BUFF_DESC2[49];
addNewBuffKrin("EMPOWERED4",BUFF_NAME[49],"Physical");
_root.hackMove2[11] = 0.36;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 15;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[49] + _root.hackMove2[11] * 100 + BUFF_DESC2[49];
addNewBuffKrin("BETRAYALSREWARD1",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -2.600000000000001;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BLOODFLAMESHADOWREGEN",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -12;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BLOODFLAMESHADOWREGEN2",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -7;
_root.hackMove2[28] = -7;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD2",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -3.12;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD2B",BUFF_NAME[50],"Blackflame");
_root.hackMove2[28] = -2.5;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD2B2",BUFF_NAME[50],"Blackflame");
_root.hackMove2[29] = -2.5;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD2B3",BUFF_NAME[50],"Blackflame");
_root.hackMove2[29] = -5;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD3",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -3.68;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("BETRAYALSREWARD4",BUFF_NAME[50],"Shadow");
_root.hackMove2[29] = -4.280000000000001;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[29] * -100 + BUFF_DESC2[50];
addNewBuffKrin("SHOCKTRAUMA1",BUFF_NAME[51],"Shadow");
_root.hackMove2[17] = 1;
_root.hackMove2[15] = 10;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[51] + _root.hackMove2[15] * 1 + BUFF_DESC2[51];
addNewBuffKrin("SHATTERBOLT",BUFF_NAME[91],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[31] = 2;
_root.hackMove2[25] = BUFF_DESC1[91];
addNewBuffKrin("SHOCKTRAUMA2",BUFF_NAME[51],"Shadow");
_root.hackMove2[17] = 1;
_root.hackMove2[15] = 15;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[51] + _root.hackMove2[15] * 1 + BUFF_DESC2[51];
addNewBuffKrin("WILLPOWER1",BUFF_NAME[52],"Shadow");
_root.hackMove2[39] = 2;
_root.hackMove2[29] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[52] + _root.hackMove2[39] * 100 + BUFF_DESC2[52] + _root.hackMove2[29] * -100 + BUFF_DESC3[52];
addNewBuffKrin("WILLPOWER2",BUFF_NAME[52],"Shadow");
_root.hackMove2[39] = 3;
_root.hackMove2[29] = -1.1;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[52] + _root.hackMove2[39] * 100 + BUFF_DESC2[52] + _root.hackMove2[29] * -100 + BUFF_DESC3[52];
addNewBuffKrin("WILLPOWER3",BUFF_NAME[52],"Shadow");
_root.hackMove2[39] = 4;
_root.hackMove2[29] = -1.2;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[52] + _root.hackMove2[39] * 100 + BUFF_DESC2[52] + _root.hackMove2[29] * -100 + BUFF_DESC3[52];
addNewBuffKrin("WILLPOWER4",BUFF_NAME[52],"Shadow");
_root.hackMove2[39] = 5;
_root.hackMove2[29] = -1.3000000000000005;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[52] + _root.hackMove2[39] * 100 + BUFF_DESC2[52] + _root.hackMove2[29] * -100 + BUFF_DESC3[52];
addNewBuffKrin("PROTECTOR1",BUFF_NAME[53],"Physical");
_root.hackMove2[15] = -4;
_root.hackMove2[37] = 0.3;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[53] + _root.hackMove2[15] * -1 + BUFF_DESC2[53] + _root.hackMove2[37] * 100 + BUFF_DESC3[53];
addNewBuffKrin("PROTECTOR2",BUFF_NAME[53],"Physical");
_root.hackMove2[15] = -5;
_root.hackMove2[37] = 0.6;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 11;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[53] + _root.hackMove2[15] * -1 + BUFF_DESC2[53] + _root.hackMove2[37] * 100 + BUFF_DESC3[53];
addNewBuffKrin("PROTECTOR3",BUFF_NAME[53],"Physical");
_root.hackMove2[15] = -6;
_root.hackMove2[37] = 0.9000000000000002;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 13;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[53] + _root.hackMove2[15] * -1 + BUFF_DESC2[53] + _root.hackMove2[37] * 100 + BUFF_DESC3[53];
addNewBuffKrin("PROTECTOR4",BUFF_NAME[53],"Physical");
_root.hackMove2[15] = -7;
_root.hackMove2[37] = 1.2;
_root.hackMove2[13] = -0.15;
_root.hackMove2[16] = 15;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[53] + _root.hackMove2[15] * -1 + BUFF_DESC2[53] + _root.hackMove2[37] * 100 + BUFF_DESC3[53];
addNewBuffKrin("TENACITY1","","Physical");
_root.hackMove2[9] = 0.2;
_root.hackMove2[24] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("TENACITY2","","Physical");
_root.hackMove2[9] = 0.3;
_root.hackMove2[24] = 0.4;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("TENACITY3","","Physical");
_root.hackMove2[9] = 0.4;
_root.hackMove2[24] = 0.6;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("TENACITY4","","Physical");
_root.hackMove2[9] = 0.5;
_root.hackMove2[24] = 0.8;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("TENACITY5","","Physical");
_root.hackMove2[9] = 0.6;
_root.hackMove2[24] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("ELECTRIFIED1",BUFF_NAME[54],"Lightning");
_root.hackMove2[35] = 0.5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[37] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[54] + _root.hackMove2[35] * 100 + BUFF_DESC2[54];
addNewBuffKrin("ELECTRIFIED2",BUFF_NAME[54],"Lightning");
_root.hackMove2[35] = 0.5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[37] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[54] + _root.hackMove2[35] * 100 + BUFF_DESC2[54];
addNewBuffKrin("ELECTRIFIED3",BUFF_NAME[54],"Lightning");
_root.hackMove2[35] = 0.5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[37] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[54] + _root.hackMove2[35] * 100 + BUFF_DESC2[54];
addNewBuffKrin("ELECTRIFIED4",BUFF_NAME[54],"Lightning");
_root.hackMove2[35] = 0.5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[37] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[54] + _root.hackMove2[35] * 100 + BUFF_DESC2[54];
addNewBuffKrin("OVERDRIVE1","","Magic");
_root.hackMove2[16] = -1;
_root.hackMove2[48] = 0.5;
addNewBuffKrin("ZPCIENDURANCE1","","Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[47] = -0.25;
_root.hackMove2[9] = 0.1;
_root.hackMove2[23] = 0.2;
_root.hackMove2[48] = 0.25;
addNewBuffKrin("ZPCIENDURANCE2","","Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[47] = -0.25;
_root.hackMove2[9] = 0.15;
_root.hackMove2[23] = 0.3;
_root.hackMove2[48] = 0.25;
addNewBuffKrin("ZPCIENDURANCE3","","Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[47] = -0.25;
_root.hackMove2[9] = 0.2;
_root.hackMove2[23] = 0.4;
_root.hackMove2[48] = 0.25;
addNewBuffKrin("ZPCIENDURANCE4","","Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[47] = -0.25;
_root.hackMove2[9] = 0.25;
_root.hackMove2[23] = 0.5;
_root.hackMove2[48] = 0.25;
addNewBuffKrin("ZPCISHELLL1","","Blackflame");
_root.hackMove2[16] = -1;
_root.hackMove2[39] = 10;
_root.hackMove2[38] = 10;
_root.hackMove2[49] = 50;
_root.hackMove2[15] = -150;
_root.hackMove2[3] = -0.9000000000000002;
addNewBuffKrin("ZPCISHELLL2","","Blackflame");
_root.hackMove2[16] = -1;
_root.hackMove2[39] = 20;
_root.hackMove2[38] = 20;
_root.hackMove2[49] = 50;
_root.hackMove2[15] = -200;
_root.hackMove2[23] = -10;
_root.hackMove2[3] = -0.9000000000000002;
addNewBuffKrin("PSOVERDRIVE1","","Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[45] = 0.1;
_root.hackMove2[48] = 0.5;
addNewBuffKrin("INSECURE1",BUFF_NAME[55],"Shadow");
_root.hackMove2[24] = -0.21;
_root.hackMove2[13] = 0.06;
_root.hackMove2[7] = -0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[55];
addNewBuffKrin("INSECURE2",BUFF_NAME[56],"Shadow");
_root.hackMove2[24] = -0.28;
_root.hackMove2[13] = 0.12;
_root.hackMove2[7] = -0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[56];
addNewBuffKrin("INSECURE3",BUFF_NAME[57],"Shadow");
_root.hackMove2[24] = -0.35000000000000003;
_root.hackMove2[13] = 0.2;
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[57];
addNewBuffKrin("UNSTABLECHARGE1",BUFF_NAME[58],"Lightning");
_root.hackMove2[7] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[58] + _root.hackMove2[7] * 100 + BUFF_DESC2[58];
addNewBuffKrin("UNSTABLECHARGE2",BUFF_NAME[58],"Lightning");
_root.hackMove2[7] = 0.35000000000000003;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[58] + _root.hackMove2[7] * 100 + BUFF_DESC2[58];
addNewBuffKrin("UNSTABLECHARGE3",BUFF_NAME[58],"Lightning");
_root.hackMove2[7] = 0.3;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[58] + _root.hackMove2[7] * 100 + BUFF_DESC2[58];
addNewBuffKrin("UNSTABLECHARGE4",BUFF_NAME[58],"Lightning");
_root.hackMove2[7] = 0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[58] + _root.hackMove2[7] * 100 + BUFF_DESC2[58];
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
addNewBuffKrin("BloodyFury1","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.25;
addNewBuffKrin("BloodyFury2","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 0.5;
addNewBuffKrin("BloodyFury3","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[128] = 0.5;
_root.hackMove2[9] = 0.75;
addNewBuffKrin("FUNDASENDURANCE1","","Shadow");
_root.hackMove2[49] = 50;
_root.hackMove2[16] = -1;
addNewBuffKrin("FUNDASENDURANCE2","","Shadow");
_root.hackMove2[49] = 100;
_root.hackMove2[16] = -1;
addNewBuffKrin("FUNDASENDURANCE3","","Shadow");
_root.hackMove2[49] = 150;
_root.hackMove2[16] = -1;
addNewBuffKrin("PSCHARGEDBLOOD1","","Lightning");
_root.hackMove2[23] = 0.4;
_root.hackMove2[16] = -1;
addNewBuffKrin("PSCHARGEDBLOOD2","","Lightning");
_root.hackMove2[23] = 0.8;
_root.hackMove2[16] = -1;
addNewBuffKrin("PSCHARGEDBLOOD3","","Lightning");
_root.hackMove2[23] = 1.2;
_root.hackMove2[16] = -1;
addNewBuffKrin("PSCHARGEDBLOOD4","","Lightning");
_root.hackMove2[23] = 1.6;
_root.hackMove2[16] = -1;
addNewBuffKrin("PSCHARGEDBLOOD5","","Lightning");
_root.hackMove2[23] = 2;
_root.hackMove2[16] = -1;
addNewBuffKrin("EARTHED1",BUFF_NAME[59],"Lightning");
_root.hackMove2[15] = -8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[59] + _root.hackMove2[15] * -1 + BUFF_DESC2[59];
addNewBuffKrin("EARTHED2",BUFF_NAME[59],"Lightning");
_root.hackMove2[15] = -12;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[59] + _root.hackMove2[15] * -1 + BUFF_DESC2[59];
addNewBuffKrin("EARTHED3",BUFF_NAME[59],"Lightning");
_root.hackMove2[15] = -16;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[59] + _root.hackMove2[15] * -1 + BUFF_DESC2[59];
addNewBuffKrin("EARTHED4",BUFF_NAME[59],"Lightning");
_root.hackMove2[15] = -20;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[59] + _root.hackMove2[15] * -1 + BUFF_DESC2[59];
addNewBuffKrin("EPIPHANY1",BUFF_NAME[60],"Shadow");
_root.hackMove2[29] = 1;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[60] + _root.hackMove2[29] * 100 + BUFF_DESC2[60];
addNewBuffKrin("EPIPHANY2",BUFF_NAME[60],"Shadow");
_root.hackMove2[29] = 1.1;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[60] + _root.hackMove2[29] * 100 + BUFF_DESC2[60];
addNewBuffKrin("EPIPHANY3",BUFF_NAME[60],"Shadow");
_root.hackMove2[29] = 1.2;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[60] + _root.hackMove2[29] * 100 + BUFF_DESC2[60];
addNewBuffKrin("EPIPHANY4",BUFF_NAME[60],"Shadow");
_root.hackMove2[29] = 1.4;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[60] + _root.hackMove2[29] * 100 + BUFF_DESC2[60];
addNewBuffKrin("WAKINGUP1",BUFF_NAME[61],"Shadow");
_root.hackMove2[29] = -0.44;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[61];
addNewBuffKrin("WAKINGUP2",BUFF_NAME[61],"Shadow");
_root.hackMove2[29] = -0.54;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[61];
addNewBuffKrin("WAKINGUP3",BUFF_NAME[61],"Shadow");
_root.hackMove2[29] = -0.64;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[61];
addNewBuffKrin("WAKINGUP4",BUFF_NAME[61],"Shadow");
_root.hackMove2[29] = -0.7400000000000002;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[61];
addNewBuffKrin("HAUNTED1",BUFF_NAME[62],"Shadow");
_root.hackMove2[15] = 3;
_root.hackMove2[16] = 40;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[62] + _root.hackMove2[15] * 1 + BUFF_DESC2[62];
addNewBuffKrin("HAUNTED2",BUFF_NAME[62],"Shadow");
_root.hackMove2[15] = 5;
_root.hackMove2[16] = 40;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[62] + _root.hackMove2[15] * 1 + BUFF_DESC2[62];
addNewBuffKrin("PSYCHOPATHFORM",BUFF_NAME[63],"Shadow");
_root.hackMove2[15] = -8;
_root.hackMove2[16] = 5;
_root.hackMove2[5] = 1;
_root.hackMove2[33] = -0.1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[31] = 13;
_root.hackMove2[25] = BUFF_DESC1[63];
addNewBuffKrin("CONFINED1",BUFF_NAME[64],"Shadow");
_root.hackMove2[36] = 0.4500000000000001;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED2",BUFF_NAME[64],"Shadow");
_root.hackMove2[36] = 0.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED3",BUFF_NAME[64],"Shadow");
_root.hackMove2[36] = 0.75;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED4",BUFF_NAME[64],"Shadow");
_root.hackMove2[36] = 0.9000000000000002;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("DEADLINE",BUFF_NAME[65],"Shadow");
_root.hackMove2[13] = -0.9500000000000001;
_root.hackMove2[36] = 0.9500000000000001;
_root.hackMove2[33] = 1;
_root.hackMove2[16] = 20;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[65] + _root.hackMove2[13] * -100 + BUFF_DESC2[65];
addNewBuffKrin("POWEROFTHECHOSEN1",BUFF_NAME[66],"Shadow");
_root.hackMove2[5] = 0.4;
_root.hackMove2[33] = -0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[66] + _root.hackMove2[5] * 100 + BUFF_DESC2[66];
addNewBuffKrin("POWEROFTHECHOSEN2",BUFF_NAME[66],"Shadow");
_root.hackMove2[5] = 0.6;
_root.hackMove2[33] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[66] + _root.hackMove2[5] * 100 + BUFF_DESC2[66];
addNewBuffKrin("SLEEPY1",BUFF_NAME[67],"Lightning");
_root.hackMove2[15] = -10;
_root.hackMove2[45] = -0.12;
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[67] + -1 * _root.hackMove2[15] + BUFF_DESC2[67] + _root.hackMove2[45] * -100 + BUFF_DESC3[67];
addNewBuffKrin("SLEEPY2",BUFF_NAME[67],"Lightning");
_root.hackMove2[15] = -15;
_root.hackMove2[45] = -0.12;
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[67] + -1 * _root.hackMove2[15] + BUFF_DESC2[67] + _root.hackMove2[45] * -100 + BUFF_DESC3[67];
addNewBuffKrin("SLEEPY3",BUFF_NAME[67],"Lightning");
_root.hackMove2[15] = -20;
_root.hackMove2[45] = -0.12;
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[67] + -1 * _root.hackMove2[15] + BUFF_DESC2[67] + _root.hackMove2[45] * -100 + BUFF_DESC3[67];
addNewBuffKrin("SUPERCONDUCTOR1",BUFF_NAME[68],"Shadow");
_root.hackMove2[46] = 1;
_root.hackMove2[47] = 4;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[68] + _root.hackMove2[46] * 100 + BUFF_DESC2[68];
addNewBuffKrin("SUPERCONDUCTOR2",BUFF_NAME[68],"Shadow");
_root.hackMove2[46] = 2;
_root.hackMove2[47] = 6;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[68] + _root.hackMove2[46] * 100 + BUFF_DESC2[68];
addNewBuffKrin("CANNIBALBLOOD",BUFF_NAME[0],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[33] = -0.03;
_root.hackMove2[25] = BUFF_DESC1[0] + _root.hackMove2[33] * -100 + BUFF_DESC2[0] + _root.hackMove2[32] * 100 + BUFF_DESC3[0];
addNewBuffKrin("BLACKCANNIBALBLOOD",BUFF_NAME[0],"Blackflame");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[33] = -0.05;
_root.hackMove2[25] = BUFF_DESC1[0] + _root.hackMove2[33] * -100 + BUFF_DESC2[0] + _root.hackMove2[32] * 100 + BUFF_DESC3[0];
addNewBuffKrin("SHADOWBLEND1",BUFF_NAME[1],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 1;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[1] + _root.hackMove2[7] * 100 + BUFF_DESC2[1];
addNewBuffKrin("SHADOWBLEND2",BUFF_NAME[1],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 2;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[1] + _root.hackMove2[7] * 100 + BUFF_DESC2[1];
addNewBuffKrin("SHADOWBLEND3",BUFF_NAME[1],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 3;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[1] + _root.hackMove2[7] * 100 + BUFF_DESC2[1];
addNewBuffKrin("SHADOWBLEND4",BUFF_NAME[1],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 4;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[1] + _root.hackMove2[7] * 100 + BUFF_DESC2[1];
addNewBuffKrin("BREAK",BUFF_NAME[2],"Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[2];
addNewBuffKrin("WOUND1",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[28] = 0.63;
_root.hackMove2[13] = 0.3;
_root.hackMove2[12] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[3] + _root.hackMove2[13] * 100 + BUFF_DESC2[3] + _root.hackMove2[28] * 100 + BUFF_DESC3[3];
addNewBuffKrin("WOUND2",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[28] = 0.63;
_root.hackMove2[13] = 0.35000000000000003;
_root.hackMove2[12] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[3] + _root.hackMove2[13] * 100 + BUFF_DESC2[3] + _root.hackMove2[28] * 100 + BUFF_DESC3[3];
addNewBuffKrin("WOUND3B",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[28] = 1.24;
_root.hackMove2[13] = 0.45;
_root.hackMove2[12] = 600;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[3] + _root.hackMove2[13] * 100 + BUFF_DESC2[3] + _root.hackMove2[28] * 100 + BUFF_DESC3[3];
addNewBuffKrin("DEPLETE1",BUFF_NAME[4],"Physical");
_root.hackMove2[7] = -0.3;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[4] + _root.hackMove2[7] * -100 + BUFF_DESC2[4] + _root.hackMove2[32] * 100 + BUFF_DESC3[4];
addNewBuffKrin("DEPLETE2",BUFF_NAME[4],"Physical");
_root.hackMove2[7] = -0.4;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[4] + _root.hackMove2[7] * -100 + BUFF_DESC2[4] + _root.hackMove2[32] * 100 + BUFF_DESC3[4];
addNewBuffKrin("DEPLETE3",BUFF_NAME[4],"Physical");
_root.hackMove2[7] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[4] + _root.hackMove2[7] * -100 + BUFF_DESC2[4] + _root.hackMove2[32] * 100 + BUFF_DESC3[4];
addNewBuffKrin("DEPLETE4",BUFF_NAME[4],"Physical");
_root.hackMove2[7] = -0.6;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[4] + _root.hackMove2[7] * -100 + BUFF_DESC2[4] + _root.hackMove2[32] * 100 + BUFF_DESC3[4];
addNewBuffKrin("SAVAGERY1","This character is stalking.","Physical");
_root.hackMove2[11] = 0.03;
_root.hackMove2[23] = 0.03;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SAVAGERY2","This character is stalking.","Physical");
_root.hackMove2[11] = 0.06;
_root.hackMove2[23] = 0.06;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SAVAGERY3","This character is stalking.","Physical");
_root.hackMove2[11] = 0.09;
_root.hackMove2[23] = 0.09;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SAVAGERY4","This character is stalking.","Physical");
_root.hackMove2[11] = 0.12;
_root.hackMove2[23] = 0.12;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("STALK",BUFF_NAME[5],"Physical");
_root.hackMove2[11] = 0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[15] = -100;
_root.hackMove2[24] = 0.25;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 9;
_root.hackMove2[25] = BUFF_DESC1[5] + _root.hackMove2[11] * 100 + BUFF_DESC2[5] + _root.hackMove2[24] * 100 + BUFF_DESC3[5];
addNewBuffKrin("AUTOREGEN","Prepared","Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -8;
addNewBuffKrin("PREPARED","Prepared","Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -50;
addNewBuffKrin("PREPARED2","Prepared","Physical");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -25;
addNewBuffKrin("PREPARED_DUX",BUFF_NAME[41],"Lightning");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -35;
_root.hackMove2[25] = BUFF_DESC1[41];
addNewBuffKrin("VAPOUR",BUFF_NAME[40],"Ice");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -12;
_root.hackMove2[25] = BUFF_DESC1[40] + _root.hackMove2[15] * -1 + BUFF_DESC2[40];
addNewBuffKrin("EXPOSED1",BUFF_NAME[6],"Physical");
_root.hackMove2[13] = 0.6;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[6] + _root.hackMove2[13] * 100 + BUFF_DESC2[6];
addNewBuffKrin("EXPOSED2",BUFF_NAME[6],"Physical");
_root.hackMove2[13] = 0.8;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[6] + _root.hackMove2[13] * 100 + BUFF_DESC2[6];
addNewBuffKrin("EXPOSED3",BUFF_NAME[6],"Physical");
_root.hackMove2[13] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[6] + _root.hackMove2[13] * 100 + BUFF_DESC2[6];
addNewBuffKrin("EXPOSEDB",BUFF_NAME[6],"Blackflame");
_root.hackMove2[13] = 0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[6] + _root.hackMove2[13] * 100 + BUFF_DESC2[6];
addNewBuffKrin("INTEGRITY1","This character feels integrated!","Physical");
_root.hackMove2[15] = -10;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 0;
_root.hackMove2[32] = 1;
addNewBuffKrin("INTEGRITY2"," This character feels integrated!","Physical");
_root.hackMove2[15] = -15;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 0;
_root.hackMove2[32] = 1;
_root.hackMove2[33] = -0.01;
addNewBuffKrin("INTEGRITY3"," This character feels integrated !","Physical");
_root.hackMove2[15] = -20;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 0;
_root.hackMove2[32] = 1;
_root.hackMove2[33] = -0.02;
addNewBuffKrin("INTEGRITY4"," This character feels integrated!","Physical");
_root.hackMove2[15] = -25;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 0;
_root.hackMove2[32] = 1;
_root.hackMove2[33] = -0.03;
addNewBuffKrin("ADRENALINE1",BUFF_NAME[7],"Lightning");
_root.hackMove2[3] = 0.15;
_root.hackMove2[15] = -7;
_root.hackMove2[35] = 0.4;
_root.hackMove2[37] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[7] + _root.hackMove2[3] * 100 + BUFF_DESC2[7] + _root.hackMove2[15] * -1 + BUFF_DESC3[7];
addNewBuffKrin("ADRENALINE2",BUFF_NAME[7],"Lightning");
_root.hackMove2[3] = 0.2;
_root.hackMove2[15] = -10;
_root.hackMove2[35] = 0.4;
_root.hackMove2[37] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[7] + _root.hackMove2[3] * 100 + BUFF_DESC2[7] + _root.hackMove2[15] * -1 + BUFF_DESC3[7];
addNewBuffKrin("ADRENALINE3",BUFF_NAME[7],"Lightning");
_root.hackMove2[3] = 0.25;
_root.hackMove2[15] = -13;
_root.hackMove2[35] = 0.4;
_root.hackMove2[37] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[7] + _root.hackMove2[3] * 100 + BUFF_DESC2[7] + _root.hackMove2[15] * -1 + BUFF_DESC3[7];
addNewBuffKrin("REFORM1",BUFF_NAME[8],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -5;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = -1.2;
_root.hackMove2[25] = BUFF_DESC1[8] + _root.hackMove2[28] * -100 + BUFF_DESC2[8] + _root.hackMove2[15] * -1 + BUFF_DESC3[8];
addNewBuffKrin("REFORM2",BUFF_NAME[8],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = -1.5;
_root.hackMove2[25] = BUFF_DESC1[8] + _root.hackMove2[28] * -100 + BUFF_DESC2[8] + _root.hackMove2[15] * -1 + BUFF_DESC3[8];
addNewBuffKrin("REFORM3",BUFF_NAME[8],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = -1.7;
_root.hackMove2[25] = BUFF_DESC1[8] + _root.hackMove2[28] * -100 + BUFF_DESC2[8] + _root.hackMove2[15] * -1 + BUFF_DESC3[8];
addNewBuffKrin("REFORM4",BUFF_NAME[43],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[15] = -20;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = -1.9000000000000001;
_root.hackMove2[25] = BUFF_DESC1[43];
addNewBuffKrin("ANIMALISM1",BUFF_NAME[9],"Physical");
_root.hackMove2[3] = 0.2;
_root.hackMove2[5] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[36] = 0.4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[9] + _root.hackMove2[3] * 100 + BUFF_DESC2[9] + _root.hackMove2[36] * 100 + BUFF_DESC3[9];
addNewBuffKrin("ANIMALISM2",BUFF_NAME[9],"Physical");
_root.hackMove2[3] = 0.24;
_root.hackMove2[5] = 0.24;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[36] = 0.4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[9] + _root.hackMove2[3] * 100 + BUFF_DESC2[9] + _root.hackMove2[36] * 100 + BUFF_DESC3[9];
addNewBuffKrin("ANIMALISM3",BUFF_NAME[9],"Physical");
_root.hackMove2[3] = 0.28;
_root.hackMove2[5] = 0.28;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[36] = 0.4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[9] + _root.hackMove2[3] * 100 + BUFF_DESC2[9] + _root.hackMove2[36] * 100 + BUFF_DESC3[9];
addNewBuffKrin("ANIMALISM4",BUFF_NAME[9],"Physical");
_root.hackMove2[3] = 0.32;
_root.hackMove2[5] = 0.32;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[36] = 0.4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[9] + _root.hackMove2[3] * 100 + BUFF_DESC2[9] + _root.hackMove2[36] * 100 + BUFF_DESC3[9];
addNewBuffKrin("BERSERK1",BUFF_NAME[10],"Physical");
_root.hackMove2[11] = 0.5;
_root.hackMove2[13] = 0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 7;
_root.hackMove2[25] = BUFF_DESC1[10] + _root.hackMove2[11] * 100 + BUFF_DESC2[10];
addNewBuffKrin("BERSERK2",BUFF_NAME[10],"Physical");
_root.hackMove2[11] = 0.6500000000000002;
_root.hackMove2[13] = 0.6500000000000002;
_root.hackMove2[16] = 2;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[10] + _root.hackMove2[11] * 100 + BUFF_DESC2[10];
addNewBuffKrin("BERSERK3",BUFF_NAME[10],"Physical");
_root.hackMove2[11] = 0.8;
_root.hackMove2[13] = 0.8;
_root.hackMove2[16] = 2;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[10] + _root.hackMove2[11] * 100 + BUFF_DESC2[10];
addNewBuffKrin("IRRITATE1",BUFF_NAME[11],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[36] = 0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[11];
addNewBuffKrin("IRRITATE2",BUFF_NAME[11],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[36] = 0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[11];
addNewBuffKrin("IRRITATE3",BUFF_NAME[11],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[36] = 0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[11];
addNewBuffKrin("IRRITATE4",BUFF_NAME[11],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[36] = 0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[11];
addNewBuffKrin("CAUTERIZE1",BUFF_NAME[12],"Poison");
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.09;
_root.hackMove2[23] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[12] + _root.hackMove2[13] * 100 + BUFF_DESC2[12] + _root.hackMove2[23] * -100 + BUFF_DESC3[12];
addNewBuffKrin("CAUTERIZE2",BUFF_NAME[12],"Poison");
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.16;
_root.hackMove2[23] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[12] + _root.hackMove2[13] * 100 + BUFF_DESC2[12] + _root.hackMove2[23] * -100 + BUFF_DESC3[12];
addNewBuffKrin("CAUTERIZE3",BUFF_NAME[12],"Poison");
_root.hackMove2[13] = 0.3;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.23;
_root.hackMove2[23] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[12] + _root.hackMove2[13] * 100 + BUFF_DESC2[12] + _root.hackMove2[23] * -100 + BUFF_DESC3[12];
addNewBuffKrin("CAUTERIZE4",BUFF_NAME[12],"Poison");
_root.hackMove2[13] = 0.35000000000000003;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[23] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[12] + _root.hackMove2[13] * 100 + BUFF_DESC2[12] + _root.hackMove2[23] * -100 + BUFF_DESC3[12];
addNewBuffKrin("POISON1",BUFF_NAME[13],"Poison");
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("POISON2",BUFF_NAME[13],"Poison");
_root.hackMove2[28] = 0.55;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("POISON3",BUFF_NAME[13],"Poison");
_root.hackMove2[28] = 0.6;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("POISON4",BUFF_NAME[13],"Poison");
_root.hackMove2[28] = 0.6500000000000002;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("CONTAMINATE1",BUFF_NAME[14],"Poison");
_root.hackMove2[28] = 3;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[14] + _root.hackMove2[28] * 100 + BUFF_DESC2[14] + _root.hackMove2[32] * 100 + BUFF_DESC3[14];
addNewBuffKrin("CONTAMINATE2",BUFF_NAME[14],"Poison");
_root.hackMove2[28] = 3.15;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[14] + _root.hackMove2[28] * 100 + BUFF_DESC2[14] + _root.hackMove2[32] * 100 + BUFF_DESC3[14];
addNewBuffKrin("CONTAMINATE3",BUFF_NAME[14],"Poison");
_root.hackMove2[28] = 3.3000000000000003;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[14] + _root.hackMove2[28] * 100 + BUFF_DESC2[14] + _root.hackMove2[32] * 100 + BUFF_DESC3[14];
addNewBuffKrin("CONTAMINATE4",BUFF_NAME[14],"Poison");
_root.hackMove2[28] = 3.45;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[14] + _root.hackMove2[28] * 100 + BUFF_DESC2[14] + _root.hackMove2[32] * 100 + BUFF_DESC3[14];
addNewBuffKrin("DISRUPT",BUFF_NAME[15],"Lightning");
_root.hackMove2[15] = -6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[15] + _root.hackMove2[15] * -1 + BUFF_DESC2[15];
addNewBuffKrin("NUMB1",BUFF_NAME[16],"Poison");
_root.hackMove2[15] = 3;
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.3;
_root.hackMove2[11] = -0.28;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[16] + _root.hackMove2[11] * -100 + BUFF_DESC2[16] + _root.hackMove2[15] + BUFF_DESC3[16];
addNewBuffKrin("NUMB2",BUFF_NAME[16],"Poison");
_root.hackMove2[15] = 4;
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.3;
_root.hackMove2[11] = -0.32;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[16] + _root.hackMove2[11] * -100 + BUFF_DESC2[16] + _root.hackMove2[15] + BUFF_DESC3[16];
addNewBuffKrin("NUMB3",BUFF_NAME[16],"Poison");
_root.hackMove2[15] = 5;
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.3;
_root.hackMove2[11] = -0.36;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[16] + _root.hackMove2[11] * -100 + BUFF_DESC2[16] + _root.hackMove2[15] + BUFF_DESC3[16];
addNewBuffKrin("NUMB4",BUFF_NAME[16],"Poison");
_root.hackMove2[15] = 6;
_root.hackMove2[16] = 4;
_root.hackMove2[28] = 0.3;
_root.hackMove2[11] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[16] + _root.hackMove2[11] * -100 + BUFF_DESC2[16] + _root.hackMove2[15] + BUFF_DESC3[16];
addNewBuffKrin("ACIDIC1"," This character is aware of the chinks in the enemy’s armour.","Poison");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 5.200000000000002;
addNewBuffKrin("ACIDIC2"," This character is aware of the chinks in the enemy’s armour.","Poison");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 5.700000000000002;
addNewBuffKrin("ACIDIC3"," This character is aware of the chinks in the enemy’s armour.","Poison");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 6.200000000000002;
addNewBuffKrin("ACIDIC4"," This character is aware of the chinks in the enemy’s armour.","Poison");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 6.700000000000002;
addNewBuffKrin("AWARENESS1",BUFF_NAME[17],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.2;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[17] + _root.hackMove2[23] * 100 + BUFF_DESC2[17];
addNewBuffKrin("AWARENESS2",BUFF_NAME[17],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.35;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[17] + _root.hackMove2[23] * 100 + BUFF_DESC2[17];
addNewBuffKrin("AWARENESS3",BUFF_NAME[17],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.5;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[17] + _root.hackMove2[23] * 100 + BUFF_DESC2[17];
addNewBuffKrin("AWARENESS4",BUFF_NAME[17],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1.6500000000000001;
_root.hackMove2[24] = _root.hackMove2[23];
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[17] + _root.hackMove2[23] * 100 + BUFF_DESC2[17];
addNewBuffKrin("LEECH1"," Parasites have invaded this character.","Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[23] = 1;
_root.hackMove2[32] = 0.1;
addNewBuffKrin("LEECH2"," Parasites have invaded this character.","Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[23] = 1.1;
_root.hackMove2[32] = 0.1;
addNewBuffKrin("LEECH3"," Parasites have invaded this character.","Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[23] = 1.2;
_root.hackMove2[32] = 0.1;
addNewBuffKrin("LEECH4"," Parasites have invaded this character.","Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[23] = 1.3000000000000005;
_root.hackMove2[32] = 0.1;
addNewBuffKrin("SUBVERSION",BUFF_NAME[18],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[26] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[18];
addNewBuffKrin("TESTUDO1",BUFF_NAME[44],"Poison");
_root.hackMove2[48] = 0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[44] + _root.hackMove2[48] * 100 + BUFF_DESC2[44];
addNewBuffKrin("TESTUDO2",BUFF_NAME[44],"Poison");
_root.hackMove2[48] = 0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[44] + _root.hackMove2[48] * 100 + BUFF_DESC2[44];
addNewBuffKrin("TESTUDO3",BUFF_NAME[44],"Poison");
_root.hackMove2[48] = 0.3;
_root.hackMove2[16] = 7;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[44] + _root.hackMove2[48] * 100 + BUFF_DESC2[44];
addNewBuffKrin("MARATHON1","This character is fortified with more life.","Physical");
_root.hackMove2[9] = 0.04;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("MARATHON2","This character is fortified with more life.","Physical");
_root.hackMove2[9] = 0.08;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("MARATHON3","This character is fortified with more life.","Physical");
_root.hackMove2[9] = 0.12;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("MARATHON4","This character is fortified with more life.","Physical");
_root.hackMove2[9] = 0.16;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SUPERHEALTH1","This character is fortified with more life.","Earth");
_root.hackMove2[9] = 0.1;
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SUPERHEALTH2","This character is fortified with more life.","Earth");
_root.hackMove2[9] = 0.12;
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SUPERHEALTH3","This character is fortified with more life.","Earth");
_root.hackMove2[9] = 0.14;
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.18;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SUPERHEALTH4","This character is fortified with more life.","Earth");
_root.hackMove2[9] = 0.18;
_root.hackMove2[16] = -1;
_root.hackMove2[13] = -0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("SUPERHEALTH5","This character is fortified with more life.","Earth");
_root.hackMove2[9] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[13] = -0.22;
_root.hackMove2[32] = 1;
addNewBuffKrin("EVOLUTION1","This character has increased defence at the expense of speed.","Poison");
_root.hackMove2[3] = 0.02;
_root.hackMove2[5] = 0.02;
_root.hackMove2[7] = 0.02;
_root.hackMove2[9] = 0.02;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("EVOLUTION2","This character has increased defence at the expense of speed.","Poison");
_root.hackMove2[3] = 0.04;
_root.hackMove2[5] = 0.04;
_root.hackMove2[7] = 0.04;
_root.hackMove2[9] = 0.04;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("EVOLUTION3","This character has increased defence at the expense of speed.","Poison");
_root.hackMove2[3] = 0.06;
_root.hackMove2[5] = 0.06;
_root.hackMove2[7] = 0.06;
_root.hackMove2[9] = 0.06;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
addNewBuffKrin("TOXICBLOOD",BUFF_NAME[19],"Poison");
_root.hackMove2[33] = -0.2;
_root.hackMove2[11] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[23] = 0.4;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 10;
_root.hackMove2[25] = BUFF_DESC1[19] + _root.hackMove2[33] * -100 + BUFF_DESC2[19] + _root.hackMove2[11] * 100 + BUFF_DESC3[19];
addNewBuffKrin("SOLID1",BUFF_NAME[20],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[19] = 10;
_root.hackMove2[41] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 3;
_root.hackMove2[25] = BUFF_DESC1[20];
addNewBuffKrin("SOLID2",BUFF_NAME[20],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[19] = 10;
_root.hackMove2[41] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 3;
_root.hackMove2[25] = BUFF_DESC1[20];
addNewBuffKrin("SOLID3",BUFF_NAME[20],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[19] = 10;
_root.hackMove2[41] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 3;
_root.hackMove2[25] = BUFF_DESC1[20];
addNewBuffKrin("FROST1",BUFF_NAME[21],"Ice");
_root.hackMove2[7] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[21] + _root.hackMove2[7] * -100 + BUFF_DESC2[21] + _root.hackMove2[32] * 100 + BUFF_DESC3[21];
addNewBuffKrin("FROST2",BUFF_NAME[21],"Ice");
_root.hackMove2[7] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[21] + _root.hackMove2[7] * -100 + BUFF_DESC2[21] + _root.hackMove2[32] * 100 + BUFF_DESC3[21];
addNewBuffKrin("FROST3",BUFF_NAME[21],"Ice");
_root.hackMove2[7] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[21] + _root.hackMove2[7] * -100 + BUFF_DESC2[21] + _root.hackMove2[32] * 100 + BUFF_DESC3[21];
addNewBuffKrin("FROST4",BUFF_NAME[21],"Ice");
_root.hackMove2[7] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[21] + _root.hackMove2[7] * -100 + BUFF_DESC2[21] + _root.hackMove2[32] * 100 + BUFF_DESC3[21];
addNewBuffKrin("HYPO1",BUFF_NAME[22],"Ice");
_root.hackMove2[7] = -0.12;
_root.hackMove2[28] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[22] + _root.hackMove2[28] * 100 + BUFF_DESC2[22] + _root.hackMove2[32] * 100 + BUFF_DESC3[22];
addNewBuffKrin("HYPO2",BUFF_NAME[22],"Ice");
_root.hackMove2[7] = -0.13;
_root.hackMove2[28] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[22] + _root.hackMove2[28] * 100 + BUFF_DESC2[22] + _root.hackMove2[32] * 100 + BUFF_DESC3[22];
addNewBuffKrin("HYPO3",BUFF_NAME[22],"Ice");
_root.hackMove2[7] = -0.14;
_root.hackMove2[28] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[22] + _root.hackMove2[28] * 100 + BUFF_DESC2[22] + _root.hackMove2[32] * 100 + BUFF_DESC3[22];
addNewBuffKrin("HYPO4",BUFF_NAME[22],"Ice");
_root.hackMove2[7] = -0.15;
_root.hackMove2[28] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[22] + _root.hackMove2[28] * 100 + BUFF_DESC2[22] + _root.hackMove2[32] * 100 + BUFF_DESC3[22];
addNewBuffKrin("SILENCED",BUFF_NAME[111],"Physical");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[111];
addNewBuffKrin("MINDFREEZE1",BUFF_NAME[23],"Ice");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC2[23] + _root.hackMove2[32] * 100 + BUFF_DESC3[23];
addNewBuffKrin("MINDFREEZE2",BUFF_NAME[23],"Ice");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC2[23] + _root.hackMove2[32] * 100 + BUFF_DESC3[23];
addNewBuffKrin("MINDFREEZE3",BUFF_NAME[23],"Ice");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC2[23] + _root.hackMove2[32] * 100 + BUFF_DESC3[23];
addNewBuffKrin("MINDFREEZE4",BUFF_NAME[23],"Ice");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC2[23] + _root.hackMove2[32] * 100 + BUFF_DESC3[23];
addNewBuffKrin("FLASHFREEZE1",BUFF_NAME[24],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[24] + _root.hackMove2[32] * 100 + BUFF_DESC2[24];
addNewBuffKrin("FLASHFREEZE2",BUFF_NAME[24],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[24] + _root.hackMove2[32] * 100 + BUFF_DESC2[24];
addNewBuffKrin("FLASHFREEZE3",BUFF_NAME[24],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[24] + _root.hackMove2[32] * 100 + BUFF_DESC2[24];
addNewBuffKrin("FLASHFREEZE4",BUFF_NAME[24],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[24] + _root.hackMove2[32] * 100 + BUFF_DESC2[24];
addNewBuffKrin("VASCULAR1",BUFF_NAME[25],"Ice");
_root.hackMove2[36] = 0.5700000000000003;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[25] + _root.hackMove2[36] * 100 + BUFF_DESC2[25] + _root.hackMove2[32] * 100 + BUFF_DESC3[25];
addNewBuffKrin("VASCULAR2",BUFF_NAME[25],"Ice");
_root.hackMove2[36] = 0.5800000000000001;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[25] + _root.hackMove2[36] * 100 + BUFF_DESC2[25] + _root.hackMove2[32] * 100 + BUFF_DESC3[25];
addNewBuffKrin("VASCULAR3",BUFF_NAME[25],"Ice");
_root.hackMove2[36] = 0.59;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[25] + _root.hackMove2[36] * 100 + BUFF_DESC2[25] + _root.hackMove2[32] * 100 + BUFF_DESC3[25];
addNewBuffKrin("VASCULAR4",BUFF_NAME[25],"Ice");
_root.hackMove2[36] = 0.6;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[25] + _root.hackMove2[36] * 100 + BUFF_DESC2[25] + _root.hackMove2[32] * 100 + BUFF_DESC3[25];
addNewBuffKrin("GLACIER1",BUFF_NAME[26],"Ice");
_root.hackMove2[11] = -0.13;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[26] + _root.hackMove2[11] * -100 + BUFF_DESC2[26] + _root.hackMove2[32] * 100 + BUFF_DESC3[26];
addNewBuffKrin("GLACIER2",BUFF_NAME[26],"Ice");
_root.hackMove2[11] = -0.13;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[26] + _root.hackMove2[11] * -100 + BUFF_DESC2[26] + _root.hackMove2[32] * 100 + BUFF_DESC3[26];
addNewBuffKrin("GLACIER3",BUFF_NAME[26],"Ice");
_root.hackMove2[11] = -0.13;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[26] + _root.hackMove2[11] * -100 + BUFF_DESC2[26] + _root.hackMove2[32] * 100 + BUFF_DESC3[26];
addNewBuffKrin("GLACIER4",BUFF_NAME[26],"Ice");
_root.hackMove2[11] = -0.13;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[26] + _root.hackMove2[11] * -100 + BUFF_DESC2[26] + _root.hackMove2[32] * 100 + BUFF_DESC3[26];
addNewBuffKrin("CRYSTALICE1","","Ice");
_root.hackMove2[23] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[120] = 10;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "";
addNewBuffKrin("CRYSTALICE2","","Ice");
_root.hackMove2[23] = 0.8;
_root.hackMove2[20] = 1;
_root.hackMove2[120] = 10;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "";
addNewBuffKrin("CRYSTALICE3","","Ice");
_root.hackMove2[23] = 1.2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[120] = 10;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "";
addNewBuffKrin("CRYSTALICE4","","Ice");
_root.hackMove2[23] = 1.6;
_root.hackMove2[20] = 1;
_root.hackMove2[120] = 10;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "";
addNewBuffKrin("CRYSTALICE5","","Ice");
_root.hackMove2[23] = 2;
_root.hackMove2[120] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = "";
addNewBuffKrin("FRAGILE",BUFF_NAME[42],"Ice");
_root.hackMove2[13] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[42] + _root.hackMove2[13] * 100 + BUFF_DESC2[42];
addNewBuffKrin("IMPAIR1",BUFF_NAME[27],"Physical");
_root.hackMove2[13] = 0.06;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[27] + _root.hackMove2[13] * 100 + BUFF_DESC2[27];
addNewBuffKrin("IMPAIR2",BUFF_NAME[27],"Physical");
_root.hackMove2[13] = 0.09;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[27] + _root.hackMove2[13] * 100 + BUFF_DESC2[27];
addNewBuffKrin("IMPAIR3",BUFF_NAME[27],"Physical");
_root.hackMove2[13] = 0.12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[27] + _root.hackMove2[13] * 100 + BUFF_DESC2[27];
addNewBuffKrin("IMPAIR4",BUFF_NAME[27],"Physical");
_root.hackMove2[13] = 0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[27] + _root.hackMove2[13] * 100 + BUFF_DESC2[27];
addNewBuffKrin("BLOODRUSH1",BUFF_NAME[28],"Physical");
_root.hackMove2[11] = 0.06;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[28] + _root.hackMove2[11] * 100 + BUFF_DESC2[28];
addNewBuffKrin("BLOODRUSH2",BUFF_NAME[28],"Physical");
_root.hackMove2[11] = 0.09;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[28] + _root.hackMove2[11] * 100 + BUFF_DESC2[28];
addNewBuffKrin("BLOODRUSH3",BUFF_NAME[28],"Physical");
_root.hackMove2[11] = 0.12;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[28] + _root.hackMove2[11] * 100 + BUFF_DESC2[28];
addNewBuffKrin("BLOODRUSH4",BUFF_NAME[28],"Physical");
_root.hackMove2[11] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[28] + _root.hackMove2[11] * 100 + BUFF_DESC2[28];
addNewBuffKrin("HOTBLOOD1","","Physical");
_root.hackMove2[3] = 0.5;
_root.hackMove2[119] = 10;
_root.hackMove2[15] = 10;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = "";
addNewBuffKrin("WRECK",BUFF_NAME[29],"Physical");
_root.hackMove2[28] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 1;
_root.hackMove2[25] = BUFF_DESC1[29] + _root.hackMove2[28] * 100 + BUFF_DESC2[29];
addNewBuffKrin("DEMOLISH",BUFF_NAME[30],"Physical");
_root.hackMove2[3] = 0.12;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[30] + _root.hackMove2[3] * 100 + BUFF_DESC2[30];
addNewBuffKrin("DECIMATE1",BUFF_NAME[31],"Physical");
_root.hackMove2[28] = 0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[31] + _root.hackMove2[28] * 100 + BUFF_DESC2[31];
addNewBuffKrin("DECIMATE2",BUFF_NAME[31],"Physical");
_root.hackMove2[28] = 0.35000000000000003;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[31] + _root.hackMove2[28] * 100 + BUFF_DESC2[31];
addNewBuffKrin("DECIMATE3",BUFF_NAME[31],"Physical");
_root.hackMove2[28] = 0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[31] + _root.hackMove2[28] * 100 + BUFF_DESC2[31];
addNewBuffKrin("DECIMATE4",BUFF_NAME[31],"Physical");
_root.hackMove2[28] = 0.4500000000000001;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[31] + _root.hackMove2[28] * 100 + BUFF_DESC2[31];
addNewBuffKrin("LASTINGPAIN1","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[48] = 0.6;
_root.hackMove2[123] = "EMPOWERBLOOD";
addNewBuffKrin("LASTINGPAIN2","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[123] = "EMPOWERBLOOD";
_root.hackMove2[48] = 0.8;
addNewBuffKrin("LASTINGPAIN3","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[48] = 1;
_root.hackMove2[123] = "EMPOWERBLOOD";
addNewBuffKrin("LASTINGPAIN4","","Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[123] = "EMPOWERBLOOD";
_root.hackMove2[48] = 1.2;
addNewBuffKrin("REGULATE1",BUFF_NAME[32],"Ice");
_root.hackMove2[15] = -5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[32] + _root.hackMove2[15] * -1 + BUFF_DESC2[32];
addNewBuffKrin("REGULATE2",BUFF_NAME[32],"Ice");
_root.hackMove2[15] = -8;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[32] + _root.hackMove2[15] * -1 + BUFF_DESC2[32];
addNewBuffKrin("REGULATE3",BUFF_NAME[32],"Ice");
_root.hackMove2[15] = -11;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[32] + _root.hackMove2[15] * -1 + BUFF_DESC2[32];
addNewBuffKrin("RECONSTRUCT1",BUFF_NAME[33],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[45] = -0.15;
_root.hackMove2[31] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[33] + _root.hackMove2[45] * -100 + BUFF_DESC2[33];
addNewBuffKrin("RECONSTRUCT2",BUFF_NAME[33],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[45] = -0.21;
_root.hackMove2[31] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[33] + _root.hackMove2[45] * -100 + BUFF_DESC2[33];
addNewBuffKrin("RECONSTRUCT3",BUFF_NAME[33],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[45] = -0.33000000000000007;
_root.hackMove2[31] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[33] + _root.hackMove2[45] * -100 + BUFF_DESC2[33];
addNewBuffKrin("RECONSTRUCT4",BUFF_NAME[33],"Ice");
_root.hackMove2[17] = 1;
_root.hackMove2[45] = -0.35000000000000003;
_root.hackMove2[31] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[33] + _root.hackMove2[45] * -100 + BUFF_DESC2[33];
addNewBuffKrin("SAFEGUARD1",BUFF_NAME[34],"Physical");
_root.hackMove2[41] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARD2",BUFF_NAME[34],"Physical");
_root.hackMove2[41] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARD3",BUFF_NAME[34],"Physical");
_root.hackMove2[41] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARD4",BUFF_NAME[34],"Physical");
_root.hackMove2[41] = 0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("ICYSHELL1",BUFF_NAME[35],"Ice");
_root.hackMove2[11] = -0.5;
_root.hackMove2[13] = -0.5;
_root.hackMove2[35] = 1;
_root.hackMove2[31] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[35] + _root.hackMove2[11] * -100 + BUFF_DESC2[35];
addNewBuffKrin("ICYSHELL2",BUFF_NAME[35],"Ice");
_root.hackMove2[11] = -0.5800000000000001;
_root.hackMove2[13] = -0.5800000000000001;
_root.hackMove2[35] = 1.2;
_root.hackMove2[31] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[35] + _root.hackMove2[11] * -100 + BUFF_DESC2[35];
addNewBuffKrin("ICYSHELL3",BUFF_NAME[35],"Ice");
_root.hackMove2[11] = -0.6600000000000001;
_root.hackMove2[13] = -0.6600000000000001;
_root.hackMove2[35] = 1.4000000000000001;
_root.hackMove2[31] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[35] + _root.hackMove2[11] * -100 + BUFF_DESC2[35];
addNewBuffKrin("ICYSHELL4",BUFF_NAME[35],"Ice");
_root.hackMove2[11] = -0.75;
_root.hackMove2[13] = -0.75;
_root.hackMove2[35] = 1.6;
_root.hackMove2[31] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[35] + _root.hackMove2[11] * -100 + BUFF_DESC2[35];
addNewBuffKrin("MIRAGE1",BUFF_NAME[36],"Fire");
_root.hackMove2[13] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 30;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[36] + _root.hackMove2[9] * 100 + BUFF_DESC2[36] + _root.hackMove2[13] * 100 + BUFF_DESC3[36];
addNewBuffKrin("MIRAGE2",BUFF_NAME[36],"Fire");
_root.hackMove2[13] = 2.8000000000000003;
_root.hackMove2[9] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 30;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[36] + _root.hackMove2[9] * 100 + BUFF_DESC2[36] + _root.hackMove2[13] * 100 + BUFF_DESC3[36];
addNewBuffKrin("MIRAGE3",BUFF_NAME[36],"Fire");
_root.hackMove2[13] = 2.600000000000001;
_root.hackMove2[9] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 30;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[36] + _root.hackMove2[9] * 100 + BUFF_DESC2[36] + _root.hackMove2[13] * 100 + BUFF_DESC3[36];
addNewBuffKrin("MIRAGE4",BUFF_NAME[36],"Fire");
_root.hackMove2[13] = 2.4;
_root.hackMove2[9] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 30;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[36] + _root.hackMove2[9] * 100 + BUFF_DESC2[36] + _root.hackMove2[13] * 100 + BUFF_DESC3[36];
addNewBuffKrin("DEADMAN1",BUFF_NAME[37],"Fire");
_root.hackMove2[11] = 0.5;
_root.hackMove2[37] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[37] + _root.hackMove2[11] * 100 + BUFF_DESC2[37];
addNewBuffKrin("DEADMAN2",BUFF_NAME[37],"Fire");
_root.hackMove2[11] = 0.5;
_root.hackMove2[37] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[37] + _root.hackMove2[11] * 100 + BUFF_DESC2[37];
addNewBuffKrin("DEADMAN3",BUFF_NAME[37],"Fire");
_root.hackMove2[11] = 0.5;
_root.hackMove2[37] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[37] + _root.hackMove2[11] * 100 + BUFF_DESC2[37];
addNewBuffKrin("DEADMAN4",BUFF_NAME[37],"Fire");
_root.hackMove2[11] = 0.5;
_root.hackMove2[37] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[37] + _root.hackMove2[11] * 100 + BUFF_DESC2[37];
addNewBuffKrin("STIFFUPPER1","","Ice");
_root.hackMove2[9] = 0.04;
_root.hackMove2[35] = 0.07;
_root.hackMove2[16] = -1;
addNewBuffKrin("STIFFUPPER2","","Ice");
_root.hackMove2[9] = 0.08;
_root.hackMove2[35] = 0.14;
_root.hackMove2[16] = -1;
addNewBuffKrin("STIFFUPPER3","","Ice");
_root.hackMove2[9] = 0.12;
_root.hackMove2[35] = 0.21;
_root.hackMove2[16] = -1;
addNewBuffKrin("STIFFUPPER4","","Ice");
_root.hackMove2[9] = 0.16;
_root.hackMove2[35] = 0.28;
_root.hackMove2[16] = -1;
addNewBuffKrin("STIFFUPPER5","","Ice");
_root.hackMove2[9] = 0.2;
_root.hackMove2[35] = 0.35000000000000003;
_root.hackMove2[16] = -1;
addNewBuffKrin("COLDNEU1","","Ice");
_root.hackMove2[13] = -0.05;
_root.hackMove2[49] = -10;
_root.hackMove2[16] = -1;
addNewBuffKrin("COLDNEU2","","Ice");
_root.hackMove2[13] = -0.1;
_root.hackMove2[49] = -20;
_root.hackMove2[16] = -1;
addNewBuffKrin("COLDNEU3","","Ice");
_root.hackMove2[13] = -0.15;
_root.hackMove2[49] = -30;
_root.hackMove2[16] = -1;
addNewBuffKrin("COLDNEU4","","Ice");
_root.hackMove2[13] = -0.2;
_root.hackMove2[49] = -40;
_root.hackMove2[16] = -1;
addNewBuffKrin("WARMNEU1","","Fire");
_root.hackMove2[13] = 0.05;
_root.hackMove2[49] = 10;
_root.hackMove2[16] = -1;
addNewBuffKrin("WARMNEU2","","Fire");
_root.hackMove2[13] = 0.1;
_root.hackMove2[49] = 20;
_root.hackMove2[16] = -1;
addNewBuffKrin("WARMNEU3","","Fire");
_root.hackMove2[13] = 0.15;
_root.hackMove2[49] = 30;
_root.hackMove2[16] = -1;
addNewBuffKrin("WARMNEU4","","Fire");
_root.hackMove2[13] = 0.2;
_root.hackMove2[49] = 40;
_root.hackMove2[16] = -1;
addNewBuffKrin("ICEFORM",BUFF_NAME[38],"Ice");
_root.hackMove2[13] = -0.3;
_root.hackMove2[24] = 0.25;
_root.hackMove2[5] = 0.25;
_root.hackMove2[31] = 11;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[38] + _root.hackMove2[13] * -100 + BUFF_DESC2[38] + _root.hackMove2[24] * 100 + BUFF_DESC3[38];
addNewBuffKrin("AVENGERFORM",BUFF_NAME[39],"Fire");
_root.hackMove2[11] = 0.15;
_root.hackMove2[7] = 0.15;
_root.hackMove2[15] = -10;
_root.hackMove2[31] = 12;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[39] + _root.hackMove2[11] * 100 + BUFF_DESC2[39] + _root.hackMove2[15] * -1 + BUFF_DESC3[39];
addNewBuffKrin("FATALFLAW",_root.KrinLang[KLangChoosen].AU[30],"Earth");
_root.hackMove2[3] = -0.15;
_root.hackMove2[5] = -0.15;
_root.hackMove2[7] = -0.15;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = _root.KrinLang[KLangChoosen].AUX[30];
addNewBuffKrin("BURN","Target is BURN.","Fire");
_root.hackMove2[16] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 2;
_root.hackMove2[25] = "Target is stunned.";
addNewBuffKrin("STUN","Target is stunned.","Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = "Poison";
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = "Target is stunned.";
addNewBuffKrin("CHAINS",BUFF_NAME[101],"Fire");
_root.hackMove2[7] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[101] + _root.hackMove2[7] * -100 + BUFF_DESC2[101];
addNewBuffKrin("SOLITARY",BUFF_NAME[102],"Fire");
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[102] + _root.hackMove2[13] * 100 + BUFF_DESC2[102];
addNewBuffKrin("PICKTHESOAP",BUFF_NAME[103],"Physical");
_root.hackMove2[15] = 1;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[103] + _root.hackMove2[15] + BUFF_DESC2[103];
addNewBuffKrin("DEATHSENTENCE",BUFF_NAME[104],"Fire");
_root.hackMove2[14] = 9999;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[104];
addNewBuffKrin("HEAVYPUNISHMENT",BUFF_NAME[105],"Fire");
_root.hackMove2[28] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[105];
addNewBuffKrin("HEART",BUFF_NAME[106],"Physical");
_root.hackMove2[11] = 4;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 7;
_root.hackMove2[25] = BUFF_DESC1[106] + _root.hackMove2[11] * 100 + BUFF_DESC2[106];
addNewBuffKrin("POISONBLADE",BUFF_NAME[107],"Poison");
_root.hackMove2[28] = 1;
_root.hackMove2[15] = 2;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[107];
addNewBuffKrin("ARTERY",BUFF_NAME[108],"Physical");
_root.hackMove2[28] = 3;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[108];
addNewBuffKrin("SHELLSHOCK",BUFF_NAME[109],"Fire");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[109];
addNewBuffKrin("AUXILLARY",BUFF_NAME[110],"Lightning");
_root.hackMove2[15] = -15;
_root.hackMove2[33] = -0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[110];
addNewBuffKrin("SUNDER",BUFF_NAME[27],"Physical");
_root.hackMove2[13] = 0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[27] + _root.hackMove2[13] * 100 + BUFF_DESC2[27];
addNewBuffKrin("GREATERPURPOSE",BUFF_NAME[118],"Physical");
_root.hackMove2[13] = -0.4;
_root.hackMove2[35] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[118] + _root.hackMove2[13] * -100 + BUFF_DESC2[118];
addNewBuffKrin("TRUEFORM",BUFF_NAME[119],"Shadow");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 99;
_root.hackMove2[31] = 4;
_root.hackMove2[25] = BUFF_DESC1[119];
addNewBuffKrin("TICKTOCK",BUFF_NAME[120],"Shadow");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[36] = 0.5;
_root.hackMove2[45] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[120];
addNewBuffKrin("HOLYSCARS",BUFF_NAME[121],"Lightning");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[13] = 10;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[121];
addNewBuffKrin("DEEPBURNING",BUFF_NAME[122],"Shadow");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[45] = 0.05;
_root.hackMove2[15] = -100;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[122];
addNewBuffKrin("INFECTBITE",BUFF_NAME[123],"Poison");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[3] = -0.15;
_root.hackMove2[15] = 7;
_root.hackMove2[36] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[123];
addNewBuffKrin("ZPCISHELL",BUFF_NAME[124],"Lightning");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 13;
_root.hackMove2[19] = 2500;
_root.hackMove2[32] = 1;
_root.hackMove2[15] = -150;
_root.hackMove2[3] = -0.9000000000000002;
_root.hackMove2[25] = BUFF_DESC1[124];
addNewBuffKrin("MARKFIRE",BUFF_NAME[125],"Fire");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.2;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[125];
addNewBuffKrin("PICKTHESOAP2",BUFF_NAME[103],"Physical");
_root.hackMove2[15] = 5;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[103] + _root.hackMove2[15] + BUFF_DESC2[103];
addNewBuffKrin("MARKDEATH",BUFF_NAME[126],"Fire");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.15;
_root.hackMove2[13] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[126];
addNewBuffKrin("CALMDOWN",BUFF_NAME[127],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[35] = 2;
_root.hackMove2[25] = BUFF_DESC1[127];
addNewBuffKrin("HEALBUFF",BUFF_NAME[128],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[37] = 2;
_root.hackMove2[25] = BUFF_DESC1[128];
addNewBuffKrin("LOCKANDLOAD",BUFF_NAME[129],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[11] = 3;
_root.hackMove2[25] = BUFF_DESC1[129];
addNewBuffKrin("CROUCH",BUFF_NAME[130],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[23] = 2.5;
_root.hackMove2[25] = BUFF_DESC1[130];
addNewBuffKrin("ZPCISHELL2",BUFF_NAME[131],"Lightning");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 15;
_root.hackMove2[19] = 4000;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[131];
addNewBuffKrin("DULLSENSES",BUFF_NAME[153],"Shadow");
_root.hackMove2[23] = -0.35000000000000003;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[153] + _root.hackMove2[23] * -100 + BUFF_DESC2[153];
addNewBuffKrin("FAITHLESS",BUFF_NAME[154],"Shadow");
_root.hackMove2[36] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[154] + _root.hackMove2[36] * 100 + BUFF_DESC2[154];
addNewBuffKrin("MIDNIGHTOIL",BUFF_NAME[132],"Shadow");
_root.hackMove2[3] = 0.2;
_root.hackMove2[5] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[7] = 0.33000000000000007;
_root.hackMove2[20] = 1;
_root.hackMove2[28] = 1;
_root.hackMove2[25] = BUFF_DESC1[132];
addNewBuffKrin("SHADOWINFUSION2",BUFF_NAME[133],"Shadow");
_root.hackMove2[15] = -7;
_root.hackMove2[16] = 3;
_root.hackMove2[30] = 0.8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[133] + _root.hackMove2[15] * -1 + BUFF_DESC2[133];
addNewBuffKrin("DARKHEAL",BUFF_NAME[134],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[29] = -1.2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[134] + _root.hackMove2[29] * -100 + BUFF_DESC2[134];
addNewBuffKrin("BEGGINGTACTICS",BUFF_NAME[135],"Physical");
_root.hackMove2[15] = -10;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[135];
addNewBuffKrin("PITY",BUFF_NAME[136],"Physical");
_root.hackMove2[11] = -0.9000000000000002;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[136];
addNewBuffKrin("BADSMELL",BUFF_NAME[137],"Poison");
_root.hackMove2[29] = 0.6100000000000001;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[137];
addNewBuffKrin("DARKRAGE",BUFF_NAME[138],"Shadow");
_root.hackMove2[11] = 3;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[138];
addNewBuffKrin("OVERDOSE",BUFF_NAME[139],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[35] = 0.8;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[139];
addNewBuffKrin("BUFF1",BUFF_NAME[140],"Shadow");
_root.hackMove2[26] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[140];
addNewBuffKrin("BUFF2",BUFF_NAME[141],"Shadow");
_root.hackMove2[11] = 0.4;
_root.hackMove2[13] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[141];
addNewBuffKrin("BUFF3",BUFF_NAME[142],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[29] = -1.6600000000000001;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[142];
addNewBuffKrin("SHADOWSTATE",BUFF_NAME[143],"Shadow");
_root.hackMove2[11] = 0.25;
_root.hackMove2[13] = -0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[31] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[143] + _root.hackMove2[11] * 100 + BUFF_DESC2[143] + _root.hackMove2[13] * -100 + BUFF_DESC3[143];
addNewBuffKrin("COLLAPSE",BUFF_NAME[144],"Shadow");
_root.hackMove2[42] = 1;
_root.hackMove2[43] = 1;
_root.hackMove2[44] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[144] + _root.hackMove2[42] * 100 + BUFF_DESC2[144];
addNewBuffKrin("DECAY",BUFF_NAME[145],"Shadow");
_root.hackMove2[29] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[145] + _root.hackMove2[29] * 100 + BUFF_DESC2[145];
addNewBuffKrin("TRUEFORM2",BUFF_NAME[146],"Shadow");
_root.hackMove2[13] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 15;
_root.hackMove2[25] = BUFF_DESC1[146] + _root.hackMove2[13] * 100 + BUFF_DESC2[146];
addNewBuffKrin("HOBODISEASED",BUFF_NAME[147],"Poison");
_root.hackMove2[28] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[147];
addNewBuffKrin("HOBOGROGGY",BUFF_NAME[148],"Physical");
_root.hackMove2[46] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[148] + _root.hackMove2[46] * 100 + BUFF_DESC2[148];
addNewBuffKrin("HOBODRUNK",BUFF_NAME[149],"Physical");
_root.hackMove2[13] = 2.5;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[149] + _root.hackMove2[13] * 100 + BUFF_DESC2[149];
addNewBuffKrin("HOBOSLIFE",BUFF_NAME[150],"Physical");
_root.hackMove2[9] = -0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[150] + _root.hackMove2[9] * -100 + BUFF_DESC2[150];
addNewBuffKrin("HOBOCLUMSY",BUFF_NAME[151],"Physical");
_root.hackMove2[7] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[151];
addNewBuffKrin("VOID",BUFF_NAME[152],"Shadow");
_root.hackMove2[24] = -0.3;
_root.hackMove2[13] = 0.2;
_root.hackMove2[7] = -0.12;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[152];
addNewBuffKrin("NOMANALEFT","","Shadow");
_root.hackMove2[15] = 100;
_root.hackMove2[16] = 1;
addNewBuffKrin("EDGEOFDEATH",BUFF_NAME[155],"Shadow");
_root.hackMove2[9] = -0.85;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[155];
addNewBuffKrin("C1",BUFF_NAME[392],"Magic");
_root.hackMove2[13] = 0.05;
_root.hackMove2[29] = 0.6;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[392] + _root.hackMove2[29] * 100 + BUFF_DESC2[392] + _root.hackMove2[13] * 100 + BUFF_DESC3[392];
addNewBuffKrin("CV1",BUFF_NAME[392],"Magic");
_root.hackMove2[13] = 0.1;
_root.hackMove2[29] = 0.9;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[392] + _root.hackMove2[29] * 100 + BUFF_DESC2[392] + _root.hackMove2[13] * 100 + BUFF_DESC3[392];
addNewBuffKrin("CV11",BUFF_NAME[392],"Magic");
_root.hackMove2[13] = 0.15;
_root.hackMove2[29] = 1.2;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[392] + _root.hackMove2[29] * 100 + BUFF_DESC2[392] + _root.hackMove2[13] * 100 + BUFF_DESC3[392];
addNewBuffKrin("CV111",BUFF_NAME[392],"Magic");
_root.hackMove2[13] = 0.2;
_root.hackMove2[29] = 1.3;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[392] + _root.hackMove2[29] * 100 + BUFF_DESC2[392] + _root.hackMove2[13] * 100 + BUFF_DESC3[392];
addNewBuffKrin("C2",BUFF_NAME[393],"Magic");
_root.hackMove2[24] = -0.1;
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[393] + _root.hackMove2[28] * 100 + BUFF_DESC2[393] + _root.hackMove2[24] * -100 + BUFF_DESC3[393];
addNewBuffKrin("CV2",BUFF_NAME[393],"Magic");
_root.hackMove2[24] = -0.15;
_root.hackMove2[28] = 0.8;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[393] + _root.hackMove2[28] * 100 + BUFF_DESC2[393] + _root.hackMove2[24] * -100 + BUFF_DESC3[393];
addNewBuffKrin("CV22",BUFF_NAME[393],"Magic");
_root.hackMove2[24] = -0.2;
_root.hackMove2[28] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[393] + _root.hackMove2[28] * 100 + BUFF_DESC2[393] + _root.hackMove2[24] * -100 + BUFF_DESC3[393];
addNewBuffKrin("CV222",BUFF_NAME[393],"Magic");
_root.hackMove2[24] = -0.25;
_root.hackMove2[28] = 1.5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[393] + _root.hackMove2[28] * 100 + BUFF_DESC2[393] + _root.hackMove2[24] * -100 + BUFF_DESC3[393];
addNewBuffKrin("C3",BUFF_NAME[394],"Magic");
_root.hackMove2[39] = 5;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[394];
addNewBuffKrin("C33",BUFF_NAME[394],"Magic");
_root.hackMove2[39] = 6;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[399];
addNewBuffKrin("C4",BUFF_NAME[395],"Magic");
_root.hackMove2[39] = 1;
_root.hackMove2[38] = 1;
_root.hackMove2[29] = -2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[395];
addNewBuffKrin("C44",BUFF_NAME[395],"Magic");
_root.hackMove2[39] = 2;
_root.hackMove2[38] = 2;
_root.hackMove2[29] = -3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[400];
addNewBuffKrin("C5",BUFF_NAME[396],"Magic");
_root.hackMove2[28] = -2;
_root.hackMove2[47] = 0.4;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[396];
addNewBuffKrin("C55",BUFF_NAME[396],"Magic");
_root.hackMove2[28] = -3;
_root.hackMove2[47] = 0.5;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[401];
addNewBuffKrin("C6",BUFF_NAME[397],"Magic");
_root.hackMove2[29] = -1;
_root.hackMove2[38] = 2;
_root.hackMove2[47] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[397];
addNewBuffKrin("C66",BUFF_NAME[397],"Magic");
_root.hackMove2[29] = -2;
_root.hackMove2[38] = 2.5;
_root.hackMove2[47] = 0.7;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[402];
addNewBuffKrin("C7",BUFF_NAME[398],"Magic");
_root.hackMove2[39] = 10;
_root.hackMove2[38] = 10;
_root.hackMove2[23] = -0.2;
_root.hackMove2[14] = -300;
_root.hackMove2[16] = 99;
_root.hackMove2[25] = BUFF_DESC1[398];
addNewBuffKrin("C8",BUFF_NAME[403],"Magic");
_root.hackMove2[11] = 0.5;
_root.hackMove2[13] = 1;
_root.hackMove2[23] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 7;
_root.hackMove2[25] = BUFF_DESC1[403];
addNewBuffKrin("C88",BUFF_NAME[403],"Magic");
_root.hackMove2[11] = 0.8;
_root.hackMove2[13] = 0.8;
_root.hackMove2[23] = 0.7;
_root.hackMove2[16] = 5;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[404];
addNewBuffKrin("C888",BUFF_NAME[403],"Magic");
_root.hackMove2[11] = 1;
_root.hackMove2[13] = 0.5;
_root.hackMove2[23] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[31] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[405];
addNewBuffKrin("ENERGYDRAIN2",BUFF_NAME[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[83] + _root.hackMove2[15] + BUFF_DESC2[83];
addNewBuffKrin("ENERGYDRAIN3",BUFF_NAME[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 14;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[83] + _root.hackMove2[15] + BUFF_DESC2[83];
addNewBuffKrin("ENERGYDRAIN4",BUFF_NAME[83],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 20;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[83] + _root.hackMove2[15] + BUFF_DESC2[83];
addNewBuffKrin("C11",BUFF_NAME[406],"Magic");
_root.hackMove2[13] = 0.25;
_root.hackMove2[29] = 1.2;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[406] + _root.hackMove2[29] * 100 + BUFF_DESC2[406] + _root.hackMove2[13] * 100 + BUFF_DESC3[392];
addNewBuffKrin("C12",BUFF_NAME[407],"Magic");
_root.hackMove2[24] = -0.3;
_root.hackMove2[28] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[407] + _root.hackMove2[28] * 100 + BUFF_DESC2[407];
addNewBuffKrin("C9",BUFF_NAME[408],"Magic");
_root.hackMove2[3] = -0.25;
_root.hackMove2[5] = -0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[408];
addNewBuffKrin("C13",BUFF_NAME[409],"Magic");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = "Unit is stunned and cannot act also taking 25% extra damage from all sources.";
addNewBuffKrin("C14",BUFF_NAME[412],"Magic");
_root.hackMove2[29] = -2.5;
_root.hackMove2[28] = -2.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[412];
addNewBuffKrin("C15",BUFF_NAME[412],"Magic");
_root.hackMove2[29] = -4;
_root.hackMove2[28] = -4;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[413];
addNewBuffKrin("C16",BUFF_NAME[410],"Magic");
_root.hackMove2[39] = 5;
_root.hackMove2[38] = 5;
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.2;
_root.hackMove2[25] = BUFF_DESC1[410];
addNewBuffKrin("C17",BUFF_NAME[410],"Magic");
_root.hackMove2[39] = 8;
_root.hackMove2[38] = 8;
_root.hackMove2[16] = 4;
_root.hackMove2[13] = -0.4;
_root.hackMove2[25] = BUFF_DESC1[411];
addNewBuffKrin("C18",BUFF_NAME[414],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 0.3;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[414] + _root.hackMove2[7] * 100 + BUFF_DESC2[414];
addNewBuffKrin("C20",BUFF_NAME[415],"Magic");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -3;
_root.hackMove2[28] = -3;
_root.hackMove2[47] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[415];
addNewBuffKrin("C21",BUFF_NAME[415],"Magic");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -3.5;
_root.hackMove2[28] = -3.5;
_root.hackMove2[47] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[416];
addNewBuffKrin("FORCEOFJUSTICE2",BUFF_NAME[339],"Magic");
_root.hackMove2[5] = 0.2;
_root.hackMove2[3] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[417];
addNewBuffKrin("FORCEOFJUSTICE3",BUFF_NAME[339],"Magic");
_root.hackMove2[5] = 0.25;
_root.hackMove2[3] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[418];
addNewBuffKrin("FORCEOFJUSTICE4",BUFF_NAME[339],"Magic");
_root.hackMove2[5] = 0.3;
_root.hackMove2[3] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[419];
addNewBuffKrin("FORCEOFJUSTICE5",BUFF_NAME[339],"Magic");
_root.hackMove2[5] = 0.4;
_root.hackMove2[3] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[420];
addNewBuffKrin("C222",BUFF_NAME[421],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[13] = -1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[421];
addNewBuffKrin("C23",BUFF_NAME[422],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[28] = -0.5;
_root.hackMove2[29] = -0.5;
_root.hackMove2[25] = BUFF_DESC1[422];
addNewBuffKrin("FATE2",BUFF_NAME[423],"Shadow");
_root.hackMove2[16] = 9;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 100;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[423];
addNewBuffKrin("FATE3",BUFF_NAME[424],"Shadow");
_root.hackMove2[29] = 1.4;
_root.hackMove2[16] = 7;
_root.hackMove2[24] = -0.2;
_root.hackMove2[25] = BUFF_DESC1[424];
addNewBuffKrin("FATE4",BUFF_NAME[425],"Earth");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 5;
_root.hackMove2[9] = -0.6;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[425];
addNewBuffKrin("EARTH",BUFF_NAME[426],"Earth");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 4;
_root.hackMove2[24] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[426];
addNewBuffKrin("EARTH3",BUFF_NAME[427],"Earth");
_root.hackMove2[16] = 5;
_root.hackMove2[19] = 2000;
_root.hackMove2[15] = -20;
_root.hackMove2[14] = -100;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[427];
addNewBuffKrin("EARTH2",BUFF_NAME[428],"Earth");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[15] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[428];
addNewBuffKrin("FATE5",BUFF_NAME[429],"Earth");
_root.hackMove2[14] = 2000;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[429];
addNewBuffKrin("GUARDIAN3",BUFF_NAME[430],"Earth");
_root.hackMove2[38] = 10;
_root.hackMove2[19] = 10;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[430];
addNewBuffKrin("FEARTH3",BUFF_NAME[431],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 2000;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -100;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[431];
addNewBuffKrin("FURY",BUFF_NAME[432],"Earth");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.6;
_root.hackMove2[9] = 0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[432];
addNewBuffKrin("EARTHTERRIFY",BUFF_NAME[433],"Earth");
_root.hackMove2[28] = 1.5;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[433];
addNewBuffKrin("EARTHH",BUFF_NAME[434],"Earth");
_root.hackMove2[7] = -0.15;
_root.hackMove2[28] = 0.6;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[434];
addNewBuffKrin("FURY2",BUFF_NAME[435],"Earth");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.5;
_root.hackMove2[5] = 0.6;
_root.hackMove2[9] = 0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[435];
addNewBuffKrin("FURY3",BUFF_NAME[436],"Shadow");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.5;
_root.hackMove2[3] = 0.6;
_root.hackMove2[9] = -0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[436];
addNewBuffKrin("FURY4",BUFF_NAME[437],"Lightning");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.5;
_root.hackMove2[3] = 0.3;
_root.hackMove2[5] = 0.3;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[437];
addNewBuffKrin("TRUEFORM3",BUFF_NAME[438],"Magic");
_root.hackMove2[16] = 99;
_root.hackMove2[3] = 0.2;
_root.hackMove2[5] = 0.2;
_root.hackMove2[13] = -0.3;
_root.hackMove2[31] = 20;
_root.hackMove2[25] = BUFF_DESC1[438];
addNewBuffKrin("FTR",BUFF_NAME[439],"Shadow");
_root.hackMove2[16] = 20;
_root.hackMove2[13] = -1;
_root.hackMove2[48] = -99;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[439];
addNewBuffKrin("BTR",BUFF_NAME[440],"Shadow");
_root.hackMove2[11] = 0.5;
_root.hackMove2[16] = 40;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[440];
addNewBuffKrin("FATE6",BUFF_NAME[441],"Shadow");
_root.hackMove2[14] = 2500;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[441];
addNewBuffKrin("FATE7",BUFF_NAME[442],"Shadow");
_root.hackMove2[14] = 625;
_root.hackMove2[13] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[442];
addNewBuffKrin("FATE8",BUFF_NAME[443],"Shadow");
_root.hackMove2[14] = -625;
_root.hackMove2[11] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[443];
addNewBuffKrin("HYPO5",BUFF_NAME[22],"Ice");
_root.hackMove2[7] = -0.2;
_root.hackMove2[28] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[22] + _root.hackMove2[28] * 100 + BUFF_DESC2[22] + _root.hackMove2[32] * 100 + BUFF_DESC3[22];
addNewBuffKrin("GLACIER5",BUFF_NAME[26],"Ice");
_root.hackMove2[11] = -0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[26] + _root.hackMove2[11] * -100 + BUFF_DESC2[26] + _root.hackMove2[32] * 100 + BUFF_DESC3[26];
addNewBuffKrin("FROST5",BUFF_NAME[21],"Ice");
_root.hackMove2[7] = -0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 12;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[21] + _root.hackMove2[7] * -100 + BUFF_DESC2[21] + _root.hackMove2[32] * 100 + BUFF_DESC3[21];
addNewBuffKrin("SCHADENFREUDE5",BUFF_NAME[48],"Shadow");
_root.hackMove2[29] = -1.5;
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[48] + _root.hackMove2[29] * -100 + BUFF_DESC2[48];
addNewBuffKrin("PARALYSIS5",BUFF_NAME[47],"Shadow");
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[47] + _root.hackMove2[7] * -100 + BUFF_DESC2[47];
addNewBuffKrin("ECHOEDSCREAMS5",BUFF_NAME[45],"Shadow");
_root.hackMove2[13] = 0.3;
_root.hackMove2[24] = -0.3;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[45] + _root.hackMove2[13] * 100 + BUFF_DESC2[45];
addNewBuffKrin("ELECTRIFIED5",BUFF_NAME[54],"Lightning");
_root.hackMove2[35] = 0.6;
_root.hackMove2[11] = 0.3;
_root.hackMove2[37] = 0.6;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.2;
_root.hackMove2[25] = BUFF_DESC1[54] + _root.hackMove2[35] * 100 + BUFF_DESC2[54];
addNewBuffKrin("UNSTABLECHARGE5",BUFF_NAME[58],"Lightning");
_root.hackMove2[7] = 0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[24] = -0.2;
_root.hackMove2[25] = BUFF_DESC1[58] + _root.hackMove2[7] * 100 + BUFF_DESC2[58];
addNewBuffKrin("EARTHED5",BUFF_NAME[59],"Lightning");
_root.hackMove2[15] = -30;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[59] + _root.hackMove2[15] * -1 + BUFF_DESC2[59];
addNewBuffKrin("EPIPHANY5",BUFF_NAME[60],"Shadow");
_root.hackMove2[29] = 1.5;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[60] + _root.hackMove2[29] * 100 + BUFF_DESC2[60];
addNewBuffKrin("DARKHEAL2",BUFF_NAME[134],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = -4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[134] + _root.hackMove2[29] * -100 + BUFF_DESC2[134];
addNewBuffKrin("WILLPOWER5",BUFF_NAME[52],"Lightning");
_root.hackMove2[39] = 6;
_root.hackMove2[29] = -1.6000000000000005;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[52] + _root.hackMove2[39] * 100 + BUFF_DESC2[52] + _root.hackMove2[29] * -100 + BUFF_DESC3[52];
addNewBuffKrin("LIQUIDVEINS2",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.4;
_root.hackMove2[35] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[88] + _root.hackMove2[46] * 100 + BUFF_DESC2[88];
addNewBuffKrin("ICYBLOOD2",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.7;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("RECUPERATE2",BUFF_NAME[90],"Ice");
_root.hackMove2[33] = -0.09;
_root.hackMove2[3] = -0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[5] = -0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[90];
addNewBuffKrin("SOULSTRIKE2",BUFF_NAME[72],"Ice");
_root.hackMove2[28] = 1.2;
_root.hackMove2[30] = 1.2;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.7;
_root.hackMove2[25] = BUFF_DESC1[72] + _root.hackMove2[28] * 100 + BUFF_DESC2[72];
addNewBuffKrin("ICYRAGE2",BUFF_NAME[73],"Ice");
_root.hackMove2[48] = 0.66;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[73] + _root.hackMove2[48] * 100 + BUFF_DESC2[73];
addNewBuffKrin("SHIELDSTR2",BUFF_NAME[444],"Magic");
_root.hackMove2[38] = 50;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[444];
addNewBuffKrin("PREPARATION2",BUFF_NAME[445],"Magic");
_root.hackMove2[11] = 2;
_root.hackMove2[16] = 6;
_root.hackMove2[31] = 18;
_root.hackMove2[25] = BUFF_DESC1[445];
addNewBuffKrin("FUNDASMENTALISM",BUFF_NAME[446],"Shadow");
_root.hackMove2[48] = 0.5;
_root.hackMove2[11] = 0.2;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = -0.2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[446];
addNewBuffKrin("FATE9",BUFF_NAME[447],"Shadow");
_root.hackMove2[29] = 2.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[447];
addNewBuffKrin("FATE10",BUFF_NAME[448],"Shadow");
_root.hackMove2[28] = 2.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[448];
addNewBuffKrin("FROSTTERROR",BUFF_NAME[449],"Ice");
_root.hackMove2[11] = 0.2;
_root.hackMove2[23] = 0.3;
_root.hackMove2[48] = 0.2;
_root.hackMove2[3] = 0.5;
_root.hackMove2[31] = 17;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[449];
addNewBuffKrin("GUARDIAN2",BUFF_NAME[450],"Physical");
_root.hackMove2[38] = 10;
_root.hackMove2[19] = 10;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[450];
addNewBuffKrin("DUXSPEED",BUFF_NAME[451],"Lightning");
_root.hackMove2[7] = 0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[451];
addNewBuffKrin("ROALDDOT",BUFF_NAME[452],"Fire");
_root.hackMove2[28] = 0.8;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[452];
addNewBuffKrin("DMGRED",BUFF_NAME[453],"Shadow");
_root.hackMove2[13] = -0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[453];
addNewBuffKrin("FREECURE",BUFF_NAME[454],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[65] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[454];
addNewBuffKrin("OVERCURE",BUFF_NAME[455],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[65] = 1.1;
_root.hackMove2[25] = BUFF_DESC1[455];
addNewBuffKrin("DESTINY",BUFF_NAME[456],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 25;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[456] + _root.hackMove2[14] + BUFF_DESC2[456];
addNewBuffKrin("DESTINY2",BUFF_NAME[456],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 100;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[456] + _root.hackMove2[14] + BUFF_DESC2[456];
addNewBuffKrin("DESTINY3",BUFF_NAME[456],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 600;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[456] + _root.hackMove2[14] + BUFF_DESC2[456];
addNewBuffKrin("DESTINY4",BUFF_NAME[456],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 1000;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[456] + _root.hackMove2[14] + BUFF_DESC2[456];
addNewBuffKrin("DESTINY5",BUFF_NAME[456],"Shadow");
_root.hackMove2[16] = 7;
_root.hackMove2[13] = 0.2;
_root.hackMove2[14] = 2000;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[456] + _root.hackMove2[14] + BUFF_DESC2[456];
addNewBuffKrin("DEAD",BUFF_NAME[457],"Shadow");
_root.hackMove2[29] = 1.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[457] + _root.hackMove2[29] * 100 + BUFF_DESC2[457];
addNewBuffKrin("DEAD2",BUFF_NAME[457],"Shadow");
_root.hackMove2[29] = 1.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[457] + _root.hackMove2[29] * 100 + BUFF_DESC2[457];
addNewBuffKrin("DEAD3",BUFF_NAME[457],"Shadow");
_root.hackMove2[29] = 1.55;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[457] + _root.hackMove2[29] * 100 + BUFF_DESC2[457];
addNewBuffKrin("DEAD4",BUFF_NAME[457],"Shadow");
_root.hackMove2[29] = 1.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[457] + _root.hackMove2[29] * 100 + BUFF_DESC2[457];
addNewBuffKrin("SETDESTINY",BUFF_NAME[458],"Shadow");
_root.hackMove2[28] = 1.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[458] + _root.hackMove2[28] * 100 + BUFF_DESC2[458];
addNewBuffKrin("SETDESTINY2",BUFF_NAME[458],"Shadow");
_root.hackMove2[28] = 1.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[458] + _root.hackMove2[28] * 100 + BUFF_DESC2[458];
addNewBuffKrin("SETDESTINY3",BUFF_NAME[458],"Shadow");
_root.hackMove2[28] = 1.55;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[458] + _root.hackMove2[28] * 100 + BUFF_DESC2[458];
addNewBuffKrin("SETDESTINY4",BUFF_NAME[458],"Shadow");
_root.hackMove2[28] = 1.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[458] + _root.hackMove2[28] * 100 + BUFF_DESC2[458];
addNewBuffKrin("EP",BUFF_NAME[459],"Earth");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.2;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[459] + _root.hackMove2[13] * 100 + BUFF_DESC2[459] + _root.hackMove2[24] * -100 + BUFF_DESC3[459];
addNewBuffKrin("EP2",BUFF_NAME[459],"Earth");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.25;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.15;
_root.hackMove2[25] = BUFF_DESC1[459] + _root.hackMove2[13] * 100 + BUFF_DESC2[459] + _root.hackMove2[24] * -100 + BUFF_DESC3[459];
addNewBuffKrin("EP3",BUFF_NAME[459],"Earth");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[459] + _root.hackMove2[13] * 100 + BUFF_DESC2[459] + _root.hackMove2[24] * -100 + BUFF_DESC3[459];
addNewBuffKrin("EP4",BUFF_NAME[459],"Earth");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[24] = -0.35;
_root.hackMove2[27] = 1;
_root.hackMove2[13] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[459] + _root.hackMove2[13] * 100 + BUFF_DESC2[459] + _root.hackMove2[24] * -100 + BUFF_DESC3[459];
addNewBuffKrin("MP",BUFF_NAME[460],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 200;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -20;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[460] + _root.hackMove2[19] + BUFF_DESC2[460] + _root.hackMove2[14] * -1 + BUFF_DESC3[460];
addNewBuffKrin("MP2",BUFF_NAME[460],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 650;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -100;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[460] + _root.hackMove2[19] + BUFF_DESC2[460] + _root.hackMove2[14] * -1 + BUFF_DESC3[460];
addNewBuffKrin("MP3",BUFF_NAME[460],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 1000;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -150;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[460] + _root.hackMove2[19] + BUFF_DESC2[460] + _root.hackMove2[14] * -1 + BUFF_DESC3[460];
addNewBuffKrin("MP4",BUFF_NAME[460],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 2000;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -200;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[460] + _root.hackMove2[19] + BUFF_DESC2[460] + _root.hackMove2[14] * -1 + BUFF_DESC3[460];
addNewBuffKrin("MP5",BUFF_NAME[460],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 3000;
_root.hackMove2[15] = -10;
_root.hackMove2[14] = -300;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[460] + _root.hackMove2[19] + BUFF_DESC2[460] + _root.hackMove2[14] * -1 + BUFF_DESC3[460];
addNewBuffKrin("MESSAGES1","The Embassies of Funda","Shadow");
_root.hackMove2[20] = 1;
_root.hackMove2[11] = 0.25;
_root.hackMove2[37] = 0.25;
_root.hackMove2[16] = -1;
addNewBuffKrin("EMBASSY1",BUFF_NAME[462],"Shadow");
_root.hackMove2[29] = 1.25;
_root.hackMove2[28] = 1.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[462] + _root.hackMove2[29] * 100 + BUFF_DESC2[462];
addNewBuffKrin("EMBASSY2",BUFF_NAME[461],"Shadow");
_root.hackMove2[29] = 1.35;
_root.hackMove2[28] = 1.35;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[462] + _root.hackMove2[29] * 100 + BUFF_DESC2[462];
addNewBuffKrin("EMBASSY3",BUFF_NAME[462],"Shadow");
_root.hackMove2[29] = 1.45;
_root.hackMove2[28] = 1.45;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[462] + _root.hackMove2[29] * 100 + BUFF_DESC2[462];
addNewBuffKrin("EMBASSY4",BUFF_NAME[462],"Shadow");
_root.hackMove2[29] = 1.55;
_root.hackMove2[28] = 1.55;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[462] + _root.hackMove2[29] * 100 + BUFF_DESC2[462];
addNewBuffKrin("EMBASSY5",BUFF_NAME[463],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = 15;
_root.hackMove2[46] = 0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[463] + _root.hackMove2[46] * 100 + BUFF_DESC2[463] + _root.hackMove2[15] + BUFF_DESC3[463];
addNewBuffKrin("EMBASSY6",BUFF_NAME[463],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = 18;
_root.hackMove2[46] = 0.35;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[463] + _root.hackMove2[46] * 100 + BUFF_DESC2[463] + _root.hackMove2[15] + BUFF_DESC3[463];
addNewBuffKrin("EMBASSY7",BUFF_NAME[463],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = 20;
_root.hackMove2[46] = 0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[463] + _root.hackMove2[46] * 100 + BUFF_DESC2[463] + _root.hackMove2[15] + BUFF_DESC3[463];
addNewBuffKrin("EMBASSY8",BUFF_NAME[463],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[15] = 22;
_root.hackMove2[46] = 0.45;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[463] + _root.hackMove2[46] * 100 + BUFF_DESC2[463] + _root.hackMove2[15] + BUFF_DESC3[463];
addNewBuffKrin("EMBASSY9",BUFF_NAME[464],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = -1.5;
_root.hackMove2[28] = -1.5;
_root.hackMove2[20] = -1;
_root.hackMove2[11] = 0.15;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[464] + _root.hackMove2[29] * -100 + BUFF_DESC2[464] + _root.hackMove2[11] * 100 + BUFF_DESC3[464];
addNewBuffKrin("EMBASSY10",BUFF_NAME[464],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = -1.8;
_root.hackMove2[28] = -1.8;
_root.hackMove2[20] = -1;
_root.hackMove2[11] = 0.18;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[464] + _root.hackMove2[29] * -100 + BUFF_DESC2[464] + _root.hackMove2[11] * 100 + BUFF_DESC3[464];
addNewBuffKrin("EMBASSY11",BUFF_NAME[464],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = -2;
_root.hackMove2[28] = -2;
_root.hackMove2[20] = -1;
_root.hackMove2[11] = 0.2;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[464] + _root.hackMove2[29] * -100 + BUFF_DESC2[464] + _root.hackMove2[11] * 100 + BUFF_DESC3[464];
addNewBuffKrin("EMBASSY12",BUFF_NAME[464],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[29] = -2.2;
_root.hackMove2[28] = -2.2;
_root.hackMove2[20] = -1;
_root.hackMove2[11] = 0.22;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[464] + _root.hackMove2[29] * -100 + BUFF_DESC2[464] + _root.hackMove2[11] * 100 + BUFF_DESC3[464];
addNewBuffKrin("FUNDASMENTALISM2",BUFF_NAME[465],"Shadow");
_root.hackMove2[48] = 0.3;
_root.hackMove2[11] = 0.15;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = -0.15;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[465];
addNewBuffKrin("FFURY",BUFF_NAME[466],"Earth");
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.7;
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[466];
addNewBuffKrin("STUNUL",BUFF_NAME[467],"Earth");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[467];
addNewBuffKrin("FUNDASREWARD1",BUFF_NAME[50],"Shadow");
_root.hackMove2[28] = -2;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[28] * -100 + BUFF_DESC2[50];
addNewBuffKrin("FUNDASREWARD2",BUFF_NAME[50],"Shadow");
_root.hackMove2[28] = -2.5;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[28] * -100 + BUFF_DESC2[50];
addNewBuffKrin("FUNDASREWARD3",BUFF_NAME[50],"Shadow");
_root.hackMove2[28] = -3;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[28] * -100 + BUFF_DESC2[50];
addNewBuffKrin("FUNDASREWARD4",BUFF_NAME[50],"Shadow");
_root.hackMove2[28] = -3.3;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[50] + _root.hackMove2[28] * -100 + BUFF_DESC2[50];
addNewBuffKrin("FH1",BUFF_NAME[468],"Shadow");
_root.hackMove2[36] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[468] + _root.hackMove2[36] * 100 + BUFF_DESC2[468];
addNewBuffKrin("FH2",BUFF_NAME[468],"Shadow");
_root.hackMove2[36] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[468] + _root.hackMove2[36] * 100 + BUFF_DESC2[468];
addNewBuffKrin("FH3",BUFF_NAME[468],"Shadow");
_root.hackMove2[36] = 0.55;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[468] + _root.hackMove2[36] * 100 + BUFF_DESC2[468];
addNewBuffKrin("FH4",BUFF_NAME[468],"Shadow");
_root.hackMove2[36] = 0.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[468] + _root.hackMove2[36] * 100 + BUFF_DESC2[468];
addNewBuffKrin("FH5",BUFF_NAME[469],"Earth");
_root.hackMove2[16] = -1;
_root.hackMove2[9] = 1;
_root.hackMove2[7] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[469];
addNewBuffKrin("FH6",BUFF_NAME[470],"Lightning");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[37] = 0.65;
_root.hackMove2[25] = BUFF_DESC1[470];
addNewBuffKrin("FH7",BUFF_NAME[471],"Lightning");
_root.hackMove2[9] = 0.2;
_root.hackMove2[13] = -0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[471];
addNewBuffKrin("BLACKFLAME",BUFF_NAME[472],"Blackflame");
_root.hackMove2[29] = 0.9;
_root.hackMove2[16] = 3;
_root.hackMove2[14] = 2000;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[472];
addNewBuffKrin("BLACKFLAME2",BUFF_NAME[473],"Blackflame");
_root.hackMove2[16] = 5;
_root.hackMove2[48] = 0.4;
_root.hackMove2[13] = -0.15;
_root.hackMove2[25] = BUFF_DESC1[473];
addNewBuffKrin("BLACKFLAME3",BUFF_NAME[474],"Blackflame");
_root.hackMove2[11] = 0.2;
_root.hackMove2[23] = 0.9;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[474];
addNewBuffKrin("CHAPTER1FORCEFUL",BUFF_NAME[475],"Physical");
_root.hackMove2[36] = 0.6;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[475];
addNewBuffKrin("CHAPTER1PRESSURE",BUFF_NAME[476],"Physical");
_root.hackMove2[13] = 0.3;
_root.hackMove2[24] = -0.35;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[476];
addNewBuffKrin("CHAPTER1QUAKE",BUFF_NAME[477],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[14] = 2555;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[477];
addNewBuffKrin("CHAPTER1RIDDHI1",BUFF_NAME[478],"Shadow");
_root.hackMove2[15] = 50;
_root.hackMove2[13] = 0.4;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[478];
addNewBuffKrin("CHAPTER1RIDDHI2",BUFF_NAME[479],"Shadow");
_root.hackMove2[11] = 2;
_root.hackMove2[15] = 15;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[479];
addNewBuffKrin("CHAPTER1RIDDHI3",BUFF_NAME[480],"Shadow");
_root.hackMove2[15] = 25;
_root.hackMove2[11] = 0.8;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[480];
addNewBuffKrin("CHAPTER1RIDDHI4","Prepared","Shadow");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -10;
addNewBuffKrin("CHAPTER1HYPO",BUFF_NAME[481],"Shadow");
_root.hackMove2[5] = -0.3;
_root.hackMove2[3] = -0.3;
_root.hackMove2[28] = 0.8;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 8;
_root.hackMove2[32] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[481];
addNewBuffKrin("CHAPTER1MIRAGE",BUFF_NAME[482],"Shadow");
_root.hackMove2[13] = -0.5;
_root.hackMove2[9] = -0.5;
_root.hackMove2[35] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 15;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[482];
addNewBuffKrin("CHAPTER1PLACEBO",BUFF_NAME[483],"Shadow");
_root.hackMove2[7] = -0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[483];
addNewBuffKrin("CHAPTER1PREPARED",BUFF_NAME[484],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[11] = 1;
_root.hackMove2[15] = -50;
_root.hackMove2[25] = BUFF_DESC1[484];
addNewBuffKrin("CHAPTER1SIDDHI1",BUFF_NAME[485],"Fire");
_root.hackMove2[45] = 0.1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[485];
addNewBuffKrin("CHAPTER1SIDDHI2",BUFF_NAME[486],"Fire");
_root.hackMove2[11] = 2;
_root.hackMove2[45] = 0.15;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[486];
addNewBuffKrin("CHAPTER1SIDDHI3",BUFF_NAME[487],"Fire");
_root.hackMove2[45] = 0.3;
_root.hackMove2[11] = 0.8;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[487];
addNewBuffKrin("CHAPTER1SIDDHI4",BUFF_NAME[488],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[5] = -0.5;
_root.hackMove2[3] = -0.5;
_root.hackMove2[7] = -0.5;
_root.hackMove2[25] = BUFF_DESC1[488];
addNewBuffKrin("NILVEESH",BUFF_NAME[489],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[45] = 0.1;
_root.hackMove2[13] = 0.9;
_root.hackMove2[11] = -0.9;
_root.hackMove2[36] = 0.5;
_root.hackMove2[5] = -0.9;
_root.hackMove2[3] = -0.9;
_root.hackMove2[7] = -0.9;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[489];
addNewBuffKrin("CHAPTER1SRIDDHI1",BUFF_NAME[490],"Physical");
_root.hackMove2[36] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[490];
addNewBuffKrin("CHAPTER1SRIDDHI2",BUFF_NAME[491],"Physical");
_root.hackMove2[11] = 2;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[491];
addNewBuffKrin("CHAPTER1SRIDDHI3",BUFF_NAME[492],"Physical");
_root.hackMove2[9] = -0.3;
_root.hackMove2[11] = 0.8;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[492];
addNewBuffKrin("CHAPTER1SRIDDHI4",BUFF_NAME[493],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[10] = -1500;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[493];
addNewBuffKrin("CHAPTER1RISHAB1",BUFF_NAME[494],"Poison");
_root.hackMove2[36] = 0.4;
_root.hackMove2[45] = 0.1;
_root.hackMove2[15] = 50;
_root.hackMove2[13] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[494];
addNewBuffKrin("CHAPTER1RISHAB2",BUFF_NAME[495],"Poison");
_root.hackMove2[11] = 3;
_root.hackMove2[45] = 0.05;
_root.hackMove2[13] = -0.5;
_root.hackMove2[15] = 15;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[495];
addNewBuffKrin("CHAPTER1RISHAB3",BUFF_NAME[496],"Poison");
_root.hackMove2[9] = -0.3;
_root.hackMove2[15] = 25;
_root.hackMove2[45] = 0.3;
_root.hackMove2[11] = 0.8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[496];
addNewBuffKrin("CHAPTER1RISHAB4",BUFF_NAME[497],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[5] = -0.6;
_root.hackMove2[3] = -0.6;
_root.hackMove2[7] = -0.6;
_root.hackMove2[10] = -1500;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[497];
addNewBuffKrin("CHAPTER1FELICITY1",BUFF_NAME[498],"Physical");
_root.hackMove2[11] = 2;
_root.hackMove2[45] = -0.1;
_root.hackMove2[13] = -0.25;
_root.hackMove2[15] = -25;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[498];
addNewBuffKrin("SHADOWBALL",BUFF_NAME[499],"Shadow");
_root.hackMove2[11] = 0.2;
_root.hackMove2[23] = 0.3;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[499];
addNewBuffKrin("ELECTRICTRUTH",BUFF_NAME[500],"Lightning");
_root.hackMove2[15] = -10;
_root.hackMove2[24] = -0.1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[500];
addNewBuffKrin("ELECTRICTRUTH2",BUFF_NAME[500],"Lightning");
_root.hackMove2[15] = -8;
_root.hackMove2[24] = -0.1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC2[500];
addNewBuffKrin("ELECTRICTRUTH3",BUFF_NAME[500],"Lightning");
_root.hackMove2[15] = -6;
_root.hackMove2[24] = -0.1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC3[500];
addNewBuffKrin("GARTHED1",BUFF_NAME[501],"Shadow");
_root.hackMove2[45] = -0.05;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[501] + _root.hackMove2[45] * -100 + BUFF_DESC2[501];
addNewBuffKrin("GARTHED2",BUFF_NAME[501],"Shadow");
_root.hackMove2[45] = -0.075;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[501] + _root.hackMove2[45] * -100 + BUFF_DESC2[501];
addNewBuffKrin("GARTHED3",BUFF_NAME[501],"Shadow");
_root.hackMove2[45] = -0.085;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[501] + _root.hackMove2[45] * -100 + BUFF_DESC2[501];
addNewBuffKrin("GARTHED4",BUFF_NAME[501],"Shadow");
_root.hackMove2[45] = -0.1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[501] + _root.hackMove2[45] * -100 + BUFF_DESC2[501];
addNewBuffKrin("CONFINED11",BUFF_NAME[64],"Physical");
_root.hackMove2[36] = 0.4500000000000001;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED12",BUFF_NAME[64],"Physical");
_root.hackMove2[36] = 0.6;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED13",BUFF_NAME[64],"Physical");
_root.hackMove2[36] = 0.75;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED14",BUFF_NAME[64],"Physical");
_root.hackMove2[36] = 0.8;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("SEEKDESTROY2",BUFF_NAME[502],"Physical");
_root.hackMove2[23] = 0.4;
_root.hackMove2[24] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[502] + _root.hackMove2[23] * 100 + BUFF_DESC2[502];
addNewBuffKrin("POISONSHIELD",BUFF_NAME[503],"Poison");
_root.hackMove2[42] = 0.5;
_root.hackMove2[43] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[503];
addNewBuffKrin("POISONSHIELD2",BUFF_NAME[504],"Poison");
_root.hackMove2[40] = 5;
_root.hackMove2[38] = 5;
_root.hackMove2[24] = 0.35;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[504];
addNewBuffKrin("LIQUIDVEINS11",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.2;
_root.hackMove2[35] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[88] + _root.hackMove2[46] * 100 + BUFF_DESC2[88];
addNewBuffKrin("LIQUIDVEINS22",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.3;
_root.hackMove2[35] = 0.15;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[505] + _root.hackMove2[46] * 100 + BUFF_DESC2[505] + _root.hackMove2[35] * 100 + BUFF_DESC3[505];
addNewBuffKrin("LIQUIDVEINS33",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.35;
_root.hackMove2[35] = 0.1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[505] + _root.hackMove2[46] * 100 + BUFF_DESC2[505] + _root.hackMove2[35] * 100 + BUFF_DESC3[505];
addNewBuffKrin("LIQUIDVEINS44",BUFF_NAME[88],"Ice");
_root.hackMove2[46] = 0.4;
_root.hackMove2[35] = 0.1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[505] + _root.hackMove2[46] * 100 + BUFF_DESC2[505] + _root.hackMove2[35] * 100 + BUFF_DESC3[505];
addNewBuffKrin("ICYBLOOD11",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("ICYBLOOD22",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 0.75;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("ICYBLOOD33",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("ICYBLOOD44",BUFF_NAME[89],"Ice");
_root.hackMove2[28] = 1.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[89] + _root.hackMove2[28] * 100 + BUFF_DESC2[89];
addNewBuffKrin("ALLSTATSUP",BUFF_NAME[506],"Physical");
_root.hackMove2[3] = 0.5;
_root.hackMove2[5] = 0.5;
_root.hackMove2[7] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[506];
addNewBuffKrin("ADRENALINEHOT",BUFF_NAME[507],"Physical");
_root.hackMove2[13] = -0.2;
_root.hackMove2[35] = 0.35;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[507];
addNewBuffKrin("TOXICSPLASH",BUFF_NAME[13],"Poison");
_root.hackMove2[28] = 0.85;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("WOUND2017",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[64] = 0.475;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("SUPERDAZED",BUFF_NAME[509],"Physical");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = 4.5;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[509];
addNewBuffKrin("ENRAGE2017",BUFF_NAME[510],"Physical");
_root.hackMove2[5] = 3;
_root.hackMove2[3] = 3;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[510];
addNewBuffKrin("SLOW2017",BUFF_NAME[511],"Ice");
_root.hackMove2[7] = -0.35;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[511];
addNewBuffKrin("STRIKEMARK",BUFF_NAME[512],"Shadow");
_root.hackMove2[13] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[512];
addNewBuffKrin("FOCUS2017",BUFF_NAME[513],"Lightning");
_root.hackMove2[15] = 100;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[513];
addNewBuffKrin("FUNDASENVOY",BUFF_NAME[514],"Earth");
_root.hackMove2[3] = 0.25;
_root.hackMove2[5] = 0.25;
_root.hackMove2[7] = 0.25;
_root.hackMove2[15] = -20;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[514];
addNewBuffKrin("FUNDASENVOY2",BUFF_NAME[515],"Earth");
_root.hackMove2[3] = -0.25;
_root.hackMove2[5] = -0.25;
_root.hackMove2[15] = 5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[515];
addNewBuffKrin("CBIGREGEN",BUFF_NAME[516],"Magic");
_root.hackMove2[29] = -2.75;
_root.hackMove2[38] = 3.5;
_root.hackMove2[47] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[516];
addNewBuffKrin("CBIGREGEN2",BUFF_NAME[517],"Magic");
_root.hackMove2[29] = -3.75;
_root.hackMove2[38] = 4.5;
_root.hackMove2[47] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[517];
addNewBuffKrin("C99",BUFF_NAME[518],"Magic");
_root.hackMove2[3] = -0.5;
_root.hackMove2[5] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[518];
addNewBuffKrin("C233",BUFF_NAME[519],"Magic");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[28] = -1;
_root.hackMove2[29] = -1;
_root.hackMove2[25] = BUFF_DESC1[519];
addNewBuffKrin("CENRAGE",BUFF_NAME[520],"Magic");
_root.hackMove2[16] = 20;
_root.hackMove2[45] = -0.1;
_root.hackMove2[13] = -0.5;
_root.hackMove2[11] = 0.5;
_root.hackMove2[5] = 0.5;
_root.hackMove2[3] = 0.5;
_root.hackMove2[7] = 0.5;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[520];
addNewBuffKrin("POISONBLADEB",BUFF_NAME[521],"Poison");
_root.hackMove2[28] = 1;
_root.hackMove2[11] = -0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 1;
_root.hackMove2[25] = BUFF_DESC1[521];
addNewBuffKrin("ARTERYB",BUFF_NAME[522],"Blackflame");
_root.hackMove2[15] = 14;
_root.hackMove2[37] = -0.4;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[522];
addNewBuffKrin("DEADLINEB",BUFF_NAME[523],"Blackflame");
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 20;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[523];
addNewBuffKrin("BLACKFLAMEBLADE",BUFF_NAME[524],"Blackflame");
_root.hackMove2[11] = 0.35;
_root.hackMove2[23] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[25] = BUFF_DESC1[524];
addNewBuffKrin("SAFEGUARDB",BUFF_NAME[34],"Blackflame");
_root.hackMove2[41] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("BERSERKB",BUFF_NAME[525],"Blackflame");
_root.hackMove2[11] = 0.5;
_root.hackMove2[37] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[525];
addNewBuffKrin("WEAKENEDBLACK",BUFF_NAME[526],"Blackflame");
_root.hackMove2[11] = -0.1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[526];
addNewBuffKrin("BLACKFLAMEBURN",BUFF_NAME[527],"Fire");
_root.hackMove2[29] = 0.4;
_root.hackMove2[16] = 5;
_root.hackMove2[46] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[527];
addNewBuffKrin("BLACKFLAMEBLADE99",BUFF_NAME[524],"Blackflame");
_root.hackMove2[16] = -1;
_root.hackMove2[37] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[524];
addNewBuffKrin("SLOW2022",BUFF_NAME[530],"Ice");
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[530];
addNewBuffKrin("DEADLINEB2",BUFF_NAME[529],"Blackflame");
_root.hackMove2[16] = 20;
_root.hackMove2[37] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[41] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[529];
addNewBuffKrin("BLACKFLAMESHIELD",BUFF_NAME[528],"Blackflame");
_root.hackMove2[38] = 5;
_root.hackMove2[19] = 10;
_root.hackMove2[13] = -0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[528] + _root.hackMove2[38] * 100 + BUFF_DESC2[528];
addNewBuffKrin("INFECTBITE2",BUFF_NAME[531],"Blackflame");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[4] = -0.2;
_root.hackMove2[15] = 14;
_root.hackMove2[36] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[531];
addNewBuffKrin("DEADLINEB3",BUFF_NAME[532],"Blackflame");
_root.hackMove2[13] = -1;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[532];
addNewBuffKrin("DEADLINEB4",BUFF_NAME[533],"Blackflame");
_root.hackMove2[11] = 1;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[533];
addNewBuffKrin("Enraged2001",BUFF_NAME[534],"Physical");
_root.hackMove2[11] = 4;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[534];
addNewBuffKrin("Intervention",BUFF_NAME[535],"Lightning");
_root.hackMove2[28] = -0.2;
_root.hackMove2[29] = -0.2;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = 1;
_root.hackMove2[19] = 4400;
_root.hackMove2[14] = -700;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[535];
addNewBuffKrin("FTR2",BUFF_NAME[536],"Fire");
_root.hackMove2[16] = 11;
_root.hackMove2[13] = -1;
_root.hackMove2[48] = -99;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[536];
addNewBuffKrin("AUXILLARY2",BUFF_NAME[537],"Lightning");
_root.hackMove2[15] = -15;
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[537];
addNewBuffKrin("JUGULARGRASP2",BUFF_NAME[180],"Poison");
_root.hackMove2[24] = -0.8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[538] + _root.hackMove2[24] * -100 + BUFF_DESC2[180];
addNewBuffKrin("PRINCESS",BUFF_NAME[539],"Poison");
_root.hackMove2[11] = 0.25;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[539];
addNewBuffKrin("PRINCE",BUFF_NAME[541],"Shadow");
_root.hackMove2[13] = -0.05;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[541];
addNewBuffKrin("JUGULARGRASP3",BUFF_NAME[180],"Shadow");
_root.hackMove2[24] = -0.8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[540] + _root.hackMove2[24] * -100 + BUFF_DESC2[180];
addNewBuffKrin("KING",BUFF_NAME[542],"Fire");
_root.hackMove2[13] = 0.5;
_root.hackMove2[11] = 0.25;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[542];
addNewBuffKrin("JUGULARGRASP4",BUFF_NAME[180],"Fire");
_root.hackMove2[24] = -0.8;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[543] + _root.hackMove2[24] * -100 + BUFF_DESC2[180];
addNewBuffKrin("DEATHMARK2",BUFF_NAME[545],"Shadow");
_root.hackMove2[13] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[545];
addNewBuffKrin("FTR3",BUFF_NAME[544],"Ice");
_root.hackMove2[16] = 6;
_root.hackMove2[13] = -1;
_root.hackMove2[48] = -99;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[544];
addNewBuffKrin("BTR2",BUFF_NAME[546],"Ice");
_root.hackMove2[23] = 1;
_root.hackMove2[16] = 40;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[546];
addNewBuffKrin("EARTHSHOCK",BUFF_NAME[547],"Earth");
_root.hackMove2[24] = -0.8;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[547];
addNewBuffKrin("PROTECTION",BUFF_NAME[548],"Earth");
_root.hackMove2[16] = 6;
_root.hackMove2[19] = 10000000000000000;
_root.hackMove2[13] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[548];
addNewBuffKrin("TICKTOCK2",BUFF_NAME[549],"Ice");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[36] = 0.6;
_root.hackMove2[45] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[549];
addNewBuffKrin("SHELLSHOCK3",BUFF_NAME[109],"Fire");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[109];
addNewBuffKrin("AFFLICTION",BUFF_NAME[550],"Fire");
_root.hackMove2[28] = 0.5;
_root.hackMove2[29] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[550];
addNewBuffKrin("AFFLICTION2",BUFF_NAME[551],"Ice");
_root.hackMove2[28] = 0.25;
_root.hackMove2[29] = 0.25;
_root.hackMove2[24] = -0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[551];
addNewBuffKrin("AFFLICTION3",BUFF_NAME[552],"Shadow");
_root.hackMove2[28] = 0.25;
_root.hackMove2[29] = 0.25;
_root.hackMove2[11] = -0.75;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[552];
addNewBuffKrin("AMBASSADOR",BUFF_NAME[553],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[19] = 10000000;
_root.hackMove2[14] = -100000;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[553];
addNewBuffKrin("AMBASSADOR2",BUFF_NAME[554],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[13] = -0.7;
_root.hackMove2[11] = 0.8;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[554];
addNewBuffKrin("AMBASSADOR3",BUFF_NAME[555],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[555];
addNewBuffKrin("BLOODPRESSURE",BUFF_NAME[556],"Physical");
_root.hackMove2[10] = 3000;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[556];
addNewBuffKrin("BLOODPRESSURE2",BUFF_NAME[557],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[13] = -1;
_root.hackMove2[36] = 1;
_root.hackMove2[25] = BUFF_DESC1[557];
addNewBuffKrin("BLOODPRESSURE3",BUFF_NAME[558],"Physical");
_root.hackMove2[3] = 1;
_root.hackMove2[5] = 1;
_root.hackMove2[7] = 1;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[558];
addNewBuffKrin("PEACE2",BUFF_NAME[559],"Shadow");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[559];
addNewBuffKrin("EQUALITY2",BUFF_NAME[560],"Blackflame");
_root.hackMove2[47] = 0.9000000000000002;
_root.hackMove2[46] = 1.8;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[560];
addNewBuffKrin("UNITY2",BUFF_NAME[561],"Blackflame");
_root.hackMove2[3] = -0.75;
_root.hackMove2[5] = -0.75;
_root.hackMove2[7] = -0.75;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[561];
addNewBuffKrin("GUARDIANEW",BUFF_NAME[562],"Earth");
_root.hackMove2[38] = 15;
_root.hackMove2[28] = -0.5;
_root.hackMove2[19] = 10;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[562];
addNewBuffKrin("DEADLINEE2",BUFF_NAME[563],"Earth");
_root.hackMove2[16] = 9;
_root.hackMove2[20] = 1;
_root.hackMove2[41] = 0.75;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[563];
addNewBuffKrin("SUNDER2",BUFF_NAME[564],"Earth");
_root.hackMove2[47] = -0.2;
_root.hackMove2[46] = 0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[564];
addNewBuffKrin("BERSERK2022",BUFF_NAME[565],"Earth");
_root.hackMove2[11] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[38] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[565];
addNewBuffKrin("BLOODPRESSURE4",BUFF_NAME[566],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[566];
addNewBuffKrin("PRAETOR1",BUFF_NAME[567],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[47] = -1;
_root.hackMove2[25] = BUFF_DESC1[567];
addNewBuffKrin("PRAETOR2",BUFF_NAME[568],"Physical");
_root.hackMove2[5] = 0.2;
_root.hackMove2[3] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[568];
addNewBuffKrin("LIGHTSHOCK",BUFF_NAME[569],"Lightning");
_root.hackMove2[24] = -0.7;
_root.hackMove2[16] = 3;
_root.hackMove2[9] = -0.5;
_root.hackMove2[32] = 0;
_root.hackMove2[25] = BUFF_DESC1[569];
addNewBuffKrin("VULNERABLITY",BUFF_NAME[570],"Physical");
_root.hackMove2[13] = 0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[570];
addNewBuffKrin("FROSTBITTEN",BUFF_NAME[713],"Ice");
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[713];
addNewBuffKrin("BLACKSUPPRESS",BUFF_NAME[64],"Blackflame");
_root.hackMove2[36] = 0.75;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("FTR4",BUFF_NAME[571],"Fire");
_root.hackMove2[16] = 6;
_root.hackMove2[13] = -1;
_root.hackMove2[48] = -99;
_root.hackMove2[17] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[571];
addNewBuffKrin("BTR3",BUFF_NAME[572],"Fire");
_root.hackMove2[23] = 1;
_root.hackMove2[16] = 40;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[572];
addNewBuffKrin("TEAMSACRIFICE2",BUFF_NAME[573],"Lightning");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[35] = 3;
_root.hackMove2[11] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[573];
addNewBuffKrin("BLOCKHEALING2",BUFF_NAME[574],"Lightning");
_root.hackMove2[37] = -1;
_root.hackMove2[11] = 1;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[31] = 18;
_root.hackMove2[25] = BUFF_DESC1[574];
addNewBuffKrin("BLOCKDAMAGE2",BUFF_NAME[575],"Lightning");
_root.hackMove2[11] = -1;
_root.hackMove2[37] = 1;
_root.hackMove2[16] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[13] = 3;
_root.hackMove2[35] = 3;
_root.hackMove2[9] = 3;
_root.hackMove2[31] = 8;
_root.hackMove2[25] = BUFF_DESC1[575];
addNewBuffKrin("PROTECTION2",BUFF_NAME[548],"Earth");
_root.hackMove2[16] = 99;
_root.hackMove2[19] = 10000000000000000;
_root.hackMove2[13] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[576];
addNewBuffKrin("BLACKFLAMEBURN2",BUFF_NAME[577],"Fire");
_root.hackMove2[29] = 0.4;
_root.hackMove2[16] = 3;
_root.hackMove2[46] = 2.5;
_root.hackMove2[25] = BUFF_DESC1[577];
addNewBuffKrin("INSECURE3B",BUFF_NAME[578],"Blackflame");
_root.hackMove2[24] = -0.35000000000000003;
_root.hackMove2[11] = -0.2;
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[578];
addNewBuffKrin("WEAKENEDBLACK2",BUFF_NAME[579],"Blackflame");
_root.hackMove2[5] = -0.2;
_root.hackMove2[3] = -0.2;
_root.hackMove2[7] = -0.2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[25] = BUFF_DESC1[579];
addNewBuffKrin("DEATHSENTENCE2",BUFF_NAME[580],"Fire");
_root.hackMove2[14] = 9999;
_root.hackMove2[7] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[580];
addNewBuffKrin("BTR4",BUFF_NAME[581],"Blackflame");
_root.hackMove2[49] = 8000;
_root.hackMove2[16] = 99;
_root.hackMove2[15] = 7000;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[581];
addNewBuffKrin("FOCUSHELL",BUFF_NAME[374],"Blackflame");
_root.hackMove2[15] = -10000;
_root.hackMove2[16] = 1;
_root.hackMove2[25] = BUFF_DESC1[374];
addNewBuffKrin("EPIPHANY1S",BUFF_NAME[582],"Shadow");
_root.hackMove2[30] = 0.9000000000000002;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[582] + _root.hackMove2[29] * 100 + BUFF_DESC2[582];
addNewBuffKrin("EPIPHANY2S",BUFF_NAME[582],"Shadow");
_root.hackMove2[30] = 1;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[582] + _root.hackMove2[29] * 100 + BUFF_DESC2[582];
addNewBuffKrin("EPIPHANY3S",BUFF_NAME[582],"Shadow");
_root.hackMove2[30] = 1.1;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[582] + _root.hackMove2[29] * 100 + BUFF_DESC2[582];
addNewBuffKrin("EPIPHANY4S",BUFF_NAME[582],"Shadow");
_root.hackMove2[30] = 1.2;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[582] + _root.hackMove2[29] * 100 + BUFF_DESC2[582];
addNewBuffKrin("PARINEETASBERSERK",BUFF_NAME[583],"Blackflame");
_root.hackMove2[7] = 0.5;
_root.hackMove2[5] = 0.5;
_root.hackMove2[13] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[583];
addNewBuffKrin("BLACKFLAMEBURN3",BUFF_NAME[584],"Fire");
_root.hackMove2[29] = 4;
_root.hackMove2[16] = 4;
_root.hackMove2[46] = 0.8;
_root.hackMove2[25] = BUFF_DESC1[584];
addNewBuffKrin("BTR41",BUFF_NAME[585],"Blackflame");
_root.hackMove2[11] = 0.25;
_root.hackMove2[16] = 99;
_root.hackMove2[15] = -1000;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[585];
addNewBuffKrin("BTR5",BUFF_NAME[586],"Physical");
_root.hackMove2[49] = 1000;
_root.hackMove2[16] = 99;
_root.hackMove2[15] = -500;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[586];
addNewBuffKrin("BTR51",BUFF_NAME[587],"Physical");
_root.hackMove2[49] = 2000;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[587];
addNewBuffKrin("BTR52",BUFF_NAME[588],"Physical");
_root.hackMove2[49] = 3000;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[588];
addNewBuffKrin("BTR53",BUFF_NAME[589],"Physical");
_root.hackMove2[49] = 4000;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[589];
addNewBuffKrin("BTR54",BUFF_NAME[590],"Physical");
_root.hackMove2[49] = 5000;
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[590];
addNewBuffKrin("HEAVYPUNISHMENT2",BUFF_NAME[591],"Fire");
_root.hackMove2[28] = 0.9;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[591];
addNewBuffKrin("UNSTABLECHARGENO",BUFF_NAME[592],"Physical");
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[46] = 0.25;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[592];
addNewBuffKrin("EXPOSEDNO",BUFF_NAME[593],"Physical");
_root.hackMove2[46] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[593];
addNewBuffKrin("EPIN2",BUFF_NAME[594],"Poison");
_root.hackMove2[35] = -0.5;
_root.hackMove2[11] = -0.5;
_root.hackMove2[44] = 2.4;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[594];
addNewBuffKrin("HEARTATTACK2",BUFF_NAME[595],"Physical");
_root.hackMove2[46] = 2;
_root.hackMove2[47] = -1;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[595];
addNewBuffKrin("SPIRE2",BUFF_NAME[596],"Earth");
_root.hackMove2[17] = 1;
_root.hackMove2[13] = -1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[596];
addNewBuffKrin("HEAVYPUNISHMENT3",BUFF_NAME[597],"Fire");
_root.hackMove2[28] = 0.15;
_root.hackMove2[11] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[597];
addNewBuffKrin("PRAYER2",BUFF_NAME[598],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[13] = 2;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[598];
addNewBuffKrin("HEARTATTACK3",BUFF_NAME[599],"Physical");
_root.hackMove2[46] = 1;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[599];
addNewBuffKrin("FIREBURN2",BUFF_NAME[600],"Fire");
_root.hackMove2[28] = 4;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[600];
addNewBuffKrin("PATIENCEB",BUFF_NAME[601],"Blackflame");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -25;
_root.hackMove2[20] = 1;
_root.hackMove2[37] = 0.5;
_root.hackMove2[33] = -0.1;
_root.hackMove2[25] = BUFF_DESC1[601];
addNewBuffKrin("ZPCIBURN",BUFF_NAME[602],"Fire");
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[602] + _root.hackMove2[28] * 100 + BUFF_DESC2[602];
addNewBuffKrin("ZPCIBURN2",BUFF_NAME[602],"Fire");
_root.hackMove2[28] = 0.75;
_root.hackMove2[16] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[602] + _root.hackMove2[28] * 100 + BUFF_DESC2[602];
addNewBuffKrin("ZPCIBURN3",BUFF_NAME[602],"Fire");
_root.hackMove2[28] = 0.9;
_root.hackMove2[16] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[602] + _root.hackMove2[28] * 100 + BUFF_DESC2[602];
addNewBuffKrin("ZPCIBURN4",BUFF_NAME[602],"Fire");
_root.hackMove2[28] = 0.95;
_root.hackMove2[16] = 12;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[602] + _root.hackMove2[28] * 100 + BUFF_DESC2[602];
addNewBuffKrin("ZPCIACID",BUFF_NAME[603],"Fire");
_root.hackMove2[24] = -0.05;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[603] + _root.hackMove2[24] * -100 + BUFF_DESC2[603];
addNewBuffKrin("ZPCIACID2",BUFF_NAME[603],"Fire");
_root.hackMove2[24] = -0.1;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[603] + _root.hackMove2[24] * -100 + BUFF_DESC2[603];
addNewBuffKrin("ZPCIACID3",BUFF_NAME[603],"Fire");
_root.hackMove2[24] = -0.12;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[603] + _root.hackMove2[24] * -100 + BUFF_DESC2[603];
addNewBuffKrin("ZPCIACID4",BUFF_NAME[603],"Fire");
_root.hackMove2[24] = -0.15;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[603] + _root.hackMove2[24] * -100 + BUFF_DESC2[603];
addNewBuffKrin("ZPCIFOCUS",BUFF_NAME[604],"Fire");
_root.hackMove2[15] = 15;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[604] + _root.hackMove2[15] * 1 + BUFF_DESC2[604];
addNewBuffKrin("ZPCIFOCUS2",BUFF_NAME[604],"Fire");
_root.hackMove2[15] = 20;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[604] + _root.hackMove2[15] * 1 + BUFF_DESC2[604];
addNewBuffKrin("ZPCIFOCUS3",BUFF_NAME[604],"Fire");
_root.hackMove2[15] = 25;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[604] + _root.hackMove2[15] * 1 + BUFF_DESC2[604];
addNewBuffKrin("ZPCIFOCUS4",BUFF_NAME[604],"Fire");
_root.hackMove2[15] = 30;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[604] + _root.hackMove2[15] * 1 + BUFF_DESC2[604];
addNewBuffKrin("HEAVYPUNISHMENT4",BUFF_NAME[605],"Fire");
_root.hackMove2[28] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[605] + _root.hackMove2[28] * 100 + BUFF_DESC2[605];
addNewBuffKrin("HEAVYPUNISHMENT41",BUFF_NAME[605],"Fire");
_root.hackMove2[28] = 2.8;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[605] + _root.hackMove2[28] * 100 + BUFF_DESC2[605];
addNewBuffKrin("HEAVYPUNISHMENT42",BUFF_NAME[605],"Fire");
_root.hackMove2[28] = 3.6;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[605] + _root.hackMove2[28] * 100 + BUFF_DESC2[605];
addNewBuffKrin("HEAVYPUNISHMENT43",BUFF_NAME[605],"Fire");
_root.hackMove2[28] = 4.4;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[605] + _root.hackMove2[28] * 100 + BUFF_DESC2[605];
addNewBuffKrin("CONFINED1F",BUFF_NAME[64],"Fire");
_root.hackMove2[36] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED2F",BUFF_NAME[64],"Fire");
_root.hackMove2[36] = 0.6;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED3F",BUFF_NAME[64],"Fire");
_root.hackMove2[36] = 0.7;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CONFINED4F",BUFF_NAME[64],"Fire");
_root.hackMove2[36] = 0.9000000000000002;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[64] + _root.hackMove2[36] * 100 + BUFF_DESC2[64];
addNewBuffKrin("CALMDOWN2",BUFF_NAME[606],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[35] = 3;
_root.hackMove2[25] = BUFF_DESC1[606];
addNewBuffKrin("HEALBUFF2",BUFF_NAME[607],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[37] = 3;
_root.hackMove2[25] = BUFF_DESC1[607];
addNewBuffKrin("LOCKANDLOAD2",BUFF_NAME[608],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[11] = 4;
_root.hackMove2[25] = BUFF_DESC1[608];
addNewBuffKrin("CROUCH2",BUFF_NAME[609],"Physical");
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[23] = 3.5;
_root.hackMove2[25] = BUFF_DESC1[609];
addNewBuffKrin("SOLID1F",BUFF_NAME[610],"Fire");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[13] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[31] = 3;
_root.hackMove2[25] = BUFF_DESC1[610];
addNewBuffKrin("SNIPE1",BUFF_NAME[611],"Physical");
_root.hackMove2[11] = -0.12;
_root.hackMove2[13] = 0.12;
_root.hackMove2[7] = -0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[611];
addNewBuffKrin("SNIPE2",BUFF_NAME[611],"Physical");
_root.hackMove2[11] = -0.12;
_root.hackMove2[13] = 0.12;
_root.hackMove2[7] = -0.18;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC2[611];
addNewBuffKrin("SNIPE3",BUFF_NAME[611],"Physical");
_root.hackMove2[11] = -0.12;
_root.hackMove2[13] = 0.12;
_root.hackMove2[7] = -0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC3[611];
addNewBuffKrin("SNIPE4",BUFF_NAME[611],"Physical");
_root.hackMove2[11] = -0.12;
_root.hackMove2[13] = 0.12;
_root.hackMove2[7] = -0.22;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC4[611];
addNewBuffKrin("HEAL1",BUFF_NAME[612],"Physical");
_root.hackMove2[3] = 0.1;
_root.hackMove2[37] = 0.5;
_root.hackMove2[35] = 0.5;
_root.hackMove2[5] = 0.1;
_root.hackMove2[7] = 0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[612];
addNewBuffKrin("HEAL2",BUFF_NAME[612],"Physical");
_root.hackMove2[3] = 0.15;
_root.hackMove2[37] = 0.5;
_root.hackMove2[35] = 0.5;
_root.hackMove2[5] = 0.15;
_root.hackMove2[7] = 0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC2[612];
addNewBuffKrin("HEAL3",BUFF_NAME[612],"Physical");
_root.hackMove2[3] = 0.2;
_root.hackMove2[37] = 0.5;
_root.hackMove2[35] = 0.5;
_root.hackMove2[5] = 0.2;
_root.hackMove2[7] = 0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC3[612];
addNewBuffKrin("HEAL4",BUFF_NAME[612],"Physical");
_root.hackMove2[3] = 0.25;
_root.hackMove2[37] = 0.5;
_root.hackMove2[35] = 0.5;
_root.hackMove2[5] = 0.25;
_root.hackMove2[7] = 0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC4[612];
addNewBuffKrin("BLACKFLAMEBLADESONNY",BUFF_NAME[613],"Blackflame");
_root.hackMove2[11] = 0.25;
_root.hackMove2[23] = 0.15;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = BUFF_DESC1[613] + _root.hackMove2[11] * 100 + BUFF_DESC2[613] + _root.hackMove2[23] * 100 + BUFF_DESC3[613];
addNewBuffKrin("BLACKFLAMEBLADESONNY2",BUFF_NAME[613],"Blackflame");
_root.hackMove2[11] = 0.3;
_root.hackMove2[23] = 0.18;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = BUFF_DESC1[613] + _root.hackMove2[11] * 100 + BUFF_DESC2[613] + _root.hackMove2[23] * 100 + BUFF_DESC3[613];
addNewBuffKrin("BLACKFLAMEBLADESONNY3",BUFF_NAME[613],"Blackflame");
_root.hackMove2[11] = 0.34;
_root.hackMove2[23] = 0.22;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = BUFF_DESC1[613] + _root.hackMove2[11] * 100 + BUFF_DESC2[613] + _root.hackMove2[23] * 100 + BUFF_DESC3[613];
addNewBuffKrin("BLACKFLAMEBLADESONNY4",BUFF_NAME[613],"Blackflame");
_root.hackMove2[11] = 0.4;
_root.hackMove2[23] = 0.28;
_root.hackMove2[118] = "BLACKBURN456";
_root.hackMove2[16] = 5;
_root.hackMove2[25] = BUFF_DESC1[613] + _root.hackMove2[11] * 100 + BUFF_DESC2[613] + _root.hackMove2[23] * 100 + BUFF_DESC3[613] + BUFF_DESC4[613];
addNewBuffKrin("BLACKBURN456",BUFF_NAME[709],"Fire");
_root.hackMove2[28] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[709];
addNewBuffKrin("BLACKBURN4567",BUFF_NAME[710],"Fire");
_root.hackMove2[28] = 0.75;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[710];
addNewBuffKrin("BLACKFLAMESHIELDSONNY",BUFF_NAME[614],"Blackflame");
_root.hackMove2[38] = 6.5;
_root.hackMove2[19] = 10;
_root.hackMove2[13] = -0.2;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[614] + _root.hackMove2[38] * 100 + BUFF_DESC2[614] + _root.hackMove2[13] * -100 + BUFF_DESC3[614];
addNewBuffKrin("BLACKFLAMESHIELDSONNY2",BUFF_NAME[614],"Blackflame");
_root.hackMove2[38] = 8;
_root.hackMove2[19] = 10;
_root.hackMove2[13] = -0.25;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[614] + _root.hackMove2[38] * 100 + BUFF_DESC2[614] + _root.hackMove2[13] * -100 + BUFF_DESC3[614];
addNewBuffKrin("BLACKFLAMESHIELDSONNY3",BUFF_NAME[614],"Blackflame");
_root.hackMove2[38] = 10;
_root.hackMove2[19] = 10;
_root.hackMove2[13] = -0.3;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[614] + _root.hackMove2[38] * 100 + BUFF_DESC2[614] + _root.hackMove2[13] * -100 + BUFF_DESC3[614];
addNewBuffKrin("BLACKFLAMESHIELDSONNY4",BUFF_NAME[614],"Blackflame");
_root.hackMove2[38] = 12;
_root.hackMove2[19] = 10;
_root.hackMove2[13] = -0.35;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[614] + _root.hackMove2[38] * 100 + BUFF_DESC2[614] + _root.hackMove2[13] * -100 + BUFF_DESC3[614];
addNewBuffKrin("BLACKVOID",BUFF_NAME[615],"Blackflame");
_root.hackMove2[35] = -0.05;
_root.hackMove2[13] = 0.1;
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[615] + _root.hackMove2[13] * 100 + BUFF_DESC2[615];
addNewBuffKrin("BLACKVOID2",BUFF_NAME[615],"Blackflame");
_root.hackMove2[35] = -0.05;
_root.hackMove2[13] = 0.15;
_root.hackMove2[16] = 6;
_root.hackMove2[28] = 0.5;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[615] + _root.hackMove2[13] * 100 + BUFF_DESC2[615];
addNewBuffKrin("BLACKVOID3",BUFF_NAME[615],"Blackflame");
_root.hackMove2[35] = -0.05;
_root.hackMove2[13] = 0.2;
_root.hackMove2[16] = 6;
_root.hackMove2[28] = 0.5;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[615] + _root.hackMove2[13] * 100 + BUFF_DESC2[615];
addNewBuffKrin("SAFEGUARDB2",BUFF_NAME[616],"Blackflame");
_root.hackMove2[41] = 0.15;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARDB3",BUFF_NAME[616],"Blackflame");
_root.hackMove2[41] = 0.25;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARDB4",BUFF_NAME[616],"Blackflame");
_root.hackMove2[41] = 0.35;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("SAFEGUARDB5",BUFF_NAME[616],"Blackflame");
_root.hackMove2[41] = 0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[34] + _root.hackMove2[41] * 100 + BUFF_DESC2[34];
addNewBuffKrin("BERSERKB2",BUFF_NAME[617],"Blackflame");
_root.hackMove2[11] = 0.2;
_root.hackMove2[37] = 0.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[617] + _root.hackMove2[11] * 100 + BUFF_DESC2[617];
addNewBuffKrin("BERSERKB3",BUFF_NAME[617],"Blackflame");
_root.hackMove2[11] = 0.25;
_root.hackMove2[37] = 0.25;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[617] + _root.hackMove2[11] * 100 + BUFF_DESC2[617];
addNewBuffKrin("BERSERKB4",BUFF_NAME[617],"Blackflame");
_root.hackMove2[11] = 0.3;
_root.hackMove2[37] = 0.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[617] + _root.hackMove2[11] * 100 + BUFF_DESC2[617];
addNewBuffKrin("BERSERKB5",BUFF_NAME[617],"Blackflame");
_root.hackMove2[11] = 0.4;
_root.hackMove2[37] = 0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[617] + _root.hackMove2[11] * 100 + BUFF_DESC2[617];
addNewBuffKrin("SLOW2022B",BUFF_NAME[618],"Blackflame");
_root.hackMove2[7] = -0.1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[618] + _root.hackMove2[7] * -100 + BUFF_DESC2[618];
addNewBuffKrin("SLOW2022B2",BUFF_NAME[618],"Blackflame");
_root.hackMove2[7] = -0.15;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[618] + _root.hackMove2[7] * -100 + BUFF_DESC2[618];
addNewBuffKrin("SLOW2022B3",BUFF_NAME[618],"Blackflame");
_root.hackMove2[7] = -0.2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[618] + _root.hackMove2[7] * -100 + BUFF_DESC2[618];
addNewBuffKrin("SLOW2022B4",BUFF_NAME[618],"Blackflame");
_root.hackMove2[7] = -0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[618] + _root.hackMove2[7] * -100 + BUFF_DESC2[618];
addNewBuffKrin("SILENCEDB",BUFF_NAME[111],"Blackflame");
_root.hackMove2[50] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[111];
addNewBuffKrin("DEADLINEB6",BUFF_NAME[619],"Blackflame");
_root.hackMove2[37] = -0.5;
_root.hackMove2[16] = 20;
_root.hackMove2[9] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[619];
addNewBuffKrin("DEADLINEB5",BUFF_NAME[620],"Blackflame");
_root.hackMove2[16] = 20;
_root.hackMove2[37] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[13] = -0.2;
_root.hackMove2[41] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[620];
addNewBuffKrin("BERSER1",BUFF_NAME[621],"Physical");
_root.hackMove2[23] = -10;
_root.hackMove2[11] = 2;
_root.hackMove2[48] = 2;
_root.hackMove2[47] = -0.75;
_root.hackMove2[13] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[621] + _root.hackMove2[11] * 100 + BUFF_DESC2[621];
addNewBuffKrin("ALLSTATDOWNB",BUFF_NAME[622],"Blackflame");
_root.hackMove2[5] = -0.15;
_root.hackMove2[3] = -0.15;
_root.hackMove2[46] = 0.3;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[25] = BUFF_DESC1[622];
addNewBuffKrin("SLEEPYB1",BUFF_NAME[623],"Blackflame");
_root.hackMove2[5] = 0.2;
_root.hackMove2[11] = -0.2;
_root.hackMove2[3] = 0.2;
_root.hackMove2[35] = 2;
_root.hackMove2[18] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[623];
addNewBuffKrin("POISONVERA",BUFF_NAME[624],"Poison");
_root.hackMove2[28] = 1.2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[13] + _root.hackMove2[28] * 100 + BUFF_DESC2[13] + _root.hackMove2[32] * 100 + BUFF_DESC3[13];
addNewBuffKrin("BLOODLILY",BUFF_NAME[625],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[625];
addNewBuffKrin("BLOODLILY2",BUFF_NAME[626],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[66] = 0.5;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 3;
_root.hackMove2[25] = BUFF_DESC1[626];
addNewBuffKrin("MUTATION2",BUFF_NAME[627],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 1;
_root.hackMove2[57] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[627];
addNewBuffKrin("MUTATION3",BUFF_NAME[628],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[57] = -0.5;
_root.hackMove2[25] = BUFF_DESC1[628];
addNewBuffKrin("MUTATION4",BUFF_NAME[629],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[2] = 0.15;
_root.hackMove2[4] = 0.15;
_root.hackMove2[6] = 0.15;
_root.hackMove2[32] = 1;
_root.hackMove2[66] = -0.5;
_root.hackMove2[25] = BUFF_DESC1[629];
addNewBuffKrin("BREACH",BUFF_NAME[630],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[630];
addNewBuffKrin("DEFENSE15",BUFF_NAME[630],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[82] = 0.15;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[630];
addNewBuffKrin("SUPERREGEN",BUFF_NAME[631],"Poison");
_root.hackMove2[29] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[631];
addNewBuffKrin("WOODWEAVE",BUFF_NAME[632],"Poison");
_root.hackMove2[67] = "WOODWEAVE2";
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("WOODWEAVE3",BUFF_NAME[632],"Poison");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("WOODWEAVE2",BUFF_NAME[632],"Poison");
_root.hackMove2[90] = 0.2;
_root.hackMove2[91] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("SYNTHESIS",BUFF_NAME[631],"Poison");
_root.hackMove2[29] = -0.8;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[631];
addNewBuffKrin("FURYDEADLY",BUFF_NAME[633],"Poison");
_root.hackMove2[16] = 1;
_root.hackMove2[68] = 4.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[633];
addNewBuffKrin("SUPERVENOM",BUFF_NAME[634],"Poison");
_root.hackMove2[28] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[634];
addNewBuffKrin("ANAESTHETIC",BUFF_NAME[635],"Physical");
_root.hackMove2[3] = -0.5;
_root.hackMove2[5] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[635];
addNewBuffKrin("TITANMADNESS",BUFF_NAME[636],"Fire");
_root.hackMove2[7] = -0.15;
_root.hackMove2[3] = 1.3;
_root.hackMove2[5] = 1.3;
_root.hackMove2[13] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[636];
addNewBuffKrin("WILDINSTINCT",BUFF_NAME[637],"Physical");
_root.hackMove2[3] = 0.7;
_root.hackMove2[5] = 0.7;
_root.hackMove2[82] = 0.7;
_root.hackMove2[27] = 1;
_root.hackMove2[46] = 0.7;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[637];
addNewBuffKrin("DUELSTRIKE2",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("SNAPKICK",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = 0.5;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("DUELSTRIKE",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = 0.9;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("WARPSTRIKE",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = 0.75;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("WARPSTRIKE2",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = -0.75;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("SHOCKWAVE",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = -1;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("SHADESTRIKE",BUFF_NAME[6355],"Physical");
_root.hackMove2[84] = 0.25;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("FURYDEADLY2",BUFF_NAME[638],"Ice");
_root.hackMove2[16] = 1;
_root.hackMove2[68] = -4.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[638];
addNewBuffKrin("SEDUCE",BUFF_NAME[639],"Ice");
_root.hackMove2[11] = -0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[9] = -0.5;
_root.hackMove2[57] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[639];
addNewBuffKrin("CRUNCH",BUFF_NAME[640],"Shadow");
_root.hackMove2[13] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[640];
addNewBuffKrin("CHAINSDARK",BUFF_NAME[641],"Shadow");
_root.hackMove2[7] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[641];
addNewBuffKrin("CRUNCH2",BUFF_NAME[642],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 1;
_root.hackMove2[37] = -0.8;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[642];
addNewBuffKrin("SUPERREGEN2",BUFF_NAME[643],"Ice");
_root.hackMove2[29] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -15;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[643];
addNewBuffKrin("ICE1",BUFF_NAME[644],"Ice");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[644];
addNewBuffKrin("SLOW20172",BUFF_NAME[511],"Physical");
_root.hackMove2[7] = -0.35;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[511];
addNewBuffKrin("EXPOSE",BUFF_NAME[632],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[69] = 0.2;
_root.hackMove2[139] = 0.2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("SHARPENSTEEL",BUFF_NAME[632],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[70] = "SHARPENSTEEL2";
_root.hackMove2[90] = 0.05;
_root.hackMove2[91] = 0.05;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("SHARPENSTEEL2",BUFF_NAME[632],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[90] = 0.05;
_root.hackMove2[91] = 0.05;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[632];
addNewBuffKrin("FLAMESPLITTER",BUFF_NAME[645],"Fire");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[645];
addNewBuffKrin("FLAMESPLITTER2",BUFF_NAME[651],"Fire");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[651];
addNewBuffKrin("AMPLIFY",BUFF_NAME[646],"Physical");
_root.hackMove2[13] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[646];
addNewBuffKrin("EXPOSE2",BUFF_NAME[647],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[46] = -0.75;
_root.hackMove2[20] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("UNSTABLECORE",BUFF_NAME[647],"Fire");
_root.hackMove2[29] = 2.7;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("RADIATIONBURN",BUFF_NAME[647],"Fire");
_root.hackMove2[72] = 0.7;
_root.hackMove2[16] = -1;
_root.hackMove2[147] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SUPERBURN",BUFF_NAME[648],"Fire");
_root.hackMove2[28] = 2;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[648];
addNewBuffKrin("SEAR",BUFF_NAME[649],"Fire");
_root.hackMove2[28] = 0.7;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[649];
addNewBuffKrin("NUKECALIBRATION3",BUFF_NAME[652],"Fire");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[652];
addNewBuffKrin("NUKECALIBRATION4",BUFF_NAME[655],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[68] = -4.5;
_root.hackMove2[25] = BUFF_DESC1[655];
addNewBuffKrin("NUKECALIBRATION",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[74] = "NUKECALIBRATION2";
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("NUKECALIBRATION2",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[90] = 0.5;
_root.hackMove2[91] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("HUNGERMARK",BUFF_NAME[650],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[73] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[57] = 3;
_root.hackMove2[25] = BUFF_DESC1[650];
addNewBuffKrin("ENVELOPE",BUFF_NAME[656],"Fire");
_root.hackMove2[7] = -0.8;
_root.hackMove2[71] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[656];
addNewBuffKrin("NIGHT",BUFF_NAME[653],"Shadow");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 10;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[83] + _root.hackMove2[15] + BUFF_DESC2[83];
addNewBuffKrin("DAY",BUFF_NAME[654],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -10;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[654];
addNewBuffKrin("FIRE+",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[76] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SILENCE",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[75] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SILENCE3",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[75] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SILENCE2",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[75] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SILENCE50",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[75] = 50;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("SILENCE25",BUFF_NAME[647],"Fire");
_root.hackMove2[16] = -1;
_root.hackMove2[71] = 1;
_root.hackMove2[75] = 25;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[647];
addNewBuffKrin("BADSMELL2",BUFF_NAME[137],"Poison");
_root.hackMove2[29] = 0.3100000000000001;
_root.hackMove2[16] = 99;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[137];
addNewBuffKrin("SUPPRESS",BUFF_NAME[657],"Shadow");
_root.hackMove2[36] = 0.7;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[657];
addNewBuffKrin("SUPERSTUN",BUFF_NAME[2],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[2];
addNewBuffKrin("BLIND",BUFF_NAME[658],"Ice");
_root.hackMove2[16] = 3;
_root.hackMove2[77] = -32.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[658];
addNewBuffKrin("BLESSING",BUFF_NAME[659],"Shadow");
_root.hackMove2[3] = 3;
_root.hackMove2[5] = 3;
_root.hackMove2[7] = 3;
_root.hackMove2[16] = 5;
_root.hackMove2[82] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[659];
addNewBuffKrin("ESSENCELAPSE",BUFF_NAME[3],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[64] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("FROSTARROW",BUFF_NAME[660],"Ice");
_root.hackMove2[7] = -0.8;
_root.hackMove2[16] = 1;
_root.hackMove2[78] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[660];
addNewBuffKrin("BLOODHUNGER",BUFF_NAME[627],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[57] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[627];
addNewBuffKrin("EMBLEMOFDEFENSE",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[79] = "GUARD";
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("EMBLEMOFPOWER",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[79] = "EMPOWER";
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("EMBLEMOFHEALING",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[79] = "SUPERREGEN";
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("HEALINGMANA",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[81] = -20;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[508];
addNewBuffKrin("EMPOWER",BUFF_NAME[661],"Physical");
_root.hackMove2[3] = 0.5;
_root.hackMove2[5] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("STONEFORM",BUFF_NAME[716],"Physical");
_root.hackMove2[3] = 0.5;
_root.hackMove2[5] = 0.5;
_root.hackMove2[82] = 0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[716];
addNewBuffKrin("EMPOWER2",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.15;
_root.hackMove2[90] = 0.15;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("BOOSTGROWTH",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.28;
_root.hackMove2[90] = 0.28;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("HEATSHIFT",BUFF_NAME[661],"Fire");
_root.hackMove2[91] = 0.7;
_root.hackMove2[82] = -0.7;
_root.hackMove2[90] = 0.7;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("EMPOWERSHADOW",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.05;
_root.hackMove2[90] = 0.05;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("EMPOWER3",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.1;
_root.hackMove2[90] = 0.1;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("EMPOWER4",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.07;
_root.hackMove2[90] = 0.07;
_root.hackMove2[16] = -1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("SPEEDGAIN",BUFF_NAME[661],"Physical");
_root.hackMove2[92] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("EMPOWER5",BUFF_NAME[661],"Physical");
_root.hackMove2[91] = 0.2;
_root.hackMove2[90] = 0.2;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("GUARD",BUFF_NAME[662],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = 1.5;
_root.hackMove2[80] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[662];
addNewBuffKrin("HEALINGMANA2",BUFF_NAME[663],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[13] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[663];
addNewBuffKrin("POWERPULSE",BUFF_NAME[661],"Lightning");
_root.hackMove2[83] = "EMPOWER2";
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("DIVINEWIND",BUFF_NAME[661],"Lightning");
_root.hackMove2[88] = "EMPOWER3";
_root.hackMove2[85] = 0.5;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("SHADOWWALTZ",BUFF_NAME[661],"Shadow");
_root.hackMove2[83] = "SHADOWWALTZ2";
_root.hackMove2[16] = -1;
_root.hackMove2[7] = 0.03;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("SHADOWWALTZ2",BUFF_NAME[6355],"Shadow");
_root.hackMove2[84] = 0.35;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[6355];
addNewBuffKrin("ENRAGE2017L",BUFF_NAME[510],"Lightning");
_root.hackMove2[5] = 3;
_root.hackMove2[3] = 3;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[510];
addNewBuffKrin("MUTATION2017",BUFF_NAME[667],"Physical");
_root.hackMove2[5] = 1;
_root.hackMove2[3] = 1;
_root.hackMove2[29] = 2;
_root.hackMove2[7] = -0.4;
_root.hackMove2[13] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[667];
addNewBuffKrin("DIVINEWIND2",BUFF_NAME[664],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[664];
addNewBuffKrin("DIVINEWIND3",BUFF_NAME[665],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[665];
addNewBuffKrin("DIVINEWIND4",BUFF_NAME[666],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[666];
addNewBuffKrin("DIVINEWIND5",BUFF_NAME[668],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[668];
addNewBuffKrin("HASTE",BUFF_NAME[669],"Lightning");
_root.hackMove2[7] = 0.3;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[669];
addNewBuffKrin("QUICKNESS",BUFF_NAME[670],"Lightning");
_root.hackMove2[7] = 0.75;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[670];
addNewBuffKrin("CLARITY",BUFF_NAME[671],"Lightning");
_root.hackMove2[86] = 5;
_root.hackMove2[87] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[671];
addNewBuffKrin("COUNTER",BUFF_NAME[672],"Lightning");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[672];
addNewBuffKrin("DECAY2",BUFF_NAME[673],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[673];
addNewBuffKrin("DECAY3",BUFF_NAME[673],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[28] = 0.8;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[673];
addNewBuffKrin("CHROMASCREEN2",BUFF_NAME[674],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[674];
addNewBuffKrin("CHROMASCREEN",BUFF_NAME[674],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[94] = "PROTECTED";
_root.hackMove2[100] = "PROTECTED2";
_root.hackMove2[101] = "PROTECTED3";
_root.hackMove2[102] = "PROTECTED4";
_root.hackMove2[103] = "PROTECTED5";
_root.hackMove2[104] = "PROTECTED6";
_root.hackMove2[105] = "PROTECTED7";
_root.hackMove2[106] = "PROTECTED8";
_root.hackMove2[107] = "PROTECTED9";
_root.hackMove2[25] = BUFF_DESC1[674];
addNewBuffKrin("INTIMIDATE",BUFF_NAME[676],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[676];
addNewBuffKrin("DARKABSORB2",BUFF_NAME[678],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[678];
addNewBuffKrin("DARKABSORB3",BUFF_NAME[684],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[684];
addNewBuffKrin("OUTLAST2",BUFF_NAME[680],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[680];
addNewBuffKrin("OUTLAST",BUFF_NAME[680],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[83] = "EMPOWER3";
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[680];
addNewBuffKrin("PROTECTED",BUFF_NAME[683],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[71] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED2",BUFF_NAME[683],"Magic");
_root.hackMove2[16] = 3;
_root.hackMove2[71] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED3",BUFF_NAME[683],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[71] = 1;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED4",BUFF_NAME[683],"Ice");
_root.hackMove2[16] = 3;
_root.hackMove2[71] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED5",BUFF_NAME[683],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED6",BUFF_NAME[683],"Earth");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED7",BUFF_NAME[683],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED8",BUFF_NAME[683],"Poison");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("PROTECTED9",BUFF_NAME[683],"Blackflame");
_root.hackMove2[16] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[71] = 1;
_root.hackMove2[24] = 2;
_root.hackMove2[25] = BUFF_DESC1[683];
addNewBuffKrin("DAZED",BUFF_NAME[677],"Physical");
_root.hackMove2[16] = 2;
_root.hackMove2[13] = 0.3;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[677];
addNewBuffKrin("INTIMIDATE2",BUFF_NAME[676],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[95] = "ANAESTHETIC";
_root.hackMove2[25] = BUFF_DESC1[676];
addNewBuffKrin("DARKABSORB",BUFF_NAME[678],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[96] = "EMPOWER4";
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[678];
addNewBuffKrin("SHADOWHEX",BUFF_NAME[675],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[97] = "EMPOWER5";
_root.hackMove2[25] = BUFF_DESC1[675];
addNewBuffKrin("DREAMSTATE",BUFF_NAME[681],"Shadow");
_root.hackMove2[13] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[35] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[681];
addNewBuffKrin("BLEND",BUFF_NAME[679],"Shadow");
_root.hackMove2[7] = 0.5;
_root.hackMove2[86] = 5;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[679];
addNewBuffKrin("BLACKMIRROR",BUFF_NAME[682],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[66] = 0.5;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[682];
addNewBuffKrin("BLACKMIRROR2",BUFF_NAME[682],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[682];
addNewBuffKrin("ENRAGEBELAS",BUFF_NAME[686],"Poison");
_root.hackMove2[5] = 0.5;
_root.hackMove2[3] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[686];
addNewBuffKrin("STATSDOWNCASS",BUFF_NAME[687],"Magic");
_root.hackMove2[3] = -0.8;
_root.hackMove2[5] = -0.8;
_root.hackMove2[16] = 4;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[687];
addNewBuffKrin("SUPERVENOM2",BUFF_NAME[688],"Poison");
_root.hackMove2[28] = 2;
_root.hackMove2[86] = 5;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[688];
addNewBuffKrin("ANAESTHETIC2",BUFF_NAME[689],"Physical");
_root.hackMove2[11] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[689];
addNewBuffKrin("HEALINGMANA2",BUFF_NAME[3],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[20] = -1;
_root.hackMove2[81] = -1;
_root.hackMove2[27] = 1;
addNewBuffKrin("GOLBEZ2",BUFF_NAME[690],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 150;
_root.hackMove2[32] = 1;
_root.hackMove2[80] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[690];
addNewBuffKrin("PALLADION",BUFF_NAME[691],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[49] = 900;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[691];
addNewBuffKrin("PARTHENOS2",BUFF_NAME[696],"Shadow");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[15] = 1000;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[696];
addNewBuffKrin("SOULGRASP",BUFF_NAME[691],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[691];
addNewBuffKrin("BLEED2",BUFF_NAME[690],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[28] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[690];
addNewBuffKrin("SILKSPIT",BUFF_NAME[692],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[7] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[692];
addNewBuffKrin("SILKSPIT2",BUFF_NAME[693],"Magic");
_root.hackMove2[16] = 2;
_root.hackMove2[7] = -0.8;
_root.hackMove2[108] = 4.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[693];
addNewBuffKrin("BONDS1",BUFF_NAME[694],"Poison");
_root.hackMove2[16] = 1;
_root.hackMove2[68] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[694];
addNewBuffKrin("PARTHENOS",BUFF_NAME[695],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[13] = -0.5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[695];
addNewBuffKrin("POINT",BUFF_NAME[697],"Lightning");
_root.hackMove2[16] = 2;
_root.hackMove2[66] = 999999;
_root.hackMove2[20] = 1;
_root.hackMove2[81] = -1;
_root.hackMove2[25] = BUFF_DESC1[697];
addNewBuffKrin("DONUT",BUFF_NAME[698],"Lightning");
_root.hackMove2[16] = 3;
_root.hackMove2[66] = -999999;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[698];
addNewBuffKrin("INTIMIDATE3",BUFF_NAME[699],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[699];
addNewBuffKrin("INTIMIDATE4",BUFF_NAME[676],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[95] = "VULNERABLITY";
_root.hackMove2[25] = BUFF_DESC1[676];
addNewBuffKrin("VANTAGEPOINT",BUFF_NAME[700],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[700];
addNewBuffKrin("VANTAGEPOINT2",BUFF_NAME[676],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[35] = 1;
_root.hackMove2[25] = BUFF_DESC1[676];
addNewBuffKrin("STUNRESIST",BUFF_NAME[662],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[80] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[662];
addNewBuffKrin("HYDROGENSHELL",BUFF_NAME[701],"Ice");
_root.hackMove2[13] = -0.8;
_root.hackMove2[16] = 6;
_root.hackMove2[116] = 3;
_root.hackMove2[117] = 0.5;
_root.hackMove2[109] = 3;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("UNIFICATION",BUFF_NAME[702],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[702];
addNewBuffKrin("UNIFICATION2",BUFF_NAME[701],"Physical");
_root.hackMove2[110] = "EMPOWERUNIFIC";
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("EMPOWERUNIFIC",BUFF_NAME[661],"Physical");
_root.hackMove2[90] = 1;
_root.hackMove2[91] = 1;
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[661];
addNewBuffKrin("CONSOLIDATE",BUFF_NAME[703],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[703];
addNewBuffKrin("CONSOLIDATE2",BUFF_NAME[701],"Physical");
_root.hackMove2[111] = "EMPOWER3";
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("PHANTOMSREVENGE",BUFF_NAME[701],"Physical");
_root.hackMove2[112] = 9999;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("FRAGILE2017",BUFF_NAME[704],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[704];
addNewBuffKrin("FRAGILE2",BUFF_NAME[701],"Physical");
_root.hackMove2[113] = -10;
_root.hackMove2[15] = -50;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("BASTIONDNA",BUFF_NAME[705],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[705];
addNewBuffKrin("BASTIONDNA2",BUFF_NAME[701],"Physical");
_root.hackMove2[88] = "DEFENSE15";
_root.hackMove2[85] = 0.75;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("FRENZYDNA",BUFF_NAME[701],"Physical");
_root.hackMove2[114] = "EMPOWER2";
_root.hackMove2[85] = 0.25;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("DIVINECHARGE",BUFF_NAME[706],"Lightning");
_root.hackMove2[5] = 3;
_root.hackMove2[3] = 3;
_root.hackMove2[7] = -1;
_root.hackMove2[66] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[109] = 10;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[706];
addNewBuffKrin("CHAOSSTORM",BUFF_NAME[707],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[13] = 1;
_root.hackMove2[115] = "EMPOWER3";
_root.hackMove2[27] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[707];
addNewBuffKrin("BLACKFLAMESHOCK",BUFF_NAME[711],"Blackflame");
_root.hackMove2[24] = -0.7;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[711];
addNewBuffKrin("SUPERSTUNPRAETOR",BUFF_NAME[712],"Blackflame");
_root.hackMove2[16] = 2;
_root.hackMove2[17] = 1;
_root.hackMove2[25] = BUFF_DESC1[712];
addNewBuffKrin("EMPOWERBLOOD",BUFF_NAME[714],"Physical");
_root.hackMove2[3] = 0.25;
_root.hackMove2[5] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[714];
addNewBuffKrin("BLOODFLAMECLAW1",BUFF_NAME[717],"Physical");
_root.hackMove2[124] = 1.26;
_root.hackMove2[125] = "Bloodflame Claw";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[717] + (_root.hackMove2[124] - 1) * 100 + BUFF_DESC2[717];
addNewBuffKrin("BLOODFLAMECLAW2",BUFF_NAME[717],"Physical");
_root.hackMove2[124] = 1.29;
_root.hackMove2[125] = "Bloodflame Claw";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[717] + (_root.hackMove2[124] - 1) * 100 + BUFF_DESC2[717];
addNewBuffKrin("BLOODFLAMECLAW3",BUFF_NAME[717],"Physical");
_root.hackMove2[124] = 1.32;
_root.hackMove2[125] = "Bloodflame Claw";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[717] + (_root.hackMove2[124] - 1) * 100 + BUFF_DESC2[717];
addNewBuffKrin("BLOODFLAMECLAW4",BUFF_NAME[717],"Physical");
_root.hackMove2[124] = 1.35;
_root.hackMove2[125] = "Bloodflame Claw";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[717] + (_root.hackMove2[124] - 1) * 100 + BUFF_DESC2[717];
addNewBuffKrin("BLOODFLAMESPRAY1",BUFF_NAME[718],"Physical");
_root.hackMove2[126] = "FIREBURN";
_root.hackMove2[125] = "Bloodflame Spray";
_root.hackMove2[137] = "Bloodflame Spray Aoe";
_root.hackMove2[138] = "FIREBURNBA";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[718] + "40" + BUFF_DESC2[718];
addNewBuffKrin("BLOODFLAMESPRAY2",BUFF_NAME[718],"Physical");
_root.hackMove2[126] = "FIREBURNB2";
_root.hackMove2[125] = "Bloodflame Spray";
_root.hackMove2[137] = "Bloodflame Spray Aoe";
_root.hackMove2[138] = "FIREBURNBA2";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[718] + "70" + BUFF_DESC2[718];
addNewBuffKrin("BLOODFLAMESPRAY3",BUFF_NAME[718],"Physical");
_root.hackMove2[126] = "FIREBURNB3";
_root.hackMove2[125] = "Bloodflame Spray";
_root.hackMove2[137] = "Bloodflame Spray Aoe";
_root.hackMove2[138] = "FIREBURNBA3";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[718] + "100" + BUFF_DESC2[718];
addNewBuffKrin("BLOODFLAMESPRAY4",BUFF_NAME[718],"Physical");
_root.hackMove2[126] = "FIREBURNB4";
_root.hackMove2[125] = "Bloodflame Spray";
_root.hackMove2[137] = "Bloodflame Spray Aoe";
_root.hackMove2[138] = "FIREBURNBA4";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[718] + "130" + BUFF_DESC2[718];
addNewBuffKrin("FIREBURNB2",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.7;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNB3",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNB4",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 1.3;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNBA",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.132;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNBA2",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.231;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNBA3",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.33;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("FIREBURNBA4",BUFF_NAME[213],"Fire");
_root.hackMove2[28] = 0.429;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[213];
addNewBuffKrin("BLOODFLAMEBLADE",BUFF_NAME[719],"Fire");
_root.hackMove2[127] = 1.2;
_root.hackMove2[16] = 5;
_root.hackMove2[23] = 0.4;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[719] + _root.hackMove2[127] * 100 + BUFF_DESC2[719] + _root.hackMove2[23] * 100 + BUFF_DESC3[719];
addNewBuffKrin("BLOODFLAMEBLADE2",BUFF_NAME[719],"Fire");
_root.hackMove2[127] = 1.6;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.6;
_root.hackMove2[25] = BUFF_DESC1[719] + _root.hackMove2[127] * 100 + BUFF_DESC2[719] + _root.hackMove2[23] * 100 + BUFF_DESC3[719];
addNewBuffKrin("BLOODFLAMEBLADE3",BUFF_NAME[719],"Fire");
_root.hackMove2[127] = 2;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 0.8;
_root.hackMove2[25] = BUFF_DESC1[719] + _root.hackMove2[127] * 100 + BUFF_DESC2[719] + _root.hackMove2[23] * 100 + BUFF_DESC3[719];
addNewBuffKrin("BLOODFLAMEBLADE4",BUFF_NAME[719],"Fire");
_root.hackMove2[127] = 2.5;
_root.hackMove2[16] = 6;
_root.hackMove2[32] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[719] + _root.hackMove2[127] * 100 + BUFF_DESC2[719] + _root.hackMove2[23] * 100 + BUFF_DESC3[719];
addNewBuffKrin("BLOODFLAMETHRUST1",BUFF_NAME[720],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[82] = -0.23;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[720] + _root.hackMove2[82] * -100 + BUFF_DESC2[720] + _root.hackMove2[32] * 100 + BUFF_DESC3[720];
addNewBuffKrin("BLOODFLAMETHRUST2",BUFF_NAME[720],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[82] = -0.26;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[720] + _root.hackMove2[82] * -100 + BUFF_DESC2[720] + _root.hackMove2[32] * 100 + BUFF_DESC3[720];
addNewBuffKrin("BLOODFLAMETHRUST3",BUFF_NAME[720],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[82] = -0.29;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[720] + _root.hackMove2[82] * -100 + BUFF_DESC2[720] + _root.hackMove2[32] * 100 + BUFF_DESC3[720];
addNewBuffKrin("BLOODFLAMETHRUST4",BUFF_NAME[720],"Physical");
_root.hackMove2[16] = 5;
_root.hackMove2[82] = -0.32;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[720] + _root.hackMove2[82] * -100 + BUFF_DESC2[720] + _root.hackMove2[32] * 100 + BUFF_DESC3[720];
addNewBuffKrin("BLOODYRESTORATION",BUFF_NAME[721],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = 0.3;
_root.hackMove2[37] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[721] + _root.hackMove2[82] * 100 + BUFF_DESC2[721] + _root.hackMove2[32] * 100 + BUFF_DESC3[721];
addNewBuffKrin("BLOODYRESTORATION2",BUFF_NAME[721],"Physical");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = 0.35;
_root.hackMove2[37] = 0.35;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[721] + _root.hackMove2[82] * 100 + BUFF_DESC2[721] + _root.hackMove2[32] * 100 + BUFF_DESC3[721];
addNewBuffKrin("BLOODYRESTORATION3",BUFF_NAME[721],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.4;
_root.hackMove2[37] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[721] + _root.hackMove2[82] * 100 + BUFF_DESC2[721] + _root.hackMove2[32] * 100 + BUFF_DESC3[721];
addNewBuffKrin("BLOODYRESTORATION4",BUFF_NAME[721],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.45;
_root.hackMove2[37] = 0.45;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[721] + _root.hackMove2[82] * 100 + BUFF_DESC2[721] + _root.hackMove2[32] * 100 + BUFF_DESC3[721];
addNewBuffKrin("FURYPASSIVE",BUFF_NAME[722],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.25;
_root.hackMove2[11] = 0.25;
_root.hackMove2[128] = 0.25;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[722];
addNewBuffKrin("FURYPASSIVE2",BUFF_NAME[722],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[82] = 0.25;
_root.hackMove2[11] = 0.25;
_root.hackMove2[128] = 0.25;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[722];
addNewBuffKrin("FURYPASSIVE3",BUFF_NAME[753],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[753];
addNewBuffKrin("BLOODHOUNDTRANSFORMATION",BUFF_NAME[724],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[86] = 5;
_root.hackMove2[3] = 0.36;
_root.hackMove2[5] = 0.36;
_root.hackMove2[7] = 0.36;
_root.hackMove2[77] = 32.5;
_root.hackMove2[30] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[31] = 21;
_root.hackMove2[25] = BUFF_DESC1[724];
addNewBuffKrin("BLOODHOUNDBREATH",BUFF_NAME[725],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[11] = -0.35;
_root.hackMove2[36] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[725];
addNewBuffKrin("BLOODHOUNDCRUNCH1",BUFF_NAME[726],"Shadow");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[726];
addNewBuffKrin("BLOODHOUNDCRUNCH11",BUFF_NAME[727],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[7] = 0.75;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[727];
addNewBuffKrin("BLOODHOUNDTOXICBITE1",BUFF_NAME[728],"Poison");
_root.hackMove2[16] = 2;
_root.hackMove2[7] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[728];
addNewBuffKrin("BLOODHOUNDTOXICBITE2",BUFF_NAME[729],"Poison");
_root.hackMove2[16] = 4;
_root.hackMove2[30] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[729];
addNewBuffKrin("FIREBARRIER",BUFF_NAME[730],"Fire");
_root.hackMove2[40] = 6;
_root.hackMove2[129] = -10;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[730] + _root.hackMove2[40] * 100 + BUFF_DESC2[730] + _root.hackMove2[32] * 100 + BUFF_DESC3[730];
addNewBuffKrin("FIREBARRIER2",BUFF_NAME[730],"Fire");
_root.hackMove2[40] = 8;
_root.hackMove2[129] = -10;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[730] + _root.hackMove2[40] * 100 + BUFF_DESC2[730] + _root.hackMove2[32] * 100 + BUFF_DESC3[730];
addNewBuffKrin("FIREBARRIER3",BUFF_NAME[730],"Fire");
_root.hackMove2[40] = 10;
_root.hackMove2[129] = -10;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[730] + _root.hackMove2[40] * 100 + BUFF_DESC2[730] + _root.hackMove2[32] * 100 + BUFF_DESC3[730];
addNewBuffKrin("FIREBARRIER4",BUFF_NAME[730],"Fire");
_root.hackMove2[40] = 15;
_root.hackMove2[129] = -10;
_root.hackMove2[16] = 7;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[730] + _root.hackMove2[40] * 100 + BUFF_DESC2[730] + _root.hackMove2[32] * 100 + BUFF_DESC3[730];
addNewBuffKrin("ACIDSPRAY11",BUFF_NAME[731],"Poison");
_root.hackMove2[30] = 0.6;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[731];
addNewBuffKrin("ACIDSPRAY1",BUFF_NAME[732],"Poison");
_root.hackMove2[126] = "VOMIT1";
_root.hackMove2[124] = 2;
_root.hackMove2[125] = "Vomit";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[732];
addNewBuffKrin("ACIDSPRAY12",BUFF_NAME[732],"Poison");
_root.hackMove2[126] = "VOMIT1";
_root.hackMove2[124] = 2;
_root.hackMove2[140] = "Vomit";
_root.hackMove2[125] = "Vomit";
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[732];
addNewBuffKrin("VOMIT1",BUFF_NAME[733],"Poison");
_root.hackMove2[30] = 1.5;
_root.hackMove2[16] = 3;
_root.hackMove2[11] = -0.25;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[733];
addNewBuffKrin("REVENGESNAKE",BUFF_NAME[734],"Shadow");
_root.hackMove2[96] = "REVENGESNAKE2";
_root.hackMove2[109] = 1;
_root.hackMove2[116] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[734];
addNewBuffKrin("REVENGESNAKE2",BUFF_NAME[735],"Shadow");
_root.hackMove2[125] = "Fire Snake";
_root.hackMove2[130] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[735];
addNewBuffKrin("DARKSNAKE1",BUFF_NAME[736],"Shadow");
_root.hackMove2[16] = 6;
_root.hackMove2[29] = 1;
_root.hackMove2[36] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.4;
_root.hackMove2[25] = BUFF_DESC1[736];
addNewBuffKrin("PYROBLEND1",BUFF_NAME[737],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 0.5;
_root.hackMove2[131] = 32.5;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[737] + _root.hackMove2[7] * 100 + BUFF_DESC2[737];
addNewBuffKrin("PYROBLEND2",BUFF_NAME[737],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 0.75;
_root.hackMove2[131] = 32.5;
_root.hackMove2[31] = 5;
_root.hackMove2[25] = BUFF_DESC1[737] + _root.hackMove2[7] * 100 + BUFF_DESC2[737];
addNewBuffKrin("PYROBLEND3",BUFF_NAME[737],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 1;
_root.hackMove2[31] = 5;
_root.hackMove2[131] = 32.5;
_root.hackMove2[25] = BUFF_DESC1[737] + _root.hackMove2[7] * 100 + BUFF_DESC2[737];
addNewBuffKrin("PYROBLEND4",BUFF_NAME[737],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = 1.25;
_root.hackMove2[31] = 5;
_root.hackMove2[131] = 32.5;
_root.hackMove2[25] = BUFF_DESC1[737] + _root.hackMove2[7] * 100 + BUFF_DESC2[737];
addNewBuffKrin("SNAKEHEAL1",BUFF_NAME[738],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[66] = 0.5;
_root.hackMove2[82] = 0.35;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[738] + _root.hackMove2[82] * 100 + BUFF_DESC2[738];
addNewBuffKrin("SNAKEHEAL2",BUFF_NAME[738],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[66] = 0.5;
_root.hackMove2[82] = 0.45;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[738] + _root.hackMove2[82] * 100 + BUFF_DESC2[738];
addNewBuffKrin("SNAKEHEAL3",BUFF_NAME[738],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[66] = 0.5;
_root.hackMove2[82] = 0.55;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[738] + _root.hackMove2[82] * 100 + BUFF_DESC2[738];
addNewBuffKrin("SNAKEHEAL4",BUFF_NAME[738],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[66] = 0.5;
_root.hackMove2[82] = 0.65;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[738] + _root.hackMove2[82] * 100 + BUFF_DESC2[738];
addNewBuffKrin("BLOODFLAMEOVERRUN",BUFF_NAME[745],"Physical");
_root.hackMove2[24] = -0.23;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[745] + _root.hackMove2[24] * -100 + BUFF_DESC2[745];
addNewBuffKrin("BLOODFLAMEOVERRUN2",BUFF_NAME[745],"Physical");
_root.hackMove2[24] = -0.26;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[745] + _root.hackMove2[24] * -100 + BUFF_DESC2[745];
addNewBuffKrin("BLOODFLAMEOVERRUN3",BUFF_NAME[745],"Physical");
_root.hackMove2[24] = -0.29;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[745] + _root.hackMove2[24] * -100 + BUFF_DESC2[745];
addNewBuffKrin("BLOODFLAMEOVERRUN4",BUFF_NAME[745],"Physical");
_root.hackMove2[24] = -0.32;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[745] + _root.hackMove2[24] * -100 + BUFF_DESC2[745];
addNewBuffKrin("BLOODFLAMELOVE1",BUFF_NAME[739],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[15] = -10;
_root.hackMove2[3] = 0.16;
_root.hackMove2[5] = 0.16;
_root.hackMove2[37] = 0.16;
_root.hackMove2[132] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[739] + _root.hackMove2[3] * 100 + BUFF_DESC2[739];
addNewBuffKrin("BLOODFLAMELOVE2",BUFF_NAME[739],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[15] = -10;
_root.hackMove2[3] = 0.19;
_root.hackMove2[5] = 0.19;
_root.hackMove2[37] = 0.19;
_root.hackMove2[132] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[739] + _root.hackMove2[3] * 100 + BUFF_DESC2[739];
addNewBuffKrin("BLOODFLAMELOVE3",BUFF_NAME[739],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[15] = -10;
_root.hackMove2[3] = 0.22;
_root.hackMove2[5] = 0.22;
_root.hackMove2[37] = 0.22;
_root.hackMove2[132] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[739] + _root.hackMove2[3] * 100 + BUFF_DESC2[739];
addNewBuffKrin("BLOODFLAMELOVE4",BUFF_NAME[739],"Physical");
_root.hackMove2[16] = 6;
_root.hackMove2[15] = -10;
_root.hackMove2[3] = 0.25;
_root.hackMove2[5] = 0.25;
_root.hackMove2[37] = 0.25;
_root.hackMove2[132] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[739] + _root.hackMove2[3] * 100 + BUFF_DESC2[739];
addNewBuffKrin("BLOODFLAMESACRIFICE1",BUFF_NAME[740],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -12;
_root.hackMove2[23] = 0.24;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[740] + _root.hackMove2[15] * -1 + BUFF_DESC2[740] + _root.hackMove2[23] * 100 + BUFF_DESC3[740];
addNewBuffKrin("BLOODFLAMESACRIFICE2",BUFF_NAME[740],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -16;
_root.hackMove2[23] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[740] + _root.hackMove2[15] * -1 + BUFF_DESC2[740] + _root.hackMove2[23] * 100 + BUFF_DESC3[740];
addNewBuffKrin("BLOODFLAMESACRIFICE3",BUFF_NAME[740],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -20;
_root.hackMove2[23] = 0.34;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[740] + _root.hackMove2[15] * -1 + BUFF_DESC2[740] + _root.hackMove2[23] * 100 + BUFF_DESC3[740];
addNewBuffKrin("BLOODFLAMESACRIFICE4",BUFF_NAME[740],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -25;
_root.hackMove2[23] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[740] + _root.hackMove2[15] * -1 + BUFF_DESC2[740] + _root.hackMove2[23] * 100 + BUFF_DESC3[740];
addNewBuffKrin("BLOODFLAMESACRIFICE11",BUFF_NAME[741],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.15;
_root.hackMove2[86] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[741] + _root.hackMove2[82] * 100 + BUFF_DESC2[741] + _root.hackMove2[86] * 10 + BUFF_DESC3[741];
addNewBuffKrin("BLOODFLAMESACRIFICE12",BUFF_NAME[741],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.2;
_root.hackMove2[86] = 1.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[741] + _root.hackMove2[82] * 100 + BUFF_DESC2[741] + _root.hackMove2[86] * 10 + BUFF_DESC3[741];
addNewBuffKrin("BLOODFLAMESACRIFICE13",BUFF_NAME[741],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.24;
_root.hackMove2[86] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[741] + _root.hackMove2[82] * 100 + BUFF_DESC2[741] + _root.hackMove2[86] * 10 + BUFF_DESC3[741];
addNewBuffKrin("BLOODFLAMESACRIFICE14",BUFF_NAME[741],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = 0.28;
_root.hackMove2[86] = 2.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[741] + _root.hackMove2[82] * 100 + BUFF_DESC2[741] + _root.hackMove2[86] * 10 + BUFF_DESC3[741];
addNewBuffKrin("BLOODBOOM",BUFF_NAME[742],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = -20;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[742];
addNewBuffKrin("FIREPIERCING",BUFF_NAME[746],"Fire");
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[746];
addNewBuffKrin("BLOODFLAMERITUAL",BUFF_NAME[744],"Fire");
_root.hackMove2[133] = 1.2;
_root.hackMove2[134] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[744] + _root.hackMove2[133] * 100 + BUFF_DESC2[744];
addNewBuffKrin("BLOODFLAMERITUAL2",BUFF_NAME[744],"Fire");
_root.hackMove2[133] = 1.6;
_root.hackMove2[134] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[744] + _root.hackMove2[133] * 100 + BUFF_DESC2[744];
addNewBuffKrin("BLOODFLAMERITUAL3",BUFF_NAME[744],"Fire");
_root.hackMove2[133] = 2;
_root.hackMove2[134] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[744] + _root.hackMove2[133] * 100 + BUFF_DESC2[744];
addNewBuffKrin("BLOODFLAMERITUAL4",BUFF_NAME[744],"Fire");
_root.hackMove2[133] = 2.8;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[134] = 0.5;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[744] + _root.hackMove2[133] * 100 + BUFF_DESC2[744];
addNewBuffKrin("BLOODFLAMESHADOWFIRE1",BUFF_NAME[743],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[3] = -0.17;
_root.hackMove2[5] = -0.17;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.2;
_root.hackMove2[25] = BUFF_DESC1[743] + _root.hackMove2[3] * -100 + BUFF_DESC2[743] + _root.hackMove2[32] * 100 + BUFF_DESC3[743];
addNewBuffKrin("BLOODFLAMESHADOWFIRE2",BUFF_NAME[743],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[3] = -0.2;
_root.hackMove2[5] = -0.2;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[743] + _root.hackMove2[3] * -100 + BUFF_DESC2[743] + _root.hackMove2[32] * 100 + BUFF_DESC3[743];
addNewBuffKrin("BLOODFLAMESHADOWFIRE3",BUFF_NAME[743],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[3] = -0.23;
_root.hackMove2[5] = -0.23;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.45;
_root.hackMove2[25] = BUFF_DESC1[743] + _root.hackMove2[3] * -100 + BUFF_DESC2[743] + _root.hackMove2[32] * 100 + BUFF_DESC3[743];
addNewBuffKrin("BLOODFLAMESHADOWFIRE4",BUFF_NAME[743],"Shadow");
_root.hackMove2[16] = 5;
_root.hackMove2[3] = -0.26;
_root.hackMove2[5] = -0.26;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.6;
_root.hackMove2[25] = BUFF_DESC1[743] + _root.hackMove2[3] * -100 + BUFF_DESC2[743] + _root.hackMove2[32] * 100 + BUFF_DESC3[743];
addNewBuffKrin("SHELLSHOCKBLOOD1",BUFF_NAME[747],"Physical");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[747];
addNewBuffKrin("SHELLSHOCKBLOOD2",BUFF_NAME[747],"Physical");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[747];
addNewBuffKrin("BLOODFLAMEEMPOWER",BUFF_NAME[748],"Physical");
_root.hackMove2[5] = 0.6;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[748];
addNewBuffKrin("CLARITY2",BUFF_NAME[723],"Lightning");
_root.hackMove2[86] = 5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[723];
addNewBuffKrin("BLOODFLAMEDISCHARGE1",BUFF_NAME[749],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = -0.2;
_root.hackMove2[36] = 0.3;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[749] + _root.hackMove2[36] * 100 + BUFF_DESC2[749];
addNewBuffKrin("BLOODFLAMEDISCHARGE2",BUFF_NAME[749],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[82] = -0.2;
_root.hackMove2[36] = 0.35;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[749] + _root.hackMove2[82] * 100 + BUFF_DESC2[749];
addNewBuffKrin("BLOODFLAMEDISCHARGE3",BUFF_NAME[749],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = -0.2;
_root.hackMove2[36] = 0.4;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[749] + _root.hackMove2[36] * 100 + BUFF_DESC2[749];
addNewBuffKrin("BLOODFLAMEDISCHARGE4",BUFF_NAME[749],"Fire");
_root.hackMove2[16] = 4;
_root.hackMove2[82] = -0.2;
_root.hackMove2[36] = 0.45;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[749] + _root.hackMove2[36] * 100 + BUFF_DESC2[749];
addNewBuffKrin("NIHIL",BUFF_NAME[750],"Physical");
_root.hackMove2[3] = 0.25;
_root.hackMove2[5] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[123] = "BLOODFLAMESHADOWREGEN2";
_root.hackMove2[32] = 0.25;
_root.hackMove2[25] = BUFF_DESC1[750];
addNewBuffKrin("BLOODFLAMESLASH1",BUFF_NAME[751],"Fire");
_root.hackMove2[28] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[751] + _root.hackMove2[28] * 100 + BUFF_DESC2[751];
addNewBuffKrin("BLOODFLAMESLASH2",BUFF_NAME[751],"Fire");
_root.hackMove2[28] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[751] + _root.hackMove2[28] * 100 + BUFF_DESC2[751];
addNewBuffKrin("BLOODFLAMESLASH3",BUFF_NAME[751],"Fire");
_root.hackMove2[28] = 1.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[751] + _root.hackMove2[28] * 100 + BUFF_DESC2[751];
addNewBuffKrin("BLOODFLAMESLASH4",BUFF_NAME[751],"Fire");
_root.hackMove2[28] = 2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[751] + _root.hackMove2[28] * 100 + BUFF_DESC2[751];
addNewBuffKrin("BLOODFLAMESLASH10",BUFF_NAME[751],"Blackflame");
_root.hackMove2[28] = -0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[751] + _root.hackMove2[28] * 100 + BUFF_DESC2[751];
addNewBuffKrin("BLADESHIELD2",BUFF_NAME[752],"Physical");
_root.hackMove2[24] = -0.5;
_root.hackMove2[136] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[752];
addNewBuffKrin("BLACKPOINT",BUFF_NAME[755],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[755];
addNewBuffKrin("BLACKPOINT2",BUFF_NAME[755],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[77] = 32.5;
_root.hackMove2[32] = 1;
_root.hackMove2[35] = 1;
_root.hackMove2[25] = BUFF_DESC1[755];
addNewBuffKrin("BLACKFLAMEDOT2",BUFF_NAME[754],"Blackflame");
_root.hackMove2[36] = 0.5;
_root.hackMove2[29] = 1.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[754];
addNewBuffKrin("BLACKFLAMEDOT",BUFF_NAME[756],"Blackflame");
_root.hackMove2[7] = -0.8;
_root.hackMove2[28] = 2.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[756];
addNewBuffKrin("HARDPUNCH",BUFF_NAME[757],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 5;
_root.hackMove2[82] = -0.33;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[757];
addNewBuffKrin("HARDPUNCH2",BUFF_NAME[758],"Earth");
_root.hackMove2[86] = 5;
_root.hackMove2[82] = 0.25;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[758];
addNewBuffKrin("STRAIGHTPUNCH",BUFF_NAME[759],"Physical");
_root.hackMove2[3] = 0.25;
_root.hackMove2[7] = 1;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[759];
addNewBuffKrin("HAMMERBLOW",BUFF_NAME[760],"Physical");
_root.hackMove2[131] = 16.25;
_root.hackMove2[11] = 0.15;
_root.hackMove2[16] = 3;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[760];
addNewBuffKrin("HYDROPUMP",BUFF_NAME[761],"Lightning");
_root.hackMove2[24] = -0.5;
_root.hackMove2[77] = -32.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[761];
addNewBuffKrin("FLAMETHROWER",BUFF_NAME[763],"Fire");
_root.hackMove2[29] = 1.5;
_root.hackMove2[16] = 8;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[763];
addNewBuffKrin("ELECTROCUTION",BUFF_NAME[762],"Lightning");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[762];
addNewBuffKrin("ELECTROCUTION2",BUFF_NAME[764],"Lightning");
_root.hackMove2[11] = -0.8;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[764];
addNewBuffKrin("SYRINGE",BUFF_NAME[765],"Poison");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[765];
addNewBuffKrin("ROCKET",BUFF_NAME[767],"Fire");
_root.hackMove2[17] = 1;
_root.hackMove2[82] = -0.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[767];
addNewBuffKrin("FLAMESPLITTER3",BUFF_NAME[766],"Fire");
_root.hackMove2[16] = 99;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[766];
addNewBuffKrin("MUTATIONSEED",BUFF_NAME[768],"Poison");
_root.hackMove2[16] = 6;
_root.hackMove2[48] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[66] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[768];
addNewBuffKrin("SEEDMUTATION",BUFF_NAME[769],"Poison");
_root.hackMove2[29] = 4;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[769];
addNewBuffKrin("SEEDMUTATION2",BUFF_NAME[770],"Poison");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[46] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[770];
addNewBuffKrin("ROBOTINJECTION",BUFF_NAME[771],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[23] = 0.75;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[771];
addNewBuffKrin("ROBOTINJECTION2",BUFF_NAME[772],"Lightning");
_root.hackMove2[16] = 4;
_root.hackMove2[86] = 5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[11] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[772];
addNewBuffKrin("ROBOTELECTROSHOCK",BUFF_NAME[773],"Lightning");
_root.hackMove2[11] = 0.5;
_root.hackMove2[48] = -0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[773];
addNewBuffKrin("ROBOTELECTROSHOCK2",BUFF_NAME[774],"Lightning");
_root.hackMove2[13] = -0.25;
_root.hackMove2[48] = 0.5;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[774];
addNewBuffKrin("ROBOTELECTROSHOCK3",BUFF_NAME[775],"Lightning");
_root.hackMove2[29] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[775];
addNewBuffKrin("KAMIKAZE",BUFF_NAME[776],"Lightning");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[776];
addNewBuffKrin("KAMIKAZE2",BUFF_NAME[776],"Lightning");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[112] = 9999;
_root.hackMove2[25] = BUFF_DESC1[776];
addNewBuffKrin("STANCENOTE",BUFF_NAME[777],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[777] + BUFF_DESC2[777];
addNewBuffKrin("BROKENSTANCE",BUFF_NAME[778],"Physical");
_root.hackMove2[17] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[13] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[778];
addNewBuffKrin("BLACKFLAMEAPOSTLE",BUFF_NAME[779],"Blackflame");
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[45] = 0.05;
_root.hackMove2[25] = BUFF_DESC1[779];
addNewBuffKrin("APOSTLEPULL",BUFF_NAME[780],"Physical");
_root.hackMove2[126] = "APOSTLEPULL2";
_root.hackMove2[125] = "Apostle Pull";
_root.hackMove2[140] = "Apostle Pull";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[780];
addNewBuffKrin("APOSTLESLASH",BUFF_NAME[781],"Physical");
_root.hackMove2[126] = "APOSTLESLASH2";
_root.hackMove2[125] = "Apostle Slash";
_root.hackMove2[140] = "Apostle Slash";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[781];
addNewBuffKrin("APOSTLEPULL2",BUFF_NAME[782],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[15] = 15;
_root.hackMove2[82] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[782];
addNewBuffKrin("APOSTLESLASH2",BUFF_NAME[783],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[36] = -0.5;
_root.hackMove2[7] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[783];
addNewBuffKrin("BLACKFLAMEWAIT",BUFF_NAME[784],"Blackflame");
_root.hackMove2[16] = 7;
_root.hackMove2[141] = "APOSTLEENRAGE";
_root.hackMove2[142] = 80;
_root.hackMove2[20] = 1;
_root.hackMove2[7] = -0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[784];
addNewBuffKrin("BLACKFLAMEENHANCEMENT",BUFF_NAME[786],"Blackflame");
_root.hackMove2[16] = 99;
_root.hackMove2[143] = 0.05;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[31] = 22;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[786];
addNewBuffKrin("APOSTLEENRAGE",BUFF_NAME[785],"Blackflame");
_root.hackMove2[16] = 99;
_root.hackMove2[10] = 9999;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[785];
addNewBuffKrin("WATERSTACK",BUFF_NAME[787],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[7] = -0.1;
_root.hackMove2[27] = 1;
_root.hackMove2[144] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[787];
addNewBuffKrin("FROZENICE9",BUFF_NAME[788],"Ice");
_root.hackMove2[16] = 2;
_root.hackMove2[27] = 1;
_root.hackMove2[17] = 1;
_root.hackMove2[31] = 2;
_root.hackMove2[20] = -1;
_root.hackMove2[25] = BUFF_DESC1[788];
addNewBuffKrin("ICEICEICE",BUFF_NAME[789],"Ice");
_root.hackMove2[29] = 1.25;
_root.hackMove2[24] = -0.25;
_root.hackMove2[16] = 15;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[789];
addNewBuffKrin("ICEICEICE2",BUFF_NAME[790],"Ice");
_root.hackMove2[29] = 0.5;
_root.hackMove2[10] = -500;
_root.hackMove2[24] = -0.1;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[790];
addNewBuffKrin("ICE9",BUFF_NAME[791],"Ice");
_root.hackMove2[120] = 10;
_root.hackMove2[24] = 1;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[791];
addNewBuffKrin("HAVASCOMBO2",BUFF_NAME[792],"Earth");
_root.hackMove2[126] = "HAVASVULNERABLITY";
_root.hackMove2[125] = "Havas Combo 2";
_root.hackMove2[140] = "Havas Combo 2";
_root.hackMove2[124] = 2;
_root.hackMove2[87] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[792];
addNewBuffKrin("HAVASCOMBO31",BUFF_NAME[793],"Earth");
_root.hackMove2[125] = "Havas Combo 3";
_root.hackMove2[140] = "Havas Combo 3";
_root.hackMove2[126] = "BREAK";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[793];
addNewBuffKrin("HAVASCOMBO4","Prepared","Earth");
_root.hackMove2[16] = 1;
_root.hackMove2[15] = -25;
addNewBuffKrin("HAVASRAGE",BUFF_NAME[794],"Earth");
_root.hackMove2[86] = 10;
_root.hackMove2[16] = 6;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[25] = BUFF_DESC1[794];
addNewBuffKrin("HAVASVULNERABLITY",BUFF_NAME[795],"Earth");
_root.hackMove2[13] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[24] = -0.5;
_root.hackMove2[16] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[795];
addNewBuffKrin("HAVASDESIRES",BUFF_NAME[796],"Earth");
_root.hackMove2[13] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[11] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[25] = BUFF_DESC1[796];
addNewBuffKrin("HAVASDESIRES2",BUFF_NAME[797],"Earth");
_root.hackMove2[11] = 0.25;
_root.hackMove2[57] = 0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[16] = 5;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[797];
addNewBuffKrin("STANCENOTE2",BUFF_NAME[777],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[777] + BUFF_DESC3[777];
addNewBuffKrin("MIMIC",BUFF_NAME[798],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[798];
addNewBuffKrin("DARKSIDE",BUFF_NAME[799],"Shadow");
_root.hackMove2[16] = 10;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[11] = 0.1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[799];
addNewBuffKrin("SYPHONSTRIKE",BUFF_NAME[800],"Shadow");
_root.hackMove2[125] = "Syphon Strike";
_root.hackMove2[140] = "Syphon Strike";
_root.hackMove2[124] = 1.5;
_root.hackMove2[87] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[800];
addNewBuffKrin("SOULEATER",BUFF_NAME[801],"Physical");
_root.hackMove2[125] = "Souleater";
_root.hackMove2[140] = "Souleater";
_root.hackMove2[124] = 1.5;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[801];
addNewBuffKrin("LIVINGDEAD",BUFF_NAME[802],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[802];
addNewBuffKrin("LIVINGDEAD2",BUFF_NAME[802],"Shadow");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[145] = -3;
_root.hackMove2[146] = "LIVINGFURY";
_root.hackMove2[25] = BUFF_DESC1[802];
addNewBuffKrin("LIVINGFURY",BUFF_NAME[803],"Shadow");
_root.hackMove2[16] = 99;
_root.hackMove2[11] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[803];
addNewBuffKrin("BLOODWEAPON",BUFF_NAME[804],"Shadow");
_root.hackMove2[27] = 1;
_root.hackMove2[15] = -10;
_root.hackMove2[32] = 1;
_root.hackMove2[132] = 10;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[804];
addNewBuffKrin("CHARGEUPSWARA",BUFF_NAME[805],"Lightning");
_root.hackMove2[7] = 0.5;
_root.hackMove2[82] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[805];
addNewBuffKrin("CHARGEUPRAGINI",BUFF_NAME[806],"Poison");
_root.hackMove2[19] = 10000;
_root.hackMove2[82] = 0.5;
_root.hackMove2[16] = 5;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[806];
addNewBuffKrin("SNAKEBITTEN",BUFF_NAME[807],"Poison");
_root.hackMove2[29] = 10;
_root.hackMove2[11] = -0.5;
_root.hackMove2[16] = 1;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.1;
_root.hackMove2[25] = BUFF_DESC1[807];
addNewBuffKrin("SWARASVULNERABLITY",BUFF_NAME[808],"Lightning");
_root.hackMove2[46] = 2;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[808];
addNewBuffKrin("OVERHEADSTRIKE",BUFF_NAME[809],"Physical");
_root.hackMove2[126] = "OVERHEADSTRIKE2";
_root.hackMove2[125] = "Overhead Strike";
_root.hackMove2[140] = "Overhead Strike";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[809];
addNewBuffKrin("BACKHAND",BUFF_NAME[810],"Physical");
_root.hackMove2[126] = "BACKHAND2";
_root.hackMove2[125] = "Backhand";
_root.hackMove2[140] = "Backhand";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[810];
addNewBuffKrin("OVERHEADSTRIKE2",BUFF_NAME[811],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[77] = -32.5;
_root.hackMove2[82] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[811];
addNewBuffKrin("BACKHAND2",BUFF_NAME[812],"Physical");
_root.hackMove2[16] = 4;
_root.hackMove2[36] = -0.5;
_root.hackMove2[11] = -0.4;
_root.hackMove2[20] = -1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[25] = BUFF_DESC1[812];
addNewBuffKrin("BLACKFLAMERITUAL",BUFF_NAME[813],"Blackflame");
_root.hackMove2[72] = 10;
_root.hackMove2[125] = "Blackflame";
_root.hackMove2[148] = 2;
_root.hackMove2[16] = 3;
_root.hackMove2[147] = "Melee";
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[813];
addNewBuffKrin("STANCENOTE3",BUFF_NAME[777],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[777] + BUFF_DESC4[777];
addNewBuffKrin("STANCENOTE4",BUFF_NAME[777],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[32] = 1;
_root.hackMove2[81] = -1;
_root.hackMove2[13] = -1;
_root.hackMove2[25] = BUFF_DESC1[777] + BUFF_DESC4[777];
addNewBuffKrin("MISSILEREADY",BUFF_NAME[814],"Fire");
_root.hackMove2[16] = 3;
_root.hackMove2[10] = 1000;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[814];
addNewBuffKrin("FRAGILE20172",BUFF_NAME[815],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[815];
addNewBuffKrin("FRAGILE22",BUFF_NAME[701],"Physical");
_root.hackMove2[113] = -5;
_root.hackMove2[16] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[701];
addNewBuffKrin("DAMAGEDOWN",BUFF_NAME[816],"Blackflame");
_root.hackMove2[11] = -0.5;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 3;
_root.hackMove2[25] = BUFF_DESC1[816];
addNewBuffKrin("JINPU",BUFF_NAME[817],"Physical");
_root.hackMove2[11] = 0.23;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[817];
addNewBuffKrin("SHIFU",BUFF_NAME[818],"Physical");
_root.hackMove2[7] = 0.23;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 0.5;
_root.hackMove2[27] = 1;
_root.hackMove2[16] = 12;
_root.hackMove2[25] = BUFF_DESC1[818];
addNewBuffKrin("HAKAZE",BUFF_NAME[819],"Physical");
_root.hackMove2[140] = "Hakaze";
_root.hackMove2[87] = 1;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[819];
addNewBuffKrin("GEKKO",BUFF_NAME[820],"Physical");
_root.hackMove2[125] = "Gekko";
_root.hackMove2[140] = "Gekko";
_root.hackMove2[126] = "GEKKOD";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[820];
addNewBuffKrin("GEKKOD",BUFF_NAME[821],"Physical");
_root.hackMove2[24] = -0.4;
_root.hackMove2[16] = 4;
_root.hackMove2[20] = -1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 0.3;
_root.hackMove2[25] = BUFF_DESC1[821];
addNewBuffKrin("KASHA",BUFF_NAME[822],"Physical");
_root.hackMove2[125] = "Kasha";
_root.hackMove2[140] = "Kasha";
_root.hackMove2[126] = "VULNERABLITY";
_root.hackMove2[124] = 2;
_root.hackMove2[16] = 2;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[822];
addNewBuffKrin("BLOODFLAMEBLADETYRANT",BUFF_NAME[823],"Fire");
_root.hackMove2[127] = 2.5;
_root.hackMove2[16] = 99;
_root.hackMove2[86] = 3;
_root.hackMove2[32] = 1;
_root.hackMove2[23] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[31] = 23;
_root.hackMove2[25] = BUFF_DESC1[823] + BUFF_DESC1[719] + _root.hackMove2[127] * 100 + BUFF_DESC2[719] + _root.hackMove2[23] * 100 + BUFF_DESC3[719];
addNewBuffKrin("RANI",BUFF_NAME[824],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[32] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[25] = BUFF_DESC1[824];
addNewBuffKrin("RANI2",BUFF_NAME[824],"Physical");
_root.hackMove2[16] = -1;
_root.hackMove2[149] = "BFEXPLOSION";
_root.hackMove2[32] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[31] = 24;
_root.hackMove2[25] = BUFF_DESC1[824];
addNewBuffKrin("BFEXPLOSION",BUFF_NAME[820],"Physical");
_root.hackMove2[125] = "Bloodflame Explosion";
_root.hackMove2[124] = 99999999999999;
_root.hackMove2[16] = -1;
_root.hackMove2[20] = 1;
_root.hackMove2[87] = 1;
_root.hackMove2[27] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[820];
addNewBuffKrin("BLOODHOUNDTRANSFORMATION2",BUFF_NAME[724],"Physical");
_root.hackMove2[16] = 99;
_root.hackMove2[86] = 5;
_root.hackMove2[77] = 32.5;
_root.hackMove2[27] = 1;
_root.hackMove2[20] = 1;
_root.hackMove2[32] = 1;
_root.hackMove2[25] = BUFF_DESC1[825];
