import "dart:ui";

import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import "package:gaskeun_mobile/components/GradientButton.dart";
import "package:gaskeun_mobile/layouts/pageWithAppBar.dart";
import "package:gaskeun_mobile/models/Car.dart";

class CarOrderPage extends StatefulWidget {
  final Car car;
  CarOrderPage({
    Key? key, 
    required this.car,
  }) : super(key: key);

  @override 
  State<CarOrderPage> createState() => _carOrderPage();
}

class _carOrderPage extends State<CarOrderPage> {
  var _approvedTnC = false;

  @override
  Widget build(BuildContext context) {
    return PageWithAppBar(
      title: "${widget.car.brand} ${widget.car.model}",
      children: <Widget>[
        Expanded(
          // https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTam7-Ui9GARJ79WSpBJyB_z9IGpLBnbCvWPajZYD3muQ&s",
              loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress == null) return child;
                return const CircularProgressIndicator();
              }
            )
          )
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                 Color(0xFFFFBCFF),
                 Color(0xFF0117FF),
              ]
            )
          ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25, right: 25,
                  top: 40, bottom: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Spesifikasi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 5),
                    _buildCarSpec(),
                    const SizedBox(height: 20),
                    const Text(
                      "Syarat dan Ketentuan",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 5),
                    _buildTnC(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox( // https://api.flutter.dev/flutter/material/Checkbox-class.html
                          value: _approvedTnC, 
                          onChanged: (bool? value) {
                            setState(() { _approvedTnC = value!; });
                          }
                        ),
                        const Flexible( 
                          child: Text(
                            "Saya menyetujui semua Syarat & Ketentuan yang berlaku",
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFFFF6969),
                            )
                          )
                        )
                      ],
                    ),
                  ]
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 25
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Rp. ${widget.car.price}/hari",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                      )
                    ),
                    Expanded(
                      child: GradientButton(
                        onPressed: (!_approvedTnC
                          ? null: () {
                            print("Hell");
                          }
                        ), 
                        text: "GASSS"
                      )
                    )
                  ],
                )
              )
            ]
          )
        ),
      ]
    );
  }

  Widget _buildTnC() { // Terms and Conditions
    final List<String> entries = [
      "Wajib berusia minimal 21 tahun dan memiliki SIM A yang masih berlaku.",
      "Menunjukkan KTP dan SIM asli saat pengambilan mobil.",
      "Pengambilan mobil dilakukan di kantor",
      "Memberikan deposit sebagai jaminan keamanan",
      "Bertanggung jawab atas kerusakan mobil selama masa sewa",
      "Mematuhi peraturan lalu lintas yang berlaku",
      "Pemesanan dan pembayaran dapat dilakukan melalui website dan aplikasi",
      "Pembayaran sewa dilakukan secara offline",
      "Penyewa bertanggung jawab atas segala kerusakan yang terjadi pada mobil selama masa sewa",
      "Rental mobil tidak bertanggung jawab atas kehilangan barang bawaan penyewa"
    ];

    // Bullet list
    // https://stackoverflow.com/questions/49625730/how-do-i-add-a-bullet-or-create-a-bulleted-list-in-flutter
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: entries.map((entry) {
        const textStyle = TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        );
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            const Text( "\u2022 ", style: textStyle ),
              Expanded(
                child: Text(
                  entry, 
                  textAlign: TextAlign.justify,
                  style: textStyle
                )
              ),
            ],
          );
      }).toList(),
    );
  }

  Widget _buildCarSpec() {
    final List<Map> specEntries = [
      {
        "metric": "capacity",
        "icon": Icons.person,
        "data": "${widget.car.capacity} orang"
      },
      {
        "metric": "transmission",
        "icon": Icons.settings,
        "data": widget.car.transmission
      },
      {
        "metric": "fuel",
        "icon": Icons.local_gas_station,
        "data": widget.car.fuel
      },
    ];

    return Row(
      children: specEntries.map((item) => (
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white
            ),
            child: Column(
              key: ValueKey(item["metric"]),
              children: [ 
                Icon( item["icon"], ), 
                Text( 
                  item["data"], 
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ) 
                ) 
              ],
            ),
          )
        )       
      )).toList()
    );
  }
}