function [newgameboard] = shiftBoard( gameBoard,direction )
%This function is called to shift all of the tiles on the gameboard
%  in the given direction from the accelerometer. It moves all zeros to the
%  end of the row, as they represent empty tiles.



%this switch statement determines how the tiles should be sorted based on
%the directiong passed to the function
switch direction
    %this is run if a 1 is passed to the function
   case 1
       %the tiles will all be shifted left
      disp('shifting left')
       
      
             %the rows are all looped through with a for loop to analayze
             %each individually
             for j=1:4
                 % a temp matrix is made with the given row
             row=[gameBoard(1,j) gameBoard(2,j) gameBoard(3,j) gameBoard(4,j)]
             %find searches for all values that arent zero and makes an
             %array of indexes
             values=find(row)
     
                        %a for loop loops through the given index of indxes
                        %and assigns those values to the first few columns
                        %of the row
                        for m=1:(numel(values))
                            gameBoard(m,j)=gameBoard(values(m),j)
                        end
                        
                        % once all the non zero values have been filled
                        % into the board, the rest of the row is filled
                        % with zeros.
                        for m=(numel(values)+1):4
                            gameBoard(m,j)=0
                        
                        end
          
             end
      
      
      
             
             
      %the board is shifted to the right
      case 2
         disp('shifting down')
       
            %the columns are all looped through with a for loop to analayze
             %each individually
             for i=1:4
                 
              % a temp matrix is made with the given column
             row=[gameBoard(i,1); gameBoard(i,2) ;gameBoard(i,3) ;gameBoard(i,4)]
              %find searches for all values that arent zero and makes an
             %array of indexes
             values=find(row)
     
             
                        %a for loop loops through the given index of indxes
                        %and assigns those values to the first few rows
                        %of the column
                        for m=1:(numel(values))
                            gameBoard(i,m)=gameBoard(i,values(m))
                        end
                        
                         % once all the non zero values have been filled
                        % into the board, the rest of the column is filled
                        % with zeros.
                        for m=(numel(values)+1):4
                            gameBoard(i,m)=0
                        
                        end
          
             end
      
      
      %this is run if a 3 is passed to the function
     case 3
         
     %the board is shifted left
    disp('shifting left')
       
            %the rows are all looped through with a for loop to analayze
             %each individually
             for j=1:4
             % a temp matrix is made with the given row
             row=[gameBoard(1,j) gameBoard(2,j) gameBoard(3,j) gameBoard(4,j)]
              %find searches for all values that arent zero and makes an
             %array of indexes
             values=find(row)
     
                          %the size of values is assigned to count
                        count=numel(values)
                        %this only executes if there non zeros in the row
                        if numel(values)>0
                            
                        %the game board is filled from the right to the
                        %left,thus starting at 4 and decremnting to the
                        %spot of (4- numel of values +1)
                        for m=4:-1:(4-numel(values)+1)
                           gameBoard(m,j)=gameBoard(values(count),j)
                           %count is decremented to move to the next spot
                           %on the left
                           count=count-1;
                        end
                        end
                        
                        %only excexutes if the row is not all non zeros
                        if numel(values)<4
                        %fills the rest of the row with zeros
                        for m=1:(4-numel(values))
                            gameBoard(m,j)=0
                        end
                        end
                 
                        
                        
                        
                        
             end
             
             
      %this is run if a 4 is passed to the function
      case 4
          % the gameboard is shifted down
          disp('shifting up')
       
             for i=1:4
                 % a temp matrix is made with the given column
             row=[gameBoard(i,1); gameBoard(i,2) ;gameBoard(i,3) ;gameBoard(i,4)]
            
              %find searches for all values that arent zero and makes an
             %array of indexes
             values=find(row)
     
                        %count is initizlied as the size of values
                         count=numel(values)
                         %if the column is not all zeros
                        if numel(values)>0
                         %the game board is filled from the bottom to the
                        %left,thus starting at 4 and decremnting to the
                        %spot of (4- numel of values +1)
                        for m=4:-1:(4-numel(values)+1)
                           gameBoard(i,m)=gameBoard(i,values(count))
                           count=count-1;
                        end
                        end
                        
                        %if the column is not all non zeros
                        if numel(values)<4
                       %the rest of the column is filled with zeros.
                        for m=1:(4-numel(values))
                            gameBoard(i,m)=0
                        end
            
             end
             end
             %error statement for the rare chance the game breaks
      disp('you broke it')
        end

 %the output variable is assigned to the modified board
newgameboard=gameBoard
% the board is plotted on the graph through the plot graph function
plotGameBoard( gameBoard )
%this pause is added to add the illusion of animation
pause(.2)
end

