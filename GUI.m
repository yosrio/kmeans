function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 22-Oct-2020 20:33:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[baseName, folder] = uigetfile();
fullFileName = fullfile(folder, baseName);
dt = xlsread(fullFileName);
set(handles.uitable3,'Data',dt);
handles.dt = dt;
handles.data = dt;
guidata(hObject,handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
numberOfClust = str2num(handles.numberOfClust);
typeDistance = handles.typeDistance;
typeCentroid = handles.typeCentroid;
data = handles.data;

[iteration, result, distCentroid, centroid] = kmeans2(data, numberOfClust, typeCentroid, typeDistance);

eva = evalclusters(data,result,'silhouette');
optimal = eva.CriterionValues(1);

myString = sprintf('Evalution: %f', optimal);
set(handles.text6, 'String', myString);
set(handles.uitable4,'Data',result);

silhouette(data,result)
axes(handles.axes2);

if(numberOfClust == 2)
    gscatter(data(:,1),data(:,2),result,'bg')
    hold on
    plot(centroid(:,1),centroid(:,2),'kx')
    hold off
    axes(handles.axes3);
elseif(numberOfClust == 3)
    gscatter(data(:,1),data(:,2),result,'bgm')
    hold on
    plot(centroid(:,1),centroid(:,2),'kx')
    hold off
    axes(handles.axes3);
end



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes during object creation, after setting all properties.
function uibuttongroup4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
dt = handles.dt;
tempData = dt;
switch(get(eventdata.NewValue,'Tag'));
    case 'radiobutton1'
        data = minMaxNorm(tempData);
        set(handles.uitable3,'Data',data);
        handles.data = data;
        guidata(hObject,handles);
    case 'radiobutton2'
        data = zscore(tempData);
        set(handles.uitable3,'Data',data);
        handles.data = data;
        guidata(hObject,handles);
    case 'radiobutton10'
        data = tempData;
        set(handles.uitable3,'Data',data);
        handles.data = data;
        guidata(hObject,handles);
end


% --- Executes when selected object is changed in uibuttongroup4.
function uibuttongroup4_SelectionChangedFcn(hObject, eventdata, handles)
switch(get(eventdata.NewValue,'Tag'));
    case 'radiobutton3'
        typeCentroid = get(handles.radiobutton3,'string');
        handles.typeCentroid = typeCentroid;
        guidata(hObject,handles);
    case 'radiobutton4'
        typeCentroid = get(handles.radiobutton4,'string');
        handles.typeCentroid = typeCentroid;
        guidata(hObject,handles);
    case 'radiobutton5'
        typeCentroid = get(handles.radiobutton5,'string');
        handles.typeCentroid = typeCentroid;
        guidata(hObject,handles);
    case 'radiobutton14'
        typeCentroid = get(handles.radiobutton14,'string');
        handles.typeCentroid = typeCentroid;
        guidata(hObject,handles);
end


% --- Executes when uibuttongroup5 is resized.
function uibuttongroup5_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uibuttongroup5.
function uibuttongroup5_SelectionChangedFcn(hObject, eventdata, handles)
switch(get(eventdata.NewValue,'Tag'));
    case 'radiobutton7'
        typeDistance = get(handles.radiobutton7,'string');
        handles.typeDistance = typeDistance;
        guidata(hObject,handles);
    case 'radiobutton8'
        typeDistance = get(handles.radiobutton8,'string');
        handles.typeDistance = typeDistance;
        guidata(hObject,handles);
    case 'radiobutton9'
        typeDistance = get(handles.radiobutton9,'string');
        handles.typeDistance = typeDistance;
        guidata(hObject,handles);
end


% --- Executes when selected object is changed in uibuttongroup6.
function uibuttongroup6_SelectionChangedFcn(hObject, eventdata, handles)
switch(get(eventdata.NewValue,'Tag'));
    case 'radiobutton11'
        numberOfClust = get(handles.radiobutton11,'string');
        handles.numberOfClust = numberOfClust;
        guidata(hObject,handles);
    case 'radiobutton12'
        numberOfClust = get(handles.radiobutton12,'string');
        handles.numberOfClust = numberOfClust;
        guidata(hObject,handles);
end
