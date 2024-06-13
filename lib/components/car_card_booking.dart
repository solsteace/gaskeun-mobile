import 'package:flutter/material.dart';
import "../components/GradientButton.dart";  

class CarCardBooking extends StatelessWidget {
  final String carName;
  final String price;
  final String pickUpDate;
  final String returnDate;
  final String pathImage;
  final bool lunas;

  const CarCardBooking({
    super.key,
    required this.carName,
    required this.price,
    required this.pickUpDate,
    required this.returnDate,
    required this.pathImage,
    required this.lunas,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        elevation: 11,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/img/$pathImage',
                height: 100,
                width: 130,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ambil $pickUpDate',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Kembali $returnDate',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: lunas
                          ? GradientButton(
                              onPressed: () {
                                // Your button action here
                              },
                              text: "Pesan Lagi",
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Your button action here
                              },
                              child: Text(
                                "Belum Dibayar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
