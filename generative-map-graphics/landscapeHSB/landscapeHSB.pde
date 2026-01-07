/*
Generates the map based off of randomized HSB



*/


float xSeed = random(0, 100);
float ySeed = random(0, 100);

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}
void draw(){
  int sq = 9;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      float n = noise(xSeed+x*0.01, ySeed+y*.01, millis()/3000.0);
      n*=400;
      fill(n, 100, 100);
      rect(x, y, sq, sq);
      //println(n);
      
      //n*=270;
      /*float h= n*230;
      h+=240;
      h%=360;
      n*=200;
      fill(h, 100-n/6, n);
      rect(x, y, sq, sq);*/
      
      /*
      if(n > 0.5) n*=-1;
      n*=180;
      n+=180;
      fill(n, 100, 100);
      rect(x, y, sq, sq);
      */
      
    //  if(n<0.4){ //blue water
    //      fill(200, 100, n*100/0.3);
    //  }
    //  else if(n<0.6){ //green water
    //    float lightness = abs(0.5-n)*50/0.1+50;
        
    //    fill(120, 100, lightness);
    //  }
    //  else{ //white moiuntsins
    //    float lightness = 100-(abs(0.8-n)*30/0.1);
    //    fill(30, 100-lightness-30, lightness);
    //  }
    //  rect(x, y, sq, sq);
    //}
    }
  }
}

//Heat maps
//heat maps go from red to purple usually. red is like 0-120, purple is like 300-360
//lets say my range is 300-360-120
//           brightness low mid    brightness high
