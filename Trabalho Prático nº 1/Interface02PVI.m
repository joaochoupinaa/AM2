%Interface02PVI para o m�todo de Euler
%
%CHAMADA DE FUN��ES:
% � NEuler
% � dsolve
%
%   03/03/2020 - Arm�nioCorreia .: armenioc@isec.pt 
% Trabalho Pr�tico
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   Jo�o Choupina Ferreira da Mota : a2020151878@isec.pt
%%
clc
clear

disp('----- M�todos Num�ricos para EDO/PVI ------ ');
disp(' ');
disp('----- Dados do PVI ------------------------ ');

while 1
    strF=input('f(t,y) = ', 's');
    f=@(t,y) eval(vectorize(strF));
    try
        syms t y;
        fTeste=f(t,y);
        break;
    catch me
        disp('ERRO! Introduza uma fun��o em t e y');
    end
end

a=str2double(input('a = ','s'));
while 1
    b=str2double(input('b = ', 's'));
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

yEuler=NEuler(f,a,b,n,y0);

sExata=dsolve(['Dy=', strF],...
              ['y(',num2str(a),')=',num2str(y0)]);
g=@(t) eval(vectorize(char(sExata)));
h=(b-a)/n;
t=a:h:b;
yExata=g(t);

erroEuler=abs(yExata-yEuler);
tabela=[t.', yEuler.', yExata.', erroEuler.'];
disp('----- Solu��o do PVI em modo tabela de valores ----')
disp(tabela)

input('Prima numa tecla para continuar')
disp('-----Solu��o em modo gr�fico----')
plot(t,yEuler,'-r')
hold on
plot(t,yExata, 'b')
hold off
grid on
legend('Euler','Exata')
shg;