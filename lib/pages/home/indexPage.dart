import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import "package:gaskeun_mobile/layouts/pageOnBG.dart";
import "package:gaskeun_mobile/components/GradientButton.dart";
import '../../components/car_card.dart';
import '../../models/Profile.dart';
import 'filterPage.dart';
import 'package:gaskeun_mobile/models/CarList.dart';
import 'package:gaskeun_mobile/models/Profile.dart';
import '../../api/api_service.dart';
import 'package:gaskeun_mobile/api/api_mobil.dart' as apiMobil;
import "./filterResult.dart";

String getGreetingMessage() {
  var hour = DateTime.now().hour;

  if (hour < 12) {
    return 'Selamat Pagi!';
  } else if (hour < 15) {
    return 'Selamat Siang!';
  } else if (hour < 18) {
    return 'Selamat Sore!';
  } else {
    return 'Selamat Malam!';
  }
}

class IndexPage extends StatefulWidget {
  final User loggedUser;

  const IndexPage({Key? key, required this.loggedUser}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  User? _user;
  late Future<List<Car>> _futureCars;
  final ApiService _apiService = ApiService();

  DateTime? _pickupDate;
  DateTime? _returnDate;
  final _pickupDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  double _minPrice = 0;
  double _maxPrice = 1000000;
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _indonesianCurrencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _futureCars = apiMobil.ApiService.fetchCars();
    _minPriceController.text = _indonesianCurrencyFormat.format(_minPrice);
    _maxPriceController.text = _indonesianCurrencyFormat.format(_maxPrice);
  }

  Future<void> _fetchUserProfile() async {
    try {
      Map<String, dynamic> userProfile = await _apiService.fetchUserProfile(widget.loggedUser.token);
      setState(() {
        _user = User.fromJson(userProfile);
      });
    } catch (e) {
      // Handle errors here
      print('Failed to fetch user profile: $e');
    }
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isPickup ? _pickupDate : _returnDate)) {
      setState(() {
        if (isPickup) {
          _pickupDate = picked;
          _pickupDateController.text =
              DateFormat('dd-MM-yyyy').format(_pickupDate!);
        } else {
          _returnDate = picked;
          _returnDateController.text =
              DateFormat('dd-MM-yyyy').format(_returnDate!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Main content
          PageOnBG(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo, ${_user?.nama ?? 'Nama'}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      getGreetingMessage(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height *
                0.72, // 50% of screen height
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.31,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: FutureBuilder<List<Car>>(
                // Car Cards
                future: _futureCars, // Use _futureCars here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No cars available'));
                  } else {
                    List<Car> cars = snapshot.data!;
                    cars =
                        cars.where((car) => car.status == 'tersedia').toList();
                    return ListView.builder(
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        Car car = cars[index];
                        return CarCard(
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // Form container
          Positioned(
            top: MediaQuery.of(context).size.height * 0.135, // Adjust this value as needed
            left: 25,
            right: 25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Text('Tanggal Rental',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: AbsorbPointer(
                            child: SizedBox(
                              height: 40, // Explicitly set the height
                              child: TextField(
                                controller: _pickupDateController,
                                decoration: InputDecoration(
                                  labelText: 'Ambil',
                                  labelStyle: TextStyle(fontSize: 14),
                                  hintText: _pickupDate == null
                                      ? 'Pilih Tanggal'
                                      : DateFormat('yyyy-MM-dd')
                                          .format(_pickupDate!),
                                  suffixIcon:
                                      Icon(Icons.calendar_today, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  isDense: true, // Make the TextField compact
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: AbsorbPointer(
                            child: SizedBox(
                              height: 40, // Explicitly set the height
                              child: TextField(
                                controller: _returnDateController,
                                decoration: InputDecoration(
                                  labelText: 'Kembali',
                                  labelStyle: TextStyle(fontSize: 14),
                                  hintText: _returnDate == null
                                      ? 'Pilih Tanggal'
                                      : DateFormat('yyyy-MM-dd')
                                          .format(_returnDate!),
                                  suffixIcon:
                                      Icon(Icons.calendar_today, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  isDense: true, // Make the TextField compact
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Harga Mobil',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero, // Remove any padding
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFFFD143), Color(0xFFFF9153)],
                        ).createShader(bounds);
                      },
                      child: RangeSlider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.transparent,
                        values: RangeValues(_minPrice, _maxPrice),
                        min: 0,
                        max: 1000000,
                        divisions: 100000,
                        labels: RangeLabels(
                          _indonesianCurrencyFormat.format(_minPrice),
                          _indonesianCurrencyFormat.format(_maxPrice),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _minPrice = values.start;
                            _maxPrice = values.end;
                            _minPriceController.text = _indonesianCurrencyFormat.format(_minPrice);
                            _maxPriceController.text = _indonesianCurrencyFormat.format(_maxPrice);
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40, // Explicitly set the height
                          child: TextField(
                            controller: _minPriceController,
                            decoration: InputDecoration(
                              labelText: 'Rp',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0), // Adjust padding
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              setState(() {
                                _minPrice = double.tryParse(value) ?? 0;
                              });
                            },
                            readOnly: true, // Add this line
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 40, // Explicitly set the height
                          child: TextField(
                            controller: _maxPriceController,
                            decoration: InputDecoration(
                              labelText: 'Rp',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0), // Adjust padding
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              setState(() {
                                _maxPrice = double.tryParse(value) ?? 1000000;
                              });
                            },
                            readOnly: true, // Add this line
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GradientButton(
                    onPressed: () {
                      DateTime? pickupDate;
                      DateTime? returnDate;
                      if (_pickupDateController.text.isNotEmpty) {
                        pickupDate = DateFormat('dd-MM-yyyy').parse(_pickupDateController.text);
                      }
                      if (_returnDateController.text.isNotEmpty) {
                        returnDate = DateFormat('dd-MM-yyyy').parse(_returnDateController.text);
                      }
                      String formattedPickupDate = pickupDate != null ? DateFormat('yyyy-MM-dd').format(pickupDate) : '';
                      String formattedReturnDate = returnDate != null ? DateFormat('yyyy-MM-dd').format(returnDate) : '';

                      print('Pickup Date: $formattedPickupDate');
                      print('Return Date: $formattedReturnDate');
                      print('Min Price: ${int.parse(_minPriceController.text.replaceAll('.', ''))}');
                      print('Max Price: ${int.parse(_maxPriceController.text.replaceAll('.', ''))}');
                    },
                    text: 'Cari Mobil',
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'atau',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          height: 15,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  GradientButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                    text: 'Lebih Banyak Filter',
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
