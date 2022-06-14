center=load('ab.txt');
X=cos(center(:,1)*pi/180).*sin(center(:,2)*pi/180);%%这里我把师兄的先把X,Y,Z分别设成行向量再转置成列向量的那三行代码删掉了，因为不需要那样X,Y,Z就已经是列向量了，那三行太多余了
Y=sin(center(:,1)*pi/180).*sin(center(:,2)*pi/180);%%我觉得神奇的是一个两列的矩阵，每一行的两列互乘之后得到的结果矩阵依然是列矩阵。其实如果这个成立的话也说明了那三行转置是多余的
Z=cos(center(:,2)*pi/180);
P0=[X,Y,Z];
xlswrite('normal.xlsx',P0)