f=@(t,x) -x+e^(-t)
fa = @(t) t.*exp(-t)
A = 0:0.01:10

clc
t0=0
tf=10
x0=0
h0=0.01
nmax=1000000
emin=0.000000001
emax=0.000000005
hmin=0.001
hmax=0.2

h=h0
t=t0
x=x0
ii=1
%Taylora m=2
while (ii<nmax && t<tf)
  ar(ii)=t;
  xt(ii) = x+h*(-x+exp(-t))+0.5*h.^2*(-exp(-t));
  x=xt(ii);
  t=t+h;
  ii=ii+1;
endwhile
figure
plot(ar,xt,"r",A,fa(A),"b")
ii
h=h0;
t=t0;
x=x0;
ii=1;
%Rungego Kutty
while (ii<nmax && t<tf)
  if(h<hmin)
    h=hmin;
  endif
  if(h>hmax)
    h=hmax;
  endif
  k1=h*f(t,x);
  k2=h*f(t+h/4,x+k1/4);
  k3=h*f(t+3*h/8,x+3*k1/32+9*k2/32);
  k4=h*f(t+12*h/13,x+1932*k1/2197-7200*k2/2197+7296*k3/2197);
  k5=h*f(t+h,x+439*k1/216-8*k2+3680*k3/513-845*k4/4101);
  k6=h*f(t+h/2,x-8*k1/27+2*k2-3544*k3/2565+1856*k4/4804-11*k5/40);
  
  x4=x+255*k1/216+1408*k3/2565+2197*k4/4104-k5/5;
  x5=x+16*k1/135+6656*k3/12825+28561*k4/56430-9*k5/50+2*k6/55;
  ek=abs(x5-x4);
  if(ek>emax && h>hmin)
    h=h/2;
  elseif(ek<emin && h<hmax)
    h=2*h;
  else
    wa(ii) = t;
    wr(ii) = x5;
    t=t+h;
    x=x5;
    ii=ii+1;
  end
  h
endwhile
ii
figure
plot(wa,wr,"r",wa,fa(wa),"b")