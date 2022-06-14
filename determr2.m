%%%%������determr2�����Ķ��壬������ȷ��r2�ķֲ���ʽ���ֲ�����
%%%%1. ��������������γ��򣬵���r2�ķ���õ�r2������ֵ�����ܼ�������
%%%%�˶γ�����r2�������ֲַ������Լ���õ�ÿ�ֲַ���r2������ֵ��

function [nm2,Normnv2,Gamnv2,Lognnv2,NormX2,GamX2,LognX2]=determr2(re)
chre=linspace(0,0,length(re));		%re���ֳ�ʵ����϶�����ݣ������˵��������״��6��
chre(:)=re(:,4)./2; 	%�ֳ��İ뼣��ch
ch2=chre.^2;
Ech2=mean(ch2);	%����E(ch2)���ֳ�ֵ
Dch2=var(ch2);	%����D(ch2)���ֳ�ֵ
VDch2=linspace(Dch2,Dch2,100);	%���ں���Ѱ����ӽ�D(ch2)�ֳ�ֵ��D(ch2)
nm2=Ech2*1.5;	%E(r2)������1.5E(ch2)
uty=unifrnd(0,1,1,10000);	%����һ��u/r�������
chtor2=1-uty.^2; 		%��Ӧ��u/r������һ��ch2/r2�������
for ofst=1:100
nv2=Dch2*(1+ofst*0.01);		%ʹD(r2)��D(ch2)��2D(ch2)֮��仯����


%%%%%��̬�ֲ�
Normnm=nm2;   %��̬�ֲ��ô˶�ʽ����nm,nv�����ֲ�����mu��sigma
Normnv=sqrt(nv2);
for aa=1:100
Normr2=normrnd(Normnm,Normnv,1,10000);
Normch2=Normr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Nch2=Normch2;   %��̬�ֲ���ִ���ⲿ�ִ��룬����̬�ֲ����ܳ��ָ�ֵ
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
Normvarp(ofst)=mean(Normv);		%����D(ch2)��ģ��ֵ

%%%%%gamma�ֲ�
Gamnm=nm2^2/nv2;	%gamma�ֲ��ô˶�ʽ����nm,nv�����ֲ�����
Gamnv=nv2/nm2;
for aa=1:100
Gamr2=gamrnd(Gamnm,Gamnv,1,10000);
Gamch2=Gamr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Gamv(aa)=var(Gamch2);
end
Gamvarp(ofst)=mean(Gamv); 		%����D(ch2)��ģ��ֵ

%%%%%������̬�ֲ�
Lognnm=log(nm2^2 / sqrt(nv2+nm2^2));	%������̬�ֲ��ô˶�ʽ����nm,nv�����ֲ�����
Lognnv=sqrt(log(nv2/nm2^2 + 1));
for aa=1:100
Lognr2=lognrnd(Lognnm,Lognnv,1,10000);
Lognch2=Lognr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Lognv(aa)=var(Lognch2);
end
Lognvarp(ofst)=mean(Lognv); 		%����D(ch2)��ģ��ֵ

end

Normresdnt=(Normvarp-VDch2).^2;	%Ѱ����ӽ�D(ch2)�ֳ�ֵ��D(ch2)
Gamresdnt=(Gamvarp-VDch2).^2;
Lognresdnt=(Lognvarp-VDch2).^2;

[Normsorted,Normrank]=sort(Normresdnt,'ascend');
[Gamsorted,Gamrank]=sort(Gamresdnt,'ascend');
[Lognsorted,Lognrank]=sort(Lognresdnt,'ascend');

Normnv2=Dch2*(1+Normrank(1)*0.01);	%�õ����ֲַ����Ե�����D(r2)
Gamnv2=Dch2*(1+Gamrank(1)*0.01);
Lognnv2=Dch2*(1+Lognrank(1)*0.01);

%Ϊ�˽�����һ�����Ȱ��޹صı������
Gamch2=[]; Gamnm=[]; Gamnv=[]; Gamr2=[]; Gamrank=[]; Gamresdnt=[]; Gamsorted=[]; Gamv=[]; Gamvarp=[]; Lognch2=[]; Lognnm=[]; Lognnv=[]; Lognr2=[]; Lognrank=[]; Lognresdnt=[]; Lognsorted=[]; Lognv=[]; Lognvarp=[]; Nch2=[]; Normch2=[]; Normnm=[]; Normnv=[]; Normr2=[]; Normrank=[]; Normresdnt=[]; Normsorted=[]; Normv=[]; Normvarp=[]; VDch2=[]; aa=[]; chtor2=[]; i=[]; j=[]; nv2=[]; ofst=[]; uty=[];
%Ϊ�˽�����һ�����Ȱ��޹صı������


%���ˣ����ֲַ����Ե�����D(r2)�����ҵ�����������һ�γ����ж�r2�����ŷֲ���ʽ��˼����X2����

uty=unifrnd(0,1,1,10000);	%����һ��u/r�������
chtor2=1-uty.^2; 		%��Ӧ��u/r������һ��ch2/r2�������
aa=length(chre); 	%aaΪ�ֳ���϶����

%%%%%��̬�ֲ�
Normnm=nm2;   %��̬�ֲ��ô˶�ʽ����nm,nv�����ֲ�����mu��sigma
Normnv=sqrt(Normnv2);
Normr2=normrnd(Normnm, Normnv,1,10000);
Nr2=Normr2;   %��̬�ֲ���ִ���ⲿ�ִ��룬����̬�ֲ����ܳ��ָ�ֵ
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

