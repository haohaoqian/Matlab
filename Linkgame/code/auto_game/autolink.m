%2.8 自动连连看
function varargout = autolink(varargin)
% AUTOLINK MATLAB code for autolink.fig
%      AUTOLINK, by itself, creates a new AUTOLINK or raises the existing
%      singleton*.
%
%      H = AUTOLINK returns the handle to a new AUTOLINK or the handle to
%      the existing singleton*.
%
%      AUTOLINK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOLINK.M with the given input arguments.
%
%      AUTOLINK('Property','Value',...) creates a new AUTOLINK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autolink_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autolink_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autolink

% Last Modified by GUIDE v2.5 13-Jul-2020 23:29:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autolink_OpeningFcn, ...
                   'gui_OutputFcn',  @autolink_OutputFcn, ...
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


% --- Executes just before autolink is made visible.
function autolink_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autolink (see VARARGIN)

% Choose default command line output for autolink
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes autolink wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.text1.String='点击按钮开始自动连连看';


% --- Outputs from this function are returned to the command line.
function varargout = autolink_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text1.String='正在获取并分析图像...';
realcapture=user_camera();
imshow(realcapture);

%分割图像
[m, n,~] = size(realcapture);

width0=0;
height0=0;
l_margin0=0;
t_margin0=0;
for ch=1:3
    pic=realcapture(:,:,ch);
    x=mean(pic,1)-mean(mean(pic,1));%按行平均，除去直流分量
    xa=bandpass(x,[5,30],n);%带通滤波
    
    N=n;%时域采样点数
    T=1;%时间范围
    [t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
    F=FT*xa.';%傅里叶变换
    [~,b]=max(abs(F));%找出基波频率
    width=round(2*pi*n/omg(b));%根据基波频率计算横向周期
    width0=width0+width;
    
    F=FT*x.';%计算原函数的频谱
    phase=angle(F(b));%计算基波频率的相位
    t=[0:n];
    base=abs(F(b))*cos(2*pi/width*t+phase);%生成基波函数
    [~,l_margin]=max(base(1:width));%根据基波函数得到左侧空白距离
    l_margin0=l_margin0+l_margin;
    
    %计算纵向周期、顶部空白距离步骤完全相同，不再画出图像
    y=mean(pic,2)-mean(mean(pic,2));
    ya=bandpass(y,[5,30],m);
    
    N=m;
    T=1;
    [t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
    F=FT*ya;
    [~,b]=max(abs(F));
    height=round(2*pi*m/omg(b));
    height0=height0+height;
    
    F=FT*y;
    phase=angle(F(b));
    t=[0:m];
    base=abs(F(b))*cos(2*pi/height*t+phase);
    [~,t_margin]=max(base(1:height));
    t_margin0=t_margin0+t_margin;
end

width0=round(width0/3);%计算平均值
height0=round(height0/3);
l_margin0=round(l_margin0/3);
t_margin0=round(t_margin0/3);
N=floor((n-l_margin0)/width0);%计算每行方块数目
M=floor((m-t_margin0)/height0);%计算每列方块数目
handles.text1.String='分析完成，开始游戏';

previous=[];
mtx=zeros(M,N)+1;
mtx_sum=M*N;
while sum(sum(mtx))~=0
    realcapture=user_camera();
    imshow(realcapture);
    pic={};
    for k=1:N
        for t=1:M
            pic{t,k}=realcapture(t_margin0+(t-1)*height0+1:t_margin0+t*height0,l_margin0+(k-1)*width0+1:l_margin0+k*width0,:);
        end
    end
    
	%计算颜色直方图,30%以上为黑色则判定为已经消去
    for k=1:M
        for t=1:N
            if color_judge(pic{k,t},3)==0
                mtx(k,t)=0;
            else
                mtx(k,t)=1;
            end
        end
    end
    s_temp=sum(sum(mtx));
    if s_temp<mtx_sum
        previous=[];
        mtx_sum=s_temp;
    end
    %高通滤波
    pic_h={};
    h_c=(1+height0)/2;%计算中心位置
    w_c=(1+width0)/2;
    passband=2;%通带半径
    for k=1:M
        for t=1:N
            if mtx(k,t)~=0
                temp0=im2double(pic{k,t});
                for ch=1:3
                    temp=temp0(:,:,ch);%转化为double型
                    temp=fftshift(fft2(temp));%傅里叶变换并将零频率移动到中心
                    for x=1:floor(width0/2)
                        x2=x^2;
                        for y=1:floor(height0/2)
                            y2=y^2;
                            if x2+y2<passband^2%位于通带外则截断
                                temp(floor(h_c+y),floor(w_c+x))=0;%实信号频谱对称，可以由一个象限填充其他
                                temp(floor(h_c+y),ceil(w_c-x))=0;
                                temp(ceil(h_c-y),floor(w_c+x))=0;
                                temp(ceil(h_c-y),ceil(w_c-x))=0;
                            end
                        end
                    end
                    temp=real(ifft2(ifftshift(temp)));%傅里叶逆变换得到处理后的图像
                    temp0(:,:,ch)=temp;
                end
                pic_h{k,t}=temp0;
            end
        end
    end
        
    %消去一对
    max_value=0;%维护相关系数最大值
    max_pair=[0,0,0,0];
    for m=1:M*N
        row1=ceil(m/N);%遍历所有图像对的组合
        col1=m-N*(row1-1);
        if mtx(row1,col1)~=0
            for n=m+1:M*N
                row2=ceil(n/N);
                col2=n-N*(row2-1);
                if mtx(row2,col2)~=0 & judge(previous,row1,col1,row2,col2)==1
                    if detect(mtx,row1,col1,row2,col2)==1
                        s=(similarity(pic_h{row1,col1}(:,:,1),pic_h{row2,col2}(:,:,1))+...
                        similarity(pic_h{row1,col1}(:,:,2),pic_h{row2,col2}(:,:,2))+...
                        similarity(pic_h{row1,col1}(:,:,3),pic_h{row2,col2}(:,:,3)));
                        if s>max_value
                            max_value=s;
                            max_pair=[row1,col1,row2,col2];
                        end
                    end
                end
            end
        end
    end
    click(180+(max_pair(2)-1)*40,180+(max_pair(1)-1)*50);
    click(180+(max_pair(4)-1)*40,180+(max_pair(3)-1)*50);
    previous=[previous;max_pair];
    pause(0.3);
end
handles.text1.String='游戏结束！';