int antwoord = 0;
int getaleen = 0;
int getaltwee = 1;

for(int i = 0;i<10;i++){
 antwoord = getaleen + getaltwee;
 println(antwoord + "=" + getaleen + "+" +getaleen);
 getaleen = getaltwee;
 getaltwee = antwoord;
 
}
