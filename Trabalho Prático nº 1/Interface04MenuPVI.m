%INTERFACE04MENUPVI 
%Chamada de funções
%   MenuMNPVI
%
%   12/03/2020 - ArménioCorreia .: armenioc@isec.pt 

clear
primeiraVez=1;
menuPVI=1;
while menuPVI~=5 
    clc;
    disp('--------------------------------------------------------------')
    disp('            PROBLEMAS DE VALOR INICIAL (PVI)                  ')
    disp('------------------------------------------------------------- ')
    if (~primeiraVez)
    menuPVI=menu('Métodos Numéricos para PVI',...
                 'Dados do PVI',...
                 'Solução Exata',...
                 'Solução Aproximada',...
                 'Tabela e Gráficos de Resultados',...
                 'Saír');
    else
        primeiraVez=0;
        menuPVI=1;
    end
    y=[];
    switch menuPVI
        case 1
            while 1
                strF = input('\n f(t,y) = ','s');
                f = @(t,y) eval(vectorize(strF));
                try
                    syms t y;
                    fTeste=f(t,y);
                    break;
                catch me
                    disp('ERRO! Introduza uma função em t e y');
                end
            end
            while 1
                a=str2double(input('a = ','s'));
                if (isscalar(a) && isreal(a))
                    break;
                else
                    errordlg('Introduza um número real a',...
                             'ERRO','modal');
                end
            end
            while 1
                b=str2double(input('b = ','s'));
                if (isscalar(b) && isreal(b) && b > a)
                    break;
                else
                    errordlg('Introduza um número real b, com b > a',...
                             'ERRO','modal');
                end
            end
            while 1
                n=str2double(input('n = ','s'));
                if (isscalar(n) && isreal(n) && n > 0)
                    break;
                else
                    errordlg('Introduza um número real n, com n > 0',...
                             'ERRO','modal');
                end
            end
            while 1
                y0=str2double(input('y0 = ','s'));
                if (isscalar(y0) && isreal(y0))
                    break;
                else
                    errordlg('Introduza um número real y0',...
                             'ERRO','modal');
                end
            end
        case 2
              sExata=dsolve(['Dy=', strF],...
                            ['y(',num2str(a),')=',num2str(y0)]);
              g=@(t) eval(vectorize(char(sExata)));
              h=(b-a)/n;
              t=a:h:b;
              yExata=g(t);
              disp('--- Solução exata do PVI ---')
              disp(yExata)
        case 3
            y=MenuMNPVI(f,a,b,n,y0);
        case 4
            warndlg('Opção por implementar')
    end
    input('Prima numa tecla para continuar »')
end
    
