function varargout = My_Huace_Competition(varargin)
% MY_HUACE_COMPETITION MATLAB code for My_Huace_Competition.fig
%      MY_HUACE_COMPETITION, by itself, creates a new MY_HUACE_COMPETITION or raises the existing
%      singleton*.
%
%      H = MY_HUACE_COMPETITION returns the handle to a new MY_HUACE_COMPETITION or the handle to
%      the existing singleton*.
%
%      MY_HUACE_COMPETITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_HUACE_COMPETITION.M with the given input arguments.
%
%      MY_HUACE_COMPETITION('Property','Value',...) creates a new MY_HUACE_COMPETITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before My_Huace_Competition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to My_Huace_Competition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help My_Huace_Competition

% Last Modified by GUIDE v2.5 23-Mar-2018 16:17:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @My_Huace_Competition_OpeningFcn, ...
                   'gui_OutputFcn',  @My_Huace_Competition_OutputFcn, ...
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


% --- Executes just before My_Huace_Competition is made visible.
function My_Huace_Competition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to My_Huace_Competition (see VARARGIN)
axes(handles.axes1); cla; set(handles.axes1,'Visible','off');
axes(handles.axes2); cla; set(handles.axes2,'Visible','off');
set(handles.uipanel3,'visible','off');
set(handles.uipanel4,'visible','off');
handles.isslide = 0; % 判断是否滑动滑块的逻辑值
handles.realtime = 0; % 判断是否实时响应的逻辑值
% Choose default command line output for My_Huace_Competition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes My_Huace_Competition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = My_Huace_Competition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%打开文件对话框获得图片路径
[FileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Load Image File');
if (~FileName)% 打开文件界面按下取消
    return;
end
handles.FileLoad = 1;
handles.fullPath = [PathName FileName];
handles.RGB = imread(handles.fullPath);
handles.R = handles.RGB(:,:,1);
handles.G = handles.RGB(:,:,2);
handles.B = handles.RGB(:,:,3);
axes(handles.axes1); cla; imshow(handles.RGB);
set(handles.uipanel3,'visible','off');
axes(handles.axes2); cla;
guidata(hObject, handles);
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel4,'visible','on');
NVDI=double(handles.B-handles.R)./double(handles.B+handles.R); % NDVI 表示归一化差值植被指数，该值越大，表示植被的可能性越大
MNDWI=double(handles.G-handles.R)./double(handles.G+handles.R); % MNDWI表示改进的归一化差值水体指数，用来识别河流等目标
BinaryNVDI=~imbinarize(NVDI); % 将计算结果二值化，被分配为1的部分即NDVI大的部分，取反就表示不透水面可能性更大的部分，这是逆向思维
BinaryMNDWI=~imbinarize(MNDWI);
if handles.isslide
BinaryMNDWI = MNDWI>handles.slidevalue;
end
result = BinaryMNDWI&BinaryNVDI;
axes(handles.axes2); cla; imshow(result);
if handles.realtime
    handles.isslide = 0;
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band2.tif','file')
    msgbox('该功能用来实现真正的多光谱遥感数据分析，所需数据为包括RGB、近红外、中红外等波段在内的多光谱遥感数据，由于数据文件较大（1.02GB）不便于上传，故将处理结果以截图的形式放在了附件中，请查收。','没有找到相应的遥感数据文件','error');
else
BLUE=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band2.tif'); %读取蓝光通道
GREEN=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band3.tif'); %读取绿光通道
RED=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band4.tif'); %读取红光通道
NIR=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band5.tif'); %读取红外波段反射值
SWIR2=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band7.tif'); %读取中红外波段反射值
NVDI=double(NIR-RED)./double(NIR+RED); % NDVI 表示归一化差值植被指数
MNDWI=double(GREEN-SWIR2)./double(NIR+SWIR2); % MNDWI表示改进的归一化差值水体指数，用来识别河流等目标
BinaryNVDI=NVDI>0.65; % 将计算结果大于0.65的部分定为很可能是透水面的部分，参数0.65的选定是查阅资料以及调试程序修改得到
clear NVDI; % 及时释放内存以减少峰值内存占用
BinaryMNDWI=imbinarize(MNDWI); % 水系可以直接用二值化的方式确定阈值
clear MNDWI; % 及时释放内存以减少峰值内存占用
% BinaryNVDI=imrotate(BinaryNVDI,11.2,'bilinear'); %旋转图像使其不再倾斜
I(:,:,1)=uint8(RED/10); % 将图片RGB通道数据内型转换为unsigned int8以节省内存空间
I(:,:,2)=uint8(GREEN/10); % 参数10的选定是根据数据的直方图分布分析找出最大值，转换为0-255范围除以10比较合适
I(:,:,3)=uint8(BLUE/10);
IsCLOUD=(uint16(I(:,:,1))+uint16(I(:,:,2))+uint16(I(:,:,3)))>750; % 亮度过高的部分定为云层
result(:,:,1)=uint8(BinaryNVDI*255);
clear BinaryNVDI; % 及时释放内存以减少峰值内存占用
BinaryCLOUD=imerode(IsCLOUD,strel('disk',1)); % 将云层识别结果进行二值化图像腐蚀以达到去噪效果
clear IsCLOUD; % 及时释放内存以减少峰值内存占用
result(:,:,2)=uint8(BinaryCLOUD*255);
result(:,:,3)=uint8(BinaryMNDWI*255);
clear BinaryMNDWI; % 及时释放内存以减少峰值内存占用
% imwrite(result,'D:\huace\result.jpg'); % 将解析结果输出为jpg图片
axes(handles.axes1); cla; imshow(I);
axes(handles.axes2); cla; imshow(result);
set(handles.uipanel3,'visible','on');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.editvalue = str2double(get(hObject,'String'));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Min', 0.001);
set(hObject,'Max', 0.3);
handles.slidevalue = get(hObject,'Value');
handles.isslide = 1;
guidata(hObject, handles);
if handles.realtime
pushbutton2_Callback(hObject, eventdata, handles);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value', 0.1);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject, handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.realtime = get(hObject,'Value');
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox1
