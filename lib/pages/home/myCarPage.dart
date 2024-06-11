import 'package:flutter/material.dart';
import "package:gaskeun_mobile/layouts/pageOnBG.dart";
import '../../components/car_card.dart';


// import 'package:google_fonts/google_fonts.dart';

class CarPage extends StatelessWidget {
  const CarPage({super.key});

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
                      'Mobil\nKami',
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
          Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CarCard(
                      carName: 'Toyota Innova Zenix',
                      people: 4,
                      transmission: 'Manual',
                      price: 'Rp 300.000/hari',
                    ),
                    CarCard(
                      carName: 'Toyota Avanza',
                      people: 7,
                      transmission: 'Matic',
                      price: 'Rp 400.000/hari',
                    ),
                    CarCard(
                      carName: 'Honda Brio',
                      people: 5,
                      transmission: 'Manual',
                      price: 'Rp 200.000/hari',
                    ),
                    CarCard(
                      carName: 'Honda Brio',
                      people: 5,
                      transmission: 'Manual',
                      price: 'Rp 200.000/hari',
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
