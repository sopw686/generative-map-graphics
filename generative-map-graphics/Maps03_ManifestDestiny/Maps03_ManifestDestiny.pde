/*
Maps 03: Manifest Destiny

This project depicts map experiencing a westward traveling distortion onto a grid. 

The distortion of each point increases as its distance from the grid increases.
*/

//having random seeds ensures each map is unique
float xSeed = random(0, 100);
float ySeed = random(0, 100);

int tileCount = 120;
float dFactor = 0.00003;
int yIncrements = 60;
float[] xThresh = new float[yIncrements+1];
float incH; 

void setup(){
  size(720, 720);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  incH = height*1.0/yIncrements;
  println(incH);
  
  for(int i = 0; i<=yIncrements; i++){
    xThresh[i] = width;
  }
}
void draw(){
  int sq = 5;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  
  float thresh = width-millis()/20;
  noStroke();
  
  int lastIndex = -1;
  for(int r = 0; r<sqRows; r++){
    float y = r*sq;
    
    int ytIndex = (int)(y*1.0/incH);
    
    //println(ytIndex);
    if(ytIndex>lastIndex){
      lastIndex = ytIndex;
      xThresh[ytIndex]-=pow(noise(ySeed+y*.0009)*3, 2)*3;
    }
    
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      
      float xDist = min(x%tileCount, tileCount-x%tileCount);
      float yDist = min(y%tileCount, tileCount-y%tileCount);
      
      float dSq = xDist*xDist+yDist*yDist;
      float dist = sqrt(dSq);
      float n;
      //if(x>xThresh[ytIndex]) n = noise(xSeed+x*0.005+dist*0.004, ySeed+y*.005+dist*0.004, millis()/8000.0);
      //else n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/8000.0);
      
      /*
      generates a pixel value from 0-1 based off of the: 
        x seed, 
        x value, 
        y seed, 
        y value,
        and time passed.
      The use of a noise function creates a smooth gradient in values. 
      
      each y increment has a unique distortion threshold
      Checks to see if the pixel is within the distortion threshold, 
      and if so, distorts the pixel value
      */      
      if(x>xThresh[ytIndex]) n = noise(xSeed+x*0.005+dSq*dFactor, ySeed+y*.005+dSq*dFactor, millis()/15000.0);
      else n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/15000.0);
      
      //alternative distortion
      //if(x>thresh) n = noise(xSeed+x*0.005+dSq*0.00007, ySeed+y*.005+dSq*0.00007);
      //else n = noise(xSeed+x*0.005, ySeed+y*.005);
      
      //determines the type of landscape based off the n value
      if(n<0.4){ //blue water
          //higher values of n -> nearer to the shoreline -> lighter color
          //as the flood level increases -> water gets darker
          fill(210, 100, n*80+40);
      }
      else if(n<0.42)  { //tan shoreline
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

void mousePressed(){
  saveFrame("ManifestDestiny-######.png");
}  
