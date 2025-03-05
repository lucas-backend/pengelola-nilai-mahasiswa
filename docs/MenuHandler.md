## **Menu Handler**

File berisi kode yang merupakan bagian dari sistem manajemen data mahasiswa berbasis SQLite dengan bahasa pemrograman Dart. Fungsinya mencakup penambahan, pembaruan, penghapusan, dan analisis data mahasiswa dari database.

---

### 1. **Import Library**
```dart
import 'dart:io';
import 'db_handler.dart';
```
- `dart:io` digunakan untuk operasi input-output, seperti membaca dan menulis data ke terminal.
- `db_handler.dart` adalah file eksternal yang digunakan untuk mengelola database.

---

### 2. **Fungsi `add()` - Menambahkan Data Mahasiswa**
```dart
void add() {
  print("===============================================");
  print("  Tambah Data\n");
```
- Mencetak header ke terminal untuk memberi tahu pengguna bahwa ini adalah proses penambahan data.

```dart
  String npm, nama;
  double nilai;
```
- Mendeklarasikan variabel untuk menyimpan data mahasiswa (NPM, nama, dan nilai).

#### **Memasukkan NPM**
```dart
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;
```
- Pengguna diminta memasukkan NPM, yang kemudian dibaca dari terminal.

```dart
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }
    break;
  }
```
- Validasi:
  - NPM harus memiliki panjang 10 karakter.
  - NPM harus berupa angka (`int.tryParse(npm) == null` berarti bukan angka).
- Jika tidak memenuhi syarat, pengguna diminta menginput ulang.

#### **Memasukkan Nama**
```dart
  while (true) {
    stdout.write("  Masukkan Nama: ");
    nama = stdin.readLineSync()!;
    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }
    break;
  }
```
- Memastikan nama tidak kosong.

#### **Memasukkan Nilai**
```dart
  while (true) {
    try {
      stdout.write("  Masukkan Nilai: ");
      nilai = double.parse(stdin.readLineSync()!);
      if (nilai < 0 || nilai > 100) {
        throw Exception();
      }
    } catch (_) {
      print("  Nilai harus berupa angka 0-100");
      continue;
    }
    break;
  }
```
- Memvalidasi bahwa nilai harus berupa angka antara 0 hingga 100.

#### **Menyimpan Data ke Database**
```dart
  try {
    DatabaseHandler db = DatabaseHandler();
    db.open("mahasiswa.db");
    db.createTable();
    db.insertData(npm, nama, nilai);
    db.close();
    print("  Data berhasil ditambahkan");
  } catch (e) {
    print("  Terjadi kesalahan...\n  Data gagal ditambahkan");
  }
}
```
- Membuka koneksi ke database.
- Memastikan tabel sudah ada (`db.createTable()`).
- Menyimpan data (`db.insertData(npm, nama, nilai)`).
- Menutup koneksi database.
- Menampilkan pesan sukses atau error.

---

### 3. **Fungsi `update()` - Memperbarui Data Mahasiswa**
```dart
void update() {
  print("===============================================");
  print("  Update Data\n");
```
- Mencetak header untuk proses update.

#### **Memasukkan NPM yang Akan Diperbarui**
```dart
  String npmTarget, npm, nama;
  double nilai;

  while (true) {
    stdout.write("  Masukkan NPM: ");
    npmTarget = stdin.readLineSync()!;
    if (npmTarget.length != 10 || int.tryParse(npmTarget) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }
    break;
  }
```
- Meminta input NPM yang ingin diperbarui dan memvalidasinya.

#### **Mengecek Keberadaan Data di Database**
```dart
  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  if (!db.isDataExist(npmTarget)) {
    db.close();
    print("  Data tidak ditemukan");
    return;
  }
```
- Jika NPM tidak ditemukan, proses update dibatalkan.

#### **Memasukkan Data Baru**
```dart
  while (true) {
    stdout.write("  Masukkan NPM (Baru): ");
    npm = stdin.readLineSync()!;
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }
    break;
  } 
```
- Meminta NPM baru.

```dart
  while (true) {
    stdout.write("  Masukkan Nama (Baru): ");
    nama = stdin.readLineSync()!;
    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }
    break;
  }
```
- Meminta nama baru.

```dart
  while (true) {
    try {
      stdout.write("  Masukkan Nilai (Baru): ");
      nilai = double.parse(stdin.readLineSync()!);
      if (nilai < 0 || nilai > 100) {
        throw Exception();
      }
    } catch (_) {
      print("  Nilai harus berupa angka 0-100");
      continue;
    }
    break;
  }
```
- Meminta nilai baru.

#### **Memperbarui Data di Database**
```dart
  try {
    db.updateData(npm, nama, nilai);
    print("  Data berhasil diupdate");
  } catch (_) {
    print("  Terjadi kesalahan...\nData gagal diupdate\n");
  }
}
```
- Jika sukses, data diperbarui di database.

---

### 4. **Fungsi `delete()` - Menghapus Data Mahasiswa**
```dart
void delete() {
  print("===============================================");
  print("  Hapus Data\n");

  String npm;
```
- Mencetak header dan mendeklarasikan variabel.

#### **Memasukkan NPM yang Akan Dihapus**
```dart
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }
    break;
  }
```
- Memastikan NPM valid.

#### **Mengecek Keberadaan Data dan Menghapusnya**
```dart
  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  if (!db.isDataExist(npm)) {
    print("  Data tidak ditemukan");
    db.close();
    return;
  }

  try {
    db.deleteData(npm);
    print("  Data berhasil dihapus");
  } catch (_) {
    print("  Terjadi kesalahan...\nData gagal dihapus\n");
  }
}
```
- Jika data ditemukan, akan dihapus.

---

### 5. **Fungsi `stats()` - Menampilkan Statistik Mahasiswa**
```dart
void stats() {
  print("===============================================");
  print("  Statistik Data\n");

  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  List<Map<String, dynamic>> data = db.getData();
```
- Membuka database dan mengambil semua data mahasiswa.

#### **Menghitung Statistik**
```dart
  int totalMahasiswa = data.length;
  double totalNilai = data.fold(0, (sum, m) => sum + m['nilai']);
  double rataNilai = totalNilai / totalMahasiswa;
```
- Menghitung total mahasiswa, total nilai, dan rata-rata nilai.

```dart
  Map<String, dynamic> mahasiswaTertinggi = data[0];
  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] > mahasiswaTertinggi['nilai']) {
      mahasiswaTertinggi = mahasiswa;
    }
  }
```
- Mencari mahasiswa dengan nilai tertinggi.

```dart
  Map<String, dynamic> mahasiswaTerendah = data[0];
  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] < mahasiswaTerendah['nilai']) {
      mahasiswaTerendah = mahasiswa;
    }
  }
```
- Mencari mahasiswa dengan nilai terendah.

#### **Menampilkan Statistik**
```dart
  print("  Total Mahasiswa: $totalMahasiswa");
  print("  Nilai Tertinggi: ${mahasiswaTertinggi['nama']} (${mahasiswaTertinggi['nilai'].toStringAsFixed(2)})");
  print("  Nilai Terendah: ${mahasiswaTerendah['nama']} (${mahasiswaTerendah['nilai'].toStringAsFixed(2)})");
  print("  Rata-rata Nilai: ${rataNilai.toStringAsFixed(2)}");

  stdin.readLineSync();
  db.close();
}
```
- Menampilkan hasil dan menutup koneksi database.