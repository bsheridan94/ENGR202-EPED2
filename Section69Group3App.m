%% Brian Sheridan & Mike Volpe Group 3 Section 69
%%
% Our application is going to be a port of the popular online flash game
% 2048. The goal of the game is to slide the slide that all the tiles at
% once in either up down left or right direction. Each time you swipe in a
% direction a new tile is added. When two tiles that are the same bump each
% other they combine to form the sum of their numbers. The goal is to add
% up as many of the tiles till you reach a till with the number 2048.

% The app willuse the accelerometer to choose the direction in which the
% user wishes to swipe. If they want to slide the tiles down they would
% move the accelerometer downward in a quick movement, if they wished to
% slide left they would move the accelerometer left in a fast mostion, ect
% ect. The user will only need to use the controls on the GUI if they wish
% to pause, save, load, or reset game, or undo a step, .

% The overall design of our GUI is  listed below:

% There is a control panel on the left hand side which contains our start
% serial and calibrate button, start/stop data sampling toggle button, stop
% serial push button, reset game push button, save game push button, load 
% game push button, and undo last move push button. The start/stop button
% will start and pause the game at any moment. The reset game button 
% will be used to reset the game board at the end of the game or when ever 
% the user wishes to start a new game. The save button will take the data 
% of the current game and store it for later use. The load button will take
% the saved data and reload it, allowing the player to continue where
% he/she left off. Lastly, undo last move button is used to go back a move 
% incase they make a mistake. The panel also displays a move counter, which
% keeps track of all the moves in the current game. 
% Beneath the control panel are the filter settings and a filter value,
% which the user can set and customize depending on their preference. 

% The right side of the app contains a graph: a rolling plot of the 
% magnitude of the result graph. It also contains a text box giving the 
% instructions on how to play the game. 

% On the top there is a text box which will keep the current score in.
% The score is generated through adding up all the tiles. It also shows the
% current high score, which is achieved by saving the score of the highest
% scoring game until it was reseted or the user reached a game over. This
% is also placed in a text box. 

% The bottom of the app shows the threshold panel that displays the current
% threshold (which can be inputed by the user). The threshold is how
% sensitive the user would like the accelerometer to be to movement. It
% also displays the filter status and the direction the tiles will slide
% based on the accelerometer's movement. When it is stationary, it will
% read "Center", but when jerked left, the text will read "Left".

% The middle of the app has a plot, which we will use to visualize the
% tiles on the board. The app plots lines on there to form boxes and plot
% text in the respective tile spaces to represent. The tiles will only
% slide into each other if they equal the same set value; the tiles will
% then dissappear and generate a new tile (which equals the sum of the two
% tiles). Each tile has a different color to make it look different from
% the rest


function varargout = Section69Group3App(varargin)
% SECTION69GROUP3APP MATLAB code for Section69Group3App.fig
%      SECTION69GROUP3APP, by itself, creates a new SECTION69GROUP3APP or raises the existing
%      singleton*.
%
%      H = SECTION69GROUP3APP returns the handle to a new SECTION69GROUP3APP or the handle to
%      the existing singleton*.
%
%      SECTION69GROUP3APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION69GROUP3APP.M with the given input arguments.
%
%      SECTION69GROUP3APP('Property','Value',...) creates a new SECTION69GROUP3APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section69Group3App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section69Group3App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section69Group3App

% Last Modified by GUIDE v2.5 29-Aug-2014 19:39:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section69Group3App_OpeningFcn, ...
                   'gui_OutputFcn',  @Section69Group3App_OutputFcn, ...
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


% --- Executes just before Section69Group3App is made visible.
function Section69Group3App_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section69Group3App (see VARARGIN)



%selectes the backround axes
 axes(handles.backround)
 %loads the image backround from folder
backroundimage = imread('backround.jpg');
%assigns the backround image to the plot backround
image(backroundimage);

%selectes the gamewindow axes
axes(handles.gameWindow)
% Choose default command line output for Section69Group3App
handles.output = hObject;

