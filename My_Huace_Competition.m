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

% Last Modified by GUIDE v2.5 21-Mar-2018 21:44:50

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
guidata(hObject, handles);
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NVDI=double(handles.B-handles.R)./double(handles.B+handles.R)+0.1; % NDVI 表示归一化差值植被指数，加0.1是为了将负值变为正值，便于二值化选区阈值
MNDWI=double(handles.G-handles.R)./double(handles.G+handles.R); % MNDWI表示改进的归一化差值水体指数，用来识别河流等目标
BinaryNVDI=~imbinarize(NVDI); % 将计算结果二值化
BinaryMNDWI=imbinarize(MNDWI);
result = BinaryNVDI&BinaryMNDWI;
axes(handles.axes2); cla; imshow(result);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BLUE=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band2.tif'); %读取蓝光通道
GREEN=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band3.tif'); %读取绿光通道
RED=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band4.tif'); %读取红光通道
NIR=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band5.tif'); %读取红外波段反射值
SWIR2=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band7.tif'); %读取中红外波段反射值
NVDI=double(NIR-RED)./double(NIR+RED)+0.1; % NDVI 表示归一化差值植被指数，加0.1是为了将负值变为正值，便于二值化选区阈值
MNDWI=double(GREEN-SWIR2)./double(NIR+SWIR2); % MNDWI表示改进的归一化差值水体指数，用来识别河流等目标
BinaryNVDI=imbinarize(NVDI); % 将计算结果二值化
BinaryMNDWI=imbinarize(MNDWI);
% BinaryNVDI=imrotate(BinaryNVDI,11.2,'bilinear'); %旋转图像使其不再倾斜
result(:,:,1)=BinaryNVDI*255;
result(:,:,2)=BinaryNVDI*0;
result(:,:,3)=BinaryMNDWI*255;
I(:,:,1)=uint8(RED/8); % 将图片RGB通道数据内型转换为unsigned int8以节省内存空间
I(:,:,2)=uint8(GREEN/8);
I(:,:,3)=uint8(BLUE/8);
axes(handles.axes1); cla; imshow(I);
axes(handles.axes2); cla; imshow(result);
set(handles.uipanel3,'visible','on');