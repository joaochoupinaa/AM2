%NODE45  do Matlab.
%   y = N_ODE45(f,a,b,n,y0) Método numérico para a resolução de um PVI
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condição inicial  
%
%INPUT:
%   f - função do 2.º membro da Equação Diferencial
%   [a, b] - extremos do intervalo da variável independente t
%   n - número de subintervalos ou iterações do método
%   y0 - condição inicial t=a -> y=y0
%OUTPUT: 
%   y - vector das soluções aproximações
%   y(i+1) = y(i)+h*f(t(i),y(i)) , i =0 , 1 , ... , n-1
%
%   03/03/2020 - ArménioCorreia .: armenioc@isec.pt
% Trabalho Prático
%   09/04/2022 - Ricardo Tavares .: a2021144652@alunos.isec.pt
%   09/04/2022 - João Choupina Ferreira da Mota .: a2020151878@isec.pt

function [t,y] = NODE45(f,a,b,n,y0)

    arguments
    
          f ;
          a double;
          b double;
          n double;
          y0 double;
    end

h = (b-a)/n;
t1 = a:h:b;
y=y0;
for i=1:n
    [t,y_ode] = ode45(f,t1,y(end));
    y = [y; y_ode(end)];
end

