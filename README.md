# 🍽️ Restaurant App
Aplikasi Flutter yang menampilkan daftar restoran, detail restoran, daftar favorit, pengaturan tema gelap & terang, serta fitur daily reminder.  
Aplikasi ini memanfaatkan **Dicoding Restaurant API** dan menerapkan **state management Provider**, penyimpanan lokal (SQLite & Shared Preferences), serta pengujian unit.

---

## 🖼️ Tampilan Aplikasi
Light Mode
![Light Mode](https://github.com/user-attachments/assets/b57b77eb-22da-4094-a5fb-489b6b36a349)

Dark Mode
![Dark Mode](https://github.com/user-attachments/assets/7f602082-5e0a-4d6e-ba62-b734e04b509b)

---

## 📡 Sumber API
**Dicoding Restaurant API:**  
https://restaurant-api.dicoding.dev/

---

# 📱 Fitur Aplikasi

## 1. 📌 Halaman Daftar Restoran
Halaman utama yang menampilkan daftar restoran dari API.
### Informasi yang ditampilkan:
- Nama restoran  
- Gambar restoran  
- Kota  
- Rating  

### Keterangan:
- Data diambil secara real-time dari endpoint REST API.
- Tersedia indikator loading ketika proses fetch data.

---

## 2. 🏨 Halaman Detail Restoran
Menampilkan informasi detail restoran berdasarkan ID yang dipilih.

### Informasi yang ditampilkan:
- Nama restoran  
- Gambar utama  
- Deskripsi  
- Kota  
- Alamat lengkap  
- Rating  
- Menu makanan dan minuman  

### Navigasi:
- Item pada daftar restoran → halaman detail  
- Item favorit → halaman detail  

---

## 3. 🎨 Custom Theme (Light & Dark Mode)
Aplikasi menyediakan dua tema:
- 🌞 **Light Theme**  
- 🌙 **Dark Theme**

### Kustomisasi tema:
- Mengganti default font family.
- Mengubah variasi warna tema.
- Memastikan semua komponen tetap terlihat jelas di kedua tema.

### Penyimpanan tema:
- Tema disimpan menggunakan **Shared Preferences**.
- Tema tetap aktif walaupun aplikasi ditutup dan dibuka kembali.

---

## 4. 🔄 Indikator Loading
Setiap pemanggilan API menampilkan indikator loading, dapat berupa:
- `CircularProgressIndicator`
- Custom image loading
- Lottie animation
- Rive animation

Loading digunakan pada:
- Daftar restoran  
- Detail restoran  
- Favorit (bila mengambil data)

---

## 5. 🗂️ State Management — Provider
Aplikasi menggunakan **Provider** untuk mengelola seluruh state.

### Penerapan:
- Provider untuk list restoran
- Provider untuk detail restoran
- Provider untuk favorit restoran
- Provider untuk tema
- Provider untuk daily reminder

### Sealed Class State:
State API menggunakan sealed class seperti:
- `LoadingState`
- `HasDataState`
- `NoDataState`
- `ErrorState`

---

## 6. ⭐ Halaman Favorit Restoran
Halaman khusus yang menampilkan daftar restoran favorit.

### Fitur:
- Menampilkan card restoran favorit (nama, gambar, kota, rating)
- Navigasi ke halaman detail
- Menambah restoran ke favorit
- Menghapus restoran dari favorit

### Penyimpanan:
- Data disimpan di **SQLite Database**
- CRUD melalui helper database

---

## 7. ⚙️ Pengaturan Tema
Pada halaman **Settings**, pengguna bisa memilih:
- Light Theme  
- Dark Theme  

### Penyimpanan:
- Pengaturan disimpan di Shared Preferences dengan key khusus.
- Perubahan tema langsung diterapkan (*live theme switching*).

---

## 8. ⏰ Daily Reminder (11.00 AM)
Fitur pengingat otomatis untuk mengingatkan pengguna makan siang.

### Fitur reminder:
- Toggle ON/OFF di halaman Settings.
- Notifikasi dijadwalkan setiap jam **11.00 AM**.
- Menggunakan local notification + schedule.

### Penyimpanan:
- Status ON/OFF disimpan menggunakan Shared Preferences.

---

## 9. 🧪 Testing (Unit Test)
Menerapkan minimal **3 skenario pengujian** pada Provider yang mengambil data restoran.

### Skenario:
1. **State awal provider harus terdefinisi.**
2. **Berhasil mengambil data API → mengembalikan list restoran.**
3. **Gagal mengambil data API → mengembalikan state error.**

Pengujian dapat menggunakan:
- `mockito`
- `flutter_test`

---

# 🚀 Instalasi & Menjalankan Proyek

## 1. Clone Repository
```bash
git clone https://github.com/hafidz111/restaurant-app.git
cd restaurant-app
```

### 2. Jalankan Aplikasi
```bash
flutter pub get
flutter run
```
