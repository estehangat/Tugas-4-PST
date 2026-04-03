// === PIN DEFINITIONS ===
const int VEH_RED    = 6;
const int VEH_YELLOW = 5;
const int VEH_GREEN  = 4;
const int PED_A_RED   = 8;
const int PED_A_GREEN = 7;
const int PED_B_RED   = 3;
const int PED_B_GREEN = 2;
const int BUTTON_A = 10;
const int BUTTON_B = 9;

// === TIMING (ms) ===
const unsigned long WALK_DURATION   = 6000;
const unsigned long BLINK_INTERVAL  = 400;
const int           BLINK_MAX       = 3;

// === STATE MACHINE ===
enum State { IDLE, WALK, YELLOW };
State currentState = IDLE;
unsigned long stateStartTime = 0;
bool reqA = false;
bool reqB = false;

// === BLINK TRACKING ===
int  blinkCount     = 0;
bool blinkOn        = false;
unsigned long lastBlinkTime = 0;

void setup() {
  pinMode(VEH_RED,    OUTPUT);
  pinMode(VEH_YELLOW, OUTPUT);
  pinMode(VEH_GREEN,  OUTPUT);
  pinMode(PED_A_RED,   OUTPUT);
  pinMode(PED_A_GREEN, OUTPUT);
  pinMode(PED_B_RED,   OUTPUT);
  pinMode(PED_B_GREEN, OUTPUT);
  pinMode(BUTTON_A, INPUT_PULLUP);
  pinMode(BUTTON_B, INPUT_PULLUP);
  setIdle();
  Serial.begin(9600);
  Serial.println("Sistem aktif - Kondisi awal");
}

void loop() {
  unsigned long now = millis();

  if (currentState == IDLE) {
    if (digitalRead(BUTTON_A) == LOW && !reqA) {
      delay(50);
      reqA = true;
      Serial.println("[REQ] Tombol A ditekan");
    }
    if (digitalRead(BUTTON_B) == LOW && !reqB) {
      delay(50);
      reqB = true;
      Serial.println("[REQ] Tombol B ditekan");
    }
    if (reqA || reqB) {
      startWalk();
    }
  }
  else if (currentState == WALK) {
    if (now - stateStartTime >= WALK_DURATION) {
      startYellow();
    }
  }
  else if (currentState == YELLOW) {
    if (blinkCount >= BLINK_MAX) {
      setIdle();
      return;
    }
    if (now - lastBlinkTime >= BLINK_INTERVAL) {
      lastBlinkTime = now;
      blinkOn = !blinkOn;
      digitalWrite(VEH_YELLOW, blinkOn ? HIGH : LOW);
      if (!blinkOn) {
        blinkCount++;
        Serial.print("[YELLOW] Kedip ke-");
        Serial.println(blinkCount);
      }
    }
  }
}

void setIdle() {
  digitalWrite(VEH_RED,    LOW);
  digitalWrite(VEH_YELLOW, LOW);
  digitalWrite(VEH_GREEN,  HIGH);
  digitalWrite(PED_A_RED,   HIGH);
  digitalWrite(PED_A_GREEN, LOW);
  digitalWrite(PED_B_RED,   HIGH);
  digitalWrite(PED_B_GREEN, LOW);
  currentState = IDLE;
  reqA = false;
  reqB = false;
  Serial.println("[IDLE] Kendaraan HIJAU | Penyebrang MERAH");
}

void startWalk() {
  digitalWrite(VEH_RED,    HIGH);
  digitalWrite(VEH_YELLOW, LOW);
  digitalWrite(VEH_GREEN,  LOW);
  digitalWrite(PED_A_RED,   LOW);
  digitalWrite(PED_A_GREEN, HIGH);
  digitalWrite(PED_B_RED,   LOW);
  digitalWrite(PED_B_GREEN, HIGH);
  currentState   = WALK;
  stateStartTime = millis();
  Serial.print("[WALK] Permintaan dari: ");
  if (reqA && reqB) Serial.println("Tombol A & B");
  else if (reqA)    Serial.println("Tombol A");
  else              Serial.println("Tombol B");
}

void startYellow() {
  digitalWrite(VEH_RED,    LOW);
  digitalWrite(VEH_GREEN,  LOW);
  digitalWrite(PED_A_RED,   HIGH);
  digitalWrite(PED_A_GREEN, LOW);
  digitalWrite(PED_B_RED,   HIGH);
  digitalWrite(PED_B_GREEN, LOW);

  blinkCount    = 0;
  blinkOn       = false;
  lastBlinkTime = millis();
  digitalWrite(VEH_YELLOW, LOW);

  currentState   = YELLOW;
  stateStartTime = millis();
  Serial.println("[YELLOW] Mulai kedip 3x | Penyebrang MERAH");
}
