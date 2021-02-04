%1.2.3（12）音乐合成GUI
function varargout = ex_1_2_3_12(varargin)
% EX_1_2_3_12 MATLAB code for ex_1_2_3_12.fig
%      EX_1_2_3_12, by itself, creates a new EX_1_2_3_12 or raises the existing
%      singleton*.
%
%      H = EX_1_2_3_12 returns the handle to a new EX_1_2_3_12 or the handle to
%      the existing singleton*.
%
%      EX_1_2_3_12('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX_1_2_3_12.M with the given input arguments.
%
%      EX_1_2_3_12('Property','Value',...) creates a new EX_1_2_3_12 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex_1_2_3_12_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ex_1_2_3_12_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ex_1_2_3_12

% Last Modified by GUIDE v2.5 01-Jul-2020 23:13:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ex_1_2_3_12_OpeningFcn, ...
                   'gui_OutputFcn',  @ex_1_2_3_12_OutputFcn, ...
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

har=[0,0,0,0];
har_temp=[0,0,0,0];
notes=[];

% --- Executes just before ex_1_2_3_12 is made visible.
function ex_1_2_3_12_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ex_1_2_3_12 (see VARARGIN)
global har;%谐波强度
global har_temp;%谐波强度临时设置变量
global overlap;%音符间重叠时间
global overlap_temp;%重叠时间临时设置变量
global notes;%音符序列
har=[1,0,0,0,0];
har_temp=[1,0,0,0,0];
overlap=0.2;
overlap_temp=0.2;
notes=[];

% Choose default command line output for ex_1_2_3_12
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.text5.String='请设置谐波强度、延音，完成后点击<设置>按钮';


% UIWAIT makes ex_1_2_3_12 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ex_1_2_3_12_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit0_Callback(hObject, eventdata, handles)
% hObject    handle to edit0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har_temp;
har_temp(1)=str2double(get(hObject,'String'));%设置基波分量


% --- Executes during object creation, after setting all properties.
function edit0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har_temp;
har_temp(2)=str2double(get(hObject,'String'));%设置二次谐波分量


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har_temp;
har_temp(3)=str2double(get(hObject,'String'));%设置三次谐波分量


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har_temp;
har_temp(4)=str2double(get(hObject,'String'));%设置四次谐波分量


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har_temp;
har_temp(5)=str2double(get(hObject,'String'));%设置五次谐波分量


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global overlap_temp;
if get(hObject,'Value')==1%设置延音
    overlap_temp=0.8;
else
    overlap_temp=0.3;
end

% --- Executes on button press in pushbutton0.
function pushbutton0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global har_temp;
global overlap;
global overlap_temp;
global notes;
har=har_temp;%将临时设置同步到设置中
overlap=overlap_temp;
notes=[];
handles.text5.String='设置完成，音符序列已清空，请开始演奏';


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global notes;
notes=[];%清空音符序列
handles.text5.String='音符序列已清空，请重新演奏';


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
f0=220;%基准频率
freq=8000;%采样频率
output=zeros(1,freq*(0.5*length(notes)+overlap));%输出向量
position=1;%辅助指针
for k=1:length(notes)
    t=linspace(0,0.5+overlap-1/freq,freq*(0.5+overlap));%生成时间
    temp=har(1)*sin(2*pi*f0*pow2(notes(k)/12)*t);%基波
    temp=temp+har(2)*sin(2*pi*2*f0*pow2(notes(k)/12)*t);%二次谐波
    temp=temp+har(3)*sin(2*pi*3*f0*pow2(notes(k)/12)*t);%三次谐波
    temp=temp+har(4)*sin(2*pi*4*f0*pow2(notes(k)/12)*t);%四次谐波
    temp=temp+har(5)*sin(2*pi*5*f0*pow2(notes(k)/12)*t);%五次谐波
    cover=[-100*(t(1:0.1*0.5*freq-1)/0.5).^2+20*(t(1:0.1*0.5*freq-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*freq:freq*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
    output(position:position+freq*(0.5+overlap)-1)=output(position:position+freq*(0.5+overlap)-1)+cover.*temp;%添加乐音
    position=position+freq*0.5;%移动指针 
end
sound(output,freq);%播放
output=output/max(abs(output));
audiowrite('data/my_music.wav',output,freq)%保存
handles.text5.String='已保存到文件“my_music.wav”';
pause(0.5*length(notes)+overlap)
notes=[];
handles.text5.String='音符序列已清空，可以继续新的演奏';

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-9/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-9/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-9/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-9/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-9/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='C3';%显示音符
handles.text5.String=['C3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-9];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-8/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-8/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-8/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-8/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-8/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bD3';%显示音符
handles.text5.String=['bD3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-8];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-7/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-7/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-7/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-7/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-7/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='D3';%显示音符
handles.text5.String=['D3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-7];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-6/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-6/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-6/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-6/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-6/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bE3';%显示音符
handles.text5.String=['bE3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-6];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-5/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-5/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-5/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-5/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-5/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='E3';%显示音符
handles.text5.String=['E3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-5];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-4/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-4/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-4/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-4/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-4/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='F3';%显示音符
handles.text5.String=['F3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-4];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-3/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-3/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-3/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-3/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-3/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bG3';%显示音符
handles.text5.String=['bG3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-3];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-2/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-2/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-2/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-2/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-2/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='G3';%显示音符
handles.text5.String=['G3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-2];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(-1/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(-1/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(-1/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(-1/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(-1/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bA3';%显示音符
handles.text5.String=['bA3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,-1];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(0/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(0/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(0/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(0/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(0/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='A3';%显示音符
handles.text5.String=['A3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,0];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(1/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(1/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(1/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(1/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(1/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bB3';%显示音符
handles.text5.String=['bB3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,1];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(2/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(2/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(2/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(2/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(2/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='B3';%显示音符
handles.text5.String=['B3','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,2];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(3/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(3/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(3/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(3/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(3/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='C4';%显示音符
handles.text5.String=['C4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,3];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(4/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(4/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(4/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(4/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(4/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bD4';%显示音符
handles.text5.String=['bD4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,4];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(5/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(5/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(5/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(5/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(5/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='D4';%显示音符
handles.text5.String=['D4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,5];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(6/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(6/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(6/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(6/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(6/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bE4';%显示音符
handles.text5.String=['bE4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,6];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(7/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(7/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(7/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(7/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(7/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='E4';%显示音符
handles.text5.String=['E4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,7];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(8/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(8/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(8/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(8/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(8/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='F4';%显示音符
handles.text5.String=['F4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,8];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(9/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(9/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(9/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(9/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(9/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bG4';%显示音符
handles.text5.String=['bG4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,9];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(10/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(10/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(10/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(10/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(10/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='G4';%显示音符
handles.text5.String=['G4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,10];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(11/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(11/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(11/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(11/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(11/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bA4';%显示音符
handles.text5.String=['bA4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,11];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(12/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(12/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(12/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(12/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(12/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='A4';%显示音符
handles.text5.String=['A4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,12];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(13/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(13/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(13/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(13/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(13/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bB4';%显示音符
handles.text5.String=['bB4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,13];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(14/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(14/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(14/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(14/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(14/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='B4';%显示音符
handles.text5.String=['B4','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,14];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(15/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(15/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(15/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(15/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(15/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='C5';%显示音符
handles.text5.String=['C5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,15];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(16/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(16/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(16/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(16/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(16/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bD5';%显示音符
handles.text5.String=['bD5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,16];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(17/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(17/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(17/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(17/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(17/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='D5';%显示音符
handles.text5.String=['D5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,17];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(18/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(18/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(18/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(18/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(18/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bE5';%显示音符
handles.text5.String=['bE5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,18];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(19/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(19/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(19/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(19/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(19/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='E5';%显示音符
handles.text5.String=['E5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,19];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(20/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(20/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(20/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(20/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(20/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='F5';%显示音符
handles.text5.String=['F5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,20];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(21/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(21/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(21/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(21/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(21/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bG5';%显示音符
handles.text5.String=['bG5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,21];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(22/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(22/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(22/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(22/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(22/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='G5';%显示音符
handles.text5.String=['G5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,22];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(23/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(23/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(23/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(23/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(23/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bA5';%显示音符
handles.text5.String=['bA5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,23];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(24/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(24/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(24/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(24/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(24/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='A5';%显示音符
handles.text5.String=['A5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,24];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(25/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(25/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(25/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(25/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(25/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='bB5';%显示音符
handles.text5.String=['bB5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,25];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global har;
global overlap;
global notes;
t=linspace(0,overlap+0.5-1/8000,8000*(overlap+0.5));%生成时间采样
out=zeros(1,8000*(overlap+0.5));%输出序列
out=out+har(1)*sin(2*pi*220*pow2(26/12)*t);%基波
out=out+har(2)*sin(2*pi*2*220*pow2(26/12)*t);%二次谐波
out=out+har(3)*sin(2*pi*3*220*pow2(26/12)*t);%三次谐波
out=out+har(4)*sin(2*pi*4*220*pow2(26/12)*t);%四次谐波
out=out+har(5)*sin(2*pi*5*220*pow2(26/12)*t);%五次谐波
cover=[-100*(t(1:0.1*0.5*8000-1)/0.5).^2+20*(t(1:0.1*0.5*8000-1)/0.5)...
        ,1.15652*exp(-2*(t(0.1*0.5*8000:8000*(0.5+overlap))-0.1*0.5)/(0.9*0.5+overlap))-0.15652];%生成包络
out=out.*cover;%叠加包络
handles.text6.String='B5';%显示音符
handles.text5.String=['B5','音符已加入序列'];
sound(out,8000);%播放
notes=[notes,26];
pause(0.5+overlap)
handles.text6.String='';%取消显示音符
handles.text5.String='请继续演奏';
