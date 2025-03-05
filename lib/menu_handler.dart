import 'dart:io';
import 'db_handler.dart';

void add() {
  print("===============================================");
  print("  Tambah Data\n");

  String npm, nama;
  double nilai;

  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;

    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  }

  while (true) {
    stdout.write("  Masukkan Nama: ");
    nama = stdin.readLineSync()!;

    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }

    break;
  }

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

  try {
    DatabaseHandler db = DatabaseHandler();
    db.open("mahasiswa.db");
    db.createTable(); // Menambahkan table jika belum ada
    db.insertData(npm, nama, nilai);
    db.close();

    print("  Data berhasil ditambahkan");
  } catch (e) {
    print("  Terjadi kesalahan...\n"
      "  Data gagal ditambahkan");
  }

}

void update() {
  print("===============================================");
  print("  Update Data\n");

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

  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  if (!db.isDataExist(npmTarget)) {
    db.close();
    print("  Data tidak ditemukan");
    return;
  }

  while (true) {
    stdout.write("  Masukkan NPM (Baru): ");
    npm = stdin.readLineSync()!;

    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  } 

  while (true) {
    stdout.write("  Masukkan Nama (Baru): ");
    nama = stdin.readLineSync()!;

    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }

    break;
  }

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

  try {
    db.updateData(npm, nama, nilai);
    print("  Data berhasil diupdate");
  } catch (_) {
    print("  Terjadi kesalahan...\n" 
    "Data gagal diupdate\n");
  }

}

void delete() {
  print("===============================================");
  print("  Hapus Data\n");

  String npm;
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;

    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  }

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
    print("  Terjadi kesalahan...\n" 
    "Data gagal dihapus\n");
  }
}

void stats() {
  print("===============================================");
  print("  Statistik Data\n");

  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");

  List<Map<String, dynamic>> data = db.getData();
  
  // Total Mahasiswa
  int totalMahasiswa = data.length;

  // Rata-rata Nilai
  double totalNilai = data.fold(0, (sum, m) => sum + m['nilai']);
  double rataNilai = totalNilai / totalMahasiswa;

  // Mahasiswa dengan Nilai Tertinggi
  Map<String, dynamic> mahasiswaTertinggi = data[0];

  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] > mahasiswaTertinggi['nilai']) {
      mahasiswaTertinggi = mahasiswa;
    }
  }

  // Mahasiswa dengan Nilai Terendah
  Map<String, dynamic> mahasiswaTerendah = data[0];

  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] < mahasiswaTerendah['nilai']) {
      mahasiswaTerendah = mahasiswa;
    }
  }

  print("  Total Mahasiswa: $totalMahasiswa");
  print("  Nilai Tertinggi: ${mahasiswaTertinggi['nama']}"
    "(${mahasiswaTertinggi['nilai'].toStringAsFixed(2)})");
  print("  Nilai Terendah: ${mahasiswaTerendah['nama']} "
    "(${mahasiswaTerendah['nilai'].toStringAsFixed(2)})");
  print("  Rata-rata Nilai: ${rataNilai.toStringAsFixed(2)}");

  print("  Tekan enter untuk kembali...");
  stdin.readLineSync();

  db.close();
}