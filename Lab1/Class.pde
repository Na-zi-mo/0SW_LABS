// Ball.pde

class Ball {
  float x, y; // Position
  float diameter; // Diameter of the ball
  float xSpeed, ySpeed; // Speed in x and y direction
  
  // Constructor
  Ball(float x, float y, float diameter, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  
  // Update position based on speed
  void update() {
    x += xSpeed;
    y += ySpeed;
    
    // Bounce off the edges
    if (x > width - diameter / 2 || x < diameter / 2) {
      xSpeed *= -1;
    }
    if (y > height - diameter / 2 || y < diameter / 2) {
      ySpeed *= -1;
    }
  }
  
  // Display the ball
  void display() {
    fill(150, 0, 255); // Purple color
    noStroke();
    ellipse(x, y, diameter, diameter);
  }
}
