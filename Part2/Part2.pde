//File Names
String analogFile = "Analog.txt";
String digitalFile = "Digital.txt";
String newAnalogFile = "data/procAnalog.tsv";
String newDigitalFile = "data/procDigital.tsv";

//Shape parameters
float size = 25;

//Tables
String analog[][];
String digital[][];

//Graph parameters
float graphlx = 50;
float graphuy = 25;
float graphrx = 1150;
float graphdy = 575;
float mx[] = new float[24];

//Font parameters
int lblSize = 12;
int txtSize = 20;
color txtCol = #000000;
color lblCol = #ffffff;

//Colors
color bgCol = #000000;
color glCol = #fff0ff;
color grCol = #f0ffff;
color sdCol = #ffff00;
color saCol = #00ff00;
color rdCol = #0000ff;
color raCol = #ff0000;

void processAnalogData(String readFile, String writeFile)
{
  //Change time column to range 0-23
  String lines[] = loadStrings(readFile);
  PrintWriter newFile = createWriter(writeFile);
  
  newFile.println(lines[0]);
  newFile.println(lines[1]);
  
  for(int i=2;i<lines.length;i++)
  {
    String toks[] = lines[i].split("\t");
    String temp[] = toks[0].split("\\s|\\:");
    
    /*
    System.out.println(toks[0] + "\t" +temp.length);
    for(int j=0;j<temp.length;j++)
    {
      System.out.print(temp[j] + "\t");
    }
    */
    
    if(temp[2].equals("AM"))
    {
      toks[0] = (Integer.parseInt(temp[0]))%12 + "";
    }
    else
    {
      toks[0] = ((Integer.parseInt(temp[0]))%12 + 12)+"";
    }
    
    //moods
    for(int j=1;j<=2;j++)
    {
      if(toks[j].equals("Straight Face"))
        toks[j] = "0";
      else if(toks[j].equals("Polite"))
        toks[j] = "1";
      else if(toks[j].equals("Interested"))
        toks[j] = "2";
      else if(toks[j].equals("Friendly"))
        toks[j] = "3";
      else if(toks[j].equals("Loving"))
        toks[j] = "4";
    }
    
    newFile.println(toks[0] + "\t" + toks[1] + "\t" + toks[2]);
  }
  
  newFile.flush( );
  newFile.close( );  
}

void processDigitalData(String readFile, String writeFile)
{
  //Change time column to range 0-23
  String lines[] = loadStrings(readFile);
  PrintWriter newFile = createWriter(writeFile);
  
  newFile.println(lines[0]);
  newFile.println(lines[1]);
  
  for(int i=2;i<lines.length;i++)
  {
    String toks[] = lines[i].split("\t");
    String temp[] = toks[0].split("\\s|\\:");
    
    /*
    System.out.println(toks[0] + "\t" +temp.length);
    for(int j=0;j<temp.length;j++)
    {
      System.out.print(temp[j] + "\t");
    }
    */
    
    if(temp[2].equals("AM"))
    {
      toks[0] = (Integer.parseInt(temp[0]))%12 + "";
    }
    else
    {
      toks[0] = ((Integer.parseInt(temp[0]))%12 + 12)+"";
    }
    
    //moods
    for(int j=1;j<=2;j++)
    {
      if(toks[j].equals("Angry"))
        toks[j] = "0";
      else if(toks[j].equals("Irritated"))
        toks[j] = "1";
      else if(toks[j].equals("Despair"))
        toks[j] = "2";
      else if(toks[j].equals("Sad"))
        toks[j] = "3";
      else if(toks[j].equals("Business"))
        toks[j] = "4";
      else if(toks[j].equals("Busy"))
        toks[j] = "5";
      else if(toks[j].equals("Haste"))
        toks[j] = "6";
      else if(toks[j].equals("Whatever"))
        toks[j] = "7";
      else if(toks[j].equals("Tired"))
        toks[j] = "8";
      else if(toks[j].equals("Sleepy"))
        toks[j] = "9";
      else if(toks[j].equals("Excited"))
        toks[j] = "10";
      else if(toks[j].equals("Friendly"))
        toks[j] = "11";
      else if(toks[j].equals("Happy"))
        toks[j] = "12";
      else if(toks[j].equals("Intimate"))
        toks[j] = "13";
      else if(toks[j].equals("Loving"))
        toks[j] = "14";
    }
    
    newFile.println(toks[0] + "\t" + toks[1] + "\t" + toks[2]);
  }
  
  newFile.flush( );
  newFile.close( );  
}

