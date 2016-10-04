void loadURLs() {
  //url=append(url, "http://172.16.219.163/service/camera/image.jpg");
  //url=append(url, "http://172.16.219.32/service/camera/image.jpg");
  //url=append(url, "http://172.16.252.154/service/camera/image.jpg");
  url=append(url, "http://172.16.249.205:8124/service/camera/image.jpg");
  //url=append(url, "http://172.16.229.175:8124/service/camera/image.jpg");
}

void positionCameras() {
  int leftBorder=int(width*.12);
  int topBorder=int(height*.1);
  pos[0]= new PVector (leftBorder, topBorder, width/5.8);
  pos[1]= new PVector (leftBorder, topBorder+(width/5.8*.76), width/5.8);
  pos[2]= new PVector (leftBorder, topBorder+(width/5.8*.76)*2, width/5.8);
  pos[3]= new PVector (leftBorder, topBorder+(width/5.8*.76)*3, width/5.8);
  pos[4]= new PVector (leftBorder+width/5., topBorder, width/5.8);
  pos[5]= new PVector (leftBorder+width/5.*2, topBorder, width/5.8);
  pos[6]= new PVector (leftBorder+width/5.*3, topBorder, width/5.8);
  presentationPos=new PVector (leftBorder+width/5., topBorder+(width/5.8*.76), width/1.748);
  //pos[7]= new PVector (leftBorder+width/5., topBorder+(width/5.8*.76), width/1.748);
}

int testCamera() {
  int onlineCamN=0;
  for (int i=0; i<url.length; i++) {
    try {
      webImg = loadImage(url[i], "jpg");
      image(webImg, 0,0,0,0);
      //testURL(url[i]);
      validURL[onlineCamN]=url[i];
      onlineCamN++;
    }
    catch(Exception e) {
      println("Camera at: "+url[i]+" not available.");
      onlineCamN--;
      if (onlineCamN<0) {
        onlineCamN=0;
      }
    }
  }
  println("cameras online: "+onlineCamN);
  return(onlineCamN);
}