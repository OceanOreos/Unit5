String mode = "intro";
PVector ball, ballSpeed;
float ballRadius = 15;
PVector leftPaddle, rightPaddle;
float paddleRadius = 40;
boolean wPressed = false, sPressed = false;
boolean upPressed = false, downPressed = false;
int scoreA = 0, scoreB = 0;
String winner = "";

void setup() {
  size(800, 400);
  resetGame();
}

void resetGame() {
  ball = new PVector(width / 2, height / 2);
  ballSpeed = PVector.random2D();
  ballSpeed.setMag(3);  // Start off slower

  leftPaddle = new PVector(50, height / 2);
  rightPaddle = new PVector(width - 50, height / 2);
  scoreA = 0;
  scoreB = 0;
  winner = "";
}

void draw() {
  background(30);

  if (mode.equals("intro")) {
    drawIntro();
  } else if (mode.equals("game")) {
    drawGame();
  } else if (mode.equals("gameover")) {
    drawGameOver();
  }
}

void drawIntro() {
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(60);
  text("PONG", width / 2, height / 2 - 60);

  fill(255);
  rectMode(CENTER);
  rect(width / 2, height / 2 + 20, 200, 60, 10);
  fill(30);
  textSize(24);
  text("Play Now", width / 2, height / 2 + 20);
}

void drawGameOver() {
  textAlign(CENTER, CENTER);
  textSize(40);
  fill(255, 100, 100);
  text(winner + " WINS!", width / 2, height / 2);
  textSize(20);
  fill(200);
  text("Click to restart", width / 2, height / 2 + 40);
}

void drawGame() {
  drawMiddleLine();
  drawSemicircles();

  // Draw ball
  fill(255);
  ellipse(ball.x, ball.y, ballRadius * 2, ballRadius * 2);

  // Draw paddles as semicircles
  fill(255);
  arc(leftPaddle.x, leftPaddle.y, paddleRadius * 2, paddleRadius * 2, HALF_PI, -HALF_PI); // Player A
  arc(rightPaddle.x, rightPaddle.y, paddleRadius * 2, paddleRadius * 2, -HALF_PI, HALF_PI); // Player B

  moveBall();
  movePaddles();

  // Draw score
  fill(255);
  textSize(24);
  textAlign(LEFT);
  text("A", 10, 30);
  text(scoreA, 30, 30);
  textAlign(RIGHT);
  text("B", width - 30, 30);
  text(scoreB, width - 10, 30);
}

void drawMiddleLine() {
  stroke(255);
  strokeWeight(2);
  line(width / 2, 0, width / 2, height);
  noStroke();
}

void drawSemicircles() {
  noFill();
  stroke(100, 200, 255);
  strokeWeight(4);
  arc(0, height / 0
  
  , 100, 100, HALF_PI, -HALF_PI);
  arc(width, height / 2, 100, 100, -HALF_PI, HALF_PI);
  noStroke();
}

void moveBall() {
  ball.add(ballSpeed);

  if (ball.y < ballRadius || ball.y > height - ballRadius) {
    ballSpeed.y *= -1;
  }

  // Paddle collisions (and speed up)
  if (ball.dist(leftPaddle) < ballRadius + paddleRadius && ballSpeed.x < 0) {
    ballSpeed.x *= -1.05;  // Increase speed
    ballSpeed.y *= 1.05;
  }
  if (ball.dist(rightPaddle) < ballRadius + paddleRadius && ballSpeed.x > 0) {
    ballSpeed.x *= -1.05;
    ballSpeed.y *= 1.05;
  }

  // Scoring
  if (ball.x < 0) {
    scoreB++;
    checkWin();
    resetBall();
  } else if (ball.x > width) {
    scoreA++;
    checkWin();
    resetBall();
  }
}

void resetBall() {
  ball.set(width / 2, height / 2);
  ballSpeed = PVector.random2D();
  ballSpeed.setMag(3);  // Reset to slow speed again
}

void checkWin() {
  if (scoreA == 5) {
    winner = "PLAYER A";
    mode = "gameover";
  } else if (scoreB == 5) {
    winner = "PLAYER B";
    mode = "gameover";
  }
}

void movePaddles() {
  if (wPressed) leftPaddle.y -= 5;
  if (sPressed) leftPaddle.y += 5;
  if (upPressed) rightPaddle.y -= 5;
  if (downPressed) rightPaddle.y += 5;

  leftPaddle.y = constrain(leftPaddle.y, paddleRadius, height - paddleRadius);
  rightPaddle.y = constrain(rightPaddle.y, paddleRadius, height - paddleRadius);
}

void mousePressed() {
  if (mode.equals("intro")) {
    if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100 &&
        mouseY > height / 2 - 10 && mouseY < height / 2 + 50) {
      mode = "game";
    }
  } else if (mode.equals("gameover")) {
    resetGame();
    mode = "intro";
  }
}

void keyPressed() {
  if (key == 'w') wPressed = true;
  if (key == 's') sPressed = true;
  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
}

void keyReleased() {
  if (key == 'w') wPressed = false;
  if (key == 's') sPressed = false;
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
}
