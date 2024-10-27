if(deadNow == true)
{
   this.gotoAndPlay("dead");
   _parent._parent._parent.inner.gotoAndStop("third");
   h = 0;
   while(h < 10)
   {
      removeMovieClip(_parent._parent._parent["bshr" + h]);
      h++;
   }
}
else
{
   removeMovieClip(this);
}
