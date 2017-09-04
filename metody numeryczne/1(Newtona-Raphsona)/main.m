 mz=[-10;-10];

 a=0.01 ;
  function f=f(x,y)
  f=x.*x+y.*y-49;
 endfunction
 
 function df = df(x,y)
 dx = 2*x;
 dy = 2*y;
 df=[dx;dy]; 
 endfunction
while abs(f(mz(1),mz(2))) > 0.001
 mz = mz-a*f(mz(1),mz(2))./df(mz(1), mz(2));
 end
 %wynik
 mz
 %Sprawdzenie
 mz(1).^2+mz(2).^2-7^2