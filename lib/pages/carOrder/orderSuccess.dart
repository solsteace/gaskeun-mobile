import 'package:flutter/material.dart';
import "package:gaskeun_mobile/components/GradientButton.dart";
import 'package:gaskeun_mobile/pages/home/main.dart';

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.0), // Add horizontal padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 203, // Specify height to match the image's height
                    width: 310, // Specify width to match the image's width
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/forOrderSuccess.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Pemesanan Berhasil',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Terimakasih, Pesanan Anda telah kami terima. Silahkan cek email Anda untuk melanjutkan proses pembayaran.',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  GradientButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(title: "My Bookings", user: 1, index: 2),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    text: 'Pesanan Saya',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
