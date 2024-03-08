%MENUMNPVI  Menu de M�todos Num�ricos para um PVI
%   y = MenuMNPVI(f,a,b,n,y0)
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condi��o inicial  
%
%INPUT:
%   f - fun��o do 2.� membro da Equa��o Diferencial
%   [a, b] - extremos do intervalo da vari�vel independente t
%   n - n�mero de subintervalos ou itera��es do m�todo
%   y0 - condi��o inicial t=a -> y=y0
%OUTPUT: 
%   y - vector das solu��es aproxima��es
%
%   12/03/2020 - Arm�nioCorreia .: armenioc@isec.pt 
% Trabalho Pr�tico
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   Jo�o Choupina Ferreira da Mota .: a2020151878@isec.pt

function y=MenuMNPVI(f,a,b,n,y0)

y=[];
menuMNPVI = 1;
while menuMNPVI~=5
    clc
    disp('--------------------------------------------------')
    disp('           M�todos Num�ricos para PVI             ')
    disp('--------------------------------------------------')
    menuMNPVI=menu('M�todo de Euler',...
                   'M�todo RK2',...
                   'M�todo RK4',...
                   'ODE45',...
                   'M�todo de Euler Melhorado',...
                   'M�todos Num�ricos para PVI', ...
                   'Todos',...
                   'Sa�r');
    
    switch menuMNPVI
        case 1
              y=NEuler(f,a,b,n,y0);
        case 2  
              y=NRK2(f,a,b,n,y0);                
        case 3
              y=NRK4(f,a,b,n,y0);           
        case 4
              y=NODE45(f,a,b,n,y0); 
        case 5
              y=NEulerMelhorado(f,a,b,n,y0); 
        case 6
              y=MNumericosPVI(f,a,b,n,y0);  
        case 7
              break;

    end
    disp('-----------Solu��o aproximada do PVI---------')
    disp(y)
    input('Prima numa tecla para continuar �')
end
            