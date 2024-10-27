my_txt.removeTextField();
my_txt2.removeTextField();
my_txt3.removeTextField();
my_txt4.removeTextField();
ttt.removeTextField();
if(colorChange != 0)
{
   _root.krinChangeColor(fontBacker2,colorChange);
}
j = 0;
while(j < 10)
{
   this["MY_TX" + j].removeTextField();
   j++;
}
_visible = false;
if(_root._xmouse < 570)
{
   scaffold = 13;
}
else
{
   scaffold = -213;
}
this.createTextField("my_txt3",70,scaffold,21,200,120);
my_txt3.color = 16777215;
my_txt3.autoSize = "left";
my_txt3.border = true;
my_txt3.multiline = true;
my_txt3.text = t3;
my_txt3.wordWrap = true;
var my_fmt3 = new TextFormat();
my_fmt3.font = "_sans";
my_fmt3.color = 3355443;
my_fmt3.size = 12;
my_fmt3.indent = 2;
my_txt3.setTextFormat(my_fmt3);
fontBacker3._height = my_txt3._height;
fontBacker3._width = my_txt3._width;
fontBacker3._x = my_txt3._x;
fontBacker3._y = my_txt3._y;
sortNumber = 0;
previousOne = my_txt3;
for(j in this.TX)
{
   if(this.TX[j] != undefined)
   {
      this.createTextField("MY_TX" + j,j,scaffold,previousOne._y + previousOne._height + 2,200,120);
      shortCut = this["MY_TX" + j];
      shortCut.color = 16777215;
      shortCut.autoSize = "left";
      shortCut.border = false;
      shortCut.multiline = true;
      shortCut.text = this.TX[j];
      shortCut.wordWrap = true;
      var shortCut2 = new TextFormat();
      shortCut2.font = "_sans";
      shortCut2.color = 16308052;
      shortCut2.size = 12;
      shortCut2.indent = 2;
      shortCut.setTextFormat(shortCut2);
      sortNumber++;
      previousOne = this["MY_TX" + j];
   }
}
if(ttx != 0)
{
   this.createTextField("ttt",-1000,scaffold,previousOne._y + previousOne._height + 2,200,120);
   ttt.color = 12123726;
   ttt.autoSize = "left";
   ttt.border = false;
   ttt.multiline = true;
   ttt.text = ttx;
   ttt.wordWrap = true;
   var ttt2 = new TextFormat();
   ttt2.font = "_sans";
   ttt2.color = 12123726;
   ttt2.size = 12;
   ttt2.indent = 2;
   ttt.setTextFormat(ttt2);
   this.createTextField("my_txt4",80,scaffold,my_txt3._y + my_txt3._height + 2,200,2 + ttt._height + (MY_TX0._height + 2) * sortNumber);
}
else
{
   this.createTextField("my_txt4",80,scaffold,my_txt3._y + my_txt3._height + 2,200,(MY_TX0._height + 2) * sortNumber);
}
my_txt4.color = 0;
my_txt4.border = true;
my_txt4.text = "";
fontBacker._height = my_txt4._height;
fontBacker._width = my_txt4._width;
fontBacker._x = my_txt4._x;
fontBacker._y = my_txt4._y;
this.createTextField("my_txt2",90,scaffold,0,200,120);
my_txt2.size = 10;
my_txt2.color = 0;
my_txt2.autoSize = "left";
my_txt2.border = true;
my_txt2.multiline = true;
my_txt2.text = tt;
my_txt2.wordWrap = true;
var my_fmt2 = new TextFormat();
my_fmt2.font = "_sans";
my_fmt2.color = 0;
my_fmt2.size = 12;
my_fmt2.bold = true;
my_fmt2.indent = 3;
my_txt2.setTextFormat(my_fmt2);
fontBacker2._height = my_txt2._height;
fontBacker2._width = my_txt2._width;
fontBacker2._x = my_txt2._x;
fontBacker2._y = my_txt2._y;
_visible = true;
