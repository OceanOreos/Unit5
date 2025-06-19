void gameScreen() {
  stroke(255);
  line(width / 2, 0, width / 2, height);
  noStroke();

  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
  rect(30, leftY, paddleWidth, paddleHeight);
  rect(width - 40, rightY, paddleWidth, paddleHeight);

  textAlign(LEFT); textSize(20); fill(255);
  text("A", 10, 25); text(scoreA, 30, 25);
  textAlign(RIGHT);
  text("B", width - 30, 25); text(scoreB, width - 10, 25);

  moveBall();
  movePaddles();
}
