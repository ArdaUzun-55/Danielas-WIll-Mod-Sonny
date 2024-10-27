if(Krin.playerNumber == 1)
{
   SerninConditionA = true;
}
else
{
   SerninConditionA = false;
}
if(Krin.singlePlayer == true || SerninConditionA)
{
   KRS = new Array();
   r = 0;
   while(r < 100)
   {
      KRS[r] = random(100);
      r++;
   }
   KRSC = 0;
}
if(!SerninConditionA)
{
}
