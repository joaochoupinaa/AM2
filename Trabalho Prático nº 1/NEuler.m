%NEULER  Método de Euler para ED/PVI.
%   y = NEuler(f,a,b,n,y0) Método numérico para a resolução de um PVI
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condição inicial  
%
%INPUT:
%   f - função do 2.º membro da Equação Diferencial
%   [a, b] - extremos do intervalo da variável independente t
%   n - número de subintervalos ou iterações do método
%   y0 - aproximação inicial y(a)=y0
%OUTPUT: 
%   y - vector das soluções aproximações
%   y(i+1) = y(i)+h*f(t(i),y(i)) , i =0,1,...,n-1
%
%   03/03/2020 - ArménioCorreia .: armenioc@isec.pt
% Trabalho Prático
%   09/04/2022 - Ricardo Tavares .: a2021144652@alunos.isec.pt
%   09/04/2022 - João Choupina Ferreira da Mota .: a2020151878@isec.pt

function y = NEuler(f,a,b,n,y0)

  arguments

      f ;
      a double;
      b double;
      n double;
      y0 double;
  end


h = (b-a)/n;
t = ones(1,n);
t = a:h:b;
y = ones(1,n+1);
y(1) = y0;
for i=1:n
    y(i+1)=y(i)+h*f(t(i),y(i));
end
