import 'package:flutter/material.dart';
import "package:gaskeun_mobile/layouts/pageOnBG.dart";
import '../../components/car_card.dart';

import 'package:gaskeun_mobile/models/CarList.dart';
import 'package:gaskeun_mobile/models/Profile.dart';

import 'package:gaskeun_mobile/api/api_mobil.dart';

class FilterResultPage extends StatefulWidget {
  final DateTime? pickupDate;
  final DateTime? returnDate;
  final int? minPrice;
  final int? maxPrice;
  final int? numPassengers;
  final String? brand;
  final String? transmission;
  final User loggedUser;

  const FilterResultPage({
    Key? key,
    this.pickupDate,
    this.returnDate,
    this.minPrice,
    this.maxPrice,
    this.numPassengers,
    this.brand,
    this.transmission,
    required this.loggedUser
  }) : super(key: key);

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResultPage> {
  late Future<List<Car>> _futureCars;

  @override
  void initState() {
    super.initState();
    _futureCars = ApiService.fetchCarsWithFilter(
    brand: widget.brand,
    transmission: widget.transmission,
    numPassengers: widget.numPassengers,
    minPrice: widget.minPrice,
    maxPrice: widget.maxPrice,
    startDate: widget.pickupDate,
    endDate: widget.returnDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Car>>(
        future: _futureCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars available'));
          } else {
            List<Car> cars = snapshot.data!;
            return PageOnBG(
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
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Hasil Pencarian',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ]),
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
                        children: cars
                            .map((car) => CarCard(
                                  id: car.id,
                                  providerId: car.idPengguna,
                                  carImageId: car.idImage,
                                  brand: car.brand,
                                  model: car.model,
                                  people: car.kapasitas,
                                  price: car.hargaSewa,
                                  description: car.deskripsi,
                                  plateNumber: car.nomorPolisi,
                                  fuel: car.bahanBakar,
                                  transmission: car.transmisi,
                                  pathImage: car.image.path,
                                  available: car.status == 'tersedia',
                                  orderingUser: widget.loggedUser,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
