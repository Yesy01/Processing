int cols = 200;
int rows = 200;
float [][] previous =new float [cols][rows];
float [][] current = new float [cols][rows];

float dampening = 0.99;
void setup() {
  size(600, 600);
  cols = width;
  rows = height;
  current = new float[cols][rows];
  previous = new float[cols][rows];
}

void mousePressed() {
  previous[mouseX][mouseY] = 500;
}
void mouseDragged() {
  previous[mouseX][mouseY] = 1000;
}

void draw() {
  background(0);

  loadPixels();
  for (int i = 1; i <cols-1; i++) {
    for (int j = 1; j< rows-1; j++) {
      current[i][j] = (
        previous[i-1][j] +
        previous[i+1][j] +
        previous[i][j-1] +
        previous[i][j+1]) / 2 -
        current[i][j];
      current[i][j] = current[i][j] * dampening;
      int index = i + j * cols;
      pixels[index] = color(current[i][j]);
    }
  }
  updatePixels();

  float [][] temp = previous;
  previous = current;
  current = temp;
}
