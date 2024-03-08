% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Integração Numérica

function varargout = IntNumerica(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntNumerica_OpeningFcn, ...
                   'gui_OutputFcn',  @IntNumerica_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function IntNumerica_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set(hObject,'Name','Integracao Numerica');
guidata(hObject, handles);
pbLimpar_Callback(hObject, eventdata, handles)

clear
clc


function varargout = IntNumerica_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function pbCalcular_Callback(hObject, eventdata, handles)
MyAtualizar(hObject, eventdata, handles);


function cbGrelha_Callback(hObject, eventdata, handles)
t1 = get(handles.pResult,'Visible');
t2 = get(handles.pTodos,'Visible');

if strcmp(t1,'on') || strcmp(t2,'on')
    grelha = get(handles.cbGrelha,'Value');
    if grelha == 1
        grid on;
    else
        grid off;
    end
end

function cbLegenda_Callback(hObject, eventdata, handles)
t1 = get(handles.pResult,'Visible');
t2 = get(handles.pTodos,'Visible');

if strcmp(t1,'on') || strcmp(t2,'on')
    if get(handles.cbLegenda, 'Value')
        legend('show');
    else
        legend('hide');
    end
end


function cbLEixos_Callback(hObject, eventdata, handles)
t1 = get(handles.pResult,'Visible');
t2 = get(handles.pTodos,'Visible');

if strcmp(t1,'on') || strcmp(t2,'on')
    if get(handles.cbLEixos, 'Value')
        xlabel('x')
        ylabel('y')
    else
        xlabel('')
        ylabel('')
    end
end


function cbPArea_Callback(hObject, eventdata, handles)
t1 = get(handles.pResult,'Visible');
t2 = get(handles.pTodos,'Visible');

if strcmp(t1,'on') || strcmp(t2,'on')
    a  = str2num(get(handles.eA,'String'));                                 % Obtem a string existente no edit text 'eA', converte para numero e coloca em 'a'
    b  = str2num(get(handles.eB,'String'));                                 % Obtem a string existente no edit text 'eB', converte para numero e coloca em 'b'
    n  = str2num(get(handles.eN,'String'));                                 % Obtem a string existente no edit text 'eN', converte para numero e coloca em 'n'

    strF = get(handles.stFuncao,'String');                                  % Obtem a string existente no edit text 'eF' e coloca em strF
    f=@(x) eval(vectorize(char(strF)));                                     % Converte a string num function handle

    h = (b-a)/n;
    x=a:h:b;
    y = f(x);

    A=area(x,y);
    A.FaceColor='r';
    legend('Área');

    preencher = get(handles.cbPArea, 'Value');
    if preencher
        A.FaceAlpha = 1;
        A.EdgeAlpha = 1;
        
    else
        A.FaceAlpha = 0;
        A.EdgeAlpha = 0;
        plot(x,y);
        legend('Função');
    end
    cbGrelha_Callback(hObject, eventdata, handles);
    cbLEixos_Callback(hObject, eventdata, handles);
    cbLegenda_Callback(hObject, eventdata, handles)
end


function rbSimpson_Callback(hObject, eventdata, handles)


function rbTrapezios_Callback(hObject, eventdata, handles)


function rbSubInt_Callback(hObject, eventdata, handles)
set(handles.eErro,'Enable','off');                                          % Coloca o campo 'eErro' nao editavel
set(handles.eN,'Enable','on');                                              % Coloca o campo 'eN' editavel


function eN_Callback(hObject, eventdata, handles)


function eN_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eErro_Callback(hObject, eventdata, handles)


function eErro_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rbErroMax_Callback(hObject, eventdata, handles)
set(handles.eN,'Enable','off');                                             % Coloca o campo 'eN' nao editavel
set(handles.eErro,'Enable','on');                                           % Coloca o campo 'eErro' editavel


function eB_Callback(hObject, eventdata, handles)


function eB_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eA_Callback(hObject, eventdata, handles)


function eA_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MyAtualizar(hObject, eventdata, handles)

strF = get(handles.stFuncao,'String');                                      % Obtem a string existente no edit text 'eF' e coloca em strF
f=@(x) eval(vectorize(char(strF)));

a = str2num(get(handles.eA,'String'));                                      % Obtem a string existente no edit text 'eA', converte para numero e coloca em 'a'
b = str2num(get(handles.eB,'String'));                                      % Obtem a string existente no edit text 'eB', converte para numero e coloca em 'b'
n = str2num(get(handles.eN,'String'));                                      % Obtem a string existente no edit text 'eN', converte para numero e coloca em 'n'
escolhaMIntNum=get(handles.bgMIntNum,'SelectedObject');
escolhaMIN=find([handles.rbTrapezios,...
              handles.rbSimpson,...
              handles.rbQuad,...
              handles.rbTodos]==escolhaMIntNum);
TRAPEZIOS=1;
SIMPSON=2;
QUAD=3;
TODOS=4;


testeFunc=MException('MATLAB:MyAtualizar:badFunc',...
                     'Introduza uma funcao em x');
testeA=MException('MATLAB:MyAtualizar:badNReal',...
                     'Valor de "a" nao introduzido ou nao real');
testeB=MException('MATLAB:MyAtualizar:badNReal',...
                     'Valor de "b" nao introduzido ou nao real');
testeBA=MException('MATLAB:MyAtualizar:badNReal',...
                     'Valor de "b" tem de ser superior a "a"');
testeN=MException('MATLAB:MyAtualizar:badNReal',...
                     'Introduza "n" inteiro e maior que zero!');
testeE=MException('MATLAB:MyAtualizar:badNReal',...
                     'Valor de "E" nao introduzido ou nao real');
                 
syms x;
try  

    try                                                                     % Try serve para apanhar possiveis erros, sem crashar o programa
           fTeste=f(sym('x'));                                              % Verifica se a funcao esta em ordem a 'x'
    catch
           throw(testeFunc);                                                % Caso a verificacao falhe chama a Excecao 'testeFunc'
    end 
    
    if ~(isscalar(a) && isreal(a)), throw(testeA); end                      % Se 'a' nao for um namero e se nao for um numero real chama a Excecao 'testeA'
    if ~(isscalar(b) && isreal(b)), throw(testeB); end                      % Se 'b' nao for um namero e se nao for um numero real chama a Excecao 'testeB'
    if (a>b), throw(testeBA); end                                           % Se 'a' for maior que 'b' chama a Excecao 'testeBA'

    h = (b-a)/n;
    t=a:h:b;
    y=f(t);
    
    plot(t,y);
    legend('Função');
    legend('hide');
    shg;
    
    exata = double(int(f(sym('x')),a,b));

    sTodos = 0;
    switch escolhaMIN
        case TRAPEZIOS                                                      % Caso a escolha do utilizador seja a Regra dos Trapezios
            A = INumRTrapezios(f,a,b,n);                                    % 'A' trata-se da aproximacao do valor da area, e 'erro' o erro maximo dessa aproximacao
        case SIMPSON                                                        % Caso a escolha do utilizador seja a regra de Simpson
            A = INumRSimpson(f,a,b,n);                                      
        case QUAD                                                           % Caso a escolha do utilizador seja Quad
            A = quad(f,a,b);
        case TODOS                                                          % Caso a escolha do utilizador seja Todos
            sTodos = 1;
            
            set(handles.pResult,'Visible','off');
            set(handles.pTodos,'Visible','on');
            
            % Exata
            set(handles.st2Exata,'String',num2str(exata));
            
            % Regra dos Trapezios
            A = INumRTrapezios(f,a,b,n);
            set(handles.stTrap,'String',num2str(A));
            erro = A-exata;
            set(handles.stETrap,'String',num2str(erro));
            
            % Regra de Simpson
            A = INumRSimpson(f,a,b,n);
            set(handles.stSimp,'String',num2str(A));
            erro = A-exata;
            set(handles.stESimp,'String',num2str(erro));
            
            % Quad (MATLAB)
            A = quad(f,a,b);
            set(handles.stQuad,'String',num2str(A));
            erro = A-exata;
            set(handles.stEQuad,'String',num2str(erro));
    end
    
    if ~sTodos
        set(handles.pTodos,'Visible','off');
        set(handles.pResult,'Visible','on');
        

        erro = A-exata;

        set(handles.stAprox,'String',num2str(A));
        set(handles.stExata,'String',num2str(exata));
        set(handles.stErro,'String',num2str(erro));
    end
    
    cbLegenda_Callback(hObject, eventdata, handles);
    cbPArea_Callback(hObject, eventdata, handles);
    cbLEixos_Callback(hObject, eventdata, handles);
    cbGrelha_Callback(hObject, eventdata, handles);
    
catch Me
    errordlg(Me.message,'ERRO','modal')
end



function pbLimpar_Callback(hObject, eventdata, handles)

set(handles.eA,'String','0');                                               % Coloca o edit text 'eA' no default
set(handles.eB,'String','5');                                               % Coloca o edit text 'eB' no default
set(handles.eN,'String','20');                                              % Coloca o edit text 'eN' no default

set(handles.pResult,'Visible','off');
set(handles.pTodos,'Visible','off');

set(handles.rbTrapezios,'Value',1);

set(handles.cbGrelha,'Value',0);
cbGrelha_Callback(hObject, eventdata, handles)

set(handles.cbPArea,'Value',0);
cbPArea_Callback(hObject, eventdata, handles)

set(handles.cbLegenda,'Value',0);
cbLegenda_Callback(hObject, eventdata, handles)

set(handles.cbLEixos,'Value',0);
cbLEixos_Callback(hObject, eventdata, handles)

cla reset;
set(handles.axesGrafico,'Visible','off');
 


function figure1_CloseRequestFcn(hObject, eventdata, handles)
pbLimpar_Callback(hObject, eventdata, handles);                             % Limpar toda a informação
set(handles.figure1,'Visible','Off');   
