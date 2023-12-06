//ik wou er alleen nog een betere achtergrond bij toevoegen 
//en ik heb wel paar dingen opgezocht maar ik heb er wel veel van geleerd.

PImage img;

// Dit zijn twee lijsten die worden gebruikt om de x- en y-coördinaten van de slang bij te houden
// Elke coördinaat wordt opgeslagen als een geheel getal (Integer)
ArrayList<Integer> snakeX = new ArrayList<Integer>();
ArrayList<Integer> snakeY = new ArrayList<Integer>();

// Variabelen voor de positie van de slang en het voedsel
int posX, posY;
int foodX, foodY;

// Variabelen voor de richting van de slang en de grootte van het speelveld
int ctrlX = 0, ctrlY = 0;
int w, h;
int size = 40; // De grootte van elke cel op het speelveld wordt ingesteld op 40 pixels.
int snl = 6; // Dit is de snelheid van de slang.
int len = 5; // Dit is de lengte van de slang
int score = 0; // Dit is de score van het scorebord

void setup() {
  size(1080, 720);  // Het spelvenster wordt gemaakt met een grootte van 1080 bij 720 pixels.
  // Dit zorgt ervoor dat de slang in het midden van het scherm komt
  w = width / size; 
  h = height / size;
  
  img = loadImage("milky-way-2695569_1280.jpg");

  // dit zorgt ervoor dat de slang in het midden van het scherm begint
  posX = w / 2;
  posY = h / 2;

  // Dit zorgt ervoor dat het eten op een willekeurige plek van het speelveld spawn.
  newFood();

  // Dit zorgt ervoor dat er geen rand om de slang heen is
  noStroke();
  fill(0, 100, 500);
}

void draw() {
  image(img, 0, 0); //dit zorgt ervoor dat er een achtergrond op scherm komt.
  

  // Teken de slang en elke cel ervan op het speelveld.
  drawSnake();

  // Teken het voedsel op het speelveld.
  drawFood();

  // Beweging van de slang
  if (frameCount % snl == 0) { //Het controleert of het tijd is om de slang te bewegen op basis van het frameCount.
    if (ctrlX != 0 || ctrlY != 0) { //Als de slang wordt bestuurd (door de speler), voegt het de huidige positie van de slang toe aan lijsten 
    //met x- en y-coördinaten, wat de positie van de slang vertegenwoordigt.
      snakeX.add(posX);
      snakeY.add(posY);
    }
    // Zorgt ervoor dat de slang niet langer is dan de opgegeven lengte (len)
    while (snakeX.size() > len) {
      snakeX.remove(0);
      snakeY.remove(0);
    }
    // Verwijdert het oudste segment van de slang
    posX += ctrlX;
    posY += ctrlY;

    // Als de slang het voedsel raakt, wordt er nieuw voedsel gegenereerd
    if (posX == foodX && posY == foodY) {
      newFood();
      len += 1; 
      score += 1;  // Verhoog de score wanneer de slang het voedsel raakt
    }

    // Loop door elk segment van de slang
    for (int i = 0; i < snakeX.size(); i++) {
      // Controleer of de huidige positie (posX, posY) overeenkomt met een segment van de slang
      if (posX == snakeX.get(i) && posY == snakeY.get(i)) {
        // Als dat het geval is, roep de reset-functie aan
        reset();
      }
    }

    // Zorg ervoor dat de slang binnen het speelveld blijft
    if (posX < 0) { posX = w - 1; reset();} // als de slang naar links gaat komt hij weer bij de rechter kant van de speelveld uit
    if (posX >= w) { posX = 0; reset();} // als de slang naar rechts gaat komt hij weer bij de linker kant van de speelveld uit
    if (posY < 0) { posY = h - 1; reset();} // als de slang naar boven gaat komt hij weer bij de  onderkant van de speelveld uit
    if (posY >= h) { posY = 0; reset();} // als de slang naar onder gaat komt hij weer bij de  bovenkant van de speelveld uit
  }

  // Tekenen van het scorebord
  fill(255); // de kleur van het scorebord
  textSize(24); // de grootte van de tekst
  textAlign(RIGHT);
  text("Score: " + score, width - 20, 30);
}
//dit zorgt ervoor dat er voedsel op de speelveld komt
void drawFood() {
  fill(255, 0, 0);
  rect(foodX * size, foodY * size, size, size);
}

// Genereer nieuw voedsel op een willekeurige plek op het speelveld
void newFood() {
  foodX = int(random(w));
  foodY = int(random(h));
}

// Functie om de slang te tekenen op het speelveld
void drawSnake() {
  // Kleur van de slang instellen op groen
  fill(0, 250, 0);
  // Tekenen van het hoofd van de slang op de huidige positie (posX, posY)
  rect(posX * size, posY * size, size, size); 
  // Loop door elke cel van de slang en teken deze op het speelveld
  for (int i = 0; i < snakeX.size(); i++) {
    // Tekenen van elk segment van de slang op basis van de opgeslagen coördinaten
    rect(snakeX.get(i) * size, snakeY.get(i) * size, size, size);
  }
}

// Functie om de slang te resetten als deze "doodgaat"
void reset() {
  // Zet de slang terug in het midden van het scherm.
  posX = w / 2; // x-positie
  posY = h / 2; // y-positie
  ctrlX = 0;    // reset horizontale controle
  ctrlY = 0;    // reset verticale controle
  
  // Genereer nieuw voedsel op een willekeurige plek op het speelveld
  newFood();
  
  // Initialiseer nieuwe ArrayLists voor de slang
  snakeX = new ArrayList<Integer>();
  snakeY = new ArrayList<Integer>();
  
  // Zet de lengte van de slang terug naar 5
  len = 5;
  
  // Zet de score terug naar nul
  score = 0;
}

// Hiermee kan de slang worden bestuurd met de pijltjestoetsen
void keyPressed() {
  // Controleert of er op een toets is gedrukt die speciale codes heeft
  if (key == CODED) {
    
    if (keyCode == UP && ctrlY != 1) // Controleert welke pijltjestoets is ingedrukt en stelt de bewegingsrichting van de slang in
     { ctrlX = 0; // Geen horizontale beweging
     ctrlY = -1; }// Beweeg omhoog
     
    if (keyCode == DOWN && ctrlY != -1) 
    { ctrlX = 0; // Geen horizontale beweging
    ctrlY = 1; }// Beweeg omlaag
    
    if (keyCode == LEFT && ctrlX != 1) 
    { ctrlX = -1; //Beweeg naar links
    ctrlY = 0; } //Geen verticale beweging
    
    if (keyCode == RIGHT && ctrlX != -1) 
    { ctrlX = 1; // Beweeg naar rechts
    ctrlY = 0; } // Geen verticale beweging
  }
}
