function all1=ultgen(nm,nv,dnsty,Smt47,Normchi2,Gamchi2,Lognchi2,filename2)%%ע���ֶ�����generateϵ�к��������ÿһ���xlsx�ļ������������ǵڶ����Ʒ������ά����Ļ��Ͱ��ļ����еĵ�i���i����Ϊ2
%%�����������ֵ������д������У�ע���������ļ����е�iΪָ������������Ϫ�����ݷ�Ϊ���飬����������Ҫ���θ�Ϊ1~4�������1~4�����ά����ģ�����ݣ���
%%all1=ultgen(nm,nv,dnsty,Smt47,Normchi2,Gamchi2,Lognchi2,'��i����ά����ģ������.txt');
if Normchi2<Gamchi2 && Normchi2<Lognchi2
    all1=generat_Norm(nm,nv,dnsty,Smt47,filename2);
end
if Gamchi2<Normchi2 && Gamchi2<Lognchi2
    all1=generat_Gam(nm,nv,dnsty,Smt47,filename2);
end
if Lognchi2<Gamchi2 && Lognchi2<Normchi2
    all1=generat_Logn(nm,nv,dnsty,Smt47,filename2);
end