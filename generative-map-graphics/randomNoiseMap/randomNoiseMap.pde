/*
Generates a pixelated mess, completely random rather than being based off a seed
*/

float xSeed = random(0, 100);
float ySeed = random(0, 100);
float[][] yep = new float[128][144];

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  for(int r = 0; r<128; r++){
    for(int c=0; c<144; c++){
      yep[r][c] = random(0,1);
    }
  }
  
}
void draw(){
  int sq = 5;
  int sqRows = height/sq;
  int sqCols = width/sq;
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      //float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/3000.0);
      float n = noise(xSeed+x*0.005, ySeed+y*.005);
      n = yep[r][c];
      //n= noise(x, y);
      //n = random(1);
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
      
      
      rect(x, y, sq, sq);
    }
  }
}

void mousePressed(){
  saveFrame("silly-######.png");
  //println("YEP");
}
