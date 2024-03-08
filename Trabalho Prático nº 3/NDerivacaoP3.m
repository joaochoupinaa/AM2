% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Fórmula das diferenças progressivas em 3 pontos
% f′(xk) = −3f(xk)+4f(xk+1)−f(xk+2) / 2*h

function [x, y, dydx] = NDerivacaoP3(f, a, b, h, y)
x = a: h: b;
n = length(x);

if nargin == 4
    y = f(x);
end

dydx = zeros(1, n);

for i = 1: (n - 2)
    dydx(i) = (-3 * y(i) + 4 * y(i + 1) - y(i + 2)) / (2 * h);
end

dydx(n - 1) = (-3 * y(n - 2) + 4 * y(n - 1) - y(n)) / (2 * h);
dydx(n) = (-3 * y(n - 2) + 4 * y(n - 1) - y(n)) / (2 * h);
end
