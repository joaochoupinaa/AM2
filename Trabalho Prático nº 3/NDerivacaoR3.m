% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Fórmula das diferenças regressivas em 3 pontos
% f′(xk) = f(xk−2)−4f(xk−1)+3f(xk) / 2*h

function [x, y, dydx] = NDerivacaoR3(f, a, b, h, y)
x = a: h: b;
n = length(x);

if nargin == 4
    y = f(x);
end

dydx = zeros(1, n);

for i = n: -1: 3
    dydx(i) = (y(i - 2) -4 * y(i - 1) + 3 * y(i)) / (2 * h);
end

dydx(2) = (y(1) -4 * y(2) + 3 * y(3)) / (2 * h);
dydx(1) = (y(1) -4 * y(2) + 3 * y(3)) / (2 * h);
end