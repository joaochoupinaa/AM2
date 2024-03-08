% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Interface de texto para a Derivação numérica

clc;
clear;

fprintf('\n ------------------------------------\n')
fprintf(' -------- DERIVAÇÃO NUMÉRICA --------')
fprintf('\n ------------------------------------\n')



while 1
    strF=input('f(x)= ','s');
    f=@(x) eval(vectorize(strF));
    try
        fTeste=f(sym('x'));
        break;
    catch Me
        errordlg('Introduza uma função de x','ERRO','modal');
    end
end

a=str2num(input('a= ','s'));
b=str2num(input('b= ','s'));
h=str2num(input('h= ','s'));

[xd,y,dydxDFP]=NDerivacaoP2(f,a,b,h);

syms x;
df=diff(f(x));
dfdx=@(x) eval(vectorize(char(df)));
x=xd;
dydxExata=dfdx(x);

plot(x,y,'-bs');
hold on;
plot(x,dydxDFP,'-ro','LineWidth',2);
plot(x,dydxExata,'-kd')
legend('f(x)','dydxDFP','dydxExata');
hold off;
shg

erroDFP=abs(dydxExata-dydxDFP);
tabela=[x.',y.',dydxDFP.',dydxExata.',erroDFP.'];
fprintf('\n\t\t x\t\t y\t\t dydx\t dydxExata\t ErroDFP\n');
disp(tabela);

%% escrever dados no excel
Filename='TabelaDerivada.xlsx';
sheet='Sheet1';
xlswrite(Filename,strF,sheet,'B4');
xlswrite(Filename,a,sheet,'B5');
xlswrite(Filename,b,sheet,'D5');
xlswrite(Filename,h,sheet,'F5');
xlswrite(Filename,tabela,sheet,'A8');
winopen(Filename);



