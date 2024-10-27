_root.BATTLESCREEN._y += shakeValue;
shakeValue -= shakeMinus;
if(shakeValue > 0)
{
   gotoAndStop("KrinShakeplayHere");
   play();
}
else
{
   shakeValue = shakeOriginal;
   _root.BATTLESCREEN._y += 0.9000000000000002;
   gotoAndStop("KrinShakestopHere");
}
