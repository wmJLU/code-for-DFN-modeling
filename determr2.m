%%%%下面是determr2函数的定义，功能是确定r2的分布形式及分布参数
%%%%1. 首先利用下面这段程序，调节r2的方差，得到r2的最优值，方能继续进行
%%%%此段程序令r2服从三种分布，各自计算得到每种分布下r2的最优值。

function [nm2,Normnv2,Gamnv2,Lognnv2,NormX2,GamX2,LognX2]=determr2(re)
chre=linspace(0,0,length(re));		%re是现场实测裂隙的数据，包括端点坐标与产状，6列
chre(:)=re(:,4)./2; 	%现场的半迹长ch
ch2=chre.^2;
Ech2=mean(ch2);	%计算E(ch2)的现场值
Dch2=var(ch2);	%计算D(ch2)的现场值
VDch2=linspace(Dch2,Dch2,100);	%用于后面寻找最接近D(ch2)现场值的D(ch2)
nm2=Ech2*1.5;	%E(r2)，等于1.5E(ch2)
uty=unifrnd(0,1,1,10000);	%生成一组u/r的随机数
chtor2=1-uty.^2; 		%相应于u/r，生成一组ch2/r2的随机数
for ofst=1:100
nv2=Dch2*(1+ofst*0.01);		%使D(r2)在D(ch2)和2D(ch2)之间变化即可


%%%%%正态分布
Normnm=nm2;   %正态分布用此二式计算nm,nv，即分布参数mu和sigma
Normnv=sqrt(nv2);
for aa=1:100
Normr2=normrnd(Normnm,Normnv,1,10000);
Normch2=Normr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Nch2=Normch2;   %正态分布需执行这部分代码，因正态分布可能出现负值
j=1;
for i=1:10000
if Normch2(i)>0
Normch2(j)=Nch2(i);
j=j+1;
end
end
Normch2(j:10000)=[];
Normv(aa)=var(Normch2);
end
Normvarp(ofst)=mean(Normv);		%这是D(ch2)的模拟值

%%%%%gamma分布
Gamnm=nm2^2/nv2;	%gamma分布用此二式计算nm,nv，即分布参数
Gamnv=nv2/nm2;
for aa=1:100
Gamr2=gamrnd(Gamnm,Gamnv,1,10000);
Gamch2=Gamr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Gamv(aa)=var(Gamch2);
end
Gamvarp(ofst)=mean(Gamv); 		%这是D(ch2)的模拟值

%%%%%对数正态分布
Lognnm=log(nm2^2 / sqrt(nv2+nm2^2));	%对数正态分布用此二式计算nm,nv，即分布参数
Lognnv=sqrt(log(nv2/nm2^2 + 1));
for aa=1:100
Lognr2=lognrnd(Lognnm,Lognnv,1,10000);
Lognch2=Lognr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Lognv(aa)=var(Lognch2);
end
Lognvarp(ofst)=mean(Lognv); 		%这是D(ch2)的模拟值

end

Normresdnt=(Normvarp-VDch2).^2;	%寻找最接近D(ch2)现场值的D(ch2)
Gamresdnt=(Gamvarp-VDch2).^2;
Lognresdnt=(Lognvarp-VDch2).^2;

[Normsorted,Normrank]=sort(Normresdnt,'ascend');
[Gamsorted,Gamrank]=sort(Gamresdnt,'ascend');
[Lognsorted,Lognrank]=sort(Lognresdnt,'ascend');

Normnv2=Dch2*(1+Normrank(1)*0.01);	%得到三种分布各自的最优D(r2)
Gamnv2=Dch2*(1+Gamrank(1)*0.01);
Lognnv2=Dch2*(1+Lognrank(1)*0.01);

%为了进行下一步，先把无关的变量清空
Gamch2=[]; Gamnm=[]; Gamnv=[]; Gamr2=[]; Gamrank=[]; Gamresdnt=[]; Gamsorted=[]; Gamv=[]; Gamvarp=[]; Lognch2=[]; Lognnm=[]; Lognnv=[]; Lognr2=[]; Lognrank=[]; Lognresdnt=[]; Lognsorted=[]; Lognv=[]; Lognvarp=[]; Nch2=[]; Normch2=[]; Normnm=[]; Normnv=[]; Normr2=[]; Normrank=[]; Normresdnt=[]; Normsorted=[]; Normv=[]; Normvarp=[]; VDch2=[]; aa=[]; chtor2=[]; i=[]; j=[]; nv2=[]; ofst=[]; uty=[];
%为了进行下一步，先把无关的变量清空


%至此，三种分布各自的最优D(r2)都已找到。下面用下一段程序判断r2的最优分布形式，思想是X2检验

uty=unifrnd(0,1,1,10000);	%生成一组u/r的随机数
chtor2=1-uty.^2; 		%相应于u/r，生成一组ch2/r2的随机数
aa=length(chre); 	%aa为现场裂隙条数

%%%%%正态分布
Normnm=nm2;   %正态分布用此二式计算nm,nv，即分布参数mu和sigma
Normnv=sqrt(Normnv2);
Normr2=normrnd(Normnm, Normnv,1,10000);
Nr2=Normr2;   %正态分布需执行这部分代码，因正态分布可能出现负值
j=1;
for i=1:10000
if Normr2(i)>0
Normr2(j)=Nr2(i);
j=j+1;
end
end
for k=j:10000
Normr2(k)=0.1;
k=k+1;
end

