## Pengelola Nilai Mahasiswa

Proyek ini dibuat sebagai latihan dan tugas untuk mata kuliah Struktur Data. Proyek ini merupakan aplikasi command-line sederhana dengan file utama di folder bin/, kode library di lib/. Aplikasi ini berfungsi untuk mengelola data mahasiswa menggunakan bahasa pemrograman Dart dan database SQLite. Aplikasi ini memungkinkan Anda untuk menambah, memperbarui, menghapus, dan menampilkan catatan siswa.

---

### **1. Impor Library**
```dart
import "package:main/menu_handler.dart" as menu;
import "package:main/db_handler.dart";
import "dart:io";
```
- `menu_handler.dart` diimpor dengan alias `menu`, yang berisi fungsi-fungsi untuk menambah, mengupdate, menghapus, dan menampilkan statistik data mahasiswa.
- `db_handler.dart` berisi kelas `DatabaseHandler` yang menangani operasi database.
- `dart:io` digunakan untuk menangani input dan output dari pengguna.

---

### **2. Fungsi `main()`**
```dart
void main(List<String> arguments) {
```
- Fungsi utama yang dijalankan saat program dimulai.
- `arguments` adalah daftar argumen yang bisa dikirim saat menjalankan program (tidak digunakan dalam kode ini).

---

### **3. Loop Utama Program**
```dart
while (true) {
```
- Program berjalan dalam loop **infinite** (`while (true)`), sehingga terus berjalan sampai pengguna memilih untuk keluar.

---

### **4. Menghubungkan ke Database**
```dart
DatabaseHandler db = DatabaseHandler();
db.open("mahasiswa.db");
db.createTable(); // Membuat tabel jika belum ada
```
- Membuat instance `DatabaseHandler` untuk mengelola database.
- `db.open("mahasiswa.db")`: Membuka koneksi ke database `mahasiswa.db`.
- `db.createTable()`: Membuat tabel **jika belum ada** di database.

---

### **5. Mengambil Data dari Database**
```dart
List<Map<String, dynamic>> data = db.getData();
```
- Memanggil `db.getData()` untuk mengambil semua data mahasiswa dari database dalam bentuk **list of maps**.

---

### **6. Menampilkan Data Mahasiswa**
```dart
print("===============================================");
print("  NPM        | Nama                    | Nilai");
print("===============================================");
```
- Mencetak header tabel untuk menampilkan daftar mahasiswa.

```dart
for (var row in data) {
  String npm = row["npm"].toString().padRight(10);
  String nama = row["nama"].toString().padRight(23);
  String nilai = row["nilai"].toString().padRight(3);
  print("  $npm | $nama | $nilai");
}
```
- **Looping melalui `data`** dan mencetak setiap baris.
- `padRight(n)`: Memastikan teks memiliki panjang tertentu agar tampilan rapi.

---

### **7. Menutup Koneksi Database**
```dart
db.close(); 
```
- Setelah mengambil data, koneksi database ditutup.

---

### **8. Menampilkan Menu Pilihan**
```dart
print("===============================================");
print("  1. Tambah Data");
print("  2. Update Data");
print("  3. Hapus Data");
print("  4. Statistik Data");
print("  5. Keluar");
print("===============================================");
stdout.write("  Pilih menu: ");
var inputMenu = stdin.readLineSync();
```
- Mencetak menu utama program.
- `stdin.readLineSync()` membaca input dari pengguna.

---

### **9. Menjalankan Menu yang Dipilih**
```dart
if (inputMenu == "1") {
  menu.add(); // Menambah data mahasiswa
} else if (inputMenu == "2") {
  menu.update(); // Mengupdate data mahasiswa
} else if (inputMenu == "3") {
  menu.delete(); // Menghapus data mahasiswa
} else if (inputMenu == "4") {
  menu.stats(); // Menampilkan statistik data mahasiswa
} else if (inputMenu == "5") {
  exit(0); // Keluar dari aplikasi
} else {
  print("  Menu tidak tersedia");
}
```
- **Cek input pengguna**:
  - `"1"` → Menjalankan `menu.add()` untuk menambah data.
  - `"2"` → Menjalankan `menu.update()` untuk mengupdate data.
  - `"3"` → Menjalankan `menu.delete()` untuk menghapus data.
  - `"4"` → Menjalankan `menu.stats()` untuk menampilkan statistik.
  - `"5"` → **Keluar dari program** (`exit(0)`).
  - Input lain → Menampilkan pesan "Menu tidak tersedia".
