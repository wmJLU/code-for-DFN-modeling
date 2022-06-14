%%一般不用运行这个程序，因为写论文什么的不需单独验证每一组的产状频率，只需将所有组的模拟结果都结合起来之后，验证全部模拟数据与全部现场数据的拟合程度
%%这是求！！每一优势分组！！的模拟产状频率(即模拟露头面上截得的产状频率）的程序。
%%每一优势分组的现场产状频率运行determr函数之后已经自动输出了。结合这两个：即每一优势分组的模拟和现场产状频率，可以单独验证每组的产状频率
re=load('第1组与模拟露头面相交的裂隙数据.txt');
aa=length(re);
Smt47=[];
for i=1:length(re)
if re(i,5)==0
re(i,5)=360;
end
end	%以上是为了将裂隙倾向的范围改为1-360度，因为0度倾向的裂隙将不能参与计算
for j=1:4		
an=0;
for i=1:length(re)
if re(i,6)<=26.5 && re(i,5)>(j-1)*90+0.01 && re(i,5)<j*90+0.01
an=an+1;
end
end
Smt47(j)=an;
end

for j=1:10
an=0;
for i=1:length(re)
if re(i,6)>26.5 && re(i,6)<=50.8 && re(i,5)>(j-1)*36+0.01 && re(i,5)<j*36+0.01
an=an+1;
end
end
Smt47(4+j)=an;
end


for i=1:length(re)
if re(i,6)>50.8 && re(i,6)<=76.3 && re(i,5)>348+0.01 && re(i,5)<360+0.01
re(i,5)=re(i,5)-360;
end
end

for j=1:15
an=0;
for i=1:length(re)
if re(i,6)>50.8 && re(i,6)<=76.3 && re(i,5)>(j-1)*24-12+0.01 && re(i,5)<j*24-12+0.01
an=an+1;
end
end
Smt47(14+j)=an;
end

for j=1:18
an=0;
for i=1:length(re)
if re(i,6)>76.3 && re(i,6)<=90 && re(i,5)>(j-1)*20+0.01 && re(i,5)<j*20+0.01
an=an+1;
end
end
Smt47(29+j)=an;
end

%%Smt47:用模拟露头面截取三维网络后第i组的各patch内裂隙（迹线)条数

smtmodified=Smt47./sum(Smt47);	 %用模拟露头面截得的迹线的产状频率（不需校正）

xlswrite('第i组模拟产状频率.xlsx',smtmodified')%%输出每一组的模拟产状频率。用于对每一组的产状频率分别进行验证