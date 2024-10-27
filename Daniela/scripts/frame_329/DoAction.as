thingerDepthK = 0;
stop();
i = 0;
while(i < 40)
{
   if(_root.Krin.progressLevelOn >= Krin.progressArray[i][0] - 1)
   {
      krinMapper["mb" + i].sectionID = i;
      if(i > 0)
      {
         if(Krin.progressArray[i][0] != undefined)
         {
            krinMapper.lineMC.createEmptyMovieClip("line_mc" + thingerDepthK,thingerDepthK);
            krinMapper.lineMC["line_mc" + thingerDepthK].lineStyle(2,0,30);
            krinMapper.lineMC["line_mc" + thingerDepthK].moveTo(krinMapper["mb" + i]._x,krinMapper["mb" + i]._y);
            krinMapper.lineMC["line_mc" + thingerDepthK].lineTo(krinMapper["mb" + (i - 1)]._x,krinMapper["mb" + (i - 1)]._y);
            thingerDepthK++;
         }
      }
   }
   else
   {
      krinMapper["mb" + i]._visible = false;
   }
   i++;
}
if(_root.Krin.progressLevelOn >= 42)
{
   _root.Krin.friendArray = [0,1,2,3,4,5];
}
