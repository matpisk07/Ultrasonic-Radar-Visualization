/*
  Radar Visualization
  -------------------
  Base du code : Script Open Source trouvé sur internet (Auteur original inconnu).
  Adaptation & Modifications : Mattia Pischedda.
  
  Ce script lit les données (Angle, Distance) envoyées par l'Arduino sur le port Série
  pour dessiner le radar.
*/

import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;


boolean portSelected = false; 
String[] comPorts; 


Serial myPort;
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;


void setup() {
  fullScreen();
  smooth();
  comPorts = Serial.list();
}


void draw() {
  if (!portSelected) {
    drawMenu();
  } 
  else {
    fill(98,245,31);
    noStroke();
    fill(0,4); 
    rect(0, 0, width, height-height*0.065); 
    
    fill(98,245,31);
    drawRadar(); 
    drawLine();
    drawObject();
    drawText();
  }
}


void drawMenu() {
  background(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(98, 245, 31);
  text("Veuillez sélectionner un port COM :", width / 2, height / 4);
  
  textSize(24);
  
  if (comPorts != null && comPorts.length > 0) {
    for (int i = 0; i < comPorts.length; i++) {
      String portName = comPorts[i];
      float padding = 40;
      float rectWidth = textWidth(portName) + padding;
      float rectHeight = 45;
      float xPos = width / 2.0 - rectWidth / 2.0;
      float yPos = height / 2.0 + i * 55;
      
      if (mouseX > xPos && mouseX < xPos + rectWidth && mouseY > yPos - rectHeight/2 && mouseY < yPos + rectHeight/2) {
        fill(98, 245, 31, 200);
        noStroke();
        rect(xPos, yPos - rectHeight/2, rectWidth, rectHeight, 15);
        fill(0);
      } else {
        fill(255);
      }
      
      textAlign(CENTER, CENTER);
      text(portName, xPos + rectWidth / 2, yPos);
    }
  } else {
    textAlign(CENTER, CENTER);
    fill(255);
    text("Aucun port COM trouvé.", width / 2, height / 2);
  }
}

void mousePressed() {
  if (!portSelected) {
    for (int i = 0; i < comPorts.length; i++) {
      String portName = comPorts[i];
      float padding = 40;
      float rectWidth = textWidth(portName) + padding;
      float rectHeight = 45;
      float xPos = width / 2.0 - rectWidth / 2.0;
      float yPos = height / 2.0 + i * 55;
      
      if (mouseX > xPos && mouseX < xPos + rectWidth && mouseY > yPos - rectHeight/2 && mouseY < yPos + rectHeight/2) {
        String selectedPort = comPorts[i]; 
        try {
          myPort = new Serial(this, selectedPort, 9600);
          myPort.bufferUntil('.');
          portSelected = true;
          background(0);
          break; 
        } catch (Exception e) {
          println("ERREUR : Impossible de se connecter au port " + selectedPort);
        }
      }
    }
  }
}


void serialEvent (Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  index1 = data.indexOf(",");
  angle= data.substring(0, index1);
  distance= data.substring(index1+1, data.length());
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width/2,height-height*0.074);
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2,height-height*0.074);
  strokeWeight(9);
  stroke(255,10,10);
  pixsDistance = iDistance*((height-height*0.1666)*0.025);
  if(iDistance<40){
    line(pixsDistance*cos(radians(180 - iAngle)),-pixsDistance*sin(radians(180 - iAngle)),(width-width*0.505)*cos(radians(180 - iAngle)),-(width-width*0.505)*sin(radians(180 - iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height-height*0.074);
  line(0,0,(height-height*0.12)*cos(radians(180 - iAngle)),-(height-height*0.12)*sin(radians(180 - iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  if(iDistance>40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98,245,31);
  textSize(25);
  
  text("10cm",width-width*0.3854,height-height*0.0833);
  text("20cm",width-width*0.281,height-height*0.0833);
  text("30cm",width-width*0.177,height-height*0.0833);
  text("40cm",width-width*0.0729,height-height*0.0833);
  textSize(30);
  text("Object: " + noObject, width-width*0.875, height-height*0.0277);
  text("Angle: " + iAngle +" °", width-width*0.48, height-height*0.0277);
  text("Distance: ", width-width*0.26, height-height*0.0277);
  if(iDistance<40) {
    text("        " + iDistance +" cm", width-width*0.225, height-height*0.0277);
  }
  textSize(25);
  fill(98,245,60);
  translate((width-width*0.4994)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(width-width*0.513+width/2*cos(radians(120)),(height-height*0.07129)-width/2*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate((width-width*0.5104)+width/2*cos(radians(150)),(height-height*0.0574)-width/2*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}
