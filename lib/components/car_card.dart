import 'package:flutter/material.dart';
import 'GradientButton.dart';
import '../pages/carOrder/main.dart';
import '../../models/Car.dart';

class CarCard extends StatelessWidget {
  final int id;
  final int providerId;
  final int carImageId;
  final String brand;
  final String model;
  final int people;
  final int price;
  final String description;
  final bool available;
  final String plateNumber;
  final String transmission;
  final String fuel;
  final String pathImage;

  const CarCard({
    Key? key,
    required this.id,
    required this.providerId,
    required this.carImageId,
    required this.brand,
    required this.model,
    required this.people,
    required this.price,
    required this.description,
    required this.available,
    required this.plateNumber,
    required this.transmission,
    required this.fuel,
    required this.pathImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              brand + " " + model,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 5),
                                Text(
                                  '$people orang',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.settings),
                                SizedBox(width: 5),
                                Text(
                                  transmission,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Rp. $price/hari'),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: [
                          SizedBox(
                              height: 14), // Tambahkan jarak di atas gambar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Sesuaikan dengan kebutuhan Anda
                            child: Image.network(
                              'https://gaskeun.shop/storage/$pathImage',
                              height: 96,
                              width: 145,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: available
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CarOrderPage(
                                    car: Car(
                                      id: id,
                                      providerId: providerId,
                                      carImageId: carImageId,
                                      capacity: people,
                                      price: price,
                                      brand: brand,
                                      model: model,
                                      description: description,
                                      status: available
                                          ? "Tersedia"
                                          : "Tidak tersedia",
                                      plateNumber: plateNumber,
                                      transmission: transmission,
                                      fuel: fuel,
                                      imagePath: pathImage,
                                    ),
                                  ),
                                ),
                              );
                            }
                          : null,
                      text: "Pesan",
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!available)
            Positioned(
              top: 5,
              left: 3,
              right: 3, // Atur sesuai kebutuhan Anda
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  shape: BoxShape.rectangle,
                ),
                height: 188,
                child: Center(
                  child: Text(
                    'Tidak Tersedia',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 0,
            left: 3,
            right: 3,
            child: Container(
              decoration: BoxDecoration(
                color: available ? Colors.green : Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Center(
                child: Text(
                  available ? "Tersedia" : "Tidak Tersedia",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
