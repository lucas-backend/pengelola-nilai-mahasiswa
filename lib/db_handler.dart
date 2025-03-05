import 'package:sqlite3/sqlite3.dart' as sqlite;

class DatabaseHandler {
  // Membuat instance tunggal dari DatabaseHandler
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  late sqlite.Database _db;

  // Konstruktor internal untuk singleton pattern
  DatabaseHandler._internal();

  // Factory constructor untuk mengembalikan instance tunggal
  factory DatabaseHandler() {
    return _instance;
  }

  // Membuka koneksi ke database dengan path yang diberikan
  void open(String path) {
    _db = sqlite.sqlite3.open(path);
  }

  // Menutup koneksi ke database
  void close() {
    _db.dispose();
  }

  // Membuat tabel mahasiswa jika belum ada
  void createTable() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS mahasiswa (
        npm TEXT PRIMARY KEY,
        nama TEXT,
        nilai REAL
      )
    ''');
  }

  // Menambahkan data mahasiswa ke dalam tabel
  void insertData(String npm, String nama, double nilai) {
    _db.execute('''
      INSERT INTO mahasiswa (npm, nama, nilai) VALUES (?, ?, ?)
    ''', [npm, nama, nilai]);
  }

  // Memperbarui data mahasiswa berdasarkan NPM
  void updateData(String npm, String nama, double nilai) {
    _db.execute('''
      UPDATE mahasiswa SET nama = ?, nilai = ? WHERE npm = ?
    ''', [nama, nilai, npm]);
  }

  // Menghapus data mahasiswa berdasarkan NPM
  void deleteData(String npm) {
    _db.execute('''
      DELETE FROM mahasiswa WHERE npm = ?
    ''', [npm]);
  }

  // Mengecek apakah data mahasiswa dengan NPM tertentu ada
  bool isDataExist(String npm) {
    final sqlite.ResultSet resultSet = _db.select('SELECT * FROM mahasiswa WHERE npm = ?', [npm]);
    return resultSet.isNotEmpty;
  }

  // Mengambil semua data mahasiswa dari tabel
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
}