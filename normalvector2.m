function P0=normalvector2(filename)

% 本函数的功能是将倾向倾角数据ab.txt转化成裂隙面单位法向量数据P0;


%   示例：
%  在命令行窗口运行  P0=normalvector2('ab.txt');得到P0
%  再运行xlswrite('normal.xlsx',P0) 即可将裂隙面的法向量存入excel表格中


center=load(filename);
X=cos(center(:,1)*pi/180).*sin(center(:,2)*pi/180);
Y=sin(center(:,1)*pi/180).*sin(center(:,2)*pi/180);
Z=cos(center(:,2)*pi/180);
P0=[X,Y,Z];