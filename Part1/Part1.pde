//File Names
String analogFile = "Analog.txt";
String digitalFile = "Digital.txt";
String newAnalogFile = "data/procAnalog.tsv";
String newDigitalFile = "data/procDigital.tsv";

//Tables
String analog[][];
String digital[][];

//Graph parameters
float graphlx = 25;
float graphuy = 50;
float graphrx = 1225;
float graphdy = 550;
int srect = 10;
int mrect = 20;
int brect = 40;

//Font parameters
int lblSize = 12;
int txtSize = 20;
color txtCol = #000000;
color lblCol = #ffffff;

//Colors
color bgCol = #000000;
color nCol = #001133;
color dCol = #ffe441;
color topCol = #C1FFC1  ;
color botCol = #BBFFFF;
color ac1 = #FFBBFF;                  //hi, thank you
color ac2 = #FFD700;                  //assg,subm
color ac3 = #00F5FF;                  //smiling
color ac4 = #FF1493;                  //other
color dc1 = #68228B;                  //email
color dc2 = #ADFF2F;                  //text message
color dc3 = #FF8C00;                  //phone call
color dc4 = #FF4040;                  //skype,fb

void processData(String readFile, String writeFile)
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

void fillGradient()
{
  int mid = int((graphlx + graphrx)/2);
  for(int i=int(graphlx);i<=mid;i++)
  {
    float t = map(i,graphlx,mid,0,1);
    color c = lerpColor(nCol,dCol,t);
    stroke(c);
    line(i,graphuy,i,graphdy);
    line(width-i,graphuy,width-i,graphdy);
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
    text(i+"",(i+1)*50,graphdy+20);
    text(i+"",(i+1)*50,graphuy-20);
  }
  
  text("Hours (Non-Digital)",graphlx+600,graphuy-40);
  text("Hours (Digital)",graphlx + 600,graphdy+40);
  
  text("1 Flower = 1 Conversation",graphlx + 200,graphdy + 60);
  text("Size of Flower = Length of Conversation",graphlx + 1000,graphdy + 60);
  text("Hover over flower to see type of conversation",graphlx+600,graphdy+60);
}

void plotAnalogGraph()
{
    int x=0;
    float y[] = new float[24];
    float size = 0;
    
    for(int i=0;i<24;i++)
      y[i] = graphuy;
    
    for(int i=0;i<analog.length;i++)
    {
      x = Integer.parseInt(analog[i][0]);
      
      if(analog[i][1].equals("Short"))
        size = srect;
      else if(analog[i][1].equals("Medium"))
        size = mrect;
      else if(analog[i][1].equals("Long"))
        size = brect;
      
      y[x] = y[x]+(size/2);
      
      color c=#000000;
      if(analog[i][2].equals("Saying 'Hi/Thank You'"))
        c = ac1;
      else if(analog[i][2].equals("Discussing Assignment/Submissions"))
        c = ac2;
      else if(analog[i][2].equals("Smiling at the person"))
        c = ac3;
      else if(analog[i][2].equals("Other"))
        c = ac4;
        
      makeShape((x+1)*50,y[x],size,c);
      
      y[x] = y[x]+(size/2);
    }
}

void plotDigitalGraph()
{
    int x=0;
    float y[] = new float[24];
    float size = 0;
    
    for(int i=0;i<24;i++)
      y[i] = graphdy;
    
    for(int i=0;i<digital.length;i++)
    {
      x = Integer.parseInt(digital[i][0]);
      
      if(digital[i][1].equals("Short"))
        size = srect;
      else if(digital[i][1].equals("Medium"))
        size = mrect;
      else if(digital[i][1].equals("Long"))
        size = brect;
      
      y[x] = y[x]-(size/2);
      
      color c=#000000;
      if(digital[i][2].equals("Email"))
        c = dc1;
      else if(digital[i][2].equals("Text Message"))
        c = dc2;
      else if(digital[i][2].equals("Phone Call"))
        c = dc3;
      else if(digital[i][2].equals("Skype/Facebook"))
        c = dc4;
      
      makeShape((x+1)*50,y[x],size,c);
      
      y[x] = y[x]-(size/2);
    }
}

void makeShape(float x, float y,float size,color c)
{
  noStroke();
  fill(c);
  
  float offset = size/5.5;
  size = size/2;
  ellipse(x+offset,y+offset,size,size);
  ellipse(x+offset,y-offset,size,size);
  ellipse(x-offset,y+offset,size,size);
  ellipse(x-offset,y-offset,size,size);
}

void setup()
{
  processData(analogFile,newAnalogFile);
  processData(digitalFile,newDigitalFile);
  
  size(1250,630);
  background(bgCol);
  //fillGradient();
  //
  noStroke();
  fill(topCol);
  rect(graphlx,graphuy,1200,250);
  fill(botCol);
  rect(graphlx,graphuy+250,1200,250);
  //
  
  plotLabels();
  
  loadTables();
  
  plotAnalogGraph();
  plotDigitalGraph();
}

void draw()
{
  //
  noStroke();
  fill(topCol);
  rect(graphlx,graphuy,1200,250);
  fill(botCol);
  rect(graphlx,graphuy+250,1200,250);
  plotAnalogGraph();
  plotDigitalGraph();
  //
  
  color tc = get(mouseX,mouseY);
  String dispText="";
  
  noStroke();
  textAlign(CENTER,CENTER);
  fill(txtCol);
  textSize(txtSize);
  
  if(tc==ac1)
    dispText = "Saying 'Hi/Thank You'";
  else if(tc==ac2)
    dispText = "Discussing Assignment/Submissions";
  else if(tc==ac3)
    dispText = "Smiling at the person";
  else if(tc==ac4)
    dispText = "Other";  
  else if(tc==dc1)
    dispText = "Email";
  else if(tc==dc2)
    dispText = "Text Message";
  else if(tc==dc3)
    dispText = "Phone Call";
  else if(tc==dc4)
    dispText = "Skype/Facebook";
    
  text(dispText,width/2,height/2-50);
}