import processing.sound.*;
SoundFile sonido;
//bola
int posX=0; 
int posY=0; 
int D=10; 
int ancho=20; 
int alto=50; 
int mov_x=0;
int mov_y=0;

int vel_ball = 4;
int vel_player = 30;

int jug_1x=0; 
int jug_1y=0;
int gol_1=0;

int jug_2x=0; 
int jug_2y=0;
int gol_2=0;

void restart(){
  posX=500; 
  posY=278;
  jug_1x=width-50; 
  jug_1y=height/2;
  jug_2x=30; 
  jug_2y=height/2;
  //randomSeed(second());
  int xx= (int)random(2);
  int yy= (int)random(2);
  if (xx==1)mov_x = -vel_ball;
  if (yy==1)mov_y = - (int) random(3) + 5;
  if (xx==0)mov_x = vel_ball;
  if (yy==0)mov_y = (int)random(3) + 5;
  if(abs(mov_x)==abs(mov_y)){
    mov_y = mov_y +2;
  }
  
}


void setup() { 
  size(999,555) ;
  sonido = new SoundFile(this ,".\\Electro-Tom.wav");
  restart();
}


void draw() {
  
  background(0) ;
  stroke(255);
  line(500,0,500,height);
  ellipse (posX,posY,D,D) ;
 
  
  
  rect(jug_1x ,jug_1y ,ancho, alto) ;
  rect(jug_2x ,jug_2y ,ancho, alto) ;
  posX=posX+mov_x; //verificando si hay choque 
  posY=posY+mov_y;
  if (posX>=width || posX<=0 || (mov_x>0 && jug_1y<=posY+D/2 && posY-D/2<=jug_1y+alto && jug_1x<=posX+D/2 && posX-D /2<=jug_1x+ancho)
  || (mov_x<0 && jug_2y<=posY+D/2 && posY-D/2<=jug_2y+alto && jug_2x<=posX+D/2 && posX-D /2<=jug_2x+ancho)) { 
    mov_x=-mov_x; //Si choca con la derecha , es gol 
    if (posX>=width) { 
      gol_1=gol_1+1;
      restart();
      thread ("Suena") ;
    }else if (posX <=0){
      gol_2 = gol_2 + 1;
      restart();
      thread ("Suena") ;
    }
  }
  if (posY < 0) { 
    posY = 0; 
    mov_y = -mov_y; 
  }else if (posY > height) { 
    posY = height; 
    mov_y = -mov_y; 
  }
  

  textSize(26);
  text (gol_1 , 250, 25) ;
  text (gol_2 , 750, 25) ;
}

void keyPressed() {
  if (keyCode == UP) { 
    jug_1y = jug_1y - vel_player; 
    if(jug_1y < 0){
      jug_1y = 0;
    }
  } else if (keyCode == DOWN) { 
    jug_1y = jug_1y + vel_player;
    if((jug_1y+alto)> height-(alto/2)){
      jug_1y = height-alto;
    }
  }
  if (key == 'w' || key == 'W') { 
    jug_2y = jug_2y - vel_player;
    if(jug_2y< 0){
      jug_2y = 0;
    }
  } else if (key == 's' || key == 'S') { 
    jug_2y = jug_2y + vel_player; 
    if((jug_2y+alto)> height-(alto/2)){
      jug_2y = height-alto;
    }
  }
}

void Suena( ) { sonido. play ( ) ; }
