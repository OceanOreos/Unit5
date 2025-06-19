// --- INTRO SCREEN ---
void introScreen() {
  pulse += 0.05;
  float s = 1.1 + 0.05 * sin(pulse);
  textAlign(CENTER, CENTER);
  textSize(60 * s);
  fill(255, 50 + 150 * abs(sin(pulse)));
  text("PONG", width/2, height/2 - 70);

  drawButton(width/2 - 160, height/2 + 20, 120, 50, "1 Player");
  drawButton(width/2 + 40, height/2 + 20, 120, 50, "2 Player");
}
