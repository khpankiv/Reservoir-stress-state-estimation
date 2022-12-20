function[nap,koo,v1]= Napruz(filename,typ,nm,nn,shvy)

ko=1;
p0=0.0000000001;
load (filename);
ee=0;
sz=size(rr1);
n1=sz(2);  %nm  FF
n2=sz(1);  %nn  SS
if nm<n1    
    nm=n1;
end
if nn<n2
    nn=n2;
end

%************shvy***********************************
evs(1:nn,1:nm)=ev;
sigs(1:nn,1:nm)=sig;
if shvy
    ks=length(v1);
    evs(1,1:nm)=ev*0.9;
    sigs(1,1:nm)=sig*0.9;
    for i=1:ks
        vys=sum(v1(1:i));
        nom=find (abs(ss1g(1:nn,1)-vys)<=0.005);
        evs(nom,1:nm)=ev*0.9;
        sigs(nom,1:nm)=sig*0.9;
    end
end
lam=evs.*sigs./((1+sigs).*(1-2*sigs));
mju=evs./(2*(sigs+1));

% vidtvorennia
%***********************************************************************************
j=1:n1;
i=1:n2;
jj=1:(n1-1)/(nm-1):n1;
ii=1:(n2-1)/(nn-1):n2;

for k=1:n1
    ss1g1(1:nn,k)=splinezgl(i,ii,ss1(:,k)',p0,0,2);
    ff1g1(1:nn,k)=splinezgl(i,ii,ff1(:,k)',p0,0,2);
    rr1g(1:nn,k)=splinezgl(ss1(:,k)',ss1g1(:,k)',rr1(:,k)',p0,0,2);
    rr2g(1:nn,k)=splinezgl(ss1(:,k)',ss1g1(:,k)',rr2(:,k)',p0,0,2);
end
for k=1:nn
    ss1g(k,1:nm)=splinezgl(j,jj,ss1g1(k,:),p0,0,1)';
    ff1g(k,1:nm)=splinezgl(j,jj,ff1g1(k,:),p0,0,2)';
   figure(40)
   polar(ff1g1(k,:),rr1g(k,:),'b');
   hold on
   polar(ff1g1(k,:),rr2g(k,:),'r');
    [rr1g(k,1:nm),rr1g11(k,:),rr1g21(k,:)]=splinezgl(ff1g1(k,:),ff1g(k,:),rr1g(k,:),p0,ee,1);
%     polar(ff1g(k,:),rr1g(k,:));
    hold off
    [rr2g(k,1:nm),rr2g11(k,:),rr2g21(k,:)]=splinezgl(ff1g1(k,:),ff1g(k,:),rr2g(k,:),p0,ee,1);
end

% % vyznachennia P
% save temp lam mju rr1g rr2g ff1g1 nm nn ss1g ff1 ff1g n1 n2 ss1g1
% pp0(1:nn,1:nm)=p0;
% options = optimset('MaxFunEvals',100000,'MaxIter',100000);
% pp=fminsearch(@nevyazka,[pp0 pp0],options);
% delete temp

% for k=1:nn
%     rr1g(k,1:nm)=splinezgl(ff1g(k,:),ff1g(k,:),rr1g(k,:),pp(k,1:n1),-1,1);
%     rr2g(k,1:nm)=splinezgl(ff1g(k,:),ff1g(k,:),rr2g(k,:),pp(k,n1+1:2*n1),-1,1);
% end
for k=1:nm
    [rr1g(1:nn,k),rr1g12(:,k),rr1g22(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr1g(:,k)',p0,0,2);
    [rr2g(1:nn,k),rr2g12(:,k),rr2g22(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr2g(:,k)',p0,0,2);
end

% *********************hlopun*******************************************
rr1n=rr1g;
for i=1:nn
    qwe=(sign(rr2g21(i,:))-sign(rr1g21(i,:)));
    r1=rr1g(i,1:nm-1);
    r2=rr2g(i,1:nm-1);
    fg=ff1g(i,1:nm-1);
    r1n=r1;
    pq(1:nm-1)=0;
    for k=1:nm-1
        if (qwe(k)~=0 )
            i1=k;
            b=true;
            while b&(qwe(i1)~=0)
                if i1>1
                    i1=i1-1;
                else
                    b=false;
                end
            end
            in=k;
            b=true;
            while b&(qwe(in)~=0)
                if in<nm-1
                    in=in+1;
                else
                    b=false;
                end
            end
            kut=(r1(in)*sin(fg(in))-r1(i1)*sin(fg(i1)))/(r1(in)*cos(fg(in))-r1(i1)*cos(fg(i1)));
            pq(k)=r1(i1)*sin(fg(i1))/(sin(fg(k))-kut*cos(fg(k)));
            kut2=tan(2*atan(kut)-pi/2);
            ry(i1:in)=kut2*(r1(i1:in).*cos(fg(i1:in))-r1(k)*cos(fg(k)))+pq(k);
            [rizn,ii]=min(abs(ry(i1:in)-r1(i1:in).*sin(fg(i1:in))));
            ii=ii+i1-1;
            d=sqrt((r1(ii)*sin(fg(ii))-pq(k))^2+(r1(ii)*cos(fg(ii))-r1(k)*cos(fg(k)))^2);
            rn(k)=pq(k)+sign(pq(k)-r1(k)*sin(fg(k))).*d;
            r1n(k)=sqrt(rn(k)*sin(fg(k)))+rn(k)*cos(fg(k));
        end
    end
    rr1n(i,1:nm-1)=r1n;
    figure(30)
    polar(fg,r1,'b')
    hold on
    polar(fg,r2,'r')
    polar(fg,r1n,'b*')
    polar(fg,pq,'g')
    hold off
end
rr1n(:,nm)=rr1n(:,1);
%end hlopun

for k=1:nm
    [rr1g(:,k),rr1g12(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr1n(:,k)',p0,0,2);
    [rr2g(:,k),rr2g12(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr2g(:,k)',p0,0,2);
end
for k=1:nn
    [rr1g(k,:),rr1g11(k,:)]=splinezgl(ff1g(k,:),ff1g(k,:),rr1g(k,:),p0,0,1);
    [rr2g(k,:),rr2g11(k,:)]=splinezgl(ff1g(k,:),ff1g(k,:),rr2g(k,:),p0,0,1);
end
rrg=rr2g-rr1g;
rrg11=rr2g11-rr1g11;
rrg12=rr2g12-rr1g12;

%kinec vidtvorennia

%******************napruzennia*********************************
toc=1;
%naprr
nap11=(lam.*rrg./rr1n)/ko;
%naprf
nap12=(mju.*rrg11./rr1n)/ko;
%naprs
nap13=mju.*rrg12/ko;
%napff
nap22=((lam+2*mju).*rrg./rr1n)/ko;
%napfs
nap23=0;
%napss
nap33=(lam.*rrg./rr1n)/ko;
%napekv
nape=sqrt(((nap11-nap22).^2+(nap22-nap33).^2+(nap11-nap33).^2)+6.*(nap12.^2).*(nap13.^2).*(nap23.^2));
%end napruzennia
nap(1:7,1:nn,1:nm)=0;
nap(1,1:nn,1:nm)=nap11;
nap(2,1:nn,1:nm)=nap22;
nap(3,1:nn,1:nm)=nap33;
nap(4,1:nn,1:nm)=nap12;
nap(5,1:nn,1:nm)=nap13;
nap(6,1:nn,1:nm)=nap23;
nap(7,1:nn,1:nm)=nape;
koo(1:4,1:nn,1:nm)=0;
koo(1,1:nn,1:nm)=ff1g;
koo(2,1:nn,1:nm)=ss1g;
koo(3,1:nn,1:nm)=rr2g;
koo(4,1:nn,1:nm)=rr1g;


function delta = nevyazka(p)
load temp
for k=1:nn
    [rr1g(k,1:nm),rr1g11(k,:),rr1g21(k,:)]=splinezgl(ff1g1(k,:),ff1g(k,:),rr1g(k,:),p(k,1:n1),-1,1);
    [rr2g(k,1:nm),rr2g11(k,:),rr2g21(k,:)]=splinezgl(ff1g1(k,:),ff1g(k,:),rr2g(k,:),p(k,n1+1:2*n1),-1,1);
end
for k=1:nm
    [rr1g(1:nn,k),rr1g12(:,k),rr1g22(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr1g(:,k)',1,0,2);
    [rr2g(1:nn,k),rr2g12(:,k),rr2g22(:,k)]=splinezgl(ss1g(:,k)',ss1g(:,k)',rr2g(:,k)',1,0,2);
end
rrg=rr2g-rr1g;
rrg11=rr2g11-rr1g11;
rrg12=rr2g12-rr1g12;
rrg21=rr2g21-rr1g21;
rrg22=rr2g22-rr1g22;
f1=sum(sum(mju.*(rrg21+(rr1g.^2).*rrg22-2*rrg)./(rr1g.^2)));
f2=sum(sum((lam+5*mju).*rrg11./(rr1g.^3)));
f3=sum(sum((mju+lam).*rrg12./rr1g));
delta=abs(sqrt(f1^2+f2^2+f3^2));


function [g,g1,g2,p]=splinezgl(x,xx,f,p0,ee,tt);
%jaksho tt=1 periodychnyj spline
% jaksho ee=0 to prostyj, inakshe zgladzujuchyj
% jzksho ee<0 to to nevjazky, inakshe po pohybci
n=length(x)-1;
nx=length(xx);
%spline
h(2:n+1)=x(2:n+1)-x(1:n);
a(1:n-1,1:n-1)=0;
for i=1:n-1
    a(i,i)=(h(i+1)+h(i+2))/3;
    if (i~=(n-1))
        a(i,i+1)=h(i+2)/6;
        a(i+1,i)=h(i+2)/6;
    end
end
hh(1:n-1,1:n-1)=0;
for i=1:n-1
    hh(i,i)=1/h(i+1);
    hh(i,i+1)=(-1/h(i+1)-1/h(i+2));
    hh(i,i+2)=1/h(i+2);
end
% tut periodychnyj spline
if (tt==1)
    a(n,1)=h(2)/6;
    a(n,n-1)=h(n+1)/6;
    a(n,n)=(h(1)+h(n+1))/3;
    hh(n,1)=1/h(2);
    hh(n,n-1)=-1/h(2)-1/h(n+1);
    hh(n,n)=1/h(n+1);
end;
if ee<0
    pp(1:n+1,1:n+1)=0;
    for i=1:n+1
        pp(i,i)=1/p0(i);
    end
    m=((a+hh*pp*hh'))^(-1)*hh*f(1:n+1)';
    mu=f(1:n+1)'-pp*hh'*m;
end
if ee>0
    p(1:n)=p0(1);
    pp=0;
    bol=1;
    while (bol==1)
        pp(1:n,1:n)=0;
        for i=1:n
            pp(i,i)=1/p(i);
        end
        pp(n+1,n+1)=pp(1,1);
        m=((a+hh*pp*hh'))^(-1)*hh*f(1:n+1)';
        mu=f(1:n+1)'-pp*hh'*m;
        bol=0;
        for i=1:n
            rizn=abs(mu(i)-f(i));
            if rizn>ee
                bol=1;
                p(i)=p(i)*rizn/ee;
            end
        end
    end
end
if ee==0
    mu=f(1:n+1)';
    m=a^(-1)*hh*f(1:n+1)';
end
if (tt~=1)
    m(n+1)=0;
end;
m(2:n+1)=m(1:n);
m(1)=m(n+1);
g(1:nx)=0;
g1(1:nx)=0;
g2(1:nx)=0;
for j=1:nx
    i=find(xx(j)<=x+0.00001);
    i=i(1);
    if i==1
        i=2;
    end;
    g(j)=m(i-1)*((x(i)-xx(j))^3)/(6*h(i))+m(i)*((xx(j)-x(i-1))^3)/(6*h(i))+(mu(i-1)-m(i-1)*(h(i)^2)/6)*(x(i)-xx(j))/h(i)+(mu(i)-m(i)*(h(i)^2)/6)*(xx(j)-x(i-1))/h(i);
    g1(j)=-m(i-1)*((x(i)-xx(j))^2)/(2*h(i))+ m(i)*((xx(j)-x(i-1))^2)/(2*h(i))+(mu(i)-mu(i-1))/h(i)-(m(i)-m(i-1))*h(i)/6;
    g2(j)=m(i-1)*(x(i)-xx(j))/h(i)+ m(i)*(xx(j)-x(i-1))/h(i);
end
%end spline
