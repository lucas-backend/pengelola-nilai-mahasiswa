import "package:main/menu_handler.dart" as menu;
import "package:main/db_handler.dart";
import "dart:io";

void main(List<String> arguments) {

  while (true) {
    DatabaseHandler db = DatabaseHandler();
    db.open("mahasiswa.db");
    db.createTable();

    List<Map<String, dynamic>> data = db.getData();

    print("===============================================");
    print("  NPM        | Nama                    | Nilai");
    print("===============================================");
    
    for (var row in data) {
      String npm = row["npm"].toString().padRight(10);
      String nama = row["nama"].toString().padRight(23);
      String nilai = row["nilai"].toString().padRight(3);
      print("  $npm | $nama | $nilai");
    }
    db.close();

    print("===============================================");
    print("  1. Tambah Data");
    print("  2. Update Data");
    print("  3. Hapus Data");
    print("  4. Statistik Data");
    print("  5. Keluar");
    print("===============================================");
    stdout.write("  Pilih menu: ");
    var inputMenu = stdin.readLineSync();

    if (inputMenu == "1") {
      menu.add();
    } else if (inputMenu == "2") {
      menu.update();
    } else if (inputMenu == "3") {
      menu.delete();
    } else if (inputMenu == "4") {
      menu.stats();
    } else if (inputMenu == "5") {
      exit(0);
    } else {
      print("  Menu tidak tersedia");
    }
  }
  
}
