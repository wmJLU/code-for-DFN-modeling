%%%%%下面是smt47函数的定义。
%%%%%2. 下列程序可以计算47等分施密特网中的产状频率
function Smt47=smt47(re)
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

