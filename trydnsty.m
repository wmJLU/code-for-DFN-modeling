function [nm,nv,dnsty]=trydnsty(aa,Smt47,ER,DR,Normchi2,Gamchi2,Lognchi2)
if Normchi2<Gamchi2 && Normchi2<Lognchi2
    [nm,nv,dnsty]=dnsty_Norm(aa,Smt47,ER,DR);
    dnsty
end
if Gamchi2<Normchi2 && Gamchi2<Lognchi2
    [nm,nv,dnsty]=dnsty_Gam(aa,Smt47,ER,DR);
    dnsty
end
if Lognchi2<Gamchi2 && Lognchi2<Normchi2
    [nm,nv,dnsty]=dnsty_Logn(aa,Smt47,ER,DR);
    dnsty
end
