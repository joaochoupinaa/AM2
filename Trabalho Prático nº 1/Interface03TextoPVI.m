% Interface (versão03) para os PVI
% Aplicação dos Métodos Numéricos de Euler e de Runge-Kutta
% Autor: Arménio Correia  | armenioc@isec.pt
% Data : 12/03/2020
% Trabalho Prático
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota .: a2020151878@isec.pt

clear
primeiraVez = 1;
opcao = 1;
while opcao ~= 6 
    clc
    disp('------- MÉTODOS NUMÉRICOS PARA PVI ------')
    disp(' ')
    if(~primeiraVez)
        fprintf('1. INTRODUZIR PARÂMETROS DO PVI\n')     
        fprintf('2. MÉTODO DE EULER\n')         
        fprintf('3. MÉTODO DE RK2\n')
        fprintf('4. MÉTODO DE RK4\n')
        fprintf('5. MÉTODO DE EULER MELHORADO\n')
        fprintf('6. USO DE ODE45\n')
        fprintf('7. APLICAR OS 4 MÉTODOS EM SIMULTÂNEO\n')
        fprintf('8. TERMINAR\n\n')
        opcao=input('Opção: ');
    else
        opcao=1;
        primeiraVez=0;
    end
    
    y=[];
    switch opcao
        case 1      %Validação de inputs (a,b,n,y0 são numeros e f tem t ou y)
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
                if (isscalar(n) && isreal(n) && n >= 2)
                    break;
                else
                    errordlg('Introduza um número real n, com n >= 2',...
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
        disp('------ AS APROXIMAÇÕES OBTIDAS SÃO: ------')
        disp(' ')
        disp(y)
    end
    if opcao~=8
       tecla =input('\nPrima uma tecla para continuar ...');
    end
end   