% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Regra dos Trapézios
% IT(f)=h2[f(x0)+2f(x1)+⋯+2f(xn−1)+f(xn)] 
% |ET|≤b−a12h2M2,M2=max , x∈[a,b]|f′′(x)|

function T = Trapezios(f,a,b,n)

h = (b-a)/n;
s = 0;
x=a;

for i=1:n-1
	x=x+h;
	s = s+f(x);
end

T = h/2 * ( f(a) + 2*s + f(b) );