%All this code was moved to the top to inialize the rolling plot and
%variables as soon as the application is opened. 
handles.buf_len = 200;

%intializes the values which will store x and y values for threshold
%checking based on filter selection
handles.gxThres=0;
handles.gyThres=0;



% initializes the intial values for the alpha filtered values x y z and mag
handles.filtX=0;
handles.filtY=0;
handles.filtZ=0;

% alpha is intially assigend to 0.5, window size for moving average is 10
% data points
handles.alpha=0.5;
handles.windowSize=10;



% intializes all the threshold status flags for xy axis
handles.signalHighX=0;
handles.signalHighY=0;
handles.signalLowX=0;
handles.signalLowY=0;

% intializes the varibale for move direction as 0, not moving
handles.move=0;



% the intial threshold value is set to .75
set(handles.EditThresholdValue,'String','.75');
% Threshold is assgined to the value of the editable textbox containing the
% threshold
handles.threshold=str2num(get(handles.EditThresholdValue,'String'));
%Threshold data array is filled with zeros.
handles.thresholddata = zeros(handles.buf_len,1);
% win flag is inialized as false
handles.win=0


%gamewindow axes is selected
axes(handles.gameWindow)
%axis dimensions are declared as 0 to 4 x and 0 to 4 y
axis([0 4 0 4])

%intilaizes gameboard as blank with all 0 tiles
handles.gameboard=[ 0 0 0 0;  0 0 0 0;  0 0 0 0; 0 0 0 0];
%calls add random tile to add the starting tile to the board
handles.gameboard=addNewTile(handles.gameboard)
%Plots the gameboard on the plot gameWindow
plotGameBoard(handles.gameboard)
%Opens highschore.txt 
fileID = fopen('highScore.txt','r');
%assigns the read in format as integers
formatSpec = '%d';
%Fills matrix A with intenger from file
A = fscanf(fileID,formatSpec,inf)
%closes file highscore.txt
fclose(fileID);
%assigns highscore value display as the integer stored in A
set(handles.highScoreValue,'String',num2str(A(1)));

%current score is set to zero and displayed on the gui
set(handles.scoreValue,'String','0')

%pastmoves is initialized as the starting gameboard
handles.pastMoves=handles.gameboard

%editable threshold is intially set at .75
set(handles.EditThresholdValue,'String','.75')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section69Group3App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section69Group3App_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in CalibrateAccelerometer.
function CalibrateAccelerometer_Callback(hObject, eventdata, handles)
% hObject    handle to CalibrateAccelerometer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.comPort = 'COM21';%This can be found out using the device manager (Windows)
                  %On a mac type ls /dev/tty* in Terminal and 
                  %  identify the device that is listed as usbmodem
                  %  Example for a MAC comPort = '/dev/tty.usbmodemfa131';

%comPort = '/dev/tty.usbmodemfd121';
if (~exist('serialFlag','var'))
 [handles.accelerometer.s ,handles.serialFlag] = setupSerial(handles.comPort);
