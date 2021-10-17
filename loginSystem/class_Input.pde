class Input{
  float x;
  float y;
  float w = 250;
  float h = 50;
  String inputText = "";
  boolean clicked = false;
  String navn = "";
  
  Input(float x_, float y_, String navn_){
    x = x_;
    y = y_;
    navn = navn_;
  }
  
  void display(){
    if(clicked){
      stroke(0, 168, 255);
    }
    
    fill(203, 204, 200);
    rect(x, y, w, h);
    fill(0);
    text(inputText, x, y);
    
    text(navn, x, y - 35);
    
    stroke(0);
  }
  
  void writeInBoks(){
    if(clicked == true){
      if(key == BACKSPACE && inputText.length() > 0){
        inputText = inputText.substring(0, inputText.length() - 1);
      } else{
        inputText += key;
      }
    }
  }
  
  void checkIfBoksIsClicked(){
    if(mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2){
      clicked = true;
    }else{
      clicked = false;
    }
  }
}
