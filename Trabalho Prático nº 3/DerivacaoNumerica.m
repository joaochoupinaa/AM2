% 07/06/2022
%   Ricardo Almeida de Aguiar Tavares .: a2021144652@alunos.isec.pt
%   João Choupina Ferreira da Mota : a2020151878@isec.pt
%
%
% DerivacaoNumerica - Derivação Numérica
% Máquina para calcular soluções aproximadas de derivadas

function varargout = DerivacaoNumerica(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DerivacaoNumerica_OpeningFcn, ...
                   'gui_OutputFcn',  @DerivacaoNumerica_OutputFcn, ...
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

function DerivacaoNumerica_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
MyAtualizar(handles);

end


function varargout = DerivacaoNumerica_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end

function pbAtualizar_Callback(hObject, eventdata, handles)
MyAtualizar(handles);
end

function eA_Callback(hObject, eventdata, handles)
end

function eA_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function eH_Callback(hObject, eventdata, handles)
% hObject    handle to eH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eH as text
%        str2double(get(hObject,'String')) returns contents of eH as a double
end

% --- Executes during object creation, after setting all properties.
function eH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function eB_Callback(hObject, eventdata, handles)
% hObject    handle to eB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eB as text
%        str2double(get(hObject,'String')) returns contents of eB as a double
end

% --- Executes during object creation, after setting all properties.
function eB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes when user attempts to close figureDerivacaoNumerica.
function figureDerivacaoNumerica_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figureDerivacaoNumerica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hint: delete(hObject) closes the figure
%delete(hObject);
set(hObject,'Visible','Off');
end

% --- Função auxiliar associada ao botão Atualizar.
function MyAtualizar(handles)
% handles estrutura de dados com as handles para os objetos...
syms x;
cla reset;

strF = get(handles.tbF,'String');
f=@(x) eval(vectorize(char(strF)));
df = diff(f(x));
df2 = diff(df);

a = str2num(get(handles.eA, 'String'));
b = str2num(get(handles.eB, 'String'));
h = str2num(get(handles.eH, 'String'));

escolhabg = get(handles.bgMetodos, 'SelectedObject');
escolhaM = find([handles.rbP2, ...
              handles.rbR2, ...
              handles.rbP3, ...
              handles.rbR3, ...
              handles.rbC3, ...
              handles.rb2, ...
              handles.rbTodos] == escolhabg);
          
testeFun = MException('MATLAB:MyAtualizar:badFunc',....
                        'Introduza uma função em x!');
                    
testeNReal = MException('MATLAB:MyAtualizar:badNReal',....
                        'Introduza um número real!');                
                    
testeB = MException('MATLAB:MyAtualizar:badB',....
                        'Introduza um número maior que a!');
try
    set(handles.tbF, 'BackgroundColor', 'white');
    
    try
        fTest = f(sym('x'));
    catch
        set(handles.tbF, 'BackgroundColor', 'red');
        throw(testeFun);
    end
   
     if ~(isscalar(a) && isreal(a))
        set(handles.eA, 'BackgroundColor', 'red');
        throw(testeNReal);
    else
        set(handles.eA, 'BackgroundColor', 'white');
    end
    
    if (isscalar(b) && isreal(b))
        if ~(b > a)
            set(handles.eB, 'BackgroundColor', 'red');
            throw(testeB);
        end
        set(handles.eB, 'BackgroundColor', 'white');
    else
        set(handles.eB, 'BackgroundColor', 'red');
        throw(testeNReal);
    end
    
    if ~(isscalar(h) && isreal(h))
        set(handles.eH, 'BackgroundColor', 'red');
        throw(testeNReal);
    else
        set(handles.eH, 'BackgroundColor', 'white');
    end  
    
    switch escolhaM
        case 1 % 2 pontos - progressivas
            [x, y, P2] = NDerivacaoP2(f, a, b, h);
            sExata = eval(df);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            erroP2 = abs(sExata - P2);
            
            plot(x, y, 'b');
            hold on;
            plot(x, P2, 'r');
            plot(x, sExata, 'k');
            hold off;
            legend('Função', 'D.F. em 2 P. - Progressivas', 'D. Exata');
            tabela = [x.', y.', sExata.', P2.', erroP2.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, ...
                    {'D. F. em 2 P. - Progressivas'}, {'Erro'}]);     	
        
        case 2 %2 pontos - regressivas
            [x, y, R2] = NDerivacaoR2(f, a, b, h);
            sExata = eval(df);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            erroR2 = abs(sExata - R2);
            
            plot(x, y, 'b');
            hold on;
            plot(x, R2, 'r');
            plot(x, sExata, 'k');
            hold off;
            legend('Função', 'D.F. em 2 P. - Regressivas', 'D. Exata');
            tabela = [x.', y.', sExata.', R2.', erroR2.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, ...
                    {'D. F. em 2 P. - Regressivas'}, {'Erro'}]);
                   
        case 3 % 3 pontos - progressivas
            [x, y, P3] = NDerivacaoP3(f, a, b, h);
            sExata = eval(df);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            erroP3 = abs(sExata - P3);
            
            plot(x, y, 'b');
            hold on;
            plot(x, P3, 'r');
            plot(x, sExata, 'k');
            hold off;
            legend('Função', 'D.F. em 3 P. - Progressivas', 'D. Exata');
            tabela = [x.', y.', sExata.', P3.', erroP3.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, ...
                    {'D. F. em 3 P. - Progressivas'}, {'Erro'}]);

        case 4 % 3 pontos - regressivas
            [x, y, R3] = NDerivacaoR3(f, a, b, h);
            sExata = eval(df);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            erroR3 = abs(sExata - R3);
            
            plot(x, y, 'b');
            hold on;
            plot(x, R3, 'r');
            plot(x, sExata, 'k');
            hold off;
            legend('Função', 'D.F. em 3 P. - Regressivas', 'D. Exata');
            tabela = [x.', y.', sExata.', R3.', erroR3.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, ...
                    {'D. F. em 3 P. - Regressivas'}, {'Erro'}]);
            
        case 5 % 3 pontos - centradas
            [x, y, C3] = NDerivacaoC3(f, a, b, h);
            sExata = eval(df);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            erroC3 = abs(sExata - C3);
            
            plot(x, y, 'b');
            hold on;
            plot(x, C3, 'r');
            plot(x, sExata, 'k');
            hold off;
            legend('Função', 'D.F. em 3 P. - Centrais', 'D. Exata');
            tabela = [x.', y.', sExata.', C3.', erroC3.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, ...
                    {'D. F. em 3 P. - Centrais'}, {'Erro'}]);

        case 6 % 3 pontos - 2nd derivada
            [x, y, D2] = NDerivacaoD2(f, a, b, h);
            sExata2 = eval(df2);
            
            if size(sExata2) == 1
                sExata2 = zeros(length(x), 1) + sExata2;
                sExata2 = sExata2.';
            end
            
            erroD2 = abs(sExata2 - D2);
            
            plot(x, y, 'b');
            hold on;
            plot(x, D2, 'r');
            plot(x, sExata2, 'k');
            hold off;
            legend('Função', 'D.F. em 3 P. - 2a D.', '2a D. Exata');
            tabela = [x.', y.', sExata2.', D2.', erroD2.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'2a D. Exata'}, ...
                    {'D. F. em 3 P. - 2a D.'}, {'Erro'}]);
            
        case 7 % TODOS
            [x, y, P2] = NDerivacaoP2(f, a, b, h);
            [~, ~, R2] = NDerivacaoR2(f, a, b, h);
            [~, ~, P3] = NDerivacaoP3(f, a, b, h);
            [~, ~, R3] = NDerivacaoR3(f, a, b, h);
            [~, ~, C3] = NDerivacaoC3(f, a, b, h);
            [~, ~, D2] = NDerivacaoD2(f, a, b, h);
            sExata = eval(df);
            sExata2 = eval(df2);
            
            if size(sExata) == 1
                sExata = zeros(length(x), 1) + sExata;
                sExata = sExata.';
            end
            
            if size(sExata2) == 1
                sExata2 = zeros(length(x), 1) + sExata2;
                sExata2 = sExata2.';
            end
            
            erroP2 = abs(sExata - P2);
            erroR2 = abs(sExata - R2);
            erroP3 = abs(sExata - P3);
            erroR3 = abs(sExata - R3);
            erroC3 = abs(sExata - C3);
            erroD2 = abs(sExata - D2);
            
            plot(x, y, 'b');
            hold on;
            
            plot(x, P2, 'Color', [0 1 0]);
            plot(x, R2, 'Color', [0 0.75 0]);
            plot(x, P3, 'Color', [1 0 1]);
            plot(x, R3, 'Color', [1 0 0.75]);
            plot(x, C3, 'Color', [0.75 0 1]);
            plot(x, D2, 'Color', [0.75 0 0.75]);
            plot(x, sExata, 'k');
            plot(x, sExata2, 'r');
            
            legend('Função', 'D.F. em 2 P. - Progressivas', ...
                    'D.F. em 2 P. - Regressivas', ...
                    'D.F. em 3 P. - Progressivas', ...
                    'D.F. em 3 P. - Regressivas', ...
                    'D.F. em 3 P. - Centrais', ...
                    'D.F. em 3 P. - 2a D.', ...
                    'D. Exata', '2a D. Exata')
                
            tabela = [x.', y.', sExata.', sExata2.', P2.', erroP2.', ...
                        R2.', erroR2.', P3.', erroP3.', ...
                        R3.', erroR3.', C3.', erroC3.', ...
                        D2.', erroD2.'];
            
            set(handles.uitabela, 'Data', num2cell(tabela));
            set(handles.uitabela, 'ColumnName', ...
                    [{'x'}, {'y'}, {'D. Exata'}, {'2a D. Exata'},...
                    {'D. F. em 2 P. - Progressivas'}, {'Erro Prog. 2P'}, ...
                    {'D. F. em 2 P. - Regressivas'}, {'Erro Regr. 2P'}, ...
                    {'D. F. em 3 P. - Progressivas'}, {'Erro Prog. 3P'}, ...
                    {'D. F. em 3 P. - Regressivas'}, {'Erro Regr. 3P'}, ...
                    {'D. F. em 3 P. - Centrais'}, {'Erro Centrais 3P'}, ...
                    {'D. F. em 3 P. - 2a D.'}, {'Erro 2a D 3P'}]);     
    end

    if get(handles.cbGrid, 'Value')
        grid on;
    else
        grid off;
    end
    
catch Me
    errordlg(Me.message,'ERRO','modal');
end
end




function tbF_Callback(hObject, eventdata, handles)
end


function tbF_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function mExcel_Callback(hObject, eventdata, handles)
filename = inputdlg('Nome do ficheiro:', 'Exportar para Excel', [1 30], {'valores'});
filename = string(filename) + '.xlsx';

l = get(handles.uitabela, 'ColumnName');
l = l.';
tabela = get(handles.uitabela, 'Data');

writecell(tabela, filename, 'Sheet', 1, 'Range', 'A2');
writecell(l, filename, 'Sheet', 1, 'Range', 'A1');
end


function cbGrid_Callback(hObject, eventdata, handles)

if get(handles.cbGrid, 'Value')
    grid on;
else
    grid off;
end
end

function cbLegendAxes_Callback(hObject, eventdata, handles)

if get(handles.cbLegendAxes, 'Value')
    xlabel('Eixo dos xx');
    ylabel('Eixo dos yy');
else
    xlabel('');
    ylabel('');
end
end