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
void setup(){
  frameRate(10);
  //port = new Serial(this, 9600);
  createBoard();
  textSize(32);
  size(600, 600);
  background(255);
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
          ;
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
     println(line);
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
   for (int k = 0; k < board.length; k++){
     for (int j = 0; j < board[k].length; j++){
       /* switch (board[k][j]){
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
        }*/
        stroke(255, 255, 255);
        println(width);
       rect(j * width/aWidth, k * width/aWidth, width/aWidth, width/aWidth);
     }
     println();
   }
}
