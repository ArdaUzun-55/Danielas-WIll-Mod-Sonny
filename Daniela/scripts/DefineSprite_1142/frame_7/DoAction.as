my_txt.removeTextField();
my_txt2.removeTextField();
my_txt3.removeTextField();
my_txt4.removeTextField();
ttt.removeTextField();
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
   scaffold = -163;
}
this.createTextField("my_txt3",2,scaffold,21,150,120);
my_txt3.color = 16777215;
my_txt3.autoSize = "left";
my_txt3.border = true;
my_txt3.multiline = true;
my_txt3.text = t3;
my_txt3.wordWrap = true;
var my_fmt3 = new TextFormat();
my_fmt3.font = "_sans";
my_fmt3.color = 51;
my_fmt3.size = 12;
my_fmt3.indent = 2;
my_txt3.setTextFormat(my_fmt3);
fontBacker3._height = my_txt3._height;
fontBacker3._width = my_txt3._width;
fontBacker3._x = my_txt3._x;
fontBacker3._y = my_txt3._y;
this.createTextField("my_txt",0,scaffold,my_txt3._y + my_txt3._height + 2,150,120);
my_txt.color = 16777215;
my_txt.autoSize = "left";
my_txt.border = true;
my_txt.multiline = true;
my_txt.text = t;
my_txt.wordWrap = true;
var my_fmt = new TextFormat();
my_fmt.font = "_sans";
my_fmt.color = 16777215;
my_fmt.size = 12;
my_fmt.indent = 2;
my_txt.setTextFormat(my_fmt);
fontBacker._height = my_txt._height;
fontBacker._width = my_txt._width;
fontBacker._x = my_txt._x;
fontBacker._y = my_txt._y;
this.createTextField("my_txt2",1,scaffold,0,150,120);
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