Normch2=Normr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Normch=sqrt(Normch2);		%相应地得到ch的一组随机数
Normmi=floor(min(Normch));
Normma=ceil(max(Normch));
Norminter=(Normma-Normmi)/15;
Normmii=linspace(Normmi, Normmi,10000);
Normmir=linspace(Normmi, Normmi,aa);
Normchmodified=Normch-Normmii;	%设计Normchmodified和Normchremodified的目的是便于计数
Normchremodified=chre-Normmir;

Normchcounter= linspace(0,0,15);	%chcounter向量，存放模拟出的半迹长ch值落在各区间内的频数。这里将直方图组数固定为15
Normchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Normchmodified(i)> Norminter*(n1-1) && Normchmodified(i)<= Norminter*n1
Normchcounter(n1)= Normchcounter(n1)+1;
end
end
end

for j=1:aa		%aa为现场裂隙条数
for n2=1:15
if Normchremodified (j)> Norminter*(n2-1) && Normchremodified (j)<= Norminter*n2
Normchcounterre(n2)= Normchcounterre(n2)+1;	%chcounterre是现场半迹长ch值落在各区间内的频数
end
end
end
Normchcounterim= Normchcounter./10000.*aa;	%数据个数换算成与现场一致
Normchcounterim(Normchcounterim==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
NormX2=nansum(((Normchcounterre-Normchcounterim).^2)./ Normchcounterim);	%计算X2值，以确定r2的最优分布。
NormX2

%%%%%gamma分布
Gamnm=nm2^2/Gamnv2;	%gamma分布用此二式计算nm,nv，即分布参数
Gamnv=Gamnv2/nm2;
Gamr2=gamrnd(Gamnm,Gamnv,1,10000);

Gamch2=Gamr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Gamch=sqrt(Gamch2);		%相应地得到ch的一组随机数
Gammi=floor(min(Gamch));
Gamma=ceil(max(Gamch));
Gaminter=(Gamma-Gammi)/15;
Gammii=linspace(Gammi, Gammi,10000);
Gammir=linspace(Gammi, Gammi,aa);
Gamchmodified=Gamch-Gammii;	%设计Gamchmodified和Gamchremodified的目的是便于计数
Gamchremodified=chre-Gammir;

Gamchcounter= linspace(0,0,15);	%chcounter向量，存放模拟出的半迹长ch值落在各区间内的频数。这里将直方图组数固定为15
Gamchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Gamchmodified(i)> Gaminter*(n1-1) && Gamchmodified(i)<= Gaminter*n1
Gamchcounter(n1)= Gamchcounter(n1)+1;
end
end
end

for j=1:aa		%aa为现场裂隙条数
for n2=1:15
if Gamchremodified (j)> Gaminter*(n2-1) && Gamchremodified (j)<= Gaminter*n2
Gamchcounterre(n2)= Gamchcounterre(n2)+1;	%chcounterre是现场半迹长ch值落在各区间内的频数
end
end
end
Gamchcounterim= Gamchcounter./10000.*aa;	%数据个数换算成与现场一致
Gamchcounterim(Gamchcounterim==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
GamX2=nansum(((Gamchcounterre-Gamchcounterim).^2)./ Gamchcounterim);	%计算X2值，以确定r2的最优分布。
GamX2

%%%%%对数正态分布
Lognnm=log(nm2^2 / sqrt(Lognnv2+nm2^2));	%对数正态分布用此二式计算nm,nv，即分布参数
Lognnv=sqrt(log(Lognnv2/nm2^2 + 1));
Lognr2=lognrnd(Lognnm, Lognnv,1,10000);


Lognch2=Lognr2.*chtor2;	%相应于r，生成一组ch^2的随机数
Lognch=sqrt(Lognch2);		%相应地得到ch的一组随机数
Lognmi=floor(min(Lognch));
Lognma=ceil(max(Lognch));
Logninter=(Lognma-Lognmi)/15;
Lognmii=linspace(Lognmi,Lognmi,10000);
Lognmir=linspace(Lognmi,Lognmi,aa);
Lognchmodified=Lognch-Lognmii;	%设计Lognchmodified和Lognchremodified的目的是便于计数
Lognchremodified=chre-Lognmir;

Lognchcounter= linspace(0,0,15);	%chcounter向量，存放模拟出的半迹长ch值落在各区间内的频数。这里将直方图组数固定为15
Lognchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Lognchmodified(i)>Logninter*(n1-1) && Lognchmodified(i)<= Logninter*n1
Lognchcounter(n1)=Lognchcounter(n1)+1;
end
end
end

for j=1:aa		%aa为现场裂隙条数
for n2=1:15
if Lognchremodified (j)> Logninter*(n2-1) && Lognchremodified (j)<= Logninter*n2
Lognchcounterre(n2)=Lognchcounterre(n2)+1;	%chcounterre是现场半迹长ch值落在各区间内的频数
end
end
end
Lognchcounterim= Lognchcounter./10000.*aa;	%数据个数换算成与现场一致
Lognchcounterim(Lognchcounterim==0)=1;  %这是为了防止除0，出现卡方值无穷大的情况
LognX2=nansum(((Lognchcounterre-Lognchcounterim).^2)./Lognchcounterim);	%计算X2值，以确定r2的最优分布。
LognX2
%Normnv2
%Gamnv2
%Lognnv2

