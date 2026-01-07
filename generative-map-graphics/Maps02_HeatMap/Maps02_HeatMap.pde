/*
Maps 02: Heat Map

This project generates a fluid landscape map that constrasts the landscape to its heat map

Water forms the coldest areas and higher elevations to have higher temperatuers.
As time passes, the landscape remains relatively unchanged, yet the temperatuers of the entire landscape increase.

Color key:
  blue and purple signify the coldest temperatures,
  red and orange are moderate,
  yellow going into green indicates the highest temperatures.
*/

//having random seeds ensures each map is unique
float xSeed = random(0, 100);
float ySeed = random(0, 100);
float b = -40; //change in temperature over time
//b ranges from -40 to +40
boolean hMap = false; //determines which map is displayed

void setup(){
  size(720, 640);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
}


void draw(){
  if(b<=40) b+=0.3;
  //else println("reached maximum heat");
  int sq = 5;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
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
      float n = noise(xSeed+x*0.01, ySeed+y*.01, millis()/3000.0);
      
      if(hMap){ //displays a heatmap
        float h= n*200; //hue
        h+=240; 
        h+=b;
        h%=360; //adjusts hue to range from purple to red to yellow
        n*=100;
        fill(h, 100-n/12, n*2+b/2);
        rect(x, y, sq, sq);
      }      
      
      else{ //otherwise, displays default map: type of landscape is based off the n value
        
          if(n<0.4){ //blue water
              //higher values of n -> nearer to the shoreline -> lighter color
              //as the flood level increases -> water gets darker
              fill(210, 100, n*80+40);
          }
          else if(n<0.42){ //tan shoreline
            fill(30, 45, 80);
          }
          else if(n<0.6){ //green forest
            //center of the forest (n = 0.5) is darkest and most saturated
            float lightness = abs(0.5-n)*45/0.1+25;
            fill(120, 100-lightness/4, lightness);
          }
          else{ //rocky mountains
            //centers of the mountains are white
            
            //when flood lvl is high, want lightness to be low, when its low, you still want it to be low
            float lightness = 100-(abs(0.8-n)*300);
            fill(30, 100-lightness+10, lightness);
          }
          rect(x, y, sq, sq);
        }  
    }
  }
}

//swaps the kind of map that is displayed
void mousePressed(){
  hMap = !hMap;
}