end
if(~exist('calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
end
% Update handles structure
guidata(hObject, handles);

% This button calibrates checks the com port and sets up serial
% communication with the arduino and accelerometer, and creates an
% accelerometer object which it then runs the calibration routine.






% --- Executes on button press in StopSerial.
function StopSerial_Callback(hObject, eventdata, handles)
% hObject    handle to StopSerial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% this clears all , and clears all varaibles
clc
clear all
% this closes the serial connection and then close all and clc again. then
% displays that the serial port has been closed.
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
close all
clc
disp('Serial Port Closed')

% This button closes the serial connection when the user wishes to end the app and then it closes the app.




% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartButton
% initialize str and buf_len
handles.str=get(handles.StartButton,'String');


%Magnitude data has been left in all the spots to allow for it to be added
%in if i choose to continue development.

% create variables for all the three axis and the resultant 
handles.gxdata = zeros(handles.buf_len,1);
handles.gydata = zeros(handles.buf_len,1);
handles.gzdata = zeros(handles.buf_len,1);
handles.magnitudeData = zeros(handles.buf_len,1);
handles.index = 1:handles.buf_len;


% create the Alpha Filter Parameters
handles.filtXData=zeros(handles.buf_len,1);
handles.filtYData=zeros(handles.buf_len,1);
handles.filtZData=zeros(handles.buf_len,1);
handles.filtMagData=zeros(handles.buf_len,1);

% create the Moving Average Filter Parameters
%handles.alpha=get(handles.Slider,'value');
handles.movXData=zeros(handles.buf_len,1);
handles.movYData=zeros(handles.buf_len,1);
handles.movZData=zeros(handles.buf_len,1);
handles.movMagData=zeros(handles.buf_len,1);

%this if statement checks the text in the toggle botton StartButton. If the
% test is equal to start, it changes the text to stop, the color to red. if
% it is not start, it changes the the text to start and the color to green.
if strcmp(handles.str,'Start');
    set(handles.StartButton,'String','Stop');
      set(handles.StartButton, 'BackgroundColor',[1 0 0]);
    guidata(hObject,handles);
    
else
   set(handles.StartButton,'String','Start');
     set(handles.StartButton, 'BackgroundColor',[0 1 0]);
     set(handles.FilterStatusValue,'String','Not Running');
   guidata(hObject,handles);
end

% This while loop checks that the text of the toggle button is stop, and if
% it is, it will read in the accelerometer data and plot the rolling plot
% of the resultant magnitude and the xyz magnitude rolling plot. once the
% toggle button is toggled, and the text changes back to stop, the while
% loop will stop and will stop plotting the graphs. starting the sampling
% again will then reset the sampled data graph.

while(strcmp(get(handles.StartButton,'String'),'Stop'))
    
    % Get the new values from the accelerometer
    [handles.gx handles.gy handles.gz] = readAcc(handles.accelerometer,handles.calCo);

% checks if the selected filter is the low pass filter, if so  alpha is
% assigned the current value of the slider used to select the numerical
% value for the alpha coefficent.
    if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'lowPassFilter')==1)
     handles.alpha=get(handles.Slider,'Value');
    end
    
   
    % the filtered values for x y and z are calculed here based on alpha
    % previous filt values and the accelerometer data
    handles.filtX = ...
        (1-handles.alpha)*handles.filtX + handles.alpha*handles.gx;
      handles.filtY = ...
        (1-handles.alpha)*handles.filtY + handles.alpha*handles.gy;
      handles.filtZ = ...
        (1-handles.alpha)*handles.filtZ + handles.alpha*handles.gz;
  
    
    % Calculate the magnitude of the accelerometer axis readings
    handles.magnitude=sqrt( handles.gx^2+ handles.gy^2+ handles.gz^2);
        % Calculate the alpha filtered magnitude of the accelerometer axis readings
    handles.filtMag=sqrt( handles.filtX^2+ handles.filtY^2+ handles.filtZ^2);
    
    % checks if the selected filter is the Moving Average Filetr, if so  the window size is
    % assigned the current value of the display of the slider value, which is the slider value multiplied by 20 and rounded up. 
    % window size is the sample size of the moving average
    
       if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'movingAverageFilter')==1)
            handles.windowSize=str2num(get(handles.sliderValue,'String'));
       end
   
    % The x y z and mag componeents for moving average are calculated here
    % based on the mean of the windows size of data.
    handles.movX= mean(handles.gxdata(length(handles.gxdata): -1:length(handles.gxdata)-handles.windowSize+1));
    handles.movY= mean(handles.gydata(length(handles.gxdata): -1:length(handles.gydata)-handles.windowSize+1));
    handles.movZ= mean(handles.gzdata(length(handles.gzdata): -1:length(handles.gzdata)-handles.windowSize+1));
    handles.movMag= mean(handles.magnitudeData(length(handles.magnitudeData): -1:length(handles.magnitudeData)-handles.windowSize+1));
    
  
    %Threshold data is appened with the current value for the threshold and
    %the first value is dropped
    handles.thresholddata = [handles.thresholddata(2:end) ; handles.threshold];
    
     % Append the new reading to the end of the rolling plot data. Drop the
    % first value
    handles.gxdata = [handles.gxdata(2:end) ; handles.gx];
    handles.gydata = [handles.gydata(2:end) ; handles.gy];
    handles.gzdata = [handles.gzdata(2:end) ; handles.gz];    
    handles.magnitudeData = [handles.magnitudeData(2:end) ; handles.magnitude];
    
      % Append the new reading for filtered data to the end of the rolling plot data. Drop the
    % first value
    handles.filtXData = [handles.filtXData(2:end) ; handles.filtX];
    handles.filtYData = [handles.filtYData(2:end) ; handles.filtY];
     handles.filtZData = [handles.filtZData(2:end) ; handles.filtZ];
    handles.filtMagData = [handles.filtMagData(2:end) ; handles.filtMag];
       
      % Append the new reading  for moving average data to the end of the rolling plot data. Drop the
    % first value
     handles.movXData = [handles.movXData(2:end) ; handles.movX];
    handles.movYData = [handles.movYData(2:end) ; handles.movY];
     handles.movZData = [handles.movZData(2:end) ; handles.movZ];
    handles.movMagData = [handles.movMagData(2:end) ; handles.movMag];
    
 
    % These if statements check which of the current radio buttons for the filters are
    % selected. based on the currently selected filter, its respective
    % magnitude is used to determine if the threshold has been crossed.
    
    % check and use no filter magnitude, magnitude, gx, gy
    if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'noFilter')==1)
 handles.magnitudeThreshold=handles.magnitude;
 handles.gxThres=handles.gx
  handles.gyThres=handles.gy
    end 
   % check and use lowpassfilter magnitude, filtMag Filtx, Filty  
    if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'lowPassFilter')==1)
 handles.magnitudeThreshold=handles.filtMag;
  handles.gxThres=handles.filtX
   handles.gyThres=handles.filtY
 
    end 
    % check and use moving average magnitude, movMag, movX, movY
    if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'movingAverageFilter')==1)
  handles.magnitudeThreshold=handles.movMag;
   handles.gxThres=handles.movX
   handles.gyThres=handles.movY
    end 
    
 
    
    
    %threshold value is determined from user editable text box containg
    %value
    handles.threshold=str2num(get(handles.EditThresholdValue,'String'));
  
 
    % subplot for x y z magnitude on the XYZMagnitude graph on the GUI
    axes(handles.XYZMagnitude)
    
    
    % Checks the currently selected filter as specified above, and then
    % graphs the x y z components that were calculated for the repsecitve
    % filter and also sets the status of which filter is being graphed in
    % the text box in the upper right corner, as well as edits the slider
    % text to indicate what the slider value changes.
    
    
    
    % plots the no filter components, sets filter status to no filter, and
    % sets slider name to no filter value
        if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'noFilter')==1)
