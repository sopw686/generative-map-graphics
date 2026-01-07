/*
Maps 01: Flood Map

This project generates a fluid landscape map that depicts extreme flooding and drought

The horizontal location of the mouse (the mouse's X position) determines the degree of flood:
  the left creates significant drought,
  the right creates significant flooding,
  and the center is neutral.
*/

//having random seeds ensures each map is unique
float xSeed = random(0, 100);
float ySeed = random(0, 100);

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}

void draw(){
  int sq = 5; //pixel size
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  
  float fLvl = (mouseX*1.0-width*1.0/2)/width;
  //println(fLvl);
  
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      
      /*
      generates a pixel value from 0-1 based off of the: 
        x seed, 
        x value, 
        y seed, 
        y value,
        and time passed.
      The use of a noise function creates a smooth gradient in values. 
      */
      float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/7000.0);
      //float n = noise(xSeed+x*0.005, ySeed+y*.005); //produces a landscape that doesn't change over time
      
      //determines the type of landscape based off the n value
      if(n<0.4+fLvl){ //blue water
          //higher values of n -> nearer to the shoreline -> lighter color
          //as the flood level increases -> water gets darker
          fill(210, 100, n*80-fLvl*60+40);
      }
      else if(n<0.42+fLvl){ //tan shoreline
        fill(30, 45, 80);
      }
      else if(n<0.6+fLvl){ //green forest
        //center of the forest (n = 0.5) is darkest and most saturated
        float lightness = abs(0.5-n+fLvl)*45/0.1+25;
        fill(120, 100-lightness/4, lightness);
      }
      else{ //rocky mountains
        //centers of the mountains are white
        
        //when flood lvl is high, want lightness to be low, when its low, you still want it to be low
        float lightness = 100-(abs(0.8-n)*300)-fLvl*30;
        fill(30, 100-lightness+10, lightness);
      }
      rect(x, y, sq, sq);
    }
  }
}

//downloads a frame onto the computer
void mousePressed(){
  saveFrame("extreme-floodmap-######.png");
}
