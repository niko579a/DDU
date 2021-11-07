import de.bezier.data.sql.*;
import java.security.*;

String brugernavn = "";

SQLite database;

boolean loginPage = true;
boolean opretPage = false;
boolean appPage = false;

Input LoginUserNameInputFelt;
Input LoginPasswordInputFelt;

Input OpretUserNameInputFelt;
Input OpretPasswordInputFelt;

Button loginKnap;
Button loginOpretKnap;

Button opretKnap;

Button logUdKnap;

void setup(){
  rectMode(CENTER);
  textAlign(CENTER);
  size(700,700);
  
  LoginUserNameInputFelt = new Input(width/2, height/3 - 50, "Brugernavn");
  LoginPasswordInputFelt = new Input(width/2, height/3 + 50, "Adgangskode");
  
  OpretUserNameInputFelt = new Input(width/2, height/3 - 50, "Brugernavn");
  OpretPasswordInputFelt = new Input(width/2, height/3 + 50, "Adgangskode");
  
  loginKnap = new Button(width/2, height/3*2-110, "Login");
  loginOpretKnap = new Button(width/2, height/3*2-50, "Opret en bruger");
  
  opretKnap = new Button(width/2, height/3*2-125, "Opret");
  
  logUdKnap = new Button(width/2, height/2, "Log ud");
 
}

void draw(){
  clear();
  background(255);
  
  //login
  if(loginPage == true){
   LoginUserNameInputFelt.display();
   LoginPasswordInputFelt.display();
   
   loginKnap.hidden = false;
   loginOpretKnap.hidden = false;
  
   loginKnap.display();
   loginOpretKnap.display();
  }
  
  //opret 
  if(opretPage == true){
    OpretUserNameInputFelt.display();
    OpretPasswordInputFelt.display();
    
    opretKnap.hidden = false;
    opretKnap.display();
  }
  
  //log ud siden
  if(appPage == true){
    fill(0);
    text(brugernavn, width/2, height/3);
    logUdKnap.hidden = false;
    logUdKnap.display();
  }
}

void mousePressed(){
  if(logUdKnap.checkIfButtonIsClicked() == true){
    appPage = false;
    loginPage = true;
  }
  
  if(loginPage == true) {
    LoginUserNameInputFelt.checkIfBoksIsClicked();
    LoginPasswordInputFelt.checkIfBoksIsClicked();
  }
  
  if(opretPage == true) {
    OpretUserNameInputFelt.checkIfBoksIsClicked();
    OpretPasswordInputFelt.checkIfBoksIsClicked();
  }
  
  if(loginOpretKnap.checkIfButtonIsClicked() == true){
    LoginUserNameInputFelt.inputText = "";
    LoginPasswordInputFelt.inputText = "";

    OpretUserNameInputFelt.inputText = "";
    OpretPasswordInputFelt.inputText = "";
    
    loginKnap.hidden = true;
    loginOpretKnap.hidden = true;
    
    loginPage = false;
    opretPage = true;
  }
  
  if(opretKnap.checkIfButtonIsClicked() == true){
    if(OpretUserNameInputFelt.inputText.length() > 0 && OpretPasswordInputFelt.inputText.length() > 0){
      try{
        database = new SQLite(this, "mydatabase.sqlite");
        if(database.connect()){
          database.query("insert into Users values(null, \"" + OpretUserNameInputFelt.inputText + "\", \"" + hash(OpretPasswordInputFelt.inputText) + "\");");
          database.close();
          
          OpretUserNameInputFelt.inputText = "";
          OpretPasswordInputFelt.inputText = "";
          
          LoginUserNameInputFelt.inputText = "";
          LoginPasswordInputFelt.inputText = "";
        
          opretPage = false;
          loginPage = true; 
        }else{
          println("Input opret fejl");
        }
      } catch(Exception e){
        println("Opret fejl");
      }
    }
  }
  
  if(loginKnap.checkIfButtonIsClicked() == true){
    if(LoginUserNameInputFelt.inputText.length() > 0 && LoginPasswordInputFelt.inputText.length() > 0){
      try{
        database = new SQLite(this, "mydatabase.sqlite");
        if(database.connect()){
          database.query("select * from Users where Username = \"" + LoginUserNameInputFelt.inputText + "\"; ");
          while(database.next()){
            brugernavn = "";
            brugernavn = database.getString("Username");
            String password = database.getString("Password");
            if(password.equals(hash(LoginPasswordInputFelt.inputText))){
              LoginUserNameInputFelt.inputText = "";
              LoginPasswordInputFelt.inputText = "";
          
              OpretUserNameInputFelt.inputText = "";
              OpretPasswordInputFelt.inputText = "";
            
              loginPage = false; 
              appPage = true;
            } else {
              println("Adgangskoder passer ikke sammen");
            }
          }
        } else{
          println("Login input fejl");
        }
        
        database.close();
      } catch(Exception e){
        println("Login fejl");
      }
    }
  }
}

void keyPressed(){
  if(loginPage == true) {
    LoginUserNameInputFelt.writeInBoks();
    LoginPasswordInputFelt.writeInBoks();
  }
  
  if(opretPage == true) {
    OpretUserNameInputFelt.writeInBoks();
    OpretPasswordInputFelt.writeInBoks();
  }
}

String hash(String password){
  StringBuffer hashed = new StringBuffer();
  
  try{
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    md.update(password.getBytes());
    byte[] byteList = md.digest();
    for(byte b: byteList){
      hashed.append(hex(b));
    }
  } catch(Exception e){
    println("Hash fejl");
  }
  return hashed.toString();
}
