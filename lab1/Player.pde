class Player {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float G = 5;
  int distance;
  int mass = 100;

  Player(PVector loc) {
    location = loc.copy();
    velocity = new PVector(0, 0);
  }

  void update(int deltaTime) {
    location.add(velocity);
    velocity.mult(0);
  }

  void setDistance(int dist) {
    distance = dist;
  }

  void display() {

    drawPacman();
  }
  void drawPacman() {
    fill(255);
    ellipse(location.x, location.y, distance*2, distance*2);
    fill(255, 255, 0);

    arc(location.x, location.y, 100, 100, radians(-70), radians(250));

    fill(0);
    ellipse(location.x - 22, location.y - 10, 10, 10);
    ellipse(location.x + 22, location.y - 10, 10, 10);
  }

  PVector attract(Particle p) {
    PVector force = PVector.sub(this.location, p.position);
    float dist = PVector.dist(this.location, p.position);

    if (dist < distance) {
      dist = constrain(dist, 5, distance);
      float strength = (G * this.mass * p.mass) / (dist * dist);
      force.setMag(strength);
      return force;
    } else {
      return new PVector(0, 0);
    }
  }

  void keyPressed() {
    if (key == 'a') {
      player.velocity.x = -2;
    } else if (key == 'd') {
      player.velocity.x = 2;
    }
  }
}
