import processing.serial.*;
Serial port;
int val;
char [][] board;
BufferedReader reader;
int level = 1;
int width;
int height;
int currI;
int currJ;
void setup(){
  frameRate(10);
  //port = new Serial(this, 9600);
  createBoard();
  textSize(32);
}

void draw(){
  //if (0 < port.available()){
    // val = port.read();
     if (board[currI][currJ+1] == 'G'){
       text("You Win!", 20, 20);
     }
     else{
       if (val == 0){
         //move down - temp;
         println("WOOOHOO");
       }
         
     }  
  //}
}

void move(int i, int j, char temp){
  board[i][j] = temp;
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
   width = Integer.parseInt(line);
   try{
     line = reader.readLine();
   }catch(IOException e){
     e.printStackTrace();
     line = null;
   }
   height = Integer.parseInt(line);
   size(width, height);
   board = new char[width][height];
   int i = 0;
   try{
     line = reader.readLine();
   }catch(IOException e){
     e.printStackTrace();
     line = null;
   }
   while (line != null){
     String [] pieces = split(line, "");
     for (int j = 0; j < pieces.length; j++){
       board[i][j] = pieces[j].charAt(0);
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
   for (i = 0; i < board.length; i++){
     for (int j = 0; j < board[i].length; j++){
       text(board[i][j], i, j);
     }
   }
}
