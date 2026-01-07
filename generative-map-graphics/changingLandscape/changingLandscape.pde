//changes over time
//basic landscape
float xSeed = random(0, 100);
float ySeed = random(0, 100);

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}
void draw(){
  int sq = 5;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/3000.0);
      //println(n);
      if(n<0.4){ //blue water
          fill(200, 100, n*100/0.3);
      }
      else if(n<0.6){ //green water
        float lightness = abs(0.5-n)*50/0.1+50;
        
        fill(120, 100, lightness);
      }
      else{ //white moiuntsins
        float lightness = 100-(abs(0.8-n)*30/0.1);
        fill(30, 100-lightness-30, lightness);
      }
      rect(x, y, sq, sq);
    }
  }
}
void mousePressed(){
  saveFrame("changing-landscape-######.png");
}
