### **Database Handler (db_handler.dart)**  

SQLite adalah salah satu sistem manajemen basis data (DBMS) yang ringan, cepat, dan tidak memerlukan server terpisah. Dalam pengembangan aplikasi menggunakan Dart, kita dapat menggunakan paket **sqlite3** untuk berinteraksi dengan database SQLite secara langsung.  

Dokumen ini menjelaskan implementasi **DatabaseHandler**, sebuah kelas yang mengelola operasi database menggunakan SQLite di Dart. Kelas ini dirancang dengan **pola Singleton**, memastikan hanya ada satu instance database yang digunakan sepanjang aplikasi berjalan.  

_Class_ **DatabaseHandler** menyediakan berbagai metode untuk mengelola data mahasiswa, termasuk:  
1. **Membuka dan Menutup Koneksi Database**  
2. **Membuat Tabel**  
3. **CRUD (Create, Read, Update, Delete)** untuk data mahasiswa  
4. **Mengecek Keberadaan Data**  

Dokumentasi berikut akan menjelaskan setiap bagian kode secara detail.

---

### **1. Import Library SQLite**
```dart
import 'package:sqlite3/sqlite3.dart' as sqlite;
```
- Baris ini mengimpor paket `sqlite3` yang digunakan untuk mengelola database SQLite di Dart.
- Menggunakan `as sqlite` agar nama modul lebih jelas saat digunakan dalam kode.

---

### **2. Deklarasi Kelas `DatabaseHandler`**
```dart
class DatabaseHandler {
```
- `DatabaseHandler` adalah kelas yang menangani semua operasi database seperti membuka, menutup, membuat tabel, dan CRUD (Create, Read, Update, Delete).

---

### **3. Singleton Pattern**
```dart
  static final DatabaseHandler _instance = DatabaseHandler._internal();
```
- Mendeklarasikan **_instance** sebagai instance tunggal (`static final`) dari kelas `DatabaseHandler`.
- Ini berarti hanya akan ada satu instance dari `DatabaseHandler` selama aplikasi berjalan.

```dart
  late sqlite.Database _db;
```
- `_db` adalah objek database yang digunakan untuk mengelola operasi SQL.
- Menggunakan `late` karena nilainya akan diinisialisasi kemudian.

```dart
  DatabaseHandler._internal();
```
- Konstruktor private yang hanya bisa diakses dalam kelas ini sendiri.
- Ini untuk mencegah pembuatan instance lain dari luar kelas.

```dart
  factory DatabaseHandler() {
    return _instance;
  }
```
- **Factory constructor** digunakan agar setiap kali `DatabaseHandler()` dipanggil, instance yang sama dikembalikan (`_instance`).
- Dengan ini, kita memastikan pola **Singleton** diterapkan.

---

### **4. Membuka Koneksi Database**
```dart
  void open(String path) {
    _db = sqlite.sqlite3.open(path);
  }
```
- Metode `open()` digunakan untuk membuka koneksi ke database SQLite.
- Parameter `path` menentukan lokasi file database.

---

### **5. Menutup Koneksi Database**
```dart
  void close() {
    _db.dispose();
  }
```
- `dispose()` digunakan untuk menutup koneksi dan melepaskan sumber daya database.

---

### **6. Membuat Tabel `mahasiswa`**
```dart
  void createTable() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS mahasiswa (
        npm TEXT PRIMARY KEY,
        nama TEXT,
        nilai REAL
      )
    ''');
  }
```
- Menjalankan perintah SQL `CREATE TABLE IF NOT EXISTS` untuk membuat tabel `mahasiswa` jika belum ada.
- **Struktur tabel**:
  - `npm` → **TEXT (String)**, sebagai PRIMARY KEY.
  - `nama` → **TEXT (String)**, menyimpan nama mahasiswa.
  - `nilai` → **REAL (Double)**, menyimpan nilai mahasiswa.

---

### **7. Menambahkan Data ke Tabel**
```dart
  void insertData(String npm, String nama, double nilai) {
    _db.execute('''
      INSERT INTO mahasiswa (npm, nama, nilai) VALUES (?, ?, ?)
    ''', [npm, nama, nilai]);
  }
```
- Menggunakan **parameterized query** (`?`) untuk mencegah SQL Injection.
- Data yang dimasukkan ke dalam tabel `mahasiswa` berupa `npm`, `nama`, dan `nilai`.

---

### **8. Memperbarui Data Mahasiswa**
```dart
  void updateData(String npm, String nama, double nilai) {
    _db.execute('''
      UPDATE mahasiswa SET nama = ?, nilai = ? WHERE npm = ?
    ''', [nama, nilai, npm]);
  }
```
- `UPDATE mahasiswa SET` digunakan untuk memperbarui **nama** dan **nilai** mahasiswa berdasarkan `npm`.

---

### **9. Menghapus Data Mahasiswa**
```dart
  void deleteData(String npm) {
    _db.execute('''
      DELETE FROM mahasiswa WHERE npm = ?
    ''', [npm]);
  }
```
- `DELETE FROM mahasiswa` menghapus data mahasiswa berdasarkan **npm**.

---

### **10. Mengecek Apakah Data Tertentu Ada**
```dart
  bool isDataExist(String npm) {
    final sqlite.ResultSet resultSet = _db.select('SELECT * FROM mahasiswa WHERE npm = ?', [npm]);
    return resultSet.isNotEmpty;
  }
```
- **`SELECT * FROM mahasiswa WHERE npm = ?`** mengecek apakah data dengan `npm` tertentu ada.
- `isNotEmpty` mengembalikan `true` jika data ditemukan, `false` jika tidak.

---

### **11. Mengambil Seluruh Data Mahasiswa**
```dart
  List<Map<String, dynamic>> getData() {
    final sqlite.ResultSet resultSet = _db.select('SELECT * FROM mahasiswa');
    List<Map<String, dynamic>> data = [];

    // Mengonversi setiap baris hasil query menjadi map dan menambahkannya ke list
    for (final sqlite.Row row in resultSet) {
      data.add({
        'npm': row['npm'],
        'nama': row['nama'],
        'nilai': row['nilai'],
      });
    }

    return data;
  }
```
- Menggunakan `SELECT * FROM mahasiswa` untuk mengambil semua data mahasiswa.
- **Looping melalui hasil query (`ResultSet`)**:
  - Setiap baris dikonversi ke dalam **Map** (`{npm, nama, nilai}`).
  - Data kemudian dimasukkan ke dalam **List<Map<String, dynamic>>**.