void mousePressed() {
  if (mode.equals("intro")) {
    if (mouseX > width/2 - 160 && mouseX < width/2 - 40 && mouseY > height/2 + 20 && mouseY < height/2 + 70) {
      aiMode = true; mode = "game";
    }
    if (mouseX > width/2 + 40 && mouseX < width/2 + 160 && mouseY > height/2 + 20 && mouseY < height/2 + 70) {
      aiMode = false; mode = "game";
    }
  } else if (mode.equals("gameover")) {
    resetGame();
    mode = "intro";
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    if (mode.equals("game")) paused = !paused;
  }
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
