size(100,100);
background(255,255,255);

int sizec = 100;

for(int i = 0;i<5;i++){
  ellipse(100-sizec/2,100-sizec/2,sizec,sizec);
  sizec=sizec-10;
}
