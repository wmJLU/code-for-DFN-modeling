%%%�����Ǻ���interangle�Ķ��壬�����Ǽ�����϶ƽ����״�ķ�����¶ͷ�淨�ߵļнǡ����ں����������Ҫ���˺����ķ���ֵ�Ǽнǵ�����ֵ��
function theta=interangle(avdir,avdiar,sdir,sdiar)
%%%%%%%%��϶�淨����%%%%%%%
FA=cos(avdir*3.14/180)*sin(avdiar*3.14/180);
FB=sin(avdir*3.14/180)*sin(avdiar*3.14/180);
FC=cos(avdiar*3.14/180);
%%%%%%%%¶ͷ�淨����%%%%%%%
SA=cos(sdir*3.14/180)*sin(sdiar*3.14/180);
SB=sin(sdir*3.14/180)*sin(sdiar*3.14/180);
SC=cos(sdiar*3.14/180);
theta=FA*SA+FB*SB+FC*SC;	%��������������ģ��Ϊ1�����Զ��ߵ��ڻ����Ǽн�����
