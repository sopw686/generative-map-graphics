/*
goal: generate an interactive landscape map that floods based on the X position of the mouse
as the mouse moves towards the right, the map floods
*/

float xSeed = random(0, 100);
float ySeed = random(0, 100);
//float fLvl = 0;

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}
void draw(){
  int sq = 5;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  
  float fLvl = float((mouseX-height/2))/height/15;
  println(fLvl);
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      //float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/3000.0);
      float n = noise(xSeed+x*0.005, ySeed+y*.005);
      
      
      //println(n);
      if(n<0.4+fLvl){ //blue water
          fill(200, 100, n*100.0/0.5);
      }
      else if(n<0.42+fLvl){
        fill(30, 45, 80);
      }
      else if(n<0.6){ //green forest
        float lightness = abs((0.42+fLvl+0.6)/2-n)*50/0.1+50;
        
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
  saveFrame("flloodmap-######.png");
  //println("YEP");
}
