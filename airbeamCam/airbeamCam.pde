import java.net.*;
import processing.video.*;

PImage webImg;
int numCameras=8;
int numProjections=8;
//URL[] url= new URL[3];
String[] url= new String[0];
String[] validURL=new String[numCameras];
PVector[] pos= new PVector[numCameras];
PVector presentationPos;

IntList posOrder=new IntList(0, 1, 2, 3, 4, 5, 6);//only 7, keep main in center
int counter=0;
int lastChange=0;
int randomChange=0;

boolean presentationMode=false;
int totalSlides=9;
boolean movieIsPlaying=false;
Movie movie;


int currentSlide=0;

void setup() {
  //size(1000, 700);
  fullScreen();
  loadURLs();
  positionCameras();
  numCameras=testCamera();
}

void draw() {
  if (!movieIsPlaying) {
    drawCameras();
  }
  if (movieIsPlaying) {
    image(movie, presentationPos.x, presentationPos.y, presentationPos.z, presentationPos.z*.65);
    if (movie.time() >= movie.duration()) { //movie must be finishe
      println("here");
      movieIsPlaying=false;
      movie.stop();
      currentSlide++;
    }
  }
}

void drawCameras() {
  if (counter>20) {
    counter=0;
    posOrder.shuffle();
    numCameras=testCamera();
    randomChange=int(random(numProjections-1));
  }
  int cameraToProject=0;//number of projected cameras
  int cycles=0;//fill all projection frames with cameras, even if they are repeated.

  background(0);
  for (int i=0; i<numProjections; i++) {
    try {
      if (i>numCameras*cycles) {
        cycles++;
        cameraToProject=0;
      }
      webImg = loadImage(validURL[cameraToProject], "jpeg");
      filter(GRAY);
      if (i<numProjections-1) {//all projections except main one
        image(webImg, pos[posOrder.get(i)].x, pos[posOrder.get(i)].y, pos[posOrder.get(i)].z, pos[posOrder.get(i)].z*.65);
      }

      //if (i==numProjections-1 && presentationMode==false) {
      if (i==randomChange && presentationMode==false) {
        image(webImg, presentationPos.x, presentationPos.y, presentationPos.z, presentationPos.z*.65);
      }
      filter(GRAY);
      if (i==numProjections-1 && presentationMode==true) {
        loadSlide();
      }
      cameraToProject++;
    }
    catch(Exception e) {
      println("camera not found");
      numCameras=testCamera();
    }
  }
  // delay(10);
  counter++;
}

void keyPressed() {
  if (key == 'p' ||key=='P') {
    if (presentationMode) {
      presentationMode=false;
    } else {
      presentationMode=true;
    }
  }
  if (keyCode== RIGHT) {
    if (presentationMode==false) {
      presentationMode=true;
      return;
    }
    if (movieIsPlaying) {
      movieIsPlaying=false;
      movie.stop();
    }
    if (currentSlide==totalSlides) {
      currentSlide=0;
      presentationMode=false;
    } else {
      currentSlide++;
      presentationMode=true;
    }
  } 
  if (keyCode==LEFT) {
    currentSlide--;
    presentationMode=true;
  }
}