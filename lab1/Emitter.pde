class Emitter {
  PVector position;
  int particleRate;
  int lastParticleTime;
  int maxParticles;
  int distance;

  ArrayList<Particle> particles;


  Emitter(PVector l, int max, int rate) {
    position = l.copy();
    particleRate = rate;
    lastParticleTime = 0;
    maxParticles = max;
    particles = new ArrayList<Particle>();
  }
  
  void setDistance(int dist) {
    distance = dist;
  }

  
  void update(int deltaTime, Player player) {
    if (millis() - lastParticleTime > particleRate && particles.size() < maxParticles) {
      lastParticleTime = millis();
      particles.add(new Particle(position));
    }

    for (Particle p : particles) {

      p.update(deltaTime, player.location, distance);
      
      p.applyForce(player.attract(p));
    }
  }

  void display() {
    for (Particle p : particles) {
      p.display();
    }
  }
}
