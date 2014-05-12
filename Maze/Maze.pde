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
void setup(){
  frameRate(10);
  //port = new Serial(this, 9600);
  
  textSize(32);
  size(600, 600);
  background(255);
  createBoard();
}

void draw(){
  //if (0 < port.available()){
    // val = port.read();
     if (board[currI][currJ+1] == 'G'){
       text("You Win!", 20, 20);
     }
     else{
       if (val == 0){
         //temp down
         if (board[currI][currJ + 1] == 'B'){
           int temp = currJ;
           while (board[currI + 1][temp] == ' '){
             temp--;
           }
           board[currI + 1][temp] = 'B';
         }
         else if (board[currI + 1][currJ] == 'B'){
           board[currI][currJ + 1] = 'B';
         }
         else {
           ;
         }
       }
       if (val == 1){
         //temp left
         direction = -1;
         int temp = currJ;
         board[currI][currJ] = ' ';
         while (currI > 0 && board[currI - 1][temp] == ' '){
            temp--;
         }
         currI = currI - 1;
         currJ = temp + 1;
         board[currI][currJ] = 'P';
       }
       if (val == 2){
         //temp up
         if ((board[currI + direction][currJ] == 'B' || board[currI + direction][currJ] == 'X') && (board[currI + direction][currJ + 1] != 'B' ||  board[currI + direction][currJ + 1] != 'B' )){
             board[currI][currJ] = ' ';
             currI = currI + direction;
             board[currI][currJ] = 'P';
         }
       }
       if (val == 3){
          direction = 1;
         int temp = currJ;
         board[currI][currJ] = ' ';
         while (currI > 0 && board[currI + 1][temp] == ' '){
           temp--;
         }
         currI = currI + 1;
         currJ = temp + 1;
         board[currI][currJ] = 'P';
       }
       drawBoard();
         
     }  
  //}
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
