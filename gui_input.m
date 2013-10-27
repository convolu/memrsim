function varargout = gui_input(varargin)
% GUI_INPUT MATLAB code for gui_input.fig
%      GUI_INPUT, by itself, creates a new GUI_INPUT or raises the existing
%      singleton*.
%
%      H = GUI_INPUT returns the handle to a new GUI_INPUT or the handle to
%      the existing singleton*.
%
%      GUI_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INPUT.M with the given input arguments.
%
%      GUI_INPUT('Property','Value',...) creates a new GUI_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_input

% Last Modified by GUIDE v2.5 05-Jun-2013 22:15:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_input_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_input_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before gui_input is made visible.
function gui_input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_input (see VARARGIN)

% Choose default command line output for gui_input
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_input wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_input_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edNoCycles_Callback(hObject, eventdata, handles)
% hObject    handle to edNoCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edNoCycles as text
%        str2double(get(hObject,'String')) returns contents of edNoCycles as a double


% --- Executes during object creation, after setting all properties.
function edNoCycles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edNoCycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to edFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFrequency as text
%        str2double(get(hObject,'String')) returns contents of edFrequency as a double


% --- Executes during object creation, after setting all properties.
function edFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTimeOff_Callback(hObject, eventdata, handles)
% hObject    handle to edTimeOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTimeOff as text
%        str2double(get(hObject,'String')) returns contents of edTimeOff as a double


% --- Executes during object creation, after setting all properties.
function edTimeOff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTimeOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTimeOn_Callback(hObject, eventdata, handles)
% hObject    handle to edTimeOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTimeOn as text
%        str2double(get(hObject,'String')) returns contents of edTimeOn as a double


% --- Executes during object creation, after setting all properties.
function edTimeOn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTimeOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edMaxVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to edMaxVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edMaxVoltage as text
%        str2double(get(hObject,'String')) returns contents of edMaxVoltage as a double


% --- Executes during object creation, after setting all properties.
function edMaxVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edMaxVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edVoltageStep_Callback(hObject, eventdata, handles)
% hObject    handle to edVoltageStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edVoltageStep as text
%        str2double(get(hObject,'String')) returns contents of edVoltageStep as a double


% --- Executes during object creation, after setting all properties.
function edVoltageStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edVoltageStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in butCreate.
function butCreate_Callback(hObject, eventdata, handles)
% hObject    handle to butCreate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of butCreate


% --- Executes on button press in rbSine.
function rbSine_Callback(hObject, eventdata, handles)
% hObject    handle to rbSine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSine


% --- Executes on button press in rbCustomPulse.
function rbCustomPulse_Callback(hObject, eventdata, handles)
% hObject    handle to rbCustomPulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbCustomPulse
