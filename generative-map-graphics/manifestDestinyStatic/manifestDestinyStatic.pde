float xSeed = random(0, 100);
float ySeed = random(0, 100);
float pathSeed = random(0, 100);

PGraphics pg;
long mSeed = (int) (random(0,1000000));
int capMode = SQUARE;
int tileCount = 120;


void setup(){
  size(720, 720);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  
  for(int gridY = 0; gridY < tileCount; gridY++){
    //gridY counts tiles going from TOP to bottom
    
    for(int gridX = 0; gridX< tileCount; gridX++) {
      int posX = width / tileCount * gridX;
      int posY = height / tileCount * gridY;
      
      boolean downward = random(0,1)<0.5; //makes it a 5050
      
      if(downward){
        pg.strokeWeight(10);
        //pg.stroke(0, 100, 100);
        pg.stroke(0);
        pg.line(posX, posY, posX+width/tileCount, posY+height/tileCount);
      }else{
        pg.strokeWeight(10);
        //pg.stroke(200, 100, 100);
        pg.stroke(0);
        pg.line(posX, posY+height/tileCount, posX+width/tileCount, posY);
        //line(posX, posY, posX+width/tileCount, posY-height/tileCount);
      }
      
    }//end of the gridX
  } //end of the gridY
  
  
  pg.endDraw();
  
}
void draw(){
  int sq = 5;
  int sqRows = height/sq+1;
  int sqCols = width/sq+1;
  
  float thresh = width-millis()/20;
  noStroke();
  for(int r = 0; r<sqRows; r++){
    for(int c = 0; c<sqCols; c++){
      float x = c*sq;
      float y = r*sq;
      float pix = pg.get((int)x, (int)y)*mSeed;
      
      float posX = x+sq/2;
      float posY = y+sq/2;
      float xDist = min(posX%tileCount, tileCount-posX%tileCount);
      float yDist = min(posY%tileCount, tileCount-posY%tileCount);
      
      float dSq = xDist*xDist+yDist*yDist;
      float dist = sqrt(dSq);
      
      //float n = noise(xSeed+x*0.005, ySeed+y*.005, millis()/3000.0);
      float path = noise(xSeed+x*0.004, ySeed+y*.003, pathSeed);
      //float n = noise(xSeed+x*0.005, ySeed+y*.005, pix);
      //float n = noise(xSeed+x*0.005, ySeed+y*.005);
      float n;
      //if(x>thresh) n = noise(xSeed+x*0.005+dist*0.004, ySeed+y*.005+dist*0.004);
      //else n = noise(xSeed+x*0.005, ySeed+y*.005);
      
      if(x>thresh) n = noise(xSeed+x*0.005+dSq*0.00007, ySeed+y*.005+dSq*0.00007);
      else n = noise(xSeed+x*0.005, ySeed+y*.005);
      //println(n);
      
      
      if(n<0.4){ //blue water
          fill(200, 100, n*100.0/0.5);
      }
      else if(n<0.42){
        fill(30, 45, 80);
      }
      else if(n<0.6){ //green forest
        float lightness = abs(0.5-n)*50/0.1+30;
        //lightness is the dist from the middle of it, *500, +50.
        //if(lightness<55) lightness = 0;
        fill(120, 70, lightness);
      }
      else{ //white moiuntsins
        float lightness = 100-(abs(0.8-n)*30/0.1);
        fill(30, 100-lightness+10, lightness);
      }
      
      //uncomment this to add path back
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
  //image(pg, 0, 0, width, height);
  
  //gridlines
  /*
  fill(0);
  stroke(2);
  for (int x = 0; x<width; x+=tileCount){
    line(x, 0, x, height);
    println(x);
  }
  for (int y = 0; y<height; y+=tileCount){
    line(0, y,width, y);
    println(y);
  }//*/
}

void mousePressed(){
  saveFrame("landscape-######.png");
  //println("YEP");
}
