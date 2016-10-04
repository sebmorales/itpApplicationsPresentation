void loadSlide() {
  PImage img;
  try {
    img = loadImage("data/"+currentSlide+".jpg");
    image(img, presentationPos.x, presentationPos.y, presentationPos.z, presentationPos.z*.65);
  }
  catch(Exception e) {
    try {
      String newPath=currentSlide+".m4v";
      movie = new Movie(this, newPath);
      movie.loop();
      movieIsPlaying=true;
      //presentationMode=false;
    }
    catch(Exception er) {
      println("Failed to play video.");
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}