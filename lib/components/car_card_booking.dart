import 'package:flutter/material.dart';
import "../components/GradientButton.dart";
import 'package:gaskeun_mobile/pages/home/main.dart';

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
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 11,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      pathImage,
                      height: 100,
                      width: 145,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          carName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(height: 8),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ambil $pickUpDate',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Kembali $returnDate',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: lunas
                    ? GradientButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(title: "My Bookings", user: 1, index: 1),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        text: "Pesan Lagi",
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          disabledBackgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: null,
                        child: const Text(
                          "Belum Dibayar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
