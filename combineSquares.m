function [newgameboard,updateScore] = combineSquares( gameBoard,direction,score )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


%the score is passed in and assigned to update score
updateScore=score;
%switch statement that is based on the direction that is passed to the
%function



switch direction
   case 1
       %case 1 is when the board is shifted left
      disp('combining left')
       
      
              
             %the rows are all looped through with a for loop to analayze
             %each individually  
             for j=1:4
              % a temp matrix is made with the given row
             row=[gameBoard(1,j) gameBoard(2,j) gameBoard(3,j) gameBoard(4,j)]
             % only 1 to 3 are checked,as the tiles check the tile on their
             % right
             for i=1:3
                 %checks to see if tile at (i,j) is equal to tile on the
                 %right
                if gameBoard(i,j) == gameBoard(i+1,j)
                   %if so tile(i,j) is set to 2 times the orignal value
                    gameBoard(i,j)=gameBoard(i,j)*2
                    %the tile on the right is set to zero
                   gameBoard(i+1,j)=0;
                   %the sum of the two addded tiles is added to the score
                  updateScore=updateScore+(gameBoard(i,j));
                end
                
             end
             
             end
             
             %shiftgameboard is called to move the zeros to the end
             gameBoard=shiftBoard(gameBoard,direction)
      
      
      case 2
          %case 2 is when the board is shifted down
         disp('combining down')
       
         
         %the columns are all looped through with a for loop to analayze
             %each individually
             for i=1:4
            % a temp matrix is made with the given column
             row=[gameBoard(i,1) gameBoard(i,2) gameBoard(i,3) gameBoard(i,4)]
             
             % only 4 to 2 are checked,as the tiles check the tile above
             % them
          
             for j=4:-1:2
                if gameBoard(i,j) == gameBoard(i,j-1)
                     %if so tile(i,j) is set to 2 times the orignal value
                   gameBoard(i,j)=gameBoard(i,j)*2
                   %the tile on the top is set to zero
                   gameBoard(i,j-1)=0;
                   %the sum of the two addded tiles is added to the score
                  updateScore=updateScore+(gameBoard(i,j));
                end
                
             end
             
             end
             
             %shiftgameboard is called to move the zeros to the end
             gameBoard=shiftBoard(gameBoard,direction)
       
           
      
      
      
     case 3
 %case 3 is when the board is shifted right
        disp('combining right')
       
        
         %the rows are all looped through with a for loop to analayze
             %each individually
             for j=1:4
                 % a temp matrix is made with the given row
             row=[gameBoard(1,j) gameBoard(2,j) gameBoard(3,j) gameBoard(4,j)]
             
             
              
             % only 4 to 2 are checked,as the tiles check the tile to the
             % left of them
             for i=4:-1:2
                if gameBoard(i,j) == gameBoard(i-1,j)
                     %if so tile(i,j) is set to 2 times the orignal value
                   gameBoard(i,j)=gameBoard(i,j)*2
                   %the tile on the left is set to zero
                   gameBoard(i-1,j)=0;
                   %the sum of the two addded tiles is added to the score
                   updateScore=updateScore+(gameBoard(i,j));
                end
                
             end
             
             end
             
             %shiftgameboard is called to move the zeros to the end
             gameBoard=shiftBoard(gameBoard,direction)
           
             
             
      case 4
           %case 4 is when the board is shifted up
           disp('combining up')
       
           
           %the columns are all looped through with a for loop to analayze
             %each individually
             for i=1:4
                 % a temp matrix is made with the given column
             row=[gameBoard(i,1) gameBoard(i,2) gameBoard(i,3) gameBoard(i,4)]
             
              
             % only 1 to 3 are checked,as the tiles check the tile below
             % them
             for j=1:3
                if gameBoard(i,j) == gameBoard(i,j+1)
                     %if so tile(i,j) is set to 2 times the orignal value
                   gameBoard(i,j)=gameBoard(i,j)*2
                   %the tile on the bottom is set to zero
                   gameBoard(i,j+1)=0;
                   %the sum of the two addded tiles is added to the score
                  updateScore=updateScore+(gameBoard(i,j));
                end
                
             end
             
             end
             
             %shiftgameboard is called to move the zeros to the end
             gameBoard=shiftBoard(gameBoard,direction)
            
         
  %error message in the case the switch statement is broke
      disp('you broke it')
end

%the new combined board is plotted on game window in the gui
plotGameBoard( gameBoard )
pause(.2)
%the newgamebaord assigned the modified combined gameboard and returned to
%the main function
newgameboard=gameBoard
end

