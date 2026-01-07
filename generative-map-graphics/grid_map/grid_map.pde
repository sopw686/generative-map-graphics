/*
Generates a 3 part map, each one with a diff ver of the same map
*/

PImage img;
String url = "https://www.landsat.com/street-map/massachusetts/detail/lexington-ma-2535250.gif";
PGraphics imgPG;

float xSeed = random(0, 100);
float ySeed = random(0, 100);
int W; //width
int H;
int NUM = 3;
float[][] seeds = new float[NUM][NUM];
void setup(){
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  W = width/NUM;
  H = height/NUM;
  
  resetSeed();
  
  img = loadImage(url);
  imgPG = createGraphics(width, height);
  imgPG.beginDraw();
  imgPG.imageMode(CENTER);
  imgPG.image(img, width/2, height/2, width, height);
  imgPG.endDraw();
}

void draw(){
  int sq = 2;
  int sqRows = H/sq+1;
  int sqCols = W/sq+1;
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      drawSqure(x, y, sq, millis());
      
      //drawL(x, y, sq, 0);
      //drawH(x, y, sq, 1);
    }
  }
  tint(0, 0, 100, 50);
  image(img, 0, 0, width, height);
  //image(imgPG, 0, 0);
}

void drawSqure(float x, float y, int sq, int t){
  for(int r = 0; r<NUM; r++){
    for(int c = 0; c<NUM; c++){
      
      //this one animates
      float n = noise(xSeed+x*0.006, ySeed+y*.006, seeds[r][c]+t/3000.0);
      //this one is still
      //float n = noise(xSeed+x*0.005, ySeed+y*.005);
      if(n<0.4){ //blue water
          fill(200, 100, n*100.0/0.5);
      }
      else if(n<0.42){
        fill(30, 45, 80);
      }
      else if(n<0.6){ //green forest
        float lightness = abs(0.5-n)*50/0.1+50;
        
        fill(120, 85, lightness);
      }
      else{ //white moiuntsins
        float lightness = 100-(abs(0.8-n)*30/0.1);
        fill(30, 100-lightness+10, lightness);
      }
      rect(x+r*H, y+c*W, sq, sq);
      
      
      
      
    }
  }
}

void keyPressed(){
  resetSeed();
}

void mousePressed(){
  saveFrame("grid-landscape-######.png");
  //println("YEP");
}

void resetSeed(){
  for(int r = 0; r<NUM; r++){
    for(int c = 0; c<NUM; c++){
      seeds[r][c] = random(0, 100);
    }
  }
}

void drawL(float x, float y, int sq, int order){
  
        
      float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/3000.0);
      //float n = noise(xSeed+x*0.005, ySeed+y*.005);
      //println(n);
      if(n<0.4){ //blue water
          fill(200, 100, n*100.0/0.5);
      }
      else if(n<0.42){
        fill(30, 45, 80);
      }
      else if(n<0.6){ //green forest
        float lightness = abs(0.5-n)*50/0.1+50;
        
        fill(120, 85, lightness);
      }
      else{ //white moiuntsins
        float lightness = 100-(abs(0.8-n)*30/0.1);
        fill(30, 100-lightness+10, lightness);
      }
      rect(x+order*W, y, sq, sq);
}

void drawH(float x, float y, int sq, int order){
  float n = noise(xSeed+x*0.01, ySeed+y*.01, millis()/3000.0);
  //println(n);
  
  //n*=270;
  float h=(50-abs(0.5-n)*480)%360;
  //h+=240;
  //h%=360;
  if(n<0.4) h-=50;
  else if(n>0.8) h-= 40;
  n*=200;
  
  fill(h, 100-n/6, n);
  rect(x+order*W, y, sq, sq);
}
