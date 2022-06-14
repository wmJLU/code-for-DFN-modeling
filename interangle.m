%%%下面是函数interangle的定义，功能是计算裂隙平均产状的法线与露头面法线的夹角。由于后续程序的需要，此函数的返回值是夹角的余弦值。
function theta=interangle(avdir,avdiar,sdir,sdiar)
%%%%%%%%裂隙面法向量%%%%%%%
FA=cos(avdir*3.14/180)*sin(avdiar*3.14/180);
FB=sin(avdir*3.14/180)*sin(avdiar*3.14/180);
FC=cos(avdiar*3.14/180);
%%%%%%%%露头面法向量%%%%%%%
SA=cos(sdir*3.14/180)*sin(sdiar*3.14/180);
SB=sin(sdir*3.14/180)*sin(sdiar*3.14/180);
SC=cos(sdiar*3.14/180);
theta=FA*SA+FB*SB+FC*SC;	%由于两个向量的模都为1，所以二者的内积就是夹角余弦
