%%%%%下面是determr_Logn函数的定义。
%%%%%%3C. 以下反求三维空间中的裂隙总数，并确定三维空间中的r服从何种分布，这是r2服从对数正态分布的情况
function [Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Logn(aa,zz,theta,nm2,Lognnv2)
uty=unifrnd(0,1,1,100000);	%生成一组u/r的随机数
chtor2=1-uty.^2; 		%相应于u/r，生成一组ch2/r2的随机数
nm=log(nm2^2 / sqrt(Lognnv2+nm2^2));	%对数正态分布用此二式计算nm,nv
nv=sqrt(log(Lognnv2/nm2^2 + 1));		
r2=lognrnd(nm,nv,1,100000);
r=sqrt(r2);	%得到相应的r的随机数
rmax=10*ceil(max(r));		%这里乘以10，是为了与下面的步长0.1对应


rcounter=linspace(0,0, rmax);	%rcounter存放模拟的100000条裂隙中，r值位于各个区间内的裂隙的条数
for j=1:100000
for n2=1:rmax
if r(j)>0.1*(n2-1) && r(j)<=0.1*n2	%循环的步长固定为0.1
rcounter(n2)=rcounter(n2)+1;
end
end
end

rcounterim=rcounter./100000.*aa;	%数据个数换算成与现场一致，rcounterim存放现场裂隙中，r值位于各个区间内的裂隙的条数
I=linspace(0,0,rmax);
syms x;
for k=1:rmax
I(k)= sqrt(1-theta^2)/ zz *int(x,0.1*(k-1),0.1*k);	%计算积分。此积分是r属于每一区间的所有裂隙与三维空间中平面相交的概率。此概率乘以三维空间内半径位于该区间内的裂隙条数，即是该半径区间内与平面相交的（有迹长的）裂隙条数。
end
Netofr=rcounterim./I;		%换算出三维空间中，r值位于各个区间内的裂隙条数
Nofr=Netofr;
r2d=[];	%r2d存放模拟出的三维空间中的r值
r2d(1:round(Nofr(1)))=unifrnd(0,0.1,1,round(Nofr(1)));	%Nofr只是r值分布直方图，没有具体的r，这行就模拟出一组r值来，在每一个r值分组内认为r服从均匀分布。
r2dstd=round(Nofr(1));
for n4=2:rmax
r2d((r2dstd+1):(r2dstd+round(Nofr(n4))))=unifrnd(0.1*(n4-1),0.1*n4,1,round(Nofr(n4)));
r2dstd=r2dstd+round(Nofr(n4));	%这就实现了把模拟出的r值存放在一个数组中，便于形成godfit的输入文件。
end	


%%%%%%以下还要确定三维空间中的r服从何种分布，需要用X2检验
[normm, norms]=normfit(r2d); 	%获取正态分布参数
Gampara=gamfit(r2d);	%获取gamma分布参数
Lognpara=lognfit(r2d);	%获取对数正态分布参数

%%%%%正态分布
Normr2d=normrnd(normm, norms,1,10000);
Nr2d=Normr2d;   %正态分布需执行这部分代码，因正态分布可能出现负值
j=1;
for i=1:10000
if Normr2d(i)>0
Normr2d(j)=Nr2d(i);
j=j+1;
end
end
for k=j:10000
Normr2d(k)=0.1;
k=k+1;
end

Normmi=floor(min(Normr2d));
Normma=ceil(max(Normr2d));
Norminter=(Normma-Normmi)/15;
Normmii=linspace(Normmi, Normmi,10000);
Normmir=linspace(Normmi, Normmi,length(r2d));
Normr2dmodified=Normr2d-Normmii;	%设计Normr2dmodified和Normr2d2modified的目的是便于计数
Normr2d2modified=r2d-Normmir;

Normr2dcounter= linspace(0,0,15);	% Normr2dcounter向量，存放模拟出的服从正态分布的r值落在各区间内的频数。这里将直方图组数固定为15
Normr2d2counter= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Normr2dmodified(i)> Norminter*(n1-1) && Normr2dmodified(i)<= Norminter*n1
Normr2dcounter(n1)= Normr2dcounter(n1)+1;
end
end
end

for j=1: length(r2d)
for n2=1:15
if Normr2d2modified (j)> Norminter*(n2-1) && Normr2d2modified (j)<= Norminter*n2
Normr2d2counter(n2)= Normr2d2counter(n2)+1;	% Normr2d2counter是r2d值落在各区间内的频数
end
end
end
Normr2dcounterim= Normr2dcounter./10000.*length(r2d);	%数据个数换算成与现场一致
Normr2d2counter(Normr2d2counter==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
Normchi2=nansum(((Normr2d2counter -Normr2dcounterim).^2)./ Normr2d2counter);	%计算X2值，以确定r的最优分布。

Normexpt=2*normm;
Normvarp=4*norms^2;		%这里得到的是圆盘直径的均值和方差，是进行后面的工作的基础！

%%%%%gamma分布
Gamr2d=gamrnd(Gampara(1),Gampara(2),1,10000);

Gammi=floor(min(Gamr2d));
Gamma=ceil(max(Gamr2d));
Gaminter=(Gamma-Gammi)/15;
Gammii=linspace(Gammi, Gammi,10000);
Gammir=linspace(Gammi, Gammi,length(r2d));
Gamr2dmodified=Gamr2d-Gammii;	%设计Gamr2dmodified和Gamr2d2modified的目的是便于计数
Gamr2d2modified=r2d-Gammir;

Gamr2dcounter= linspace(0,0,15);	% Gamr2dcounter向量，存放模拟出的服从gamma分布的r值落在各区间内的频数。这里将直方图组数固定为15
Gamr2d2counter= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Gamr2dmodified(i)> Gaminter*(n1-1) && Gamr2dmodified(i)<= Gaminter*n1
Gamr2dcounter(n1)= Gamr2dcounter(n1)+1;
end
end
end

for j=1: length(r2d) 
for n2=1:15
if Gamr2d2modified (j)> Gaminter*(n2-1) && Gamr2d2modified (j)<= Gaminter*n2
Gamr2d2counter(n2)= Gamr2d2counter(n2)+1;	% Gamr2d2counter是r2d值落在各区间内的频数
end
end
end
Gamr2dcounterim= Gamr2dcounter./10000.*length(r2d);	%数据个数换算成与现场一致
Gamr2d2counter(Gamr2d2counter==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
Gamchi2=nansum(((Gamr2d2counter -Gamr2dcounterim).^2)./ Gamr2d2counter);	%计算X2值，以确定r的最优分布。

Gamexpt=2*Gampara(1)*Gampara(2);
Gamvarp=4*Gampara(1)*Gampara(2)^2;		%这里得到的是圆盘直径的均值和方差，是进行后面的工作的基础！

%%%%%对数正态分布
Lognr2d=lognrnd(Lognpara(1), Lognpara(2),1,10000);

Lognmi=floor(min(Lognr2d));
Lognma=ceil(max(Lognr2d));
Logninter=(Lognma-Lognmi)/15;
Lognmii=linspace(Lognmi, Lognmi,10000);
Lognmir=linspace(Lognmi, Lognmi,length(r2d));
Lognr2dmodified=Lognr2d-Lognmii;	%设计Lognr2dmodified和Lognr2d2modified的目的是便于计数
Lognr2d2modified=r2d-Lognmir;

Lognr2dcounter= linspace(0,0,15);	% Lognr2dcounter向量，存放模拟出的服从对数正态分布的r值落在各区间内的频数。这里将直方图组数固定为15
Lognr2d2counter= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Lognr2dmodified(i)> Logninter*(n1-1) && Lognr2dmodified(i)<= Logninter*n1
Lognr2dcounter(n1)= Lognr2dcounter(n1)+1;
end
end
end

for j=1: length(r2d)
for n2=1:15
if Lognr2d2modified (j)> Logninter*(n2-1) && Lognr2d2modified (j)<= Logninter*n2
Lognr2d2counter(n2)= Lognr2d2counter(n2)+1;	% Lognr2d2counter是r2d值落在各区间内的频数
end
end
end
Lognr2dcounterim= Lognr2dcounter./10000.*length(r2d);	%数据个数换算成与现场一致
Lognr2d2counter(Lognr2d2counter==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
Lognchi2=nansum(((Lognr2d2counter -Lognr2dcounterim).^2)./ Lognr2d2counter);	%计算X2值，以确定r的最优分布。

Lognexpt=2*exp(Lognpara(1)+ Lognpara(2)^2/2);
Lognvarp=Lognexpt^2*(exp(Lognpara(2)^2)-1);		%这里得到的是圆盘直径的均值和方差，是进行后面的工作的基础！
