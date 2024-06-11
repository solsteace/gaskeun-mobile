import 'package:flutter/material.dart';
import 'GradientButton.dart';

import '../pages/carOrder/main.dart';
import '../../models/Car.dart';

/*
cara pemanggilan
CarCard(
  carName: 'Toyota Innova Zenix',
  people: 4,
  transmission: 'Manual',
  price: 'Rp 300.000/hari',
  pathImage: 'car-zenix.png',
  available: true,
),
*/

class CarCard extends StatelessWidget {
  final String carName;
  final int people;
  final String transmission;
  final String price;
  final String pathImage;
  final bool available;

  const CarCard({
    super.key,
    required this.carName,
    required this.people,
    required this.transmission,
    required this.price,
    required this.pathImage,
    required this.available,
  });

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
                            SizedBox(height: 5),
                            Text(carName, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 5),
                                Text('$people orang', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.settings),
                                SizedBox(width: 5),
                                Text(transmission, style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(price),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/img/$pathImage',
                        height: 110,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: Alignment.center,
                    child: GradientButton(
                      onPressed: available ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CarOrderPage(
                              car: Car(
                                id: 1,
                                providerId: 1,
                                carImageId: 1,
                                capacity: 4,
                                price: 300000,
                                brand: "Toyota",
                                model: "Innova Zenix",
                                description: "Deskripsi",
                                status: available ? "Tersedia" : "Tidak tersedia",
                                plateNumber: "E 13 JIR",
                                transmission: "Manual",
                                fuel: "Bensin",
                              ),
                            ),
                          ),
                        );
                      } : null,
                      text: "Pesan",
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!available)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(17), 
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10), 
                  topLeft: Radius.circular(17), 
                ),
                shape: BoxShape.rectangle,
              ),
              height: 200,
              child: Center(
                child: Text(
                  'Tidak tersedia',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          Positioned(
            top: -2,
            left: 2,
            right: 2,
            child: Container(
              decoration: BoxDecoration(
                color: available ? Colors.green : Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Center(
                child: Text(
                  available ? "Tersedia" : "Tidak tersedia",
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