plot(handles.index,handles.gxdata,'r', handles.index,handles.gydata,'g');
 set(handles.FilterStatusValue,'String',get(get(handles.filterRadioGroup,'SelectedObject'),'String'));
 set(handles.SliderName,'String','No Filter Value');
    end 
      % plots the low pass filter components, sets filter status to low pass filter, and
    % sets slider name to low pass filter alpha value
   if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'lowPassFilter')==1)
 plot(handles.index,handles.filtXData,'r', handles.index,handles.filtYData,'g');
 set(handles.FilterStatusValue,'String',get(get(handles.filterRadioGroup,'SelectedObject'),'String'));
 set(handles.SliderName,'String','Low Pass Filter Alpha Value:');
   end 
     % plots the moving average filter components, sets filter status to moving average filter, and
    % sets slider name to moving average window size
   if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'movingAverageFilter')==1)
 plot(handles.index,handles.movXData,'r', handles.index,handles.movYData,'g');
 set(handles.FilterStatusValue,'String',get(get(handles.filterRadioGroup,'SelectedObject'),'String'));
 set(handles.SliderName,'String','Moving Average Window Size:');
   end 
    
    axis([1 handles.buf_len -3.5 3.5]);  
   % writes the x axis label as time
    xlabel('time');
    % writes the y axis label
    ylabel('Magnitude of individual axes acceleration');
    % writes the title for the graph
     title('Magnitude of Individual Axes X, Y');

     
     
     
     
     
     
     
     %checks if gxThres is greater than threshold and it has not already
     %been reached
     if handles.gxThres > str2num(get(handles.EditThresholdValue,'String')) && handles.signalHighX==0 
         %signal high is set to one indicate threshold has been tripped
