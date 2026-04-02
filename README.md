# Tugas-4-PST

## Overview
Project ini merupakan simulasi sistem lampu lalu lintas sederhana berbasis Arduino yang dilengkapi dengan tombol penyeberang di dua sisi jalan.

Sistem menggunakan konsep Finite State Machine (FSM) dengan tiga kondisi utama:
- IDLE: kendaraan berjalan, pejalan kaki berhenti
- WALK: kendaraan berhenti, pejalan kaki berjalan
- YELLOW: transisi sebelum kembali ke kondisi awal

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
| Merah    | 3   |
| Hijau    | 2   |

### Tombol
| Komponen | Pin |
|----------|-----|
| Tombol A | 10  |
| Tombol B | 9   |

## Timing Sistem
| State  | Durasi |
|--------|--------|
| WALK   | 6000 ms |
| YELLOW | 3000 ms |

## Cara Kerja Sistem
- Kondisi awal:
  - Lampu kendaraan hijau
  - Lampu pedestrian merah
- Saat ditekan:
  - Lampu kendaraan berubah menjadi merah
  - Lampu pedestrian berubah menjadi hijau
- Setelah waktu tertentu:
  - Lampu pedestrian kembali merah
  - Lampu kendaraan memasuki fase kuning (transisi)
- Sistem kembali ke kondisi awal:
  - Lampu kendaraan hijau
  - Lampu pedestrian tetap merah

## Konsep yang Digunakan
- Finite State Machine
- Non-blocking timing menggunakan millis
- Input pull-up internal
- Debounce sederhana

## Catatan
- Tombol menggunakan active LOW
- Pastikan tombol terhubung ke GND
- Sistem dapat menerima input dari kedua sisi secara bersamaan
