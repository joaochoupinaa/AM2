% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Fórmula das diferenças centradas em 3 pontos
% f′(xk) = f(xk+1)−f(xk−1)/ 2*h

function [x, y, dydx] = NDerivacaoC3(f, a, b, h, y)
x = a: h: b;
n = length(x);

if nargin == 4
    y = f(x);
end

dydx = zeros(1, n);

for i = 2: (n - 1)
    dydx(i) = (y(i + 1) - y(i - 1)) / (2 * h);
end

dydx(1) = (y(3) - y(1)) / (2 * h);
dydx(n) = (y(n) - y(n - 2)) / (2 * h);
end