float u = 0.918;
int numPoints = 2000;
int iterations = 1000;

float scale = 50;
PVector offset = new PVector(-120, -120);
PVector[] samplePoints = new PVector[numPoints];

void setup() {
  size(1920, 1080);
  background(0);
  stroke(255, 5);
  noFill();
  noLoop();
}

void draw() {
  background(0);
  translate(width/2 + offset.x, height/2 + offset.y);

  for (int i = 0; i < numPoints; i++) {
    if (samplePoints[i] == null) {
      samplePoints[i] = new PVector(random(0, width), random(0, height));
    }
    ArrayList<PVector> iTrajectory = computeIkedaTrajectory(samplePoints[i].x, samplePoints[i].y);
    plotIkedaTrajectory(iTrajectory);
  }
}

void plotIkedaTrajectory(ArrayList<PVector> trajectory) {
  beginShape();
  for (PVector v : trajectory) {
    vertex(v.x*scale, v.y*scale);
  }
  endShape();
}

public ArrayList<PVector> computeIkedaTrajectory(float x, float y) {
  ArrayList<PVector> trajectory = new ArrayList<PVector>();
  for (int n = 0; n < numPoints; n++) {
    float t = 0.4 - 6 / (1 + pow(x, 2) + pow(y, 2));
    float x1 = 1 + u * (x * cos(t) - y * sin(t));
    float y1 = u * (x * sin(t) + y * cos(t));
    x = x1;
    y = y1;

    trajectory.add(new PVector(x, y));
  }
  return trajectory;
}
