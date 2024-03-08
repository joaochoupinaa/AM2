%MENUMNPVI  Menu de Métodos Numéricos para um PVI
%   y = MenuMNPVI(f,a,b,n,y0)
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condição inicial  
%
%INPUT:
%   f - função do 2.º membro da Equação Diferencial
%   [a, b] - extremos do intervalo da variável independente t
%   n - número de subintervalos ou iterações do método
%   y0 - condição inicial t=a -> y=y0
%OUTPUT: 
%   y - vector das soluções aproximações
%
%   12/03/2020 - ArménioCorreia .: armenioc@isec.pt 
% Trabalho Prático
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota .: a2020151878@isec.pt

function y=MenuMNPVI(f,a,b,n,y0)

y=[];
menuMNPVI = 1;
while menuMNPVI~=5
    clc
    disp('--------------------------------------------------')
    disp('           Métodos Numéricos para PVI             ')
    disp('--------------------------------------------------')
    menuMNPVI=menu('Método de Euler',...
                   'Método RK2',...
                   'Método RK4',...
                   'ODE45',...
                   'Método de Euler Melhorado',...
                   'Métodos Numéricos para PVI', ...
                   'Todos',...
                   'Saír');
    
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
    disp('-----------Solução aproximada do PVI---------')
    disp(y)
    input('Prima numa tecla para continuar »')
end
            