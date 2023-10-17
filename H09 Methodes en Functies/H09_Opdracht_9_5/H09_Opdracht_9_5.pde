


void setup(){
  String output = voegStringsSamen("hallo", " mijn ", "studenten", "jeoef");   
  println(output);       
  
}

void draw(){
  
}
//return type, functie naam, (argumenten){scope}
String voegStringsSamen(String a, String b, String c, String d){
  String totaal;
  totaal=(a+b+c+d);
  return totaal;
}
