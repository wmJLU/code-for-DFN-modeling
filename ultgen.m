function all1=ultgen(nm,nv,dnsty,Smt47,Normchi2,Gamchi2,Lognchi2,filename2)%%注意手动更改generate系列函数输出的每一组的xlsx文件名，比如这是第二优势分组的三维网络的话就把文件名中的第i组的i都改为2
%%复制以下文字到命令行窗口运行（注意更改输出文件名中的i为指定的组数，大溪沟数据分为四组，所以这里需要依次改为1~4，会输出1~4组的三维网络模拟数据）：
%%all1=ultgen(nm,nv,dnsty,Smt47,Normchi2,Gamchi2,Lognchi2,'第i组三维网络模拟数据.txt');
if Normchi2<Gamchi2 && Normchi2<Lognchi2
    all1=generat_Norm(nm,nv,dnsty,Smt47,filename2);
end
if Gamchi2<Normchi2 && Gamchi2<Lognchi2
    all1=generat_Gam(nm,nv,dnsty,Smt47,filename2);
end
if Lognchi2<Gamchi2 && Lognchi2<Normchi2
    all1=generat_Logn(nm,nv,dnsty,Smt47,filename2);
end