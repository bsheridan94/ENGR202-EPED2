
function [] = plotGameBoard( gameboard )
%Plots the given gameboard passed to the function on the Gamewindow axes on
%the main gui.

%a white block is plotted against the whole plot to hide any old tiles that
%were not cleared.
handles.blockX=[0 0 4 4 ];
handles.blockY=[0 4 4 0];
handles.y=fill(handles.blockX,handles.blockY,[1 1 1])

%continues plotting
hold on


%for loop will loop through the 2d matrix of the gameboard evaluating all
%tile values and plotting the appropriate tile color and text
for i=1:4
    for j=1:4
        
   %if gameboard(i,j) equals 0, nothing is plotted
        if gameboard(i,j)==0           

        end    
        
        %if gameboard(i,j) equals 2, the tile is plotted with its unique color and
   %the text 2 in the middle
        if gameboard(i,j)==2
           handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];  
            handles.x=fill(handles.blockX,handles.blockY,[1 0 1])
            text(i-.5,j-.5,'2');
            hold on
        end        
        
        %if gameboard(i,j) equals 4, the tile is plotted with its unique color and
   %the text 4 in the middle
        if gameboard(i,j)==4
           handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[0 1 1])
             text(i-.5,j-.5,'4');
          hold on
        end
        
        %if gameboard(i,j) equals 8, the tile is plotted with its unique color and
   %the text 8 in the middle
        if gameboard(i,j)==8
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[1 0 0])
            text(i-.5,j-.5,'8');
            hold on;
        end
        
        %if gameboard(i,j) equals 16, the tile is plotted with its unique color and
   %the text 16 in the middle
        if gameboard(i,j)==16
           handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            x=fill(handles.blockX,handles.blockY,[0 1 0])
              text(i-.5,j-.5,'16');
              hold on;
        end
        
        %if gameboard(i,j) equals 32, the tile is plotted with its unique color and
   %the text 32 in the middle
        if gameboard(i,j)==32
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[0 0 1])
              text(i-.5,j-.5,'32');
              hold on;
        end
        
        %if gameboard(i,j) equals 64, the tile is plotted with its unique color and
   %the text 64 in the middle
        if gameboard(i,j)==64
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[1 .5 .1])
              text(i-.5,j-.5,'64');
              hold on;
        end
        
      %if gameboard(i,j) equals 128, the tile is plotted with its unique color and
   %the text 128 in the middle
        if gameboard(i,j)==128
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[.5 0 .5])
              text(i-.5,j-.5,'128');
              hold on;
        end
        
        %if gameboard(i,j) equals 256, the tile is plotted with its unique color and
   %the text 256 in the middle
        if gameboard(i,j)==256
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[1 1 .1])
              text(i-.5,j-.5,'256');
              hold on;
        end
        
        %if gameboard(i,j) equals 512, the tile is plotted with its unique color and
   %the text 512 in the middle
        if gameboard(i,j)==512
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[.5 .5 .5])
              text(i-.5,j-.5,'512');
              hold on;
        end
        
        %if gameboard(i,j) equals 1024, the tile is plotted with its unique color and
   %the text 1024 in the middle
        if gameboard(i,j)==1024
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[0 .5 0])
              text(i-.5,j-.5,'1024');
              hold on;
        end  
        %if gameboard(i,j) equals 2048, the tile is plotted with its unique color and
   %the text 2048 in the middle
        if gameboard(i,j)==2048
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[.5 0 0])
              text(i-.5,j-.5,'2048');hold on;
        end
        
        %if gameboard(i,j) equals 4096, the tile is plotted with its unique color and
   %the text 4096 in the middle
        if gameboard(i,j)==4096
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[.5 .5 0])
              text(i-.5,j-.5,'2048');hold on;
        end
        
        %if gameboard(i,j) equals 8192, the tile is plotted with its unique color and
   %the text 8192 in the middle
         if gameboard(i,j)==8192
            handles.blockX=[i-.95 i-.95 i-.05 i-.05 ];
            handles.blockY=[j-.95 j-.05 j-.05 j-.95];
            handles.x=fill(handles.blockX,handles.blockY,[.5 .5 .5])
              text(i-.5,j-.5,'2048');hold on;
        end
        
        
    end
end