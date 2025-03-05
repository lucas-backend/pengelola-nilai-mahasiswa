## Deskripsi

Proyek ini adalah aplikasi command-line sederhana dengan file utama di folder `bin/`, kode _library_ di `lib/`. Aplikasi ini berfungsi untuk mengelola data mahasiswa menggunakan bahasa pemrograman <span style="color:aqua;">Dart</span> dan database <span style="color: yellow;">SQLite</span>. Aplikasi ini memungkinkan Anda untuk menambah, memperbarui, menghapus, dan menampilkan catatan siswa.

## Fitur

- Menambah data siswa baru
- Memperbarui data siswa yang ada
- Menghapus data siswa
- Menampilkan semua data siswa

## Persyaratan

- Dart SDK ^3.7.0
- SQLite3 ^1.3.0

## Instalasi

1. **Instal Dart SDK**:
   - Pastikan Dart SDK versi ^3.7.0 sudah terinstal di sistem Anda. Anda dapat mengunduh dan menginstalnya dari [situs resmi Dart](https://dart.dev/get-dart).

2. **Clone repository**:
    ```sh
    git clone https://github.com/lucas-backend/pengelola-nilai-mahasiswa
    ```

3. **Masuk ke direktori proyek**:
    ```sh
    cd pengelola-nilai-mahasiswa
    ```

4. **Dapatkan dependensi**:
    ```sh
    dart pub get
    ```

## Penggunaan

Jalankan aplikasi:
```sh
dart run bin/main.dart