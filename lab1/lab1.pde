int currentTime;
int deltaTime;
int previousTime;
int lastParticleTime = 0;
int maxParticleNumber = 100;
int particleRate = 75;
int distance = 175;


Emitter emitter;
Player player;

void setup() {
  size(800, 600);
  emitter = new Emitter (new PVector( width / 2, height / 4), maxParticleNumber, particleRate);
  
  emitter.setDistance(distance);
  player = new Player(new PVector(width / 2, height * 3 / 4));
  player.setDistance(distance);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  update(deltaTime);
  display();
}

void update(int deltaTime) {
  emitter.update(deltaTime, player);
  player.update(deltaTime);
}

void display() {
  background(255);

  
  player.display();
  emitter.display();
}

void keyPressed() {
  player.keyPressed();
}