handles.signalHighX=1;
%sets threshold status to down to signifgy down has been reached
set(handles.ThresholdStatusValue,'String','Down');

%else it checks if gx is less than threshold value, and that the signal has
%alread been reached, indicating the threshold had been breached downawards
 elseif handles.gxThres < str2num(get(handles.EditThresholdValue,'String')) && handles.signalHighX==1
     %resets signal high
handles.signalHighX=0;
%sets move to 2 to indicated down
handles.move=2;
%resets status back to center 
set(handles.ThresholdStatusValue,'String','Center');
     else
     end
     
      %checks if gyThres is greater than threshold and it has not already
     %been reached
       if handles.gyThres > str2num(get(handles.EditThresholdValue,'String')) && handles.signalHighY==0 
            %signal high is set to one indicate threshold has been tripped
handles.signalHighY=1;
%sets threshold status to left to signifgy down has been reached
set(handles.ThresholdStatusValue,'String','Left');
 
%else it checks if gy is less than threshold value, and that the signal has
%alread been reached, indicating the threshold had been breached downawards
       elseif handles.gyThres < str2num(get(handles.EditThresholdValue,'String')) && handles.signalHighY==1
           %resets signal high
handles.signalHighY=0;
%sets move to 1 to indicated left
handles.move=1;
%resets status back to center 
 set(handles.ThresholdStatusValue,'String','Center');
       else
       end
       
       
        %checks if gyThres is less than negative threshold and it has not already
     %been reached
       if handles.gyThres < -(str2num(get(handles.EditThresholdValue,'String'))) && handles.signalLowY==0 
            %signal high is set to one indicate threshold has been tripped
handles.signalLowY=1;
%sets threshold status to right to signifgy down has been reached
set(handles.ThresholdStatusValue,'String','Right');

       %else it checks if gy is greater than  negative threshold value, and that the signal has
%alread been reached, indicating the threshold had been breached upwards
       elseif handles.gyThres > -(str2num(get(handles.EditThresholdValue,'String'))) && handles.signalLowY==1
     %resets signal low
handles.signalLowY=0;
%sets move to 3 to indicated right
handles.move=3;
%resets status back to center 
set(handles.ThresholdStatusValue,'String','Center');
       else
       end
       
       
       
        %checks if gxThres is less than negative threshold and it has not already
     %been reached
     if handles.gxThres < -(str2num(get(handles.EditThresholdValue,'String'))) && handles.signalLowX==0 
 %signal high is set to one indicate threshold has been tripped
  handles.signalLowX=1;
  %sets threshold status to up to signifgy down has been reached
set(handles.ThresholdStatusValue,'String','Up');
    
%else it checks if gx is greater than  negative threshold value, and that the signal has
%alread been reached, indicating the threshold had been breached upwards
 elseif handles.gxThres >  -(str2num(get(handles.EditThresholdValue,'String'))) && handles.signalLowX==1
   %resets signal low
