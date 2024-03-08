% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Regra de Simpson
% IS(f)=h3[f(x0)+4f(x1)+2f(x2)+⋯+2f(xn−2)+4f(xn−1)+f(xn)] 
% |ES|≤b−a180h4M4,M4=max , x∈[a,b]∣∣f(4)(x)∣∣

function out_S = Simpson(f,a,b,n)

h = (b-a)/n;
x = a;
s = 0;

for i=1:n-1
	x = x + h;
	if mod(i,2) == 0
		s = s + 2*f(x);
	else
		s = s + 4*f(x);
    end
end

out_S = h/3 * ( f(a) + s + f(b) );

