if(_parent._parent._parent._alpha > 0)
{
   _parent._parent._parent._alpha -= 5;
   this.gotoAndPlay("dead");
}
else
{
   _parent._parent._visible = false;
   removeMovieClip(this);
}