handles.signalLowX=0;
%sets move to 4 to indicated up
handles.move=4
%resets status back to center 
set(handles.ThresholdStatusValue,'String','Center');
       else
       end
     
     
    
     
     
     % Checks which direction the accelerometer is going and passes is used
     % to determine which way to sort and merg and will not run unless a
     % direction threshold has been tripped
        if (handles.move==1 ||handles.move==2 || handles.move==3||handles.move==4 )
        
            %clear the window with the existing tiles so new gameboard can
            %be plotted.
            cla(handles.gameWindow)
            %old game board is saved to pastMoves
         handles.pastMoves=handles.gameboard
         % gameboard axes is selected
            axes(handles.gameWindow)
            % axis is set to standard size since it was wiped.
        axis([0 4 0 4])
        hold on;    
        %game board is saved again in oldgameboad
            handles.oldGameBoard=handles.gameboard;
            %shift board is called storing the new board shifted in the
            %move direction
        handles.gameboard=shiftBoard(handles.gameboard,handles.move)
        %combine squares merges the same squares that are touching in the
        %specified direction and returns a new board and the score from
        %combining the tiles
        [handles.gameboard handles.updateScore]=combineSquares(handles.gameboard,handles.move,str2num(get(handles.scoreValue,'String')))
        
        %score value is updated to new score
        set(handles.scoreValue,'String',num2str(handles.updateScore))
       
       
        %if none of the tiles were merged
       if handles.oldGameBoard==handles.gameboard
       % nothing happens
       else
           
            %else if the tiles were merged, a newtile is added through
            %addnewtile, the move count is incremented, and the game board
            %is plotted
             handles.gameboard=addNewTile(handles.gameboard)
        set(handles.moveCountValue,'String',num2str(      str2num(get(handles.moveCountValue,'String'))+1    )   )
          axes(handles.gameWindow)
        plotGameBoard( handles.gameboard )
      
       end
       
       
       % if the current score is greater than the highschore value 
        if handles.updateScore > (str2num(get(handles.highScoreValue,'String')))
            %high score.txt is opened
        fileID = fopen('highScore.txt','w');
        %the old score is overwritten with the new updated score
        fprintf(fileID,'%d',handles.updateScore)
        %the text file is then closed
        fclose(fileID);
        %high score is then updated on the gui
        set(handles.highScoreValue,'String',num2str(handles.updateScore))
        
        end
        %the move flag is set back to zero till the next move is triggered.
        handles.move=0
        
        
        
        %these two for loops loop through the current board searching for
        %the value 2048. Once the value is found the win flag is set to 1
        %and a message box appears congratualing the user on winning and
        %allows them to continue. this will only trigger the first time the
        % 2048 appears on the board
        for i=1:4
            for j=1:4
                
                if handles.gameboard(i,j)==2048 && handles.win==0
                    handles.win=1;
                    msgbox('Congrats you have won! click OK to keep playing.')
                    
                end
            end
        end
        
        %axes is set back to gamewindow
         axes(handles.gameWindow)
       
        
        
        

            %all handles are updated when this function ends
         guidata(hObject, handles);
        end
        
    % this draws the plotting graphs
    drawnow;
    %this updates the handles that have been changed
 guidata(hObject, handles);
end
%this updates the handles that have been changed
    guidata(hObject, handles);
    

% This start button is pressed to start sampling the data from the
% accelerometer and plotting the rolling graph of the resultant magnitude and xyz
% magnitude.. When the button is toggled it will stop sampling the data
% and stop plotting the rolling graph of the resultant magnitude and xyz
% magnitude.
    
 % this function will also be used to determine the direction of the move
 % which will then call another function to move the tiles and check for
 % merges between identical tiles.
    
    
    
    
% --- Executes on button press in resetGame.
function resetGame_Callback(hObject, eventdata, handles)
% hObject    handle to resetGame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%This button will reset the game and clear the board if someone wishes to start the game over again.
%all tiles will be deleted and the 1 starting tile will be placed on the
%board, along with a reset score.

