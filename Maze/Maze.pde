import processing.serial.*;
Serial port;
int val;
char [][] board;
BufferedReader reader;
int level = 1;
int width;
int height;
void setup(){
  frameRate(10);
  port = new Serial(this, 9600);
  createBoard();
}

void draw(){
  if (0 < port.available()){
     val = port.read();
     println(val);
  }
}

void createBoard(){
   String fileName = "level" + level + ".dat";
   reader = createReader(fileName);
   String line = "";
   line = reader.readLine();
   width = Integer.parseInt(line);
   line = reader.readLine();
   height = Integer.parseInt(line);
   board = new char[width][height];
   int i = 0;
   line = reader.readLine();
   while (line != null){
     String [] pieces = split(line, '');
     for (int j = 0; j < pieces.length; j++){
       board[i][j] = pieces[j];
     }
     i++;
     line = reader.readLine();
   }
   level++;
}
