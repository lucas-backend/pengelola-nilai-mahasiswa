import "package:main/menu_handler.dart" as menu;
import "package:main/db_handler.dart";
import "dart:io";

void main(List<String> arguments) {
  // Loop utama aplikasi
  while (true) {
    // Membuat instance DatabaseHandler dan membuka database "mahasiswa.db"
    DatabaseHandler db = DatabaseHandler();
    db.open("mahasiswa.db");
    db.createTable(); // Membuat tabel jika belum ada

    // Mengambil data mahasiswa dari database
    List<Map<String, dynamic>> data = db.getData();

    // Mencetak header tabel
    print("===============================================");
    print("  NPM        | Nama                    | Nilai");
    print("===============================================");
    
    // Mencetak setiap baris data mahasiswa
    for (var row in data) {
      String npm = row["npm"].toString().padRight(10);
      String nama = row["nama"].toString().padRight(23);
      String nilai = row["nilai"].toString().padRight(3);
      print("  $npm | $nama | $nilai");
    }
    db.close(); // Menutup koneksi database

    // Mencetak menu pilihan
    print("===============================================");
    print("  1. Tambah Data");
    print("  2. Update Data");
    print("  3. Hapus Data");
    print("  4. Statistik Data");
    print("  5. Keluar");
    print("===============================================");
    stdout.write("  Pilih menu: ");
    var inputMenu = stdin.readLineSync();

    // Menjalankan fungsi sesuai dengan pilihan menu
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
  }
}