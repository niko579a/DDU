class Button{
  float x;
  float y;
  float w = 250;
  float h = 50;
  String buttonText = "";
  boolean hidden = true;
  
  Button(float x_, float y_, String buttonText_){
    x = x_;
    y = y_;
    buttonText = buttonText_;
  }
  
  void display(){
    fill(143, 168, 181);
    rect(x, y, w, h);
    fill(0);
    text(buttonText, x, y);
  }
  
  boolean checkIfButtonIsClicked(){
    if(hidden == false){
      if(mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2){
      return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}
