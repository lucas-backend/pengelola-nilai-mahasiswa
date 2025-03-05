import 'package:sqlite3/sqlite3.dart' as sqlite;

class DatabaseHandler {
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  late sqlite.Database _db;

  DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _instance;
  }

  void open(String path) {
    _db = sqlite.sqlite3.open(path);
  }

  void close() {
    _db.dispose();
  }

  void createTable() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS mahasiswa (
        npm TEXT PRIMARY KEY,
        nama TEXT,
        nilai REAL
      )
    ''');
  }

  void insertData(String npm, String nama, double nilai) {
    _db.execute('''
      INSERT INTO mahasiswa (npm, nama, nilai) VALUES (?, ?, ?)
    ''', [npm, nama, nilai]);
  }

  void updateData(String npm, String nama, double nilai) {
    _db.execute('''
      UPDATE mahasiswa SET nama = ?, nilai = ? WHERE npm = ?
    ''', [nama, nilai, npm]);
  }

  void deleteData(String npm) {
    _db.execute('''
      DELETE FROM mahasiswa WHERE npm = ?
    ''', [npm]);
  }

  bool isDataExist(String npm) {
    final sqlite.ResultSet resultSet = _db.select('SELECT * FROM mahasiswa WHERE npm = ?', [npm]);
    return resultSet.isNotEmpty;
  }

  List<Map<String, dynamic>> getData() {
    final sqlite.ResultSet resultSet = _db.select('SELECT * FROM mahasiswa');
    List<Map<String, dynamic>> data = [];

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