function [g,g1,g2]=splinezgl(x,xx,f,p0,ee,tt);
%jaksho tt=1 periodychnyj spline
% jaksho ee=0 to prostyj, inakshe zgladzujuchyj
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

if ee~=0
    
    p(1:n+1)=p0;
    pp=0;
    bol=1;
    while (bol==1)
        pp(1:n+1,1:n+1)=0;
        for i=1:n+1
            pp(i,i)=1/p(i);
        end
        m=((a+hh*pp*hh'))^(-1)*hh*f(1:n+1)';
        mu=f(1:n+1)'-pp*hh'*m;
        bol=0;
        for i=1:n+1
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
%2-ga poh
%                     m(1)=(mu(3)-2*mu(2)+mu(1))/(h(2)*h(2));
%                     m(n+1)=(mu(n+1)-2*mu(n)+mu(n-1))/(h(n+1)*h(n+1));
%end 2-ga poh
%1-sha poh
%                     f01=(mu(2)-mu(1))/h(2);
%                     fn1=(mu(n+1)-mu(n))/h(n+1);
%                     m(1)=(2*((mu(2)-mu(1))/h(2)-f01)/h(2)-m(2)/3)*3/2;
%                     m(n+1)=(2*(fn1-(mu(n+1)-mu(n))/h(n+1))/h(n+1)-m(n)/3)*3/2;
%end 1-sha poh

g(1:nx)=0;
g1(1:nx)=0;
g2(1:nx)=0;
for j=1:nx
    i=find(xx(j)<=x+0.000000000001+ee);
    i=i(1);
    if i==1
        i=2;
    end;
    g(j)=m(i-1)*((x(i)-xx(j))^3)/(6*h(i))+m(i)*((xx(j)-x(i-1))^3)/(6*h(i))+(mu(i-1)-m(i-1)*(h(i)^2)/6)*(x(i)-xx(j))/h(i)+(mu(i)-m(i)*(h(i)^2)/6)*(xx(j)-x(i-1))/h(i);
    g1(j)=-m(i-1)*((x(i)-xx(j))^2)/(2*h(i))+ m(i)*((xx(j)-x(i-1))^2)/(2*h(i))+(mu(i)-mu(i-1))/h(i)-(m(i)-m(i-1))*h(i)/6;
    g2(j)=m(i-1)*(x(i)-xx(j))/h(i)+ m(i)*(xx(j)-x(i-1))/h(i);
end
%end spline



