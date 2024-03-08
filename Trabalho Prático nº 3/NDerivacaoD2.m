% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Fórmula da 2ª Derivada em 3 pontos
% f′′(xk) = f(xk+1)−2f(xk)+f(xk−1) / h^2

function [x, y, dydx] = NDerivacaoD2(f, a, b, h, y)
x = a: h: b;
n = length(x);

if nargin == 4
    y = f(x);
end

dydx = zeros(1, n);

for i = 2: (n - 1)
    dydx(i) = (y(i + 1) - 2 * y(i) + y(i - 1)) / h^2;
end

dydx(1) = (y(3) - 2 * y(2) + y(1)) / h^2;
dydx(n) = (y(n) - 2 * y(n - 1) + y(n - 2)) / h^2;

end

