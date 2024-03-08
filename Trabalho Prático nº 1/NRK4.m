%NRK4  Método de Runge-Kutta de ordem 4.
%   y = NRK4(f,a,b,n,y0) Método numérico para a resolução de um PVI
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condição inicial  
%
%INPUT:
%   f - função do 2.º membro da Equação Diferencial
%   [a, b] - extremos do intervalo da variável independente t
%   n - número de subintervalos ou iterações do método
%   y0 - condição inicial t=a -> y=y0
%OUTPUT: 
%   y - vector das soluções aproximações
%   y(i+1)=y(i)+1/2*(k1 + k2) , i =0,1,...,n-1
%
%   03/03/2020 - ArménioCorreia .: armenioc@isec.pt
% Trabalho Prático
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota .: a2020151878@isec.pt

function y = NRK4(f,a,b,n,y0)

arguments

      f ;
      a double;
      b double;
      n double;
      y0 double;
end

h=(b-a)/n;
t=a:h:b;
y = ones(1,n);
y=zeros(1,n+1);
y(1) = y0;

for i=1:n
	k1 = h*f(t(i),y(i));
	k2 = h*f(t(i)+(h/2), y(i) + k1/2);
	k3 = h*f(t(i)+(h/2), y(i) + k2/2);
    k4 = h*f(t(i+1), y(i) + k3);
	
    y(i+1)=y(i)+(1/6)*(k1+2*k2+2*k3+k4);
end
