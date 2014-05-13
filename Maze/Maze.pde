import processing.serial.*;
Serial port;
int val;
char [][] board;
BufferedReader reader;
int level = 1;
int aWidth;
int aHeight;
int currI;
int currJ;
int direction = -1;
boolean hasBlock = false;
void setup(){
  frameRate(10);
  port = new Serial(this, 9600);
  
  textSize(32);
  size(600, 600);
  background(255);
  createBoard();
}

void draw(){
  if (0 < port.available()){
     val = port.read()- '0';
     println(val);
       if (val == 0) {
         if(hasBlock) {
           if (board[currI-1][currJ+direction] == ' ') {
             board[currI-1][currJ] = ' ';
             board[currI-1][currJ+direction] = 'B';
             gravity('B', currI-1, currJ+direction);
             hasBlock = false; 
           }
         } else {
           if (board[currI][currJ+direction] == 'B') {
             board[currI][currJ+direction] = ' ';
             board[currI-1][currJ] = 'B';
             hasBlock = true; 
           }
         }
       }
       if (val == 1 || val == 3){
         //temp left
         direction = val == 1 ? -1 : 1;
         int temp = currJ;
         if (board[currI][currJ+direction] == ' '){
           board[currI][currJ] = ' ';
           board[currI][currJ+direction] = 'P';
           gravity('P', currI, currJ+direction);
           if (hasBlock) {
             board[currI-1][currJ] = ' ';
             board[currI-1][currJ+direction] = 'B';
             gravity('B', currI-1, currJ+direction);
           }
         currJ+=direction;
         } else if (board[currI][currJ+direction] == 'G')
           won();
       }
       if (val == 2){
         //temp up
         if ((board[currI][currJ+direction] == 'B' || board[currI][currJ+direction] == 'X') && (board[currI-1][currJ + direction] != 'B' &&  board[currI-1][currJ + direction] != 'X' )){
             board[currI][currJ] = ' ';
             currJ = currJ + direction;
             currI--;
             board[currI][currJ] = 'P';
             if(hasBlock) {
               board[currI-1][currJ] = ' ';
               board[currI-2][currJ+direction] = 'B'; 
             }
         }
       }
       drawBoard(); 
  }
}

void move(int i, int j, char temp){
  board[i][j] = temp;
}
void drawBoard(){
  for (int k = 0; k < board.length; k++){
     for (int j = 0; j < board[k].length; j++){
        switch (board[k][j]){
           case 'X':
               fill(0, 0, 0);
               break;
           case ' ':
               fill(255, 255, 255);
               break;
            case 'G':
                fill(0, 255, 0);
                break;
            case 'P':
                fill(255, 0, 0);
                break;
            case 'B':
                fill(0, 0, 255);
                break;
            default:
                fill(255, 255, 255);
                break;
        }
        stroke(255, 255, 255);
       rect(j * width/aWidth, k * width/aWidth, width/aWidth, width/aWidth);
     }
   }
}
void createBoard(){
   String fileName = "level" + level + ".dat";
   reader = createReader(fileName);
   String line = "";
   try{
     line = reader.readLine();
   }catch(IOException e){
     e.printStackTrace();
     line = null;
   }
   aWidth = Integer.parseInt(line);
   try{
     line = reader.readLine();
   }catch(IOException e){
     e.printStackTrace();
     line = null;
   }
   aHeight = Integer.parseInt(line);
   board = new char[aHeight][aWidth];
   int i = 0;
   try{
     line = reader.readLine();
   }catch(IOException e){
     e.printStackTrace();
     line = null;
   }
   while (line != null){
     for (int j = 0; j < board[0].length; j++){
       board[i][j] = line.charAt(j);
       if (board[i][j] == 'P'){
        currI = i;
        currJ = j; 
       }
     }
     i++;
     try{
       line = reader.readLine();
     }catch(IOException e){
       e.printStackTrace();
       line = null;
     }
   }
   level++;
   drawBoard();
}

void gravity(char block, int r, int c){
   while (r < board.length-1 && board[r+1][c] == ' '){
     board[r][c] = ' ';
     board[r+1][c] = block;
     r = r+1; 
   }
   if (r < board.length-1 && board[r+1][c] == 'G')
     won();
   if (block == 'P') {
     currI = r;
   }
}

void won() {
  background(255);
  if (level == 5) {
    text("YOU WIN!!!", 20, 20);
    noLoop();
  } else {
    createBoard();
  }
  
}
