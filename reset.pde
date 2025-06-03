// --- GAME OVER SCREEN ---
void gameOverScreen() {
  textAlign(CENTER, CENTER);
  fill(255, 100, 100);
  textSize(36);
  text(winner + " WINS!", width / 2, height / 2);
  textSize(18);
  fill(255);
  text("Click to return to menu", width / 2, height / 2 + 40);
}
