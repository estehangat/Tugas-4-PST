# Tugas-4-PST
## Overview
Project ini merupakan simulasi sistem lampu lalu lintas sederhana berbasis Arduino yang dilengkapi dengan tombol penyeberang di dua sisi jalan.
Sistem menggunakan konsep Finite State Machine (FSM) dengan tiga kondisi utama:
- IDLE: kendaraan berjalan, pejalan kaki berhenti
- WALK: kendaraan berhenti, pejalan kaki berjalan
- YELLOW: transisi sebelum kembali ke kondisi awal (lampu kuning kedip 3x)

Pengguna dapat menekan tombol di sisi A atau B untuk meminta izin menyeberang.

## Alat dan Bahan
- Arduino Uno
- Breadboard
- LED:
  - 1x Merah (kendaraan)
  - 1x Kuning (kendaraan)
  - 1x Hijau (kendaraan)
  - 2x Merah (pejalan kaki)
  - 2x Hijau (pejalan kaki)
- 2x Push Button
- Resistor 220 ohm untuk LED
- Kabel jumper

## Schema
![Schema](Tugas%204_Daiva%20Paundra%20Gevano.png)

## Pin Mapping
### Lampu Kendaraan
| Komponen | Pin |
|----------|-----|
| Merah    | 6   |
| Kuning   | 5   |
| Hijau    | 4   |

### Pedestrian Sisi A
| Komponen | Pin |
|----------|-----|
| Merah    | 8   |
| Hijau    | 7   |

### Pedestrian Sisi B
| Komponen | Pin |
|----------|-----|
| Merah    | 11  |
| Hijau    | 12  |

### Tombol
| Komponen | Pin | Interrupt |
|----------|-----|-----------|
| Tombol A | 2   | INT0      |
| Tombol B | 3   | INT1      |

## Timing Sistem
| State  | Durasi  | Keterangan                        |
|--------|---------|-----------------------------------|
| WALK   | 6000 ms | Pejalan kaki menyeberang          |
| YELLOW | ~2400 ms | Lampu kuning kedip 3x (400ms on/off) |

## Cara Kerja Sistem
- Kondisi awal (IDLE):
  - Lampu kendaraan hijau
  - Lampu pedestrian merah
- Saat tombol ditekan (interrupt terpicu):
  - Sistem langsung mendeteksi input melalui Hardware Interrupt
  - Lampu kendaraan berubah menjadi merah
  - Lampu pedestrian berubah menjadi hijau
- Setelah waktu WALK habis:
  - Lampu pedestrian kembali merah
  - Lampu kendaraan memasuki fase kuning (kedip 3x)
- Sistem kembali ke kondisi awal:
  - Lampu kendaraan hijau
  - Lampu pedestrian tetap merah

## Konsep yang Digunakan
- Finite State Machine (FSM)
- Hardware Interrupt (ISR) untuk deteksi tombol yang responsif
- Non-blocking timing menggunakan millis()
- Input pull-up internal
- Variabel `volatile` untuk komunikasi antara ISR dan program utama

## Catatan
- Tombol menggunakan active LOW (terhubung ke GND)
- Tombol A dan B **wajib** menggunakan pin 2 dan 3 karena merupakan satu-satunya pin yang mendukung External Interrupt pada Arduino Uno
- Pin 2 dan 3 tidak boleh digunakan untuk komponen lain (LED, dsb)
- PED_B_GREEN dan PED_B_RED dipindah ke pin 12 dan 11 akibat pin 2 dan 3 digunakan untuk interrupt
- Sistem dapat menerima input dari kedua sisi secara bersamaan
