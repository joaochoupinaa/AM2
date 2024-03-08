 % MNumericosPVI função para o uso dos três métodos em simultâneo
%
% Trabalho Prático
%   09/04/2022 - Ricardo Tavares .: a2021144652@alunos.isec.pt
%   09/04/2022 - João Choupina Ferreira da Mota .: a2020151878@isec.pt

function y = MNumericosPVI(f,a,b,n,y0)

MetodoEuler=NEuler(f,a,b,n,y0);
MetodoRK2=NRK2(f,a,b,n,y0);
MetodoRK4=NRK4(f,a,b,n,y0);
MetodoEulerMelhorado=NEulerMelhorado(f,a,b,n,y0);

y=table(MetodoEuler,MetodoRK2,MetodoRK4,MetodoEulerMelhorado);

end