import 'package:flutter/material.dart';
import "GradientButton.dart";

import "../pages/carOrder/main.dart";
import "../../models/Car.dart";

/*
cara pemanggilan
CarCard(
  carName: 'Toyota Innova Zenix',
  people: 4,
  transmission: 'Manual',
  price: 'Rp 300.000/hari',
),
*/

class CarCard extends StatelessWidget {
  final String carName;
  final int people;
  final String transmission;
  final String price;

  const CarCard({
    super.key,
    required this.carName,
    required this.people,
    required this.transmission,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 11,
        color: Colors.white70,
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
                        Text(carName, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 5),
                            Text('$people orang', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.settings),
                            SizedBox(width: 5),
                            Text(transmission, style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(price),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Image.asset(
                    'assets/img/car-zenix.png',
                    height: 90, 
                    width: 150,  
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: GradientButton(onPressed: (){
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
                          status: "Tersedia", 
                          plateNumber: "E 13 JIR", 
                          transmission: "Manual", 
                          fuel: "Bensin"
                        )
                      )
                    )
                  );
                }, text: "Pesan")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
