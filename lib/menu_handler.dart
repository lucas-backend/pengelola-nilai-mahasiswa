import 'dart:io';
import 'db_handler.dart';

// Fungsi untuk menambah data mahasiswa
void add() {
  print("================================================");
  print("  Tambah Data\n");

  String npm, nama;
  double nilai;

  // Meminta input NPM dari pengguna
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;

    // Validasi NPM harus berupa 10 digit angka
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  }

  // Meminta input Nama dari pengguna
  while (true) {
    stdout.write("  Masukkan Nama: ");
    nama = stdin.readLineSync()!;

    // Validasi Nama tidak boleh kosong
    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }

    break;
  }

  // Meminta input Nilai dari pengguna
  while (true) {
    try {
      stdout.write("  Masukkan Nilai: ");
      nilai = double.parse(stdin.readLineSync()!);
      
      // Validasi Nilai harus berupa angka antara 0-100
      if (nilai < 0 || nilai > 100) {
        throw Exception();
      }
    } catch (_) {
      print("  Nilai harus berupa angka 0-100");
      continue;
    }

    break;
  }

  // Menyimpan data ke database
  try {
    DatabaseHandler db = DatabaseHandler();
    db.open("mahasiswa.db");
    db.createTable(); // Menambahkan tabel jika belum ada
    db.insertData(npm, nama, nilai);
    db.close();

    print("  Data berhasil ditambahkan");
  } catch (e) {
    print("  Terjadi kesalahan...\n"
      "  Data gagal ditambahkan");
  }
}

// Fungsi untuk mengupdate data mahasiswa
void update() {
  print("================================================");
  print("  Update Data\n");

  String npmTarget, npm, nama;
  double nilai;

  // Meminta input NPM dari pengguna untuk data yang akan diupdate
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npmTarget = stdin.readLineSync()!;

    // Validasi NPM harus berupa 10 digit angka
    if (npmTarget.length != 10 || int.tryParse(npmTarget) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  }

  // Membuka koneksi ke database dan mengecek apakah data ada
  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  if (!db.isDataExist(npmTarget)) {
    db.close();
    print("  Data tidak ditemukan");
    return;
  }

  // Meminta input NPM baru dari pengguna
  while (true) {
    stdout.write("  Masukkan NPM (Baru): ");
    npm = stdin.readLineSync()!;

    // Validasi NPM harus berupa 10 digit angka
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  } 

  // Meminta input Nama baru dari pengguna
  while (true) {
    stdout.write("  Masukkan Nama (Baru): ");
    nama = stdin.readLineSync()!;

    // Validasi Nama tidak boleh kosong
    if (nama.isEmpty) {
      print("  Nama tidak boleh kosong");
      continue;
    }

    break;
  }

  // Meminta input Nilai baru dari pengguna
  while (true) {
    try {
      stdout.write("  Masukkan Nilai (Baru): ");
      nilai = double.parse(stdin.readLineSync()!);
      
      // Validasi Nilai harus berupa angka antara 0-100
      if (nilai < 0 || nilai > 100) {
        throw Exception();
      }
    } catch (_) {
      print("  Nilai harus berupa angka 0-100");
      continue;
    }

    break;
  }

  // Mengupdate data di database
  try {
    db.updateData(npmTarget, npm, nama, nilai);
    print("  Data berhasil diupdate");
  } catch (_) {
    print("  Terjadi kesalahan...\n" 
    "Data gagal diupdate\n");
  }
}

// Fungsi untuk menghapus data mahasiswa
void delete() {
  print("================================================");
  print("  Hapus Data\n");

  String npm;
  // Meminta input NPM dari pengguna untuk data yang akan dihapus
  while (true) {
    stdout.write("  Masukkan NPM: ");
    npm = stdin.readLineSync()!;

    // Validasi NPM harus berupa 10 digit angka
    if (npm.length != 10 || int.tryParse(npm) == null) {
      print("  NPM harus berupa 10 digit angka");
      continue;
    }

    break;
  }

  // Membuka koneksi ke database dan mengecek apakah data ada
  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");
  if (!db.isDataExist(npm)) {
    print("  Data tidak ditemukan");
    db.close();
    return;
  }

  // Menghapus data dari database
  try {
    db.deleteData(npm);
    print("  Data berhasil dihapus");
  } catch (_) {
    print("  Terjadi kesalahan...\n" 
    "Data gagal dihapus\n");
  }
}

// Fungsi untuk menampilkan statistik data mahasiswa
void stats() {
  print("================================================");
  print("  Statistik Data\n");

  // Membuka koneksi ke database
  DatabaseHandler db = DatabaseHandler();
  db.open("mahasiswa.db");

  // Mengambil data mahasiswa dari database
  List<Map<String, dynamic>> data = db.getData();
  
  // Menghitung total mahasiswa
  int totalMahasiswa = data.length;

  // Menghitung total nilai dari semua mahasiswa
  double totalNilai = 0;
  for (var mahasiswa in data) {
    totalNilai += mahasiswa['nilai'];
  }
  
  // Menghitung rata-rata nilai
  double rataNilai = totalNilai / totalMahasiswa;

  // Mencari mahasiswa dengan nilai tertinggi
  Map<String, dynamic> mahasiswaTertinggi = data[0];

  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] > mahasiswaTertinggi['nilai']) {
      mahasiswaTertinggi = mahasiswa;
    }
  }

  // Mencari mahasiswa dengan nilai terendah
  Map<String, dynamic> mahasiswaTerendah = data[0];

  for (var mahasiswa in data) {
    if (mahasiswa['nilai'] < mahasiswaTerendah['nilai']) {
      mahasiswaTerendah = mahasiswa;
    }
  }

  // Mencetak statistik data mahasiswa
  print("  Total Mahasiswa: $totalMahasiswa");
  print("  Nilai Tertinggi: ${mahasiswaTertinggi['nama']}"
    "(${mahasiswaTertinggi['nilai'].toStringAsFixed(2)})");
  print("  Nilai Terendah: ${mahasiswaTerendah['nama']} "
    "(${mahasiswaTerendah['nilai'].toStringAsFixed(2)})");
  print("  Rata-rata Nilai: ${rataNilai.toStringAsFixed(2)}");

  print("  Tekan enter untuk kembali...");
  stdin.readLineSync();

  // Menutup koneksi ke database
  db.close();
}