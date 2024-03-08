% Interface (vers�o03) para os PVI
% Aplica��o dos M�todos Num�ricos de Euler e de Runge-Kutta
% Autor: Arm�nio Correia  | armenioc@isec.pt
% Data : 12/03/2020
% Trabalho Pr�tico
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   Jo�o Choupina Ferreira da Mota .: a2020151878@isec.pt

clear
primeiraVez = 1;
opcao = 1;
while opcao ~= 6 
    clc
    disp('------- M�TODOS NUM�RICOS PARA PVI ------')
    disp(' ')
    if(~primeiraVez)
        fprintf('1. INTRODUZIR PAR�METROS DO PVI\n')     
        fprintf('2. M�TODO DE EULER\n')         
        fprintf('3. M�TODO DE RK2\n')
        fprintf('4. M�TODO DE RK4\n')
        fprintf('5. M�TODO DE EULER MELHORADO\n')
        fprintf('6. USO DE ODE45\n')
        fprintf('7. APLICAR OS 4 M�TODOS EM SIMULT�NEO\n')
        fprintf('8. TERMINAR\n\n')
        opcao=input('Op��o: ');
    else
        opcao=1;
        primeiraVez=0;
    end
    
    y=[];
    switch opcao
        case 1      %Valida��o de inputs (a,b,n,y0 s�o numeros e f tem t ou y)
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
                if (isscalar(n) && isreal(n) && n >= 2)
                    break;
                else
                    errordlg('Introduza um n�mero real n, com n >= 2',...
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
              y=NEuler(f,a,b,n,y0);                        
        case 3  
              y=NRK2(f,a,b,n,y0);                
        case 4
              y=NRK4(f,a,b,n,y0);     
        case 5 
              y=NEulerMelhorado(f,a,b,n,y0);    
        case 6 
              [t,y]=NODE45(f,a,b,n,y0);        
        case 7
              y=MNumericosPVI(f,a,b,n,y0);    
        case 8
            break;
    end
    
    if ~isempty(y) && opcao~=1
        disp(' ')
        disp('------ AS APROXIMA��ES OBTIDAS S�O: ------')
        disp(' ')
        disp(y)
    end
    if opcao~=8
       tecla =input('\nPrima uma tecla para continuar ...');
    end
end   