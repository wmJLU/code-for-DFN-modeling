function P0=normalvector2(filename)

% �������Ĺ����ǽ������������ab.txtת������϶�浥λ����������P0;


%   ʾ����
%  �������д�������  P0=normalvector2('ab.txt');�õ�P0
%  ������xlswrite('normal.xlsx',P0) ���ɽ���϶��ķ���������excel�����


center=load(filename);
X=cos(center(:,1)*pi/180).*sin(center(:,2)*pi/180);
Y=sin(center(:,1)*pi/180).*sin(center(:,2)*pi/180);
Z=cos(center(:,2)*pi/180);
P0=[X,Y,Z];