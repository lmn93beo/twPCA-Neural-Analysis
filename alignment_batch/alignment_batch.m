function varargout = alignment_batch(varargin)
% ALIGNMENT_BATCH MATLAB code for alignment_batch.fig
%      ALIGNMENT_BATCH, by itself, creates a new ALIGNMENT_BATCH or raises the existing
%      singleton*.
%
%      H = ALIGNMENT_BATCH returns the handle to a new ALIGNMENT_BATCH or the handle to
%      the existing singleton*.
%
%      ALIGNMENT_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALIGNMENT_BATCH.M with the given input arguments.
%
%      ALIGNMENT_BATCH('Property','Value',...) creates a new ALIGNMENT_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before alignment_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to alignment_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help alignment_batch

% Last Modified by GUIDE v2.5 08-Nov-2017 16:36:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @alignment_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @alignment_batch_OutputFcn, ...
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


% --- Executes just before alignment_batch is made visible.
function alignment_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to alignment_batch (see VARARGIN)

% Choose default command line output for alignment_batch
handles.output = hObject;

global params
% Set up global parameters (constants)
params.times = [740, 760, 780, 800, 820, 840, 860, 1300, ...
    1340, 1380, 1420, 1460, 1500, 1540, 1580, 1620];
params.palette = [0.87021914648212229, 0.92132256824298342, 0.9685044213763937;
 0.77524029219530954, 0.85830065359477115, 0.93682429834678971;
 0.61725490196078436, 0.79086505190311418, 0.88184544405997689;
 0.41708573625528644, 0.68063052672049218, 0.83823144944252215;
 0.25628604382929643, 0.57001153402537486, 0.77516339869281048;
 0.1271049596309112, 0.44018454440599769, 0.70749711649365632;
 0.031372549019607843, 0.3140945790080738, 0.60648981161091897;
 0.99692425990003841, 0.89619377162629754, 0.84890426758938864;
 0.99137254901960792, 0.79137254901960785, 0.70823529411764707;
 0.9882352941176471, 0.67154171472510571, 0.56053825451749328;
 0.98745098039215684, 0.54117647058823526, 0.41568627450980394;
 0.98357554786620527, 0.4127950788158401, 0.28835063437139563;
 0.94666666666666666, 0.26823529411764707, 0.19607843137254902;
 0.85033448673587075, 0.14686658977316416, 0.13633217993079583;
 0.7364705882352941, 0.080000000000000002, 0.10117647058823528;
 0.59461745482506734, 0.046136101499423293, 0.075586312956555157];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes alignment_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = alignment_batch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global params
id = min(floor(get(hObject, 'Value')), 104);

% Load the aligned activity
align_filename = ['../neuron' num2str(id) '_init_linear_warp_affine_recons.csv'];
aligned = csvread(align_filename);

% Loop through with the appropriate color
axes(handles.align_axes);
for i = 1:16
    plot((1:size(aligned, 2)) * 40, aligned(i,:), ...
        'Color', params.palette(i,:));
    hold on;
end
hold off;
xlabel('Time (ms)');
ylabel('Normalized PSTH');
title('PSTH after alignment')

warp_filename = ['../neuron' num2str(id) '_init_linear_warp_affine_warp2.csv'];
warpN = csvread(warp_filename);
slope = size(warpN, 2)./(warpN(:,end) - warpN(:,1));
axes(handles.warp_axes);
scatter(params.times, slope, 'filled');
xlim([0, 1700]);
ylim([0, 1.2]);
xlabel('Time (ms)');
ylabel('Stretch');
title('Warps at different trial lengths')

set(handles.neuronID_txt, 'String', num2str(id));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
