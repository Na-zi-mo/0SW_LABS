class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int distance;
  int mass = 5;
  int colorParticle = 175;
  int v1 = 255;
  int v2 = 255;
  int v3 = 255;


  Particle() {
    position = new PVector(width/2, height/4);
    initialize();
  }

  Particle(PVector l) {
    position = l.get();
    initialize();
  }

  void initialize() {
    velocity = new PVector(random(-1, 1), random(-1, 0));
    acceleration = new PVector(0, 0.05);
    lifespan = 255;
  }

  
  void update(int deltaTime, PVector target, int dist) {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.set(0,0.05);
    velocity.limit(5);
    
    distance = dist;
    lifespan -= 2.0;

    if (isDead())
    {
      reset();
    }

    if (PVector.dist(target, position) < distance) {
      v1 = 0;
      v2 = 255;
      v3 = 102;
    } else {
      v1 = 255;
      v2 = 255;
      v3 = 255;
    }
  }
  
  void applyForce (PVector f) {
    acceleration.add(f.copy());
  }

  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(v1,v2,v3,lifespan);
    ellipse(position.x, position.y, 10, 10);
  }

  boolean isDead() {
    return lifespan < 0.0;
  }

  void reset() {
    position.set (width/2, height/4);
    velocity.set (random(-1, 1), random(-1, 0));
    lifespan = 255;
  }
}
