import 'package:flutter/material.dart';
import 'GradientButton.dart';
import '../pages/carOrder/main.dart';
import '../../models/Car.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarCard extends StatelessWidget {
  final String carName;
  final int people;
  final String transmission;
  final String price;
  final String pathImage;
  final bool available;

  const CarCard({
    Key? key,
    required this.carName,
    required this.people,
    required this.transmission,
    required this.price,
    required this.pathImage,
    required this.available,
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
                            Text(carName,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 5),
                                Text('$people orang',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.settings),
                                SizedBox(width: 5),
                                Text(transmission,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(price),
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://gaskeun.shop/storage/$pathImage',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: 96,
                              width: 145,
                              fit: BoxFit.cover,
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
                                      id: 1,
                                      providerId: 1,
                                      carImageId: 1,
                                      capacity: people,
                                      price: 300000,
                                      brand: carName,
                                      model: "Innova Zenix",
                                      description: "Deskripsi",
                                      status: available
                                          ? "Tersedia"
                                          : "Tidak tersedia",
                                      plateNumber: "E 13 JIR",
                                      transmission: transmission,
                                      fuel: "Bensin",
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
