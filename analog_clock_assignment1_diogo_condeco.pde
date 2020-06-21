/*******************************************************************************
 *
 *  Draft Processing code for the first assignment of the 'Introduction to
 *  Computer Graphics' laboratory course.
 *
 *******************************************************************************/

// Center
int cx, cy;

// Current time
int hours = 0;
int minutes = 0;
int seconds = 0;

// Extras
int days = 0;
int months = 0;
int years = 0;

// Seconds
float secondsRadiusX;
float secondsRadiusY;

// Minutes
float minutesRadiusX;
float minutesRadiusY;

// Hours
float hoursRadiusX;
float hoursRadiusY;

float clockDiameter;

// color bgColor = color(0, 191, 255); // background color
color bgColor = color(0); // background color
color secondsColor = color(255, 30, 150);
color minutesColor = color(0, 100, 80);
color hoursColor = color(50, 120, 250);

void setup()
{
  // Init our window
  size(800, 800);

  // Center
  cx = width / 2;
  cy = height / 2;

  // Diameter
  int radius = min(width, height) / 2;
  clockDiameter = radius * 1.8;

  // Set the frame rate
  frameRate(60);

  // Draw the first frame
  draw();
}

void draw()
{
  // Extract the current time
  seconds = second();
  minutes = minute();
  hours = hour() % 12;

  //Extras
  days = day();
  months = month();
  years = year();

  // Clear the canvas with the default background color
  background(bgColor);

  strokeWeight(8);
  noFill();

  String sMonths = String.valueOf(months);

  // Getting the month name
  switch(months) {
  case 1: 
    sMonths = "January";
    break;
  case 2: 
    sMonths = "February";
    break;
  case 3: 
    sMonths = "March";
    break;
  case 4: 
    sMonths = "April";
    break;
  case 5: 
    sMonths = "May";
    break;
  case 6: 
    sMonths = "June";
    break;
  case 7: 
    sMonths = "July";
    break;
  case 8: 
    sMonths = "August";
    break;
  case 9: 
    sMonths = "September";
    break;
  case 10: 
    sMonths = "October";
    break;
  case 11: 
    sMonths = "November";
    break;
  case 12: 
    sMonths = "December";
    break;
  }

  // Days + Months + Years
  textSize(32);
  text(days + " " + sMonths + " "  + years, cx - 120, cy + 100); 

  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(seconds, 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minutes + norm(seconds, 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hours + norm(minutes, 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

  // Seconds
  secondsRadiusX = cx + cos(-(PI/2)+(seconds * (2*PI)/60)) - 110;
  secondsRadiusY = cy + sin(-(PI/2)+(seconds * (2*PI)/60)) - 110;

  // Minutes
  minutesRadiusX = cx + cos(-(PI/2)+(minutes * (2*PI)/60)) - 160;
  minutesRadiusY = cy + sin(-(PI/2)+(minutes * (2*PI)/60)) - 160;

  // Hours
  hoursRadiusX = cx + cos(-(PI/2)+(hours * (2*PI)/12)) - 200;
  hoursRadiusY = cy + sin(-(PI/2)+(hours * (2*PI)/12)) - 200;

  // Draw the hands and the circles of the clock
  strokeWeight(10);
  // seconds
  stroke(secondsColor);
  line(cx, cy, cx + cos(s) * secondsRadiusX, cy + sin(s) * secondsRadiusY);
  arc(cx, cy, clockDiameter, clockDiameter, -TWO_PI/4, s);
  // minutes
  stroke(minutesColor);
  line(cx, cy, cx + cos(m) * minutesRadiusX, cy + sin(m) * minutesRadiusY);
  arc(cx, cy, clockDiameter - 30, clockDiameter - 30, -TWO_PI/4, m);
  // hours
  stroke(hoursColor);
  line(cx, cy, cx + cos(h) * hoursRadiusX, cy + sin(h) * hoursRadiusY);
  arc(cx, cy, clockDiameter - 60, clockDiameter - 60, -TWO_PI/4, h);

  // Draw the minute ticks
  strokeWeight(6);
  stroke(235, 230, 50);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadiusX;
    float y = cy + sin(angle) * secondsRadiusY;
    vertex(x, y);
  }
  endShape();

  // Draw the Dial
  for (int i = 0; i < 60; i+=1) {
    if (i % 5 == 0) {
      strokeWeight(6);
      stroke(235, 80, 50);
      float x0 = cx + (cx - 22) * cos(i * ((2 * PI) / 60));
      float y0 = cy + (cy - 22) * sin(i * ((2 * PI) / 60));
      float x1 = cx + (cx) * cos(i * ((2 * PI) / 60));
      float y1 = cy + (cy) * sin(i * ((2 * PI) / 60));
      line(x0, y0, x1, y1);
    } else {
      strokeWeight(2);
      stroke(40, 50, 235);
      float x0 = cx + (cx - 10) * cos(i * ((2 * PI) / 60));
      float y0 = cy + (cy - 10) * sin(i * ((2 * PI) / 60));
      float x1 = cx + (cx) * cos(i * ((2 * PI) / 60));
      float y1 = cy + (cy) * sin(i * ((2 * PI) / 60));
      line(x0, y0, x1, y1);
    }
  }

  stroke(0);
  strokeWeight(6);
  point(cx, cy);
}
