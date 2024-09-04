// Template for Processing sketches

int canvasWidth = 800;
int canvasHeight = 600;
int backgroundColor = 255; // White background

void setup() {
  size(canvasWidth, canvasHeight);
  background(backgroundColor);
  frameRate(60); // Set frame rate
}

void draw() {
  // Main drawing loop
  background(backgroundColor); // Clear the screen each frame
  // Add your drawing code here
}

void keyPressed() {
  // Handle key press events
}

void mousePressed() {
  // Handle mouse press events
}

// Custom reusable function example
void drawCenteredCircle(float x, float y, float diameter) {
  ellipse(x, y, diameter, diameter);
}
