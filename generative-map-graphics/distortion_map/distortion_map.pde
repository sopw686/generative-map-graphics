//stretches and squishes map based on mouse position
float xSeed = random(0, 100);
float ySeed = random(0, 100);
float pathSeed = random(0, 100);

float xFactor;
float yFactor;

float startX, startY;

float totAng = 0;
float tempAng = 0;


void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
}
void draw(){
  pushMatrix();
  translate(width/2, height/2);
  
  rotate(totAng);
  if (mousePressed){
    println("tot: "+totAng+", temp: "+tempAng);
    tempAng = findAng(startX, startY, mouseX, mouseY);
    rotate(tempAng);
  }
  
  
  //tempAng = 
  //want both x and why to range from as low as 0.001 and as high as 0.01?
  xFactor = mouseX*1.0/width/120;
  yFactor = mouseY*1.0/height/120;
  int sq = 5;
  int sqRows = (int) (height*sqrt(2)/sq/2)+1;
  int sqCols = (int) (width*sqrt(2)/sq/2) +1;
  for(int r = -1*sqRows; r<sqRows; r++){
    for(int c = -1*sqCols; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      float n = noise(xSeed+x*xFactor, ySeed+y*yFactor, millis()/6000.0);
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
      
      //if(path>0.49 && path<0.51){
      //  float lightness = abs(0.5-path)*50/0.1+50;
      //  //lightness is the dist from the middle of it, *500, +50.
      //  //if(lightness<70) 
      //  lightness-=30;
      //  fill(10, 50, lightness);
      //}
      //fill(0, 100, path*100);
      rect(x, y, sq, sq);
    }
  }
  popMatrix();
}

float findAng(float x1, float y1, float x2, float y2){
  float dotProduct = x1 * x2 + y1 * y2;
  float mag1 = sqrt(x1*x1+y1*y1);
  float mag2 = sqrt(x2*x2+y2*y2);
  float costheta = dotProduct / mag1 / mag2;
  return acos(costheta)*1.2;
}


void mousePressed(){
  //saveFrame("landscape-######.png");
  //println("YEP");
  startX = mouseX;
  startY = mouseY;
}

void mouseReleased(){
  totAng+=tempAng;
  tempAng = 0;
  
}
