float xSeed = random(0, 100);
float ySeed = random(0, 100);
float pathSeed = random(0, 100);
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
      float path = noise(xSeed+x*0.004, ySeed+y*.003, pathSeed);
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
        //lightness is the dist from the middle of it, *500, +50.
        //if(lightness<55) lightness = 0;
        fill(120, 85, lightness);
      }
      else{ //white moiuntsins
        float lightness = 100-(abs(0.8-n)*30/0.1);
        fill(30, 100-lightness+10, lightness);
      }
      
      if(path>0.49 && path<0.51){
        float lightness = abs(0.5-path)*50/0.1+50;
        //lightness is the dist from the middle of it, *500, +50.
        //if(lightness<70) 
        lightness-=30;
        fill(10, 50, lightness);
      }
      //fill(0, 100, path*100);
      rect(x, y, sq, sq);
    }
  }
}

void mousePressed(){
  saveFrame("landscape-######.png");
  //println("YEP");
}
