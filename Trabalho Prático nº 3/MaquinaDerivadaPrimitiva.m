% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% Máquina para calcular derivadas e primitivas

function varargout = MaquinaDerivadaPrimitiva(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MaquinaDerivadaPrimitiva_OpeningFcn, ...
                   'gui_OutputFcn',  @MaquinaDerivadaPrimitiva_OutputFcn, ...
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
end


function MaquinaDerivadaPrimitiva_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
set(hObject, 'Name', 'Derivadas e Primitivas')
set(handles.axesSExata, 'box', 'on');
set(handles.axesSExata, 'xtick', []);
set(handles.axesSExata, 'ytick', []);     
hSolucao = struct('hTexto', text('Parent', handles.axesSExata,...
                                     'interpreter', 'latex',...
                                     'fontsize', 20,...
                                     'units', 'norm',...
                                     'pos', [.05 .5]));   
hSolucao.filhas(1) = DerivacaoNumerica('Visible', 'Off');  
hSolucao.filhas(2) = IntegracaoNumerica('Visible', 'Off');
hSolucao.strF = 'sin(x)';
set(hObject, 'UserData', hSolucao); 
set(hSolucao.filhas(1), 'UserData', handles);
pbAnaliticamente_Callback([], [], handles);

end


function varargout = MaquinaDerivadaPrimitiva_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end


function pbAnaliticamente_Callback(hObject, eventdata, handles) 
getStrFuncao(handles)
hSolucao = get(handles.figurePrincipal, 'UserData');
y = hSolucao.strF;
funcao = @(x) eval(vectorize(y));
 
Escolha02 = get(handles.bgDerivadaPrimitiva, 'SelectedObject');
EscolhaDP = find([handles.rbDerivada,handles.rbPrimitiva] == Escolha02);
 
syms x;
try  
    if (~isempty(y))
        switch EscolhaDP
            case 1
                dF = diff(funcao(x));
                set(hSolucao.hTexto, 'String', ['$' latex(dF) '$']);
            case 2
                pF = int(funcao(x));
                set(hSolucao.hTexto, 'String', ['$' latex(pF) '+ c' '$']);
        end
    end
catch Me
    errordlg(Me.message, 'Erro', 'modal')
end
end


function pbDNumerica_Callback(hObject, eventdata, handles)
getStrFuncao(handles);
hSolucao = get(handles.figurePrincipal,'UserData');
htFuncao = findobj(hSolucao.filhas(1), 'Tag', 'tbF');
y = hSolucao.strF;
set(htFuncao, 'String', y);

bAtualizar = findobj(hSolucao.filhas(1), 'Tag', 'pbAtualizar');
atualizar = get(bAtualizar, 'callback');

if get(handles.eG, 'BackgroundColor') == [1 1 1]
    set(hSolucao.filhas(1), 'Visible', 'On');
    atualizar(bAtualizar, []);
end
end


function pbIntNumerica_Callback(hObject, eventdata, handles)
getStrFuncao(handles);
hSolucao = get(handles.figurePrincipal,'UserData');
htFuncao = findobj(hSolucao.filhas(2), 'Tag', 'tbF');
y = hSolucao.strF;
set(htFuncao, 'String', y);

bAtualizar = findobj(hSolucao.filhas(2), 'Tag', 'pbAtualizar');
atualizar = get(bAtualizar, 'callback');

if get(handles.eG, 'BackgroundColor') == [1 1 1]
    set(hSolucao.filhas(2), 'Visible', 'On');
    atualizar(bAtualizar, []);
end
end


function popupmenuF_Callback(hObject, eventdata, handles)
end


function popupmenuF_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function eG_Callback(hObject, eventdata, handles)
end


function eG_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function bgFuncoes_SelectionChangeFcn(hObject, eventdata, handles)
getStrFuncao(handles);
end


function figurePrincipal_CloseRequestFcn(hObject, eventdata, handles)

S = questdlg('Sair?','SAIR','Sim','Não','Sim');

if strcmp(S,'Não')
    return;
end

hSolucao = get(hObject, 'UserData');
delete(hSolucao.filhas);
delete(hObject);
end


function getStrFuncao(handles)
Escolha01 = get(handles.bgFuncoes, 'SelectedObject');
EscolhaFG = find([handles.rbF,handles.rbG] == Escolha01);
switch EscolhaFG
    case 1
        set(handles.eG, 'Enable', 'off');
        set(handles.popupmenuF, 'Enable', 'on');
        escolhaF = get(handles.popupmenuF, 'Value');
        switch escolhaF
            case 1
                y = 'sin(x)';
            case 2
                y = 'cos(x)';
            case 3
                y = 'exp(x)';
            case 4
                y = 'x^2';
            case 5
                y = 'log(x)';
        end
    case 2
        set(handles.eG, 'Enable', 'on');
        set(handles.popupmenuF, 'Enable', 'off');
        y = get(handles.eG, 'String');
end

testeFun = MException('MATLAB:getStrFuncao:badFunc',....
                        'Introduza uma função em x!');
                    
f = @(x) eval(vectorize(y));
                    
try
    set(handles.eG, 'BackgroundColor', 'white');
    try
        fTest = f(sym('x'));
    catch
        set(handles.eG, 'BackgroundColor', 'red');
        throw(testeFun);
    end

hSolucao = get(handles.figurePrincipal, 'UserData');
hSolucao.strF = y;
set(handles.figurePrincipal, 'UserData', hSolucao); 
catch Me
    errordlg(Me.message,'ERRO','modal');
end
end
