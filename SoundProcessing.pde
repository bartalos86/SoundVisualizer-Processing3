import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioInput input;
AudioRecorder recorder;
FFT fft;
BeatDetect beat;
float specLow = 0.03;
float specMid = 0.12;
float specHight = 0.3;
boolean isPlaying = true;
boolean isRecording = false;
boolean isFinished = false;
int frames = 0;
int musicLenghtFrames;
Cube[] cubes;

int nbCubes = 110;

void setup()
{
  size(1024, 512);
  minim = new Minim(this);
  frameRate(60);
  player = minim.loadFile("song.mp3");
  cubes = new Cube[nbCubes];
  input = minim.getLineIn(Minim.STEREO, 2048); 
  float XposCount = 0;
  for(int i = 0; i< nbCubes;i++){

    cubes[i] = new Cube(XposCount,i);
    XposCount += 10;
  }

  fft = new FFT(player.bufferSize(),player.sampleRate());
  beat = new BeatDetect();
 frameRate(60);
  player.play(0);
 
 

 musicLenghtFrames = SecondsToFrames(3,2);

}

void draw()
{
background(255);
  fft.forward(player.mix);

   float averageBand = 0;
   
     for(int i = 0;i<nbCubes;i++)
        cubes[i].updateCircle(beat.isOnset());
 
  
  for(int i = 0;i<nbCubes;i++){
   float scaledCSTBand = map(fft.getBand(i),0,50,1,75);
   averageBand += fft.getBand(i);
   if(fft.getBand(i) > 35){
    fill(#64FFA3);
  }else{fill(#FF9064);}
   
   cubes[i].update((int)scaledCSTBand);
   cubes[i].render();
  }
  println(frameRate);
  

  
  if(!isRecording && averageBand > 15){
  //recorder.beginRecord();
  frames = 0;
  isRecording = true;
  
  }
  else if(isRecording &&  frames >= musicLenghtFrames){
    isFinished = true;
 
  }
  
  frames++;
  
    if(!isFinished){
    fill(#15E555);
  ellipse(50,50,50,50);
  }
  else if (isFinished)
  {
    fill(#FA474A);
  ellipse(50,50,50,50);
  }
  
  


if(isPlaying){
 //fill(#64FFA3);
 
}
  else
  fill(#FF9064);
  rect(25,25,50,50);

}

void mousePressed()
{
  if(mouseX > 25 && mouseX < 75 && mouseY > 25 && mouseY < 75){
  if(player.isPlaying()){
    player.pause();
    isPlaying = false;
  }
      
    else{
    isPlaying = true;
    player.loop();
    }
      
  }
}

int SecondsToFrames(int minutes,int seconds){
  int frameCounts = minutes*60*10 + seconds*10;
  return frameCounts;
}