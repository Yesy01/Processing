int cols = 200;
int rows = 200;
float[][] previous = new float[cols][rows];
float[][] current = new float[cols][rows];
float dampening = 0.99;

void setup() {
  size(600, 600);
  cols = width;
  rows = height;
  current = new float[cols][rows];
  previous = new float[cols][rows];
  background(255); // Set the background to white
}

void mousePressed() {
  previous[mouseX][mouseY] = 500;
}

void mouseDragged() {
  previous[mouseX][mouseY] = 1000;
}

void draw() {
  loadPixels();

  for (int i = 1; i < cols - 1; i++) {
    for (int j = 1; j < rows - 1; j++) {
      current[i][j] = (
        previous[i-1][j] +
        previous[i+1][j] +
        previous[i][j-1] +
        previous[i][j+1]) / 2 -
        current[i][j];
      current[i][j] *= dampening;

      int index = i + j * cols;
      
      // Map the current value to a color gradient
      float value = current[i][j];
      int r = (int) map(value, -1000, 1000, 0, 30); // Red value
      int g = (int) map(value, -1000, 1000, 0, 50); // Green value
      int b = (int) map(value, -1000, 1000, 0, 100); // Blue value

      pixels[index] = color(r, g, b);
    }
  }
  
  updatePixels();

  float[][] temp = previous;
  previous = current;
  current = temp;
}
