import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer lofi;

String mode = "intro";
boolean aiMode = false;

float ballX, ballY, ballVX, ballVY;
float ballSize = 15;

float leftY, rightY;
float paddleHeight = 60;
float paddleWidth = 10;

boolean wPressed = false, sPressed = false;
boolean upPressed = false, downPressed = false;

int scoreA = 0, scoreB = 0;
String winner = "";
float pulse = 0;

void setup() {
  size(700, 500);
  minim = new Minim(this);
  lofi = minim.loadFile("resonance.mp3", 2048);
  lofi.loop();
  resetGame();
}

void resetGame() {
  ballX = width / 2;
  ballY = height / 2;
  ballVX = -4;
  ballVY = random(-2, 2);
  leftY = height / 2 - paddleHeight / 2;
  rightY = height / 2 - paddleHeight / 2;
  scoreA = 0;
  scoreB = 0;
  winner = "";
}

void draw() {
  drawBackground();
  if (mode.equals("intro")) introScreen();
  else if (mode.equals("game")) gameScreen();
  else if (mode.equals("gameover")) gameOverScreen();
}


void moveBall() {
  ballX += ballVX;
  ballY += ballVY;

  if (ballY < ballSize/2 || ballY > height - ballSize/2) ballVY *= -1;

  if (ballX - ballSize/2 < 30 + paddleWidth && ballY > leftY && ballY < leftY + paddleHeight && ballVX < 0) {
    ballVX *= -1.1;
    ballVY *= 1.05;
  }

  if (ballX + ballSize/2 > width - 40 && ballY > rightY && ballY < rightY + paddleHeight && ballVX > 0) {
    ballVX *= -1.1;
    ballVY *= 1.05;
  }

  if (ballX < 0) {
    scoreB = min(5, scoreB + 1);
    if (scoreB == 5) { winner = "RIGHT"; mode = "gameover"; }
    resetBall();
  }
  if (ballX > width) {
    scoreA = min(5, scoreA + 1);
    if (scoreA == 5) { winner = "LEFT"; mode = "gameover"; }
    resetBall();
  }
}

void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballVX = -4;
  ballVY = random(-2, 2);
}

// --- PADDLE CONTROL ---
void movePaddles() {
  if (wPressed) leftY -= 5;
  if (sPressed) leftY += 5;

  if (aiMode) {
    if (ballY < rightY + paddleHeight/2) rightY -= 4;
    if (ballY > rightY + paddleHeight/2) rightY += 4;
  } else {
    if (upPressed) rightY -= 5;
    if (downPressed) rightY += 5;
  }

  leftY = constrain(leftY, 0, height - paddleHeight);
  rightY = constrain(rightY, 0, height - paddleHeight);
}

void drawButton(float x, float y, float w, float h, String label) {
  boolean hover = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  fill(hover ? 220 : 255);
  stroke(hover ? color(255, 0, 0) : 0);
  strokeWeight(2);
  rect(x, y, w, h, 6);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(18);
  text(label, x + w/2, y + h/2);
}
