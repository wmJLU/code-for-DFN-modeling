%determr函数，其功能是计算圆盘直径的分布函数
function [aa,Smt47,Normchi2,Gamchi2,Lognchi2,ER,DR]=determr(filename1)
%%复制以下文字到命令行窗口运行（注意运行前更改i为指定的组数，大溪沟数据分为四组，所以这里需要依次改为1~4，会输入第1~4优势分组数据）：
%%[aa,Smt47,Normchi2,Gamchi2,Lognchi2,ER,DR]=determr('第i组.txt');
sdir=input('请输入测量窗口的倾向：');
sdiar=input('请输入测量窗口的倾角：');
S1=input('请输入三维裂隙网络的x向长度：');
S2=input('请输入三维裂隙网络的y向长度：');
S3=input('请输入三维裂隙网络的z向长度：');	
avdir=input('请输入本组裂隙的平均倾向：');
avdiar=input('请输入本组裂隙的平均倾角：');
if sdiar==0
sdiar=0.1;
end
if sdiar==90
sdiar=89.9;
end	%这是为了防止倾角为0度或90度时出问题
zz=zzz(sdir,sdiar,S1,S2,S3);
theta=interangle(avdir,avdiar,sdir,sdiar);
re=load(filename1);
aa=length(re);
Smt47=smt47(re);
smtmodified=Smt47./sum(Smt47);%%现场露头面上的产状频率（校正前），验证每一组产状频率要用到
xlswrite('第i组现场产状频率.xlsx',smtmodified')%%输出每一组的现场产状频率。用于对每一组的产状频率分别进行验证
[nm2,Normnv2,Gamnv2,Lognnv2,NormX2,GamX2,LognX2]=determr2(re);
nm2 %%r2的均值，可注释
if NormX2<GamX2 && NormX2<LognX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Norm(aa,zz,theta,nm2,Normnv2);
Normnv2 %%r2的方差，可注释
end
if GamX2<NormX2 && GamX2<LognX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Gam(aa,zz,theta,nm2,Gamnv2);
Gamnv2 %%r2的方差，可注释
end
if LognX2<GamX2 && LognX2<NormX2
[Normexpt, Normvarp, Normchi2, Gamexpt, Gamvarp, Gamchi2, Lognexpt, Lognvarp, Lognchi2]=determr_Logn(aa,zz,theta,nm2,Lognnv2);
Lognnv2 %%r2的方差，可注释
end
Normchi2
Gamchi2
Lognchi2
if Normchi2<Gamchi2 && Normchi2<Lognchi2
    ER=Normexpt
    DR=Normvarp
    disp('圆盘直径服从正态分布');
end
if Gamchi2<Normchi2 && Gamchi2<Lognchi2
    ER=Gamexpt
    DR=Gamvarp
    disp('圆盘直径服从Gamma分布');
end
if Lognchi2<Gamchi2 && Lognchi2<Normchi2
    ER=Lognexpt
    DR=Lognvarp
    disp('圆盘直径服从对数正态分布');
end

