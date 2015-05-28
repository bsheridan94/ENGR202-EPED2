Section 69
Group 3
Brian Sheridan
Mike Volpe

Application: 2048

Instructions:

Set Up: 
1.	Connect accelerometer to the device (make sure it is connected to the correct com-port). 
2.	Run the MATLAB code and wait for the GUI screen to appear.
3.	Calibrate the accelerometer via GUI button and follow the onscreen instructions.
How to Play 2048:
1.	2048 is a mathematical puzzle game that requires the player to achieve the 2048 tile.
2.	Slide tiles of the same value into each other; by doing so, the tiles will merge and add together.
3.	Note that the entire board moves, so it is necessary to plan a few moves ahead! 
4.	Keep in mind random 2’s pop up on the screen – it is important to try to keep the board clear. 
5.	If you are able to get the 2048 tile, you win! 
6.	If you are unable to make any more moves (because there’s no room left on the board) you lose. 
How to Play the App: 
1.	Click on the Start Game button to begin.
2.	Use the accelerometer to move the tiles – depending on how you tilt it depends on where the tiles slide. Keep the accelerometer level to avoid sliding move tiles than you desire. 
3.	Keep in mind every tile moves in 2048 (if there’s extra space), so it’s important to use strategy. 
4.	Click on the Stop Button to pause the game and to allow the gamer to: 
a.	Undo Last Move (which undo’s the last move in case of a mistake)
b.	Save the Game (which saves current progress)
c.	Load the Game (which loads the previous saved game)
5.	The scoreboard keeps track of the high score, so keep aiming high!  




Basic Functionality:

Setup Serial and Calibrate Button: The merged setup serial button and start serial button allow the user to only have to click one button to setup the whole application. If the user needs to recalibrate the accelerometer they can simply reclick the button.

Start/Stop Button: The start stop button allows the user to start and stop the application at will through simply toggling the button. The buttons color and text change to show what the button state is.

Stop Serial: Stop serial closes the serial port and exits the user out of the game.

Filter: The application allows the user to select 3 different filters, no filter, alpha filter and moving filter in order to filter the incoming data from the accelerometer.

Visualization: A graph of the X and Y magnitudes are graphed on a seperate plot to aloow the user to notice the difference in filters and help select the correct value for the threshold.

Threshold: The code uses thresholding for each direction, which detects when the x and y magnitudes breach a postive and negative threshold value that is editable by the user. Once the value returns to normal after tripping the threshold value the application then moves the board in that specified direction.



Advanced Functionality:

Image backround: An image was downloaded from the internet, and was plotted on an axes that was put behind all the gui objects inorder to add a eye pleaseing backround

Filter Status: The Filter status that is selected from the panel of radio boxes is output at the bottom of the gui to indicate the current filter being graphed.

Move Direction: Once the user has reached a move threshold for any direction, that direction is output on the Direction Status: box, to indicate to the user that they can return back to level.

Editable Threshold Value: The threshold value to determine the move direction is user editable to allow the users to select how sensitve they want the move threshold to be.

Start/Stop Color toggle: When the button for start and stop is toggled, when the text changes color so do the color in order to signify when the app is running and when it is stopped.

High Score: The high score is saved to a text file, and upon start up the high score is loaded from that text file

Save Game: The application has a button to save the current game state to a text file, consisting of all the current tiles on the board, the score and the move count.

Load Game: The application has a button to load a previous game state from a text file into the application, allowing users to continue playing a game with a save gameboard, score and move count.

Undo Button: After each turn, the previous gameboard is saved into a variabile in order to allow the user to undo a move with the press of a button in the case of an accidental move.

Sort Algorithm: A sorting algorith is used to analyze the gameboard matrix and based on the direction it shifts all non zero tiles in a specify direction and sorts all zeros in the opposite direction

Merg Algorithm: A mergingm algorithm is used to check if a neighboring tile in a certain direction is the same, and if so they are merged. this is used in alongside sort function to shift the board and sum all the numbers in the process.

Plot Function: A plot function is passed the gameboard vector which is then analyzed and a square with a unique color and text for the given value are plotted on the game window in the gui. This is function is responsible for showing the user the gameboard.
		As the game progress, this function clears the game board and uses basic animation to show the tiles moving and merging as the user plays the game.		

Function usage: The sorting, plotting, and merging code was written as a function in order to achieve cleaner code, and reduce the total length of the main code.

Winner Messagebox: If the user reaches 2048, a message box appears congratulaing the user on the win, and allows them to click continue to continue playing.


