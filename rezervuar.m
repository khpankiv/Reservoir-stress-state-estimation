function varargout = rezervuar(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @rezervuar_OpeningFcn, ...
    'gui_OutputFcn',  @rezervuar_OutputFcn, ...
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


% --- Executes just before rezervuar is made visible.
function rezervuar_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rezervuar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rezervuar_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on button press in btnobch.
function btnobch_Callback(hObject, eventdata, handles)
if get(handles.rbzgl,'Value')
    typ=1;
end
if get(handles.rbspl,'Value')
    typ=0;
end
nm=str2double(get(handles.edkstkut,'String'));
nn=str2double(get(handles.edkstvys,'String'));
shov=get(handles.shvy,'Value');
[handles.nap,handles.koo, handles.v1]=Napruz(handles.filedata,typ,nm,nn,shov);
n=size(handles.koo);
nm=n(3);
nn=n(2);
set(handles.edkstkut,'String',nm);
set(handles.edkstvys,'String',nn);
guidata(gcbo,handles);
set(handles.btngraf,'Enable','on');
set(handles.pbvybsave,'Enable','on');


% --- Executes on key press with focus on btnobch and none of its controls.
function btnobch_KeyPressFcn(hObject, eventdata, handles)


% --- Executes on button press in btnmodel.
function btnmodel_Callback(hObject, eventdata, handles)
grafic;


% --- Executes on key press with focus on btnmodel and none of its controls.
function btnmodel_KeyPressFcn(hObject, eventdata, handles)


% --- Executes on button press in btnsave.
function btnsave_Callback(hObject, eventdata, handles)
nap=handles.nap;
koo=handles.koo;
fuf=handles.filesave;
save (fuf, 'nap', 'koo');


function eddata_Callback(hObject, eventdata, handles)



% --- Executes on button press in btnopen.
function btnopen_Callback(hObject, eventdata, handles)
[fname,pname]=uigetfile('*.mat');
if fname~=0
    handles.filedata=[pname fname];
    set(handles.eddata,'String',handles.filedata);
    set(handles.btnmodel,'enable','on');
    set(handles.btnobch,'enable','on');
    set(handles.btngraf,'Enable','off');
    set(handles.pbvybsave,'Enable','off');
    set(handles.btnsave,'Enable','off');
    guidata(gcf,handles);
end


function edsave_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edsave_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbvybsave.
function pbvybsave_Callback(hObject, eventdata, handles)
[filename pathname]=uiputfile('*.mat');
handles.filesave=[pathname filename];
set(handles.edsave,'string',handles.filesave);
set(handles.btnsave,'enable','on');
guidata(gcbo,handles);



function edkut_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edkut_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edvys_Callback(hObject, eventdata, handles)


function edvys_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function panelvyv_SelectionChangeFcn(hObject, eventdata, handles)
if get(handles.rbpov,'Value')
    set(handles.edkut,'enable','off')
    set(handles.edvys,'enable','off')
end
if get(handles.rbkut,'Value')
    set(handles.edkut,'enable','off')
    set(handles.edvys,'enable','on')
end
if get(handles.rbvys,'Value')
    set(handles.edkut,'enable','on')
    set(handles.edvys,'enable','off')
end

function eddata_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function eddata_ButtonDownFcn(hObject, eventdata, handles)


function eddata_KeyPressFcn(hObject, eventdata, handles)


function btngraf_Callback(hObject, eventdata, handles)
load (handles.filedata);
axes(handles.graf);
if get(handles.rbpov,'Value')
    cla;
    reset(gca);
    z(:,:)=handles.koo(2,:,:);
    x(:,:)=handles.koo(3,:,:).*cos(handles.koo(1,:,:));
    y(:,:)=-handles.koo(3,:,:).*sin(handles.koo(1,:,:));
    if get(handles.rbn11,'Value')
        n(:,:)=handles.nap(1,:,:);
    end
    if get(handles.rbn22,'Value')
        n(:,:)=handles.nap(2,:,:);
    end
    if get(handles.rbn33,'Value')
        n(:,:)=handles.nap(3,:,:);
    end
    if get(handles.rbn12,'Value')
        n(:,:)=handles.nap(4,:,:);
    end
    if get(handles.rbn13,'Value')
        n(:,:)=handles.nap(5,:,:);
    end
    if get(handles.rbn23,'Value')
        n(:,:)=handles.nap(6,:,:);
    end
    if get(handles.rbni,'Value')
        n(:,:)=handles.nap(7,:,:);
    end
    surf(x,y,z,n,'EdgeColor','none');
    axis off;
    title('Розподіл напружень по поверхні стінки, МПа');
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
    hold on;
    for i=1:n1
        it=num2str(i);
        text(xxxl(1,i),yyyl(1,i),it);
    end
    n1=n1+1;
    nv=length(handles.v1);
    for i=2:nv
        z1(1:n1)=sum(handles.v1(1:i))-handles.v1(1)*0.75;
        y1(1:n1)=rr2(1,1:n1).*sin(ff2(1,1:n1));
        x1(1:n1)=rr2(1,1:n1).*cos(ff2(1,1:n1));
        plot3(x1,y1,z1,'color','white','linewidth',1);
        hold on;
    end
%     colormap('gray')
    colorbar;
    rotate3d on;
end

if get(handles.rbkut,'Value')
    cla;
    reset(gca);
    rotate3d off;
    sz=size(handles.koo(2,:,:));
    n1=sz(3);
    vys=get(handles.edvys,'string');
    jj=find ((handles.koo(2,:,1))<=vys);
    j=length(jj);
    if isempty(jj)
        j=1;
    end
    if get(handles.rbn11,'Value')
        nf(1:n1)=handles.nap(1,j,:);
    end
    if get(handles.rbn22,'Value')
        nf(1:n1)=handles.nap(2,j,:);
    end
    if get(handles.rbn33,'Value')
        nf(1:n1)=handles.nap(3,j,:);
    end
    if get(handles.rbn12,'Value')
        nf(1:n1)=handles.nap(4,j,:);
    end
    if get(handles.rbn13,'Value')
        nf(1:n1)=handles.nap(5,j,:);
    end
    if get(handles.rbn23,'Value')
        nf(1:n1)=handles.nap(6,j,:);
    end
    if get(handles.rbni,'Value')
        nf(1:n1)=handles.nap(7,j,:);
    end
    f(1:n1)=handles.koo(1,j,:);
    polar(f,nf+10);
    title('Напруження зсунуті на 10 МПа');
end

if get(handles.rbvys,'Value')
    cla;
    reset(gca);
    kut=str2double(get(handles.edkut,'string'));
    kut=kut*pi/180;
    jj=find ((handles.koo(1,1,:))<=kut);
    j=length(jj);
    if isempty(jj)
        j=1;
    end
    if get(handles.rbn11,'Value')
        ns=handles.nap(1,:,j);
    end
    if get(handles.rbn22,'Value')
        ns=handles.nap(2,:,j);
    end
    if get(handles.rbn33,'Value')
        ns=handles.nap(3,:,j);
    end
    if get(handles.rbn12,'Value')
        ns=handles.nap(4,:,j);
    end
    if get(handles.rbn13,'Value')
        ns=handles.nap(5,:,j);
    end
    if get(handles.rbn23,'Value')
        ns=handles.nap(6,:,j);
    end
    if get(handles.rbni,'Value')
        ns=handles.nap(7,:,j);
    end
    x=handles.koo(2,:,j);
    plot(x,ns);
    ylabel('Напруження, МПа');
    xlabel('Висота, м');
    rotate3d off;
end

function edkstvys_Callback(hObject, eventdata, handles)
set(handles.btngraf,'Enable','off');
set(handles.pbvybsave,'Enable','off');
set(handles.btnsave,'Enable','off');
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function edkstvys_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edkstkut_Callback(hObject, eventdata, handles)
set(handles.btngraf,'Enable','off');
set(handles.pbvybsave,'Enable','off');
set(handles.btnsave,'Enable','off');
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function edkstkut_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in shvy.
function shvy_Callback(hObject, eventdata, handles)
set(handles.btngraf,'Enable','off');
set(handles.pbvybsave,'Enable','off');
set(handles.btnsave,'Enable','off');
guidata(gcbo,handles);

function panelaprox_SelectionChangeFcn(hObject, eventdata, handles)
set(handles.btngraf,'Enable','off');
set(handles.pbvybsave,'Enable','off');
set(handles.btnsave,'Enable','off');
guidata(gcbo,handles);
