import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gaskeun_mobile/layouts/pageOnBG.dart';
import '../../components/car_card_booking.dart';
import 'package:gaskeun_mobile/models/Pesanan.dart'; // Import model Order
import 'package:gaskeun_mobile/models/Profile.dart'; // Import model User
import 'package:gaskeun_mobile/api/api_history.dart'; // Import service untuk fetch orders

class BookingPage extends StatefulWidget {
  final User loggedUser;
  const BookingPage({
    super.key,
    required this.loggedUser
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders(widget.loggedUser.id); // Ganti dengan userId yang sesuai
  }

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
                ]),
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
              child: FutureBuilder<List<Order>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Order>? orders = snapshot.data;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orders!
                            .map((order) => CarCardBooking(
                                  carName: order.carName,
                                  price: 'Rp ${order.price}',
                                  pickUpDate: order.pickUpDate,
                                  returnDate: order.returnDate,
                                  pathImage: order.imagePath,
                                  lunas: order.lunas,
                                  status: order.status,
                                  orderingUser: widget.loggedUser,
                                ))
                            .toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  // By default, show a loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