void loadTables()
{
  //Analog
  String lines[] = loadStrings(newAnalogFile);
  analog = new String[lines.length-2][3];
  
  for(int i=2;i<lines.length;i++)
  {
    String temp[] = lines[i].split("\t");
    analog[i-2][0] = temp[0];
    analog[i-2][1] = temp[1];
    analog[i-2][2] = temp[2]; 
  }
  
  //Digital
  lines = loadStrings(newDigitalFile);
  digital = new String[lines.length-2][3];
  
  for(int i=2;i<lines.length;i++)
  {
    String temp[] = lines[i].split("\t");
    digital[i-2][0] = temp[0];
    digital[i-2][1] = temp[1];
    digital[i-2][2] = temp[2]; 
  }
}

void plotLabels()
{
  //TODO: Add text font
  
  fill(lblCol);
  textAlign(CENTER,CENTER);
  textSize(lblSize);
  
  for(int i=0;i<=23;i++)
  {
    text(i+"",graphlx-20,(i+1)*25-1);
    text(i+"",graphrx+20,(i+1)*25-1);
  }
  
  text("Sender Mood",width/4,graphdy+50);
  text("Receiver Mood",width/4 + width/2,graphdy + 50);
  text("Dark Colour = Postive Mood          Light Colour = Negative Mood",width/2,graphdy + 75);
  
  float x = graphlx - 40;
  float y = graphuy + 275;
  pushMatrix();
  translate(x,y);
  rotate(-HALF_PI);
  text("Hours",0,0);
  popMatrix();
  
  x = graphrx + 40;
  y = graphuy + 275;
  pushMatrix();
  translate(x,y);
  rotate(+HALF_PI);
  text("Hours",0,0);
  popMatrix();
}

void plotAnalogGraph()
{
  int y = 0;
  
  for(int i=0;i<analog.length;i++)
  {
    y = Integer.parseInt(analog[i][0]);
      
    mx[y] = mx[y] + (size/2);
    
    makeShape(mx[y],(y+1)*25,"analog",saCol,Integer.parseInt(analog[i][1]));
    makeShape(width-mx[y],(y+1)*25,"analog",raCol,Integer.parseInt(analog[i][2]));
    
    mx[y] = mx[y] + (size/2);
  }
}

void plotDigitalGraph()
{
  int y = 0;
  
  for(int i=0;i<digital.length;i++)
  {
    y = Integer.parseInt(digital[i][0]);
      
    mx[y] = mx[y] + (size/2);
    
    if(mx[y] >= width/2 - 25)
      continue;
    
    makeShape(mx[y],(y+1)*25,"digital",sdCol,Integer.parseInt(digital[i][1]));
    makeShape(width-mx[y],(y+1)*25,"digital",rdCol,Integer.parseInt(digital[i][2]));
    
    mx[y] = mx[y] + (size/2);
  }
}

void makeShape(float x, float y,String type,color c,int op)
{
  noStroke();
  
  int alpha = 0;
  if(type.equals("analog"))
  {
    alpha = int(map(op,0,4,50,200));
    fill(c,alpha);
    triangle(x,y-size/2,x+size/2,y+size/2,x-size/2,y+size/2);
  }
  else if(type.equals("digital"))
  {
    alpha = int(map(op,0,14,50,200));
    fill(c,alpha);
    triangle(x,y+size/2,x-size/2,y-size/2,x+size/2,y-size/2);
  }
}

void setup()
{
  processAnalogData(analogFile,newAnalogFile);
  processDigitalData(digitalFile,newDigitalFile);
  
  loadTables();
  
  size(1200,670);
  background(bgCol);
  noStroke();
  fill(glCol);
  rect(graphlx,graphuy-12.5,550,600);
  fill(grCol);
  rect(graphlx+550,graphuy-12.5,550,600);

  plotLabels();
  
  for(int i=0;i<24;i++)
  {
    mx[i] = graphlx;
  }
  plotAnalogGraph();
  plotDigitalGraph();
}