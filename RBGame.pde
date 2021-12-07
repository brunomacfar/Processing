import processing.sound.*;
import processing.serial.*;
 
PImage backImg ;
PImage birdImg ;
PImage paw;
PImage startImg;
PImage endGame;

ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
ArrayList<BUTTON> btn = new ArrayList<BUTTON>();
ArrayList<BUTTON> btn2 = new ArrayList<BUTTON>();

SoundFile music, mainMusic;


boolean locked = false;

int gameState = 1;
int score = 0;
int highScore = 0;
int x = 0;
int y;
int vy = 0;

//SoundFile music;
//SoundFile mainMusic;

int[] pawX =new int[5];
int[] pawY =new int[2];

int rand = int(random(0, 700));

String name;

void setup() {
  size(900, 900);
  textSize(40); 
  gameState = 1;
  TEXTBOX nameT = new TEXTBOX(80, 640, 380, 45);
  nameT.BorderEnable=true;
  textboxes.add(nameT);

  backImg = loadImage("backImg.png");
  birdImg = loadImage("araraAzul.png");
  startImg = loadImage("img_Inicio.png");
  endGame = loadImage("endGame.jpg");
  paw = loadImage("paw.png");
  music = new SoundFile(this, "endGame.mp3");
  mainMusic = new SoundFile(this, "oficial.mp3");
 
 // essa logica nos traria um 10 se funcionasse.
 if (gameState == 2){
    mainMusic.stop();
    music.play();
    delay(2000);
  } else {
  mainMusic.loop();
  }
  
  
  
  //TEXTBOX player = new TEXTBOX(100, 300, 200, 35);
}

void drawZero(){
    
    imageMode(CENTER);
    backImg.resize(900,900);
    image(backImg, width/2, height/2);
    //image(backImg, x + backImg.width, 0);
    image(birdImg, width/2, y);
    text(" "+score, width/2-15, 700); 
    //  image(birdImg, width/2, y);
    x -= 6;
    vy += 1;
    y += vy;
    if (x == -1800) x = 0;
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      image(paw, pawX[i], pawY[i] - (paw.height/2+100));
      image(paw, pawX[i], pawY[i] + (paw.height/2+100));
      if (pawX[i] < 0) {
        pawY[i] = (int)random(200, height-200);
        pawX[i] = width;
      }
      if (pawX[i] == width/2) {
        score ++;
        highScore = max(score, highScore);
      }
     //Quando esta condição é atingida. É criado um novo frame contendo a imagem de Game Over.
      if (y > height || y < 0 || (abs(width/2-pawX[i])<25 && abs(y-pawY[i])>100)) {   
        gameState = 2; 
    
      }
      pawX[i] -= 6;
    }    
}

void drawOne(){   
    
    imageMode(CENTER);
    startImg.resize(900,900);
    image(startImg, width/2, height/2);
     BUTTON submitBT = new BUTTON(600, 645, 100, 40);
     submitBT.ButtonText = "Submit!";
     btn.add(submitBT);
  
    fill(0, 0, 0);
    textSize(15);
   for (TEXTBOX t : textboxes) {
      t.DRAW();
   }  
   for (BUTTON b : btn) {
      b.DRAW();
   }
   if (btn.get(0).clicked) {
     name = textboxes.get(0).Text;
     locked=true;
      gameState = 0;
    
   } if (locked) {
     
  } 
   text("Insira aqui o seu nome:",80, 630);
   text("Clique em qualquer parte da tela, para iniciar o game... ", 80, 760);
   text("Maior Pontuação: "+highScore, 80, 830);
   
}

void drawTwo(){
  
  imageMode(CENTER);
  endGame.resize(1100,900);
  image(endGame, width/2, height/2);
  
  BUTTON sbmt = new BUTTON(30,400,130, 45);
  sbmt.ButtonText = "Recomeçar";
  btn2.add(sbmt);
    for (BUTTON b : btn2) {
      b.DRAW();
   }
  text( name + " sua última pontuação foi "+ score, 30, 490);
  text("e seu maior score é "+highScore, 30, 513);
  if (btn2.get(0).clicked) {
     locked = true;
     gameState = 1; 
     
   }
   if (locked) {
   
   }
   
}

void draw() {
  
  /* em uma segunda execução, comente o código acima que mencionamos o 10, e descomente este abaixo, que vocë entenderá. 
 if (gameState == 2){
    mainMusic.stop();
    music.play();
    delay(2000);
  } else {
  mainMusic.loop();
  }
  */
if (gameState == 1) {
  drawOne();
} else if (gameState == 2) {
  drawTwo();
} else if (gameState == 0) {
  drawZero();
 } else {
  exit();
}
   
   
}

void mousePressed() {
  vy = -15;
  if (gameState == 1) {
    pawX[0] = 600;
    pawY[0] = height/2;
    pawX[1] = 900;
    pawY[1] = 600;
    x = 0;
    y = height / 2;
    score = 0;
  }
   for (TEXTBOX t : textboxes) {
      t.PRESSED(mouseX, mouseY);
   }   
   for (BUTTON b : btn) {
      b.PRESSED(mouseX, mouseY);
   }
    for (BUTTON b : btn2) {
      b.PRESSED(mouseX, mouseY);
   }
  
}

void keyPressed() {
   for (TEXTBOX t : textboxes) {
      t.KEYPRESSED(key, (int)keyCode);
   }
}
void mouseReleased() {
   for (BUTTON b : btn) {
      b.RELEASED(mouseX, mouseY);
   }
   
   for (BUTTON b : btn2) {
      b.RELEASED(mouseX, mouseY);
   }
  
}
