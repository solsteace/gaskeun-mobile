import 'package:flutter/material.dart';
import "package:gaskeun_mobile/layouts/pageOnBG.dart";
import '../../components/car_card_booking.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageOnBG(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Text(
                      'Pesanan\nSaya',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ]
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 40,
                bottom: 10,
              ),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CarCardBooking(
                      carName: "Brio",
                      price: 'Rp 400.000',
                      pickUpDate: "YYYY/MM/DD",
                      returnDate: "YYYY/MM/DD",
                      pathImage: "car-brio.png",
                      lunas: false,
                    ),
                    CarCardBooking(
                      carName: "Sigra",
                      price: 'Rp 300.000',
                      pickUpDate: "YYYY/MM/DD",
                      returnDate: "YYYY/MM/DD",
                      pathImage: "car-sigra.png",
                      lunas: true,
                    ),
                    // Add more CarCardBooking widgets if needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
