int[] distances = new int[6];  // Array to store simulated sensor data
float waveSpeed = 0.005;       // Reduced speed of the wave animation
float angleOffset = 0;         // Angle offset for the wave animation

void setup() {
  size(600, 600);
  frameRate(10);  // Control the speed of updates
  noStroke();     // Disable strokes for shapes
}

void draw() {
  background(0);  // Set background to black
  translate(width / 2, height / 2);  // Move origin to center of screen

  // Simulate sensor readings (random values between 10 and 400 cm)
  simulateSensorData();

  // Glow effect: draw larger, transparent shapes before the main shape
  drawGlowEffect();

  // Set the main wave color (green with 80 transparency)
  fill(0, 255, 0, 80);

  for (int i = 0; i < 6; i++) {
    float startAngle = map(i, 0, 6, 0, TWO_PI);  // Starting angle for each sensor wave
    float endAngle = map(i + 1, 0, 6, 0, TWO_PI);  // Ending angle for each sensor wave

    // Simulate distance (this will later be replaced with actual sensor data)
    float waveRadius = map(distances[i], 0, 400, 250, 50);  // Radius based on sensor distance

    beginShape();
    
    // Fill from the boundary (waveRadius) to the center (0)
    for (float r = waveRadius; r > 0; r -= 5) {  // Move inward from outer boundary to the center
      for (float angle = startAngle; angle <= endAngle; angle += 0.01) {
        float wave = sin(angleOffset + angle * 5) * 10;  // Sinusoidal wave effect
        float x = (r + wave) * cos(angle);  // Calculate x based on angle and wave radius
        float y = (r + wave) * sin(angle);  // Calculate y based on angle and wave radius
        vertex(x, y);  // Add the vertex to the shape
      }
    }
    
    endShape(CLOSE);  // Close the shape to fill the wave
  }

  angleOffset += waveSpeed;  // Animate the wave movement

  // Draw the car in the center (represented as a small circle)
  fill(255);  // Set fill color to white for the car
  ellipse(0, 0, 30, 30);  // Draw a small circle representing the car
}

// Function to draw the glow effect
void drawGlowEffect() {
  for (int glow = 0; glow < 5; glow++) {  // Draw multiple layers for a glowing effect
    fill(0, 255, 0, 30 - glow * 5);  // Increase transparency for outer layers
    for (int i = 0; i < 6; i++) {
      float startAngle = map(i, 0, 6, 0, TWO_PI);
      float endAngle = map(i + 1, 0, 6, 0, TWO_PI);
      float waveRadius = map(distances[i], 0, 400, 250 + glow * 10, 50 + glow * 10);

      beginShape();
      for (float r = waveRadius; r > 0; r -= 5) {
        for (float angle = startAngle; angle <= endAngle; angle += 0.01) {
          float wave = sin(angleOffset + angle * 5) * 10;
          float x = (r + wave) * cos(angle);
          float y = (r + wave) * sin(angle);
          vertex(x, y);
        }
      }
      endShape(CLOSE);
    }
  }
}

// Simulate sensor data by assigning random distances
void simulateSensorData() {
  for (int i = 0; i < 6; i++) {
    distances[i] = int(random(10, 400));  // Random distance between 10 and 400 cm
  }
}