Normch2=Normr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Normch=sqrt(Normch2);		%��Ӧ�صõ�ch��һ�������
Normmi=floor(min(Normch));
Normma=ceil(max(Normch));
Norminter=(Normma-Normmi)/15;
Normmii=linspace(Normmi, Normmi,10000);
Normmir=linspace(Normmi, Normmi,aa);
Normchmodified=Normch-Normmii;	%���Normchmodified��Normchremodified��Ŀ���Ǳ��ڼ���
Normchremodified=chre-Normmir;

Normchcounter= linspace(0,0,15);	%chcounter���������ģ����İ뼣��chֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
Normchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Normchmodified(i)> Norminter*(n1-1) && Normchmodified(i)<= Norminter*n1
Normchcounter(n1)= Normchcounter(n1)+1;
end
end
end

for j=1:aa		%aaΪ�ֳ���϶����
for n2=1:15
if Normchremodified (j)> Norminter*(n2-1) && Normchremodified (j)<= Norminter*n2
Normchcounterre(n2)= Normchcounterre(n2)+1;	%chcounterre���ֳ��뼣��chֵ���ڸ������ڵ�Ƶ��
end
end
end
Normchcounterim= Normchcounter./10000.*aa;	%���ݸ�����������ֳ�һ��
Normchcounterim(Normchcounterim==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
NormX2=nansum(((Normchcounterre-Normchcounterim).^2)./ Normchcounterim);	%����X2ֵ����ȷ��r2�����ŷֲ���
NormX2

%%%%%gamma�ֲ�
Gamnm=nm2^2/Gamnv2;	%gamma�ֲ��ô˶�ʽ����nm,nv�����ֲ�����
Gamnv=Gamnv2/nm2;
Gamr2=gamrnd(Gamnm,Gamnv,1,10000);

Gamch2=Gamr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Gamch=sqrt(Gamch2);		%��Ӧ�صõ�ch��һ�������
Gammi=floor(min(Gamch));
Gamma=ceil(max(Gamch));
Gaminter=(Gamma-Gammi)/15;
Gammii=linspace(Gammi, Gammi,10000);
Gammir=linspace(Gammi, Gammi,aa);
Gamchmodified=Gamch-Gammii;	%���Gamchmodified��Gamchremodified��Ŀ���Ǳ��ڼ���
Gamchremodified=chre-Gammir;

Gamchcounter= linspace(0,0,15);	%chcounter���������ģ����İ뼣��chֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
Gamchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Gamchmodified(i)> Gaminter*(n1-1) && Gamchmodified(i)<= Gaminter*n1
Gamchcounter(n1)= Gamchcounter(n1)+1;
end
end
end

for j=1:aa		%aaΪ�ֳ���϶����
for n2=1:15
if Gamchremodified (j)> Gaminter*(n2-1) && Gamchremodified (j)<= Gaminter*n2
Gamchcounterre(n2)= Gamchcounterre(n2)+1;	%chcounterre���ֳ��뼣��chֵ���ڸ������ڵ�Ƶ��
end
end
end
Gamchcounterim= Gamchcounter./10000.*aa;	%���ݸ�����������ֳ�һ��
Gamchcounterim(Gamchcounterim==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
GamX2=nansum(((Gamchcounterre-Gamchcounterim).^2)./ Gamchcounterim);	%����X2ֵ����ȷ��r2�����ŷֲ���
GamX2

%%%%%������̬�ֲ�
Lognnm=log(nm2^2 / sqrt(Lognnv2+nm2^2));	%������̬�ֲ��ô˶�ʽ����nm,nv�����ֲ�����
Lognnv=sqrt(log(Lognnv2/nm2^2 + 1));
Lognr2=lognrnd(Lognnm, Lognnv,1,10000);


Lognch2=Lognr2.*chtor2;	%��Ӧ��r������һ��ch^2�������
Lognch=sqrt(Lognch2);		%��Ӧ�صõ�ch��һ�������
Lognmi=floor(min(Lognch));
Lognma=ceil(max(Lognch));
Logninter=(Lognma-Lognmi)/15;
Lognmii=linspace(Lognmi,Lognmi,10000);
Lognmir=linspace(Lognmi,Lognmi,aa);
Lognchmodified=Lognch-Lognmii;	%���Lognchmodified��Lognchremodified��Ŀ���Ǳ��ڼ���
Lognchremodified=chre-Lognmir;

Lognchcounter= linspace(0,0,15);	%chcounter���������ģ����İ뼣��chֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
Lognchcounterre= linspace(0,0,15);

for i=1:10000
for n1=1:15 
if Lognchmodified(i)>Logninter*(n1-1) && Lognchmodified(i)<= Logninter*n1
Lognchcounter(n1)=Lognchcounter(n1)+1;
end
end
end

for j=1:aa		%aaΪ�ֳ���϶����
for n2=1:15
if Lognchremodified (j)> Logninter*(n2-1) && Lognchremodified (j)<= Logninter*n2
Lognchcounterre(n2)=Lognchcounterre(n2)+1;	%chcounterre���ֳ��뼣��chֵ���ڸ������ڵ�Ƶ��
end
end
end
Lognchcounterim= Lognchcounter./10000.*aa;	%���ݸ�����������ֳ�һ��
Lognchcounterim(Lognchcounterim==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
LognX2=nansum(((Lognchcounterre-Lognchcounterim).^2)./Lognchcounterim);	%����X2ֵ����ȷ��r2�����ŷֲ���
LognX2
%Normnv2
%Gamnv2
%Lognnv2

