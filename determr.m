%determr�������书���Ǽ���Բ��ֱ���ķֲ�����
function [aa,Smt47,Normchi2,Gamchi2,Lognchi2,ER,DR]=determr(filename1)
%%�����������ֵ������д������У�ע������ǰ����iΪָ������������Ϫ�����ݷ�Ϊ���飬����������Ҫ���θ�Ϊ1~4���������1~4���Ʒ������ݣ���
%%[aa,Smt47,Normchi2,Gamchi2,Lognchi2,ER,DR]=determr('��i��.txt');
sdir=input('������������ڵ�����');
sdiar=input('������������ڵ���ǣ�');
S1=input('��������ά��϶�����x�򳤶ȣ�');
S2=input('��������ά��϶�����y�򳤶ȣ�');
S3=input('��������ά��϶�����z�򳤶ȣ�');	
avdir=input('�����뱾����϶��ƽ������');
avdiar=input('�����뱾����϶��ƽ����ǣ�');
if sdiar==0
sdiar=0.1;
end
if sdiar==90
sdiar=89.9;
end	%����Ϊ�˷�ֹ���Ϊ0�Ȼ�90��ʱ������
zz=zzz(sdir,sdiar,S1,S2,S3);
theta=interangle(avdir,avdiar,sdir,sdiar);
re=load(filename1);
aa=length(re);
Smt47=smt47(re);
smtmodified=Smt47./sum(Smt47);%%�ֳ�¶ͷ���ϵĲ�״Ƶ�ʣ�У��ǰ������֤ÿһ���״Ƶ��Ҫ�õ�
xlswrite('��i���ֳ���״Ƶ��.xlsx',smtmodified')%%���ÿһ����ֳ���״Ƶ�ʡ����ڶ�ÿһ��Ĳ�״Ƶ�ʷֱ������֤
[nm2,Normnv2,Gamnv2,Lognnv2,NormX2,GamX2,LognX2]=determr2(re);
nm2 %%r2�ľ�ֵ����ע��
if NormX2<GamX2 && NormX2<LognX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Norm(aa,zz,theta,nm2,Normnv2);
Normnv2 %%r2�ķ����ע��
end
if GamX2<NormX2 && GamX2<LognX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Gam(aa,zz,theta,nm2,Gamnv2);
Gamnv2 %%r2�ķ����ע��
end
if LognX2<GamX2 && LognX2<NormX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Logn(aa,zz,theta,nm2,Lognnv2);
Lognnv2 %%r2�ķ����ע��
end
Normchi2
Gamchi2
Lognchi2
if Normchi2<Gamchi2 && Normchi2<Lognchi2
    ER=Normexpt
    DR=Normvarp
    disp('Բ��ֱ��������̬�ֲ�');
end
if Gamchi2<Normchi2 && Gamchi2<Lognchi2
    ER=Gamexpt
    DR=Gamvarp
    disp('Բ��ֱ������Gamma�ֲ�');
end
if Lognchi2<Gamchi2 && Lognchi2<Normchi2
    ER=Lognexpt
    DR=Lognvarp
    disp('Բ��ֱ�����Ӷ�����̬�ֲ�');
end

