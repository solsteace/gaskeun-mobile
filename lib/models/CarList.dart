class Car {
  final int id;
  final int idPengguna;
  final int idImage;
  final String brand;
  final String model;
  final int kapasitas;
  final int hargaSewa;
  final String deskripsi;
  final String status;
  final String nomorPolisi;
  final String transmisi;
  final String bahanBakar;
  final CarImage image;

  Car({
    required this.id,
    required this.idPengguna,
    required this.idImage,
    required this.brand,
    required this.model,
    required this.kapasitas,
    required this.hargaSewa,
    required this.deskripsi,
    required this.status,
    required this.nomorPolisi,
    required this.transmisi,
    required this.bahanBakar,
    required this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      idPengguna: json['id_pengguna'],
      idImage: json['id_image'],
      brand: json['brand'],
      model: json['model'],
      kapasitas: json['kapasitas'],
      hargaSewa: json['harga_sewa'],
      deskripsi: json['deskripsi'],
      status: json['status'],
      nomorPolisi: json['nomor_polisi'],
      transmisi: json['transmisi'],
      bahanBakar: json['bahan_bakar'],
      image: CarImage.fromJson(json['image']),
    );
  }
}

class CarImage {
  final int id;
  final String path;
  final String lastUpdate;

  CarImage({
    required this.id,
    required this.path,
    required this.lastUpdate,
  });

  factory CarImage.fromJson(Map<String, dynamic> json) {
    return CarImage(
      id: json['id'],
      path: json['path'],
      lastUpdate: json['last_update'],
    );
  }
}
