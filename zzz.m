%%%下面是函数zzz的定义，功能是计算露头面法线方向上三维空间的长度
function zz=zzz(sdir,sdiar,S1,S2,S3)
%%%%%%%%露头面法向量%%%%%%%
SA=cos(sdir*3.14/180)*sin(sdiar*3.14/180);
SB=sin(sdir*3.14/180)*sin(sdiar*3.14/180);
SC=cos(sdiar*3.14/180);

%%%为了求解zzz，需要使露头面的法线与长方体三维裂隙网络相交。模拟露头面的法线方程：(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB，令其与长方体状三维裂隙网络的6个面相交，可解得6个交点
%%%s=solve('x=0','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');
%%%s=solve('x=S1','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');
%%%s=solve('y=0','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');
%%%s=solve('y=S2','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');
%%%s=solve('z=0','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');
%%%s=solve('z=S3','(x-S1/2)/SA=(y-S2/2)/SB','(z-S3/2)/SC=(y-S2/2)/SB','x,y,z');

jd1y= (S2*SA - S1*SB)/(2*SA);
jd1z= (S3*SA - S1*SC)/(2*SA);

jd2y= (S2*SA + S1*SB)/(2*SA);
jd2z= (S3*SA + S1*SC)/(2*SA);

jd3x= -(S2*SA - S1*SB)/(2*SB);
jd3z= (S3*SB - S2*SC)/(2*SB);

jd4x= (S2*SA + S1*SB)/(2*SB);
jd4z= (S3*SB + S2*SC)/(2*SB);

jd5x= -(S3*SA - S1*SC)/(2*SC);
jd5y= -(S3*SB - S2*SC)/(2*SC);

jd6x= (S3*SA + S1*SC)/(2*SC);
jd6y= (S3*SB + S2*SC)/(2*SC);
jdzb=ones(6,3);
jdzb=jdzb.*-1;		%将jdzb初始化为全-1矩阵，是为了后续筛选的方便
if jd1y>=0 && jd1y<=S2 && jd1z>=0 && jd1z<=S3
jdzb(1,:)=[0,jd1y,jd1z];
end
if jd2y>=0 && jd2y<=S2 && jd2z>=0 && jd2z<=S3
jdzb(2,:)=[S1,jd2y,jd2z];
end
if jd3x>=0 && jd3x<=S1 && jd3z>=0 && jd3z<=S3
jdzb(3,:)=[jd3x,0,jd3z];
end
if jd4x>=0 && jd4x<=S1 && jd4z>=0 && jd4z<=S3
jdzb(4,:)=[jd4x,S2,jd4z];
end
if jd5x>=0 && jd5x<=S1 && jd5y>=0 && jd5y<=S2
jdzb(5,:)=[jd5x,jd5y,0];
end
if jd6x>=0 && jd6x<=S1 && jd6y>=0 && jd6y<=S2
jdzb(6,:)=[jd6x,jd6y,S3];
end
k=1;
for i=1:6
if jdzb(i,1)~=-1
jdslct(k,:)=jdzb(i,:);		%jdslct是筛选后的交点坐标的集合
k=k+1;
end
end
zz=sqrt((jdslct(1,1)-S1/2)^2+(jdslct(1,2)-S2/2)^2+(jdslct(1,3)-S3/2)^2)*2;
