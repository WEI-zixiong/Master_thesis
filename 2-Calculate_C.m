E0=30;
mu0=0.3;
I=eye(9);
co0=(E0/((1+mu0)*(1-2*mu0)))*I;
row123_0=[1-mu0 mu0 mu0 0 0 0 0 0 0;mu0 1-mu0 mu0 0 0 0 0 0 0;mu0 mu0 1-mu0 0 0 0 0 0 0];
row456_0=[0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2 0 0;0 0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2 0; 0 0 0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2];
row789_0=[0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2 0 0;0 0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2 0; 0 0 0 0 0 (1-2*mu0)/2 0 0 (1-2*mu0)/2];
C0=co0*[row123_0;row456_0;row789_0];
disp(C0);

E1=4.5;
mu1=0.44;
co1=(E1/((1+mu1)*(1-2*mu1)))*I;
row123_1=[1-mu1 mu1 mu1 0 0 0 0 0 0;mu1 1-mu1 mu1 0 0 0 0 0 0;mu1 mu1 1-mu1 0 0 0 0 0 0];
row456_1=[0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2 0 0;0 0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2 0; 0 0 0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2];
row789_1=[0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2 0 0;0 0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2 0; 0 0 0 0 0 (1-2*mu1)/2 0 0 (1-2*mu1)/2];
C1=co1*[row123_1;row456_1;row789_1];
disp(C1);

coS=(1/(15*(1-mu0)))*I;
row123_S=[7-5*mu0 5*mu0-1 5*mu0-1 0 0 0 0 0 0;5*mu0-1 7-5*mu0 5*mu0-1 0 0 0 0 0 0;5*mu0-1 5*mu0-1 7-5*mu0 0 0 0 0 0 0];
row456_S=[0 0 0 4-5*mu0 0 0 4-5*mu0 0 0;0 0 0 0 4-5*mu0 0 0 4-5*mu0 0;0 0 0 0 0 4-5*mu0 0 0 4-5*mu0];
row789_S=[0 0 0 4-5*mu0 0 0 4-5*mu0 0 0;0 0 0 0 4-5*mu0 0 0 4-5*mu0 0;0 0 0 0 0 4-5*mu0 0 0 4-5*mu0];
S=coS*[row123_S;row456_S;row789_S];
B=C1-C0;
D=C0-C1;
f=0;
F=(1-f)*S+f*I;
H=[];
for i = 1: 9
    for j = 1: 9
        c1=0;
        for k = 1: 9
            c1=c1+B(i,k)*F(j,k);
            H(i,j)=c1;
        end
    end
end
disp(S);
disp(H);
E=H+C0;
N=pinv(E);
A=[];
for i = 1: 9
    for j = 1: 9
        c2=0;
        for k = 1: 9
            c2=c2+N(i,k)*D(j,k);
            A(i,j)=c2;
        end
    end
end
disp(A);
M=I+f*A;
MN=pinv(M);
C_bar=[];
for i = 1: 9
    for j = 1: 9
        c3=0;
        for k = 1: 9
            c3=c3+C0(i,k)*MN(j,k);
            C_bar(i,j)=c3;
        end
    end
end
disp(C_bar);

mu_bar=C_bar(1,2)/(C_bar(4,4)+2*C_bar(1,2));
disp(mu_bar);

E_bar=(C_bar(1,1)-C_bar(1,2))*(1+mu_bar);
disp(E_bar);
