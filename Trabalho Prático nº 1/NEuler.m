%NEULER  M�todo de Euler para ED/PVI.
%   y = NEuler(f,a,b,n,y0) M�todo num�rico para a resolu��o de um PVI
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condi��o inicial  
%
%INPUT:
%   f - fun��o do 2.� membro da Equa��o Diferencial
%   [a, b] - extremos do intervalo da vari�vel independente t
%   n - n�mero de subintervalos ou itera��es do m�todo
%   y0 - aproxima��o inicial y(a)=y0
%OUTPUT: 
%   y - vector das solu��es aproxima��es
%   y(i+1) = y(i)+h*f(t(i),y(i)) , i =0,1,...,n-1
%
%   03/03/2020 - Arm�nioCorreia .: armenioc@isec.pt
% Trabalho Pr�tico
%   09/04/2022 - Ricardo Tavares .: a2021144652@alunos.isec.pt
%   09/04/2022 - Jo�o Choupina Ferreira da Mota .: a2020151878@isec.pt

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
