%INTERFACE04MENUPVI 
%Chamada de fun��es
%   MenuMNPVI
%
%   12/03/2020 - Arm�nioCorreia .: armenioc@isec.pt 

clear
primeiraVez=1;
menuPVI=1;
while menuPVI~=5 
    clc;
    disp('--------------------------------------------------------------')
    disp('            PROBLEMAS DE VALOR INICIAL (PVI)                  ')
    disp('------------------------------------------------------------- ')
    if (~primeiraVez)
    menuPVI=menu('M�todos Num�ricos para PVI',...
                 'Dados do PVI',...
                 'Solu��o Exata',...
                 'Solu��o Aproximada',...
                 'Tabela e Gr�ficos de Resultados',...
                 'Sa�r');
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
                    disp('ERRO! Introduza uma fun��o em t e y');
                end
            end
            while 1
                a=str2double(input('a = ','s'));
                if (isscalar(a) && isreal(a))
                    break;
                else
                    errordlg('Introduza um n�mero real a',...
                             'ERRO','modal');
                end
            end
            while 1
                b=str2double(input('b = ','s'));
                if (isscalar(b) && isreal(b) && b > a)
                    break;
                else
                    errordlg('Introduza um n�mero real b, com b > a',...
                             'ERRO','modal');
                end
            end
            while 1
                n=str2double(input('n = ','s'));
                if (isscalar(n) && isreal(n) && n > 0)
                    break;
                else
                    errordlg('Introduza um n�mero real n, com n > 0',...
                             'ERRO','modal');
                end
            end
            while 1
                y0=str2double(input('y0 = ','s'));
                if (isscalar(y0) && isreal(y0))
                    break;
                else
                    errordlg('Introduza um n�mero real y0',...
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
              disp('--- Solu��o exata do PVI ---')
              disp(yExata)
        case 3
            y=MenuMNPVI(f,a,b,n,y0);
        case 4
            warndlg('Op��o por implementar')
    end
    input('Prima numa tecla para continuar �')
end
    
