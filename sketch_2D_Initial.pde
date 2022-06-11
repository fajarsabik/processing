int TileSize = 6;
int ChunkSize = 32;
int TilesShown = 6;
int AmountOfChunksX = 1;
int AmountOfChunksY = 1;
int ChunkBiome;
float[][] ChunkCordsX;
float[][] ChunkCordsY;
int  [][] ChunkId;
boolean ChunkBorder;
float MoveX, MoveY, Zoom;
boolean[] Keys;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  
  fullScreen();
  
  MoveX = 739;
  MoveY = 446;
  Zoom = 4.899999;
  //Zoom = 0.9599996;
  
  Keys = new boolean[122];
  ChunkCordsX = new float[ChunkSize * AmountOfChunksX][ChunkSize * AmountOfChunksX];
  ChunkCordsY = new float[ChunkSize * AmountOfChunksY][ChunkSize * AmountOfChunksY];
  ChunkId     = new int  [ChunkSize * (AmountOfChunksY + AmountOfChunksX)][ChunkSize * (AmountOfChunksY + AmountOfChunksX)];
  
  ChunkGenerator();
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
    
  background(200);
  KeyComDraw();
  
  pushMatrix();
    translate(MoveX, MoveY);
    scale(Zoom);
    ChunkDisplay();
  popMatrix();
  fill(255, 0, 0);
  ellipse(width/2, height/2, 30, 30);
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  
  switch (key) {   
    case 'w' : 
      Keys[0] = true;
      break;
    case 'a' : 
      Keys[1] = true;
      break;
    case 's' : 
      Keys[2] = true;
      break;
    case 'd' :
      Keys[3] = true;
      break;
    case 'i' :
      Keys[4] = true;
      break;
    case 'o' :
      Keys[5] = true;
      break;
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void keyReleased() {
  
  switch (key) {   
    case 'w' : 
      Keys[0] = false;
      break;
    case 'a' : 
      Keys[1] = false;
      break;
    case 's' : 
      Keys[2] = false;
      break;
    case 'd' :
      Keys[3] = false;
      break;
    case 'i' :
      Keys[4] = false;
      break;
    case 'o' :
      Keys[5] = false;
      break;
  }
  
  if (key == 'r' || key == 'R') {
    ChunkGenerator();
  }
  if (key == 'p' || key == 'P') {
    println("Zoom: " +  Zoom);
    println("MoveX: " + MoveX);
    println("MoveY: " + MoveY);
  }
  if ((key == 'b' || key == 'B') && ChunkBorder == false) {
    ChunkBorder = true;
  } else if ((key == 'b' || key == 'B') && ChunkBorder == true) {
    ChunkBorder = false;
  }
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void ChunkDisplay() {
                                                                                                                                                                                                                                                                                                       
  if (ChunkBorder == false) {
    for (int Row = 0; Row < ChunkSize * AmountOfChunksX; Row++) {
      for (int Colmn = 0; Colmn < ChunkSize * AmountOfChunksY; Colmn++) {
        //if ((ChunkCordsX[Row][Colmn] + TileSize) * Zoom + MoveX > 0 && (ChunkCordsX[Row][Colmn] - TileSize) * Zoom + MoveX < width &&
        //    (ChunkCordsY[Row][Colmn] + TileSize) * Zoom + MoveY > 0 && (ChunkCordsY[Row][Colmn] - TileSize) * Zoom + MoveY < height) {
        if ((ChunkCordsX[Row][Colmn]) * Zoom + MoveX > 0 - ((TileSize) * Zoom) && (ChunkCordsX[Row][Colmn]) * Zoom + MoveX < width  + ((TileSize) * Zoom) &&
            (ChunkCordsY[Row][Colmn]) * Zoom + MoveY > 0 - ((TileSize) * Zoom) && (ChunkCordsY[Row][Colmn]) * Zoom + MoveY < height + ((TileSize) * Zoom)) {
              
          if (mouseX > (ChunkCordsX[Row][Colmn]) * Zoom + MoveX && mouseX < (ChunkCordsX[Row][Colmn] + TileSize) * Zoom + MoveX &&
              mouseY > (ChunkCordsY[Row][Colmn]) * Zoom + MoveY && mouseY < (ChunkCordsY[Row][Colmn] + TileSize) * Zoom + MoveY) {
            if (mousePressed) {
              stroke(random(255), random(255), random(255));
              ChunkId[Row][Colmn] = 1;
            } else {
              stroke(random(255), random(255), random(255));
            }//else
          } else {
            noStroke();
          }//else
            
            if (ChunkId[Row][Colmn] == 1) {
              fill(0);
            } else if (ChunkId[Row][Colmn] == 2) {
              fill(0, 0, 255);
            } else if (ChunkId[Row][Colmn] == 3) {
              fill(255);
            } else {
              fill(0, 0, 255);
            }
            rect(ChunkCordsX[Row][Colmn], ChunkCordsY[Row][Colmn], TileSize, TileSize);
        }//if
      }//for
    }//for
  } else if (ChunkBorder == true) {
    for (int Row = 0; Row < AmountOfChunksX; Row++) {
      for (int Colmn = 0; Colmn < AmountOfChunksY; Colmn++) {
          fill(255);
          stroke(255, 0, 0);
          rect(Row * (ChunkSize * TileSize), Colmn * (ChunkSize * TileSize), ChunkSize * TileSize, ChunkSize * TileSize);
       }//for
    }//for
  }//if

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void ChunkGenerator() {
  
  ChunkBiome = round(random(1, 3));
  
  for (int Row = 0; Row < ChunkSize * AmountOfChunksX; Row++) {
    for (int Colmn = 0; Colmn < ChunkSize * AmountOfChunksY; Colmn++) {
      ChunkCordsX[Row][Colmn] = 0 + Row   * TileSize;
      ChunkCordsY[Row][Colmn] = 0 + Colmn * TileSize;
      ChunkId[Row][Colmn] = ChunkBiome;
    }//for
  }//for
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void KeyComDraw() {
  int   MoveSpeed = 10;
  float ZoomSpeed = 0.06;
  
  //Help here
  float MoveMathX = 0;
  float MoveMathY = 0;
  if (Keys[0] == true) {
    MoveY += MoveSpeed;
  } 
  //key A
  if (Keys[1] == true) {
    MoveX += MoveSpeed;
  } 
  //key S
  if (Keys[2] == true) {
    MoveY -= MoveSpeed;
  } 
  //key D
  if (Keys[3] == true) {
    MoveX -= MoveSpeed;
  } 
  //key i
  if (Keys[4] == true) {
    Zoom  += ZoomSpeed;
    MoveX -= MoveMathX;
    MoveY -= MoveMathY;
  }
  //key o
  if (Keys[5] == true) {
    //Zoom -= 0.02;
    Zoom  -= ZoomSpeed;
    MoveX += MoveMathX;
    MoveY += MoveMathY;
  }
}