%the axes is set to gameWindow
axes(handles.gameWindow)
% the axis size is initialex on reset
axis([0 4 0 4])
%an empty gameboard matrix of zeros is declared
handles.gameboard=[0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
%a new tile is randomly added to the game baord
handles.gameboard=addNewTile(handles.gameboard)
% the game board is plotted on the gui
plotGameBoard(handles.gameboard)
% the moves count is reset to 0
set(handles.moveCountValue,'String','0')
% the score is reset to 0
set(handles.scoreValue,'String','0')
  

%handles is updated at the end of the function
guidata(hObject, handles);








% --- Executes on button press in undoLastMove.
function undoLastMove_Callback(hObject, eventdata, handles)
% hObject    handle to undoLastMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% This will allow the user to go back one move incase they accidently
% choose the wrong direction. We might only let them move back one step, we
% havent decieded on that yet.

%the gameboard is loaded with the previously saved gameboard containg the
%last move
handles.gameboard=handles.pastMoves
%the gameWindow axes is selected
axes(handles.gameWindow)
% the game board from the past turn is plotted on the gui
plotGameBoard(handles.gameboard)

%handles is updated at the end of the function
guidata(hObject, handles)




% --- Executes on slider movement.
function Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% when the slider is changed, the slider checks which filter is currently
% selected.


% if it is the low pass filter selected, the slider value display displays
% the normal value of the slider
if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'lowPassFilter')==1)
set(handles.sliderValue,'String',num2str(get(handles.Slider,'Value')));  
end
    
    % if the moving average filter is selected, the slider value displats
    % the slidervalue times 20, rounded up so the window size is always a
    % whole number.
if (strcmp(get(get(handles.filterRadioGroup,'SelectedObject'),'Tag'),'movingAverageFilter')==1)
set(handles.sliderValue,'String',num2str(ceil(get(handles.Slider,'Value')*20)));
end


%handles is updated at the end of the function
   guidata(hObject, handles);





% --- Executes during object creation, after setting all properties.
function Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EditThresholdValue_Callback(hObject, eventdata, handles)
% hObject    handle to EditThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditThresholdValue as text
%        str2double(get(hObject,'String')) returns contents of EditThresholdValue as a double


% --- Executes during object creation, after setting all properties.
function EditThresholdValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in saveGame.
function saveGame_Callback(hObject, eventdata, handles)
% hObject    handle to saveGame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%this button saves the current game state to a text file inorder for it to
%be loaded at a later point



%opens file save.txt for write
fileID = fopen('save.txt','w');
%prints the gameboard array to the file
fprintf(fileID,'%s',evalc('disp(handles.gameboard)'));
%prints the score value to the text file
fprintf(fileID,'%s',get(handles.scoreValue,'String'))
%prints a blank in text file
fprintf(fileID,'%s','   ')
%prints the move count to text file
fprintf(fileID,'%s',get(handles.moveCountValue,'String'))
%closes save.txt file
 fclose(fileID);
  guidata(hObject,handles);
 
 


% --- Executes on button press in loadGame.
function loadGame_Callback(hObject, eventdata, handles)
% hObject    handle to loadGame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%opens text file save.txt
 fileID = fopen('save.txt');
 %input format is set to integers
 formatSpec = '%d';
 %fills array a with all integers from text file
 A = fscanf(fileID,formatSpec)

 %sets count to 0
 handles.countLoadGame=0;


 % for loop is used to loop through matriix and fill the newboard matrix
 for i=1:4
     for j=1:4
         %incrememnts the count for load game
         handles.countLoadGame=handles.countLoadGame+1;
         %fills the spot i,j based on countloadgame and i and j
         handles.gameboard(i,j)=A(handles.countLoadGame);
     end
 end
 
 %the second to last integer is the scorevalue which is displayed in the
 %gui
set(handles.scoreValue,'String',num2str(A(17)))
%the last value is the move count which is then displayed on the gui
set(handles.moveCountValue,'String',num2str(A(18)))
%axes is set to gamewindow
axes(handles.gameWindow)
%the loaded gameboard is printed to the screen
plotGameBoard(handles.gameboard)
%the save text file is closed
 fclose(fileID);
   guidata(hObject,handles);
