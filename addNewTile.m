function [newgameboard] = addNewTile(gameBoard)
%This function adds a random tile to the gameboard once a move has been
%made or when the gameboard is intially created.

%searches gameboard for all spots where a zero is present and returns row
%and column for each in x and y
[x,y]=find(gameBoard==0)

%random integer is generated based on the size of x and y 
%this randomly selects a pair to be filled with zero
xRand=randi([numel(x)]);
  
%Doubles checks that the randomly choosen point is a zero
if gameBoard(x((xRand)),y((xRand)))==0
    %if so it assigns it a 2
    gameBoard(x((xRand)),y((xRand)))=2
else
    %if the choosen point is not a 2 the function is called again
newgameboard=addNewTile(gameBoard)
    
end

%the new board with the added tile is passed back to the main 
newgameboard=gameBoard
end

