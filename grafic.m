function varargout = grafic(varargin)
% GRAFIC MATLAB code for grafic.fig
%      GRAFIC, by itself, creates a new GRAFIC or raises the existing
%      singleton*.
%
%      H = GRAFIC returns the handle to a new GRAFIC or the handle to
%      the existing singleton*.
%
%      GRAFIC('CALLBACK',hObject,eventhandles.data,handles,...) calls the local
%      function named CALLBACK in GRAFIC.M with the given input arguments.
%
%      GRAFIC('Property','Value',...) creates a new GRAFIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before grafic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to grafic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIhandles.data, GUIHANDLES

% Edit the above text to modify the response to help grafic

% Last Modified by GUIDE v2.5 16-Mar-2013 14:50:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @grafic_OpeningFcn, ...
    'gui_OutputFcn',  @grafic_OutputFcn, ...
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


% --- Executes just before grafic is made visible.
function grafic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventhandles.data  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user handles.data (see GUIhandles.data)
% varargin   command line arguments to grafic (see VARARGIN)

% Choose default command line output for grafic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handres=guidata(rezervuar);
load (handres.filedata);
axes(handles.axes1)
rotate3d on;
cla;
x=rr1.*cos(ff1);
y=-rr1.*sin(ff1);
surf(x,y,ss1,rr1,'EdgeColor','none');
hold on;
sz=size(ss2);
n1=sz(2)-1;
n2=sz(1);
zzzl(1,1:n1)=ss1(1,1:n1);
zzzl(2,1:n1)=ss1(n2,1:n1);
yyyl(1,1:n1)=-rr1(1,1:n1).*sin(ff1(1,1:n1));
yyyl(2,1:n1)=yyyl(1,1:n1);
xxxl(1,1:n1)=rr1(1,1:n1).*cos(ff1(1,1:n1));
xxxl(2,1:n1)=xxxl(1,1:n1);
ll=line(xxxl,yyyl,zzzl);
set(ll,'color','white')
set(ll,'linewidth',1)
axis off;
hold on;
for i=1:n1
    it=num2str(i);
    text(xxxl(1,i),yyyl(1,i),it);
end
% colormap('gray')
colorbar;

axes(handles.axes2)
rotate3d on;
cla;
x=rr2.*cos(ff2);
y=-rr2.*sin(ff2);
surf(x,y,ss2,rr2,'EdgeColor','none');
hold on;
sz=size(ss2);
n1=sz(2)-1;
n2=sz(1);
zzzl(1,1:n1)=ss2(1,1:n1);
zzzl(2,1:n1)=ss2(n2,1:n1);
yyyl(1,1:n1)=-rr2(1,1:n1).*sin(ff2(1,1:n1));
yyyl(2,1:n1)=yyyl(1,1:n1);
xxxl(1,1:n1)=rr2(1,1:n1).*cos(ff2(1,1:n1));
xxxl(2,1:n1)=xxxl(1,1:n1);
ll=line(xxxl,yyyl,zzzl);
set(ll,'color','white')
set(ll,'linewidth',1)
axis off;
hold on;
for i=1:n1
    it=num2str(i);
    text(xxxl(1,i),yyyl(1,i),it);
end
% colormap('gray')
colorbar;
guidata(gcf,handles);

% UIWAIT makes grafic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = grafic_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventhandles.data  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user handles.data (see GUIhandles.data)

% Get default command line output from handles structure
varargout{1} = handles.output;
