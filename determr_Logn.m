%%%%%������determr_Logn�����Ķ��塣
%%%%%%3C. ���·�����ά�ռ��е���϶��������ȷ����ά�ռ��е�r���Ӻ��ֲַ�������r2���Ӷ�����̬�ֲ������
function [Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Logn(aa,zz,theta,nm2,Lognnv2)
uty=unifrnd(0,1,1,100000);	%����һ��u/r�������
chtor2=1-uty.^2; 		%��Ӧ��u/r������һ��ch2/r2�������
nm=log(nm2^2 / sqrt(Lognnv2+nm2^2));	%������̬�ֲ��ô˶�ʽ����nm,nv
nv=sqrt(log(Lognnv2/nm2^2 + 1));		
r2=lognrnd(nm,nv,1,100000);
r=sqrt(r2);	%�õ���Ӧ��r�������
rmax=10*ceil(max(r));		%�������10����Ϊ��������Ĳ���0.1��Ӧ


rcounter=linspace(0,0, rmax);	%rcounter���ģ���100000����϶�У�rֵλ�ڸ��������ڵ���϶������
for j=1:100000
for n2=1:rmax
if r(j)>0.1*(n2-1) && r(j)<=0.1*n2	%ѭ���Ĳ����̶�Ϊ0.1
rcounter(n2)=rcounter(n2)+1;
end
end
end

rcounterim=rcounter./100000.*aa;	%���ݸ�����������ֳ�һ�£�rcounterim����ֳ���϶�У�rֵλ�ڸ��������ڵ���϶������
I=linspace(0,0,rmax);
syms x;
for k=1:rmax
I(k)= sqrt(1-theta^2)/ zz *int(x,0.1*(k-1),0.1*k);	%������֡��˻�����r����ÿһ�����������϶����ά�ռ���ƽ���ཻ�ĸ��ʡ��˸��ʳ�����ά�ռ��ڰ뾶λ�ڸ������ڵ���϶���������Ǹð뾶��������ƽ���ཻ�ģ��м����ģ���϶������
end
Netofr=rcounterim./I;		%�������ά�ռ��У�rֵλ�ڸ��������ڵ���϶����
Nofr=Netofr;
r2d=[];	%r2d���ģ�������ά�ռ��е�rֵ
r2d(1:round(Nofr(1)))=unifrnd(0,0.1,1,round(Nofr(1)));	%Nofrֻ��rֵ�ֲ�ֱ��ͼ��û�о����r�����о�ģ���һ��rֵ������ÿһ��rֵ��������Ϊr���Ӿ��ȷֲ���
r2dstd=round(Nofr(1));
for n4=2:rmax
r2d((r2dstd+1):(r2dstd+round(Nofr(n4))))=unifrnd(0.1*(n4-1),0.1*n4,1,round(Nofr(n4)));
r2dstd=r2dstd+round(Nofr(n4));	%���ʵ���˰�ģ�����rֵ�����һ�������У������γ�godfit�������ļ���
end	


%%%%%%���»�Ҫȷ����ά�ռ��е�r���Ӻ��ֲַ�����Ҫ��X2����
[normm, norms]=normfit(r2d); 	%��ȡ��̬�ֲ�����
Gampara=gamfit(r2d);	%��ȡgamma�ֲ�����
Lognpara=lognfit(r2d);	%��ȡ������̬�ֲ�����

%%%%%��̬�ֲ�
Normr2d=normrnd(normm, norms,1,10000);
Nr2d=Normr2d;   %��̬�ֲ���ִ���ⲿ�ִ��룬����̬�ֲ����ܳ��ָ�ֵ
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
Normr2dmodified=Normr2d-Normmii;	%���Normr2dmodified��Normr2d2modified��Ŀ���Ǳ��ڼ���
Normr2d2modified=r2d-Normmir;

Normr2dcounter= linspace(0,0,15);	% Normr2dcounter���������ģ����ķ�����̬�ֲ���rֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
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
Normr2d2counter(n2)= Normr2d2counter(n2)+1;	% Normr2d2counter��r2dֵ���ڸ������ڵ�Ƶ��
end
end
end
Normr2dcounterim= Normr2dcounter./10000.*length(r2d);	%���ݸ�����������ֳ�һ��
Normr2d2counter(Normr2d2counter==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
Normchi2=nansum(((Normr2d2counter -Normr2dcounterim).^2)./ Normr2d2counter);	%����X2ֵ����ȷ��r�����ŷֲ���

Normexpt=2*normm;
Normvarp=4*norms^2;		%����õ�����Բ��ֱ���ľ�ֵ�ͷ���ǽ��к���Ĺ����Ļ�����

%%%%%gamma�ֲ�
Gamr2d=gamrnd(Gampara(1),Gampara(2),1,10000);

Gammi=floor(min(Gamr2d));
Gamma=ceil(max(Gamr2d));
Gaminter=(Gamma-Gammi)/15;
Gammii=linspace(Gammi, Gammi,10000);
Gammir=linspace(Gammi, Gammi,length(r2d));
Gamr2dmodified=Gamr2d-Gammii;	%���Gamr2dmodified��Gamr2d2modified��Ŀ���Ǳ��ڼ���
Gamr2d2modified=r2d-Gammir;

Gamr2dcounter= linspace(0,0,15);	% Gamr2dcounter���������ģ����ķ���gamma�ֲ���rֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
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
Gamr2d2counter(n2)= Gamr2d2counter(n2)+1;	% Gamr2d2counter��r2dֵ���ڸ������ڵ�Ƶ��
end
end
end
Gamr2dcounterim= Gamr2dcounter./10000.*length(r2d);	%���ݸ�����������ֳ�һ��
Gamr2d2counter(Gamr2d2counter==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
Gamchi2=nansum(((Gamr2d2counter -Gamr2dcounterim).^2)./ Gamr2d2counter);	%����X2ֵ����ȷ��r�����ŷֲ���

Gamexpt=2*Gampara(1)*Gampara(2);
Gamvarp=4*Gampara(1)*Gampara(2)^2;		%����õ�����Բ��ֱ���ľ�ֵ�ͷ���ǽ��к���Ĺ����Ļ�����

%%%%%������̬�ֲ�
Lognr2d=lognrnd(Lognpara(1), Lognpara(2),1,10000);

Lognmi=floor(min(Lognr2d));
Lognma=ceil(max(Lognr2d));
Logninter=(Lognma-Lognmi)/15;
Lognmii=linspace(Lognmi, Lognmi,10000);
Lognmir=linspace(Lognmi, Lognmi,length(r2d));
Lognr2dmodified=Lognr2d-Lognmii;	%���Lognr2dmodified��Lognr2d2modified��Ŀ���Ǳ��ڼ���
Lognr2d2modified=r2d-Lognmir;

Lognr2dcounter= linspace(0,0,15);	% Lognr2dcounter���������ģ����ķ��Ӷ�����̬�ֲ���rֵ���ڸ������ڵ�Ƶ�������ｫֱ��ͼ�����̶�Ϊ15
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
Lognr2d2counter(n2)= Lognr2d2counter(n2)+1;	% Lognr2d2counter��r2dֵ���ڸ������ڵ�Ƶ��
end
end
end
Lognr2dcounterim= Lognr2dcounter./10000.*length(r2d);	%���ݸ�����������ֳ�һ��
Lognr2d2counter(Lognr2d2counter==0)=1;  %����Ϊ�˷�ֹ��0�����ֿ���ֵ���������
Lognchi2=nansum(((Lognr2d2counter -Lognr2dcounterim).^2)./ Lognr2d2counter);	%����X2ֵ����ȷ��r�����ŷֲ���

Lognexpt=2*exp(Lognpara(1)+ Lognpara(2)^2/2);
Lognvarp=Lognexpt^2*(exp(Lognpara(2)^2)-1);		%����õ�����Բ��ֱ���ľ�ֵ�ͷ���ǽ��к���Ĺ����Ļ�����
