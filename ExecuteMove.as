function executeMove(IDKM, IDKM2, IDKC, IDKT)
{
   AVGNUMC = 100 + 15 * IDKC.plevel;
   SPEEDCRITCALC = IDKC.SPEEDU / getStat(10,IDKC.plevel) - 3;
   PERCALK = IDKC.PERU[IDKM2[0]] / AVGNUMC;
   if(IDKM2[81] != 0)
   {
      PERCALK = IDKC.PERU[IDKM2[0]] / AVGNUMC + IDKC.PERU[IDKM2[81]] / AVGNUMC / 2;
   }
   DEFCALK = IDKT.DEFU[IDKM2[0]] * (IDKT.DEFENSE * IDKM2[58]) / AVGNUMC;
   DEFCALK2 = IDKT.DEFU[IDKM2[0]] * IDKT.DEFENSE / AVGNUMC;
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
      perScript(PERCALK,DEFCALK,IDKM2,IDKC);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 0.016666667 * Math.pow(CRITCALC_X + 1,4) - 0.25 * Math.pow(CRITCALC_X + 1,3) + 1.233333 * Math.pow(CRITCALC_X + 1,2) - 1.9000000000000001 * (CRITCALC_X + 1) + 1.9000000000000001;
         if(coEFKN6724 < 0)
         {
            coEFKN6724 = 0;
         }
         if(IDKC.playerName == "Redfield")
         {
            _root.addSound("Effects","VO_Zakk_Crit02");
         }
         if(IDKC.playerName == "Dr Klima")
         {
            _root.addSound("Effects","Klima01");
         }
         if(IDKC.playerName == "Zakk")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","VO_Zakk_Crit02");
               numberRandomerBuffHit2 = 0;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","VO_Zakk_Crit01");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","VO_Zakk_Crit02");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               _root.addSound("Effects","VO_Zakk_Crit01");
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Veradux")
         {
            _root.addSound("Effects","Angry_Dux");
         }
         if(IDKC.playerName == "Blackflamed Elite")
         {
            _root.addSound("Effects","OfficerAttack1");
         }
         if(IDKC.playerName == "Flamed ZPCI Medic")
         {
            _root.addSound("Effects","MedicAttack3");
         }
         if(IDKC.playerName == "Blackflamed Freezer")
         {
            _root.addSound("Effects","OfficerAttack02");
         }
         if(IDKC.playerName == "Roald")
         {
            _root.addSound("Effects","Angry_Roald");
         }
         if(IDKC.playerName == "Celestia" || IDKC.playerName == "Felicity")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","crit_felicity3");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","crit_felicity2");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","crit_felicity");
               numberRandomerBuffHit2++;
            }
            else
            {
               _root.addSound("Effects","crit_felicity3");
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Carbon")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Carbon10");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Carbon09");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Carbon08");
               numberRandomerBuffHit2++;
            }
            else
            {
               _root.addSound("Effects","Carbon10");
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Lt. Farsight" || IDKC.playerName == "Parineeta")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Farsight01");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","FarsightCrit2");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","FarsightCrit1");
               numberRandomerBuffHit2++;
            }
            else
            {
               _root.addSound("Effects","FarsightCrit2");
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Cpt Vendara")
         {
            _root.addSound("Effects","VO_Vendara_Crit1");
         }
         if(IDKC.playerName == "Blackflamed Heater")
         {
            _root.addSound("Effects","ZPCIPyro_Crit01");
         }
         if(IDKC.playerName == "ZPCI Praetor")
         {
            _root.addSound("Effects","PraetorCrit");
         }
         if(IDKC.playerName == "Foreman Grosk")
         {
            _root.addSound("Effects","Grosk06");
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
         if(IDKC.playerName == "Blitz Raptor" || IDKC.playerName == "Tempest Raven" || IDKC.playerName == "War Lizard" || IDKC.playerName == "Shredder" || IDKC.playerName == "Boom Bot")
         {
            if(numberRandomerBuffHit2 == 6)
            {
               _root.addSound("Effects","Mech07");
               numberRandomerBuffHit2 = 0;
            }
            else if(numberRandomerBuffHit2 == 5)
            {
               _root.addSound("Effects","Mech06");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 4)
            {
               _root.addSound("Effects","Mech05");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 3)
            {
               _root.addSound("Effects","Mech03");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Mech02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Mech02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Mech01");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "ZPCI Praetor")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Carbon14");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Carbon15");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Carbon16");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Carbon")
         {
            if(numberRandomerBuffHit2 == 3)
            {
               _root.addSound("Effects","Carbon07");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Carbon06");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Carbon05");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Carbon04");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Lt. Farsight")
         {
            if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Farsight02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Farsight04");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Cpt Vendara")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Vendara03");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Vendara02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Vendara01");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "ZPCI Sniper" || IDKC.playerName == "ZPCI Elite")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Elite07");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Elite06");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Elite05");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "ZPCI Trident" || IDKC.playerName == "ZPCI Striker")
         {
            if(numberRandomerBuffHit2 == 3)
            {
               _root.addSound("Effects","Elite08");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Carbon12");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","OfficerAttack02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","OfficerAttack1");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "ZPCI Medic")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","MedicAttack3");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Klima05");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Klima04");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "ZPCI Pyrotech")
         {
            if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Farsight03");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Carbon13");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Dr Klima")
         {
            if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Klima02");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Klima03");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Celestia")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Celestia05");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Celestia06");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Celestia04");
               numberRandomerBuffHit2++;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Artemis" || IDKC.playerName == "Dream Keeper" || IDKC.playerName == "Baroness Marie")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","GhostG5");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","GhostG6");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","GhostG7");
               numberRandomerBuffHit2++;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Warlock" || IDKC.playerName == "Avatar of Freedom" || IDKC.playerName == "Oracle" || IDKC.playerName == "Shade Zombie")
         {
            if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Ghost05");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Ghost04");
               numberRandomerBuffHit2++;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Avatar of Justice" || IDKC.playerName == "Count Augustin" || IDKC.playerName == "Plague Assasin" || IDKC.playerName == "Baron Brixius")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Ghost026");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Ghost025");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Ghost024");
               numberRandomerBuffHit2++;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
         if(IDKC.playerName == "Apollo" || IDKC.playerName == "Spartan" || IDKC.playerName == "Zealot" || IDKC.playerName == "Templar Arcanis")
         {
            if(numberRandomerBuffHit2 == 2)
            {
               _root.addSound("Effects","Knight05");
               numberRandomerBuffHit2 = 0;
            }
            else if(numberRandomerBuffHit2 == 1)
            {
               _root.addSound("Effects","Knight06");
               numberRandomerBuffHit2++;
            }
            else if(numberRandomerBuffHit2 == 0)
            {
               _root.addSound("Effects","Knight07");
               numberRandomerBuffHit2 = 1;
            }
            else
            {
               numberRandomerBuffHit2 = 0;
            }
         }
      }
      _root.DamageOutputKrinFinal = Math.ceil(IDKC.DMG + IDKT.IDMG + IDKC.DEFU[IDKM2[0]] * IDKM2[77] * IDKT.DEFENSE + numberOutputInner1 * focusCoEF * coEFKN6723 * (coEFKN6724 * IDKM2[72]) * (1 + IDKC.DMG2) * (1 + IDKT.IDMG2) * IDKT.IDMGP2);
      _root.DamageOutputKrinFinal2 = 0;
      if(_root.perKSuccess)
      {
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            _root.DamageOutputKrinFinal *= IDKC.CRITMODIFIER;
         }
         _root.DamageOutputKrinFinal *= IDKM2[89];
      }
      if(IDKT.playerName == "Iron Guard")
      {
         IDKT.FOCUSPLUS += 0.25;
      }
      if(_root.DamageOutputKrinFinal <= 0 || _root.DamageOutputKrinFinal == eval("NaN"))
      {
         _root.DamageOutputKrinFinal = 1;
      }
      if(IDKC.playerName == "Sonny")
      {
         if(IDKM[0] == "Destroy2" || IDKM[0] == "High Voltage" && IDKM2[2] > 3)
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
         if(IDKM[0] == "Destroy2" || IDKM[0] == "High Voltage" && IDKM2[2] > 3)
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
      if(IDKM2[57] > IDKT.LIFEN / IDKT.LIFEU)
      {
         _root.DamageOutputKrinFinal *= 1.5;
      }
      if(IDKM2[59] > 0)
      {
         _root.DamageOutputKrinFinal += IDKM2[59] * IDKT.LIFEN;
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
            if(IDKT.LIFEN <= 0 && IDKT.START != 0)
            {
               G = 0;
               while(G < 3)
               {
                  _root.applyBuffKrin(_root["playerKrin" + (IDKC.teamSide + G * 2)],IDKT.START,1,_root["playerKrin" + (IDKC.teamSide + G * 2)]);
                  _root.applyChangesKrin(_root["playerKrin" + (IDKC.teamSide + G * 2)]);
                  G++;
               }
            }
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
            if(_root.DamageOutputKrinFinal != eval("NaN"))
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
      perScript(PERCALK,1,IDKM2,IDKC);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 1.5;
         if(IDKC.playerName == "Redfield")
         {
            _root.addSound("Effects","VO_Zakk_Crit01");
         }
         if(IDKC.playerName == "Felicity")
         {
            _root.addSound("Effects","crit_felicity3");
         }
         if(IDKC.playerName == "Vendara")
         {
            _root.addSound("Effects","VO_Vendara_Crit02");
         }
         if(IDKC.playerName == "Parineeta")
         {
            _root.addSound("Effects","FarsightCrit2");
         }
         if(IDKC.playerName == "Flamed ZPCI Medic")
         {
            _root.addSound("Effects","MedicHeal1");
         }
      }
      else
      {
         coEFKN6724 = 1;
      }
      if(IDKM2[71] != 0)
      {
         IDKC.LIFEN -= IDKC.MAGICU * IDKM2[4] * IDKM2[71];
         if(IDKC.LIFEN > IDKC.LIFEU)
         {
            IDKC.LIFEN = IDKC.LIFEU;
         }
         _root.KrinNumberShow(IDKC.MAGICU * IDKM2[4] * IDKM2[71],"player" + IDKC.playerID,IDKM2[0]);
         _root.lifeBarUpdate(IDKC.playerID);
      }
      _root.DamageOutputKrinFinal = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      _root.DamageOutputKrinFinal2 = Math.ceil(numberOutputInner1 * focusCoEF * coEFKN6723 * coEFKN6724 * IDKC.HEALMOD * IDKT.HEALMOD_PLUS * IDKT.HEALMOD_MINUS);
      if(_root.perKSuccess)
      {
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            _root.DamageOutputKrinFinal *= IDKC.CRITMODIFIER;
         }
         _root.DamageOutputKrinFinal *= IDKM2[89];
      }
      if(IDKM2[59] < 0)
      {
         _root.DamageOutputKrinFinal -= IDKM2[59] * IDKT.LIFEN;
      }
      if(IDKM2[84] < 0)
      {
         _root.DamageOutputKrinFinal += -1 * IDKM2[84] * IDKT.LIFEU;
      }
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
      _root.BATTLEFLASH.hitTarget = _root.BATTLESCREEN["player" + IDKT.playerID];
      _root.BATTLEFLASH.DFTC = IDKT.characterColorState;
      _root.BATTLEFLASH.DFTF = IDKT.characterFilterState;
      _root.BATTLEFLASH.DFTP = IDKT;
      _root.BATTLEFLASH.gotoAndPlay("focus");
      _root.lifeBarUpdate(IDKT.playerID);
   }
   if(IDKM[14] == "Focus3")
   {
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6] + IDKC.LIFEU * IDKM2[12] + IDKM2[9];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,1,IDKM2,IDKC);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 1.5;
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            coEFN6724 *= IDKC.CRITMODIFIER;
         }
         coEFN6724 *= IDKM2[89];
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
      if(_root.perKSuccess)
      {
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            _root.DamageOutputKrinFinal *= IDKC.CRITMODIFIER;
         }
         _root.DamageOutputKrinFinal *= IDKM2[89];
      }
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
      if(IDKM2[9] < 0)
      {
         IDKM2[9] + mTarget.SLOWRESIST;
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
      numberOutputInner1 = (IDKC.STRENGTHU + IDKM2[1]) * IDKM2[2] + (IDKC.MAGICU + IDKM2[3]) * IDKM2[4] + (IDKC.SPEEDU + IDKM2[5]) * IDKM2[6];
      coEFKN6723 = IDKM2[10];
      perScript(PERCALK,DEFCALK,IDKM2,IDKC);
      if(_root.perKSuccess)
      {
         _root.GridShaker.play();
         coEFKN6724 = 0.016666667 * Math.pow(CRITCALC_X + 1,4) - 0.25 * Math.pow(CRITCALC_X + 1,3) + 1.233333 * Math.pow(CRITCALC_X + 1,2) - 1.9000000000000001 * (CRITCALC_X + 1) + 1.9000000000000001;
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            coEFN6724 *= IDKC.CRITMODIFIER;
         }
         coEFN6724 *= IDKM2[89];
         if(coEFKN6724 < 0)
         {
            coEFKN6724 = 0;
         }
         if(IDKC.playerName == "Sonny")
         {
            _root.addSound("Effects","VO_Sonny_Crit03");
         }
         if(IDKC.playerName == "Veradux")
         {
            _root.addSound("Effects","Angry_Dux");
         }
         if(IDKC.playerName == "Blackflamed Elite")
         {
            _root.addSound("Effects","OfficerAttack1");
         }
         if(IDKC.playerName == "Flamed ZPCI Medic")
         {
            _root.addSound("Effects","MedicAttack3");
         }
         if(IDKC.playerName == "Blackflamed Freezer")
         {
            _root.addSound("Effects","OfficerAttack02");
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
            _root.addSound("Effects","VO_Vendara_Crit1");
         }
         if(IDKC.playerName == "Parineeta")
         {
            _root.addSound("Effects","FarsightCrit2");
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
      _root.DamageOutputKrinFinal = Math.ceil(IDKC.DMG + IDKT.IDMG + IDKC.DEFU[IDKM2[0]] * IDKM2[77] * IDKT.DEFENSE + numberOutputInner1 * focusCoEF * coEFKN6723 * (coEFKN6724 * IDKM2[72]) * (1 + IDKC.DMG2) * (1 + IDKT.IDMG2) * IDKT.IDMGP2);
      if(_root.perKSuccess)
      {
         if(IDKM[10] != "Melee" && IDKM[10] != "Melee2")
         {
            _root.DamageOutputKrinFinal *= IDKC.CRITMODIFIER;
         }
         _root.DamageOutputKrinFinal *= IDKM2[89];
      }
      _root.DamageOutputKrinFinal2 = 0;
      if(IDKT.playerName == "Iron Guard")
      {
         IDKT.FOCUSPLUS += 0.25;
      }
      if(_root.DamageOutputKrinFinal <= 0 || _root.DamageOutputKrinFinal == eval("NaN"))
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
            if(IDKT.LIFEN <= 0 && IDKT.START != 0)
            {
               G = 0;
               while(G < 3)
               {
                  _root.applyBuffKrin(_root["playerKrin" + (IDKC.teamSide + G * 2)],IDKT.START,1,_root["playerKrin" + (IDKC.teamSide + G * 2)]);
                  _root.applyChangesKrin(_root["playerKrin" + (IDKC.teamSide + G * 2)]);
                  G++;
               }
            }
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
            if(_root.DamageOutputKrinFinal != eval("NaN"))
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
      if(IDKM2[9] < 0)
      {
         IDKM2[9] + mTarget.SLOWRESIST;
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
function perScript(PERCALKK, DEFCALKK, GGG, GGC)
{
   _root.KRRR();
   if(SPEEDCRITCALC < 0)
   {
      SPEEDCRITCALC = 0;
   }
   if(_root.KRSO < GGG[58] * (PERCALKK + GGG[7] + GGC.CRIT + SPEEDCRITCALC) * GGG[8] / DEFCALKK * 15)
   {
      _root.perKSuccess = true;
   }
   else if(GGG[58] == 0 && _root.KRSO < (PERCALKK + GGG[7] + GGC.CRIT + SPEEDCRITCALC) * GGG[8] / DEFCALKK2 * 15)
   {
      _root.perKSuccess = true;
   }
   else
   {
      _root.perKSuccess = false;
   }
}
BarHolder = new Array();
BarHolder2 = new Array();
BarHolder3 = new Array();
BarHolder4 = new Array();
lifeBarUpdate = function(PWLC)
{
   ghjul = _root["playerKrin" + PWLC];
   _root["p" + PWLC + "BAR"].inner.lifeNow = ghjul.LIFEN;
   _root["p" + PWLC + "BAR"].inner.lifeMax = ghjul.LIFEU;
   _root["p" + PWLC + "BAR"].inner.focusNow = ghjul.FOCUSN;
   _root["p" + PWLC + "BAR"].inner.focusMax = ghjul.FOCUSU;
   if(_root.Krin.BattlePick > 4999 && _root.Krin.BattlePick < 5999)
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = ghjul.FOCUSPLUS * 100;
   }
   if(_root.Krin.BattlePick == 7001)
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = ghjul.STRENGTH;
   }
   if(ghjul.BLEED < ghjul.BLEEDMAX)
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = "Bleed:" + ghjul.BLEED;
   }
   else
   {
      _root["p" + PWLC + "BAR"].inner.focusMax20 = "                ";
   }
   _root["p" + PWLC + "BAR"].inner.playerName = ghjul.playerName;
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
