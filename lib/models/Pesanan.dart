class Order {
  final int id;
  final String carName;
  final int price;
  final String pickUpDate;
  final String returnDate;
  final String imagePath;
  final bool lunas;
  final String status;

  Order({
    required this.id,
    required this.carName,
    required this.price,
    required this.pickUpDate,
    required this.returnDate,
    required this.imagePath,
    required this.lunas,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        carName: json['brand'] + " " + json['model'],
        price: json['harga_sewa'],
        pickUpDate: json['tanggal_peminjaman'],
        returnDate: json['tanggal_pengembalian'],
        imagePath: "https://gaskeun.shop/storage/" + json['path'],
        lunas: json['status'] == 'lunas',
        status: json['pesanan_status']);
  }
}
