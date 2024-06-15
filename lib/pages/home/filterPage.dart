import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:gaskeun_mobile/layouts/pageOnBG.dart';
import 'package:gaskeun_mobile/components/GradientButton.dart';
import '../../api/api_service.dart';
import 'filterResult.dart';
import 'package:gaskeun_mobile/models/Profile.dart';

class GradientToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  GradientToggleButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFFF9153), Color(0xFFFFD143)],
          )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFF9153)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Color(0xFFFF9153),
          ),
        ),
      ),
    );
  }
}

class CarBrandItem extends StatelessWidget {
  final String brand;
  final String imageAsset;
  final bool isSelected;
  final VoidCallback onPressed;

  CarBrandItem({
    required this.brand,
    required this.imageAsset,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFF9153)),
          gradient: isSelected
              ? LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFFF9153), Color(0xFFFFD143)],
          )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isSelected
                      ? [Colors.white, Colors.white]
                      : [Color(0xFFFF9153), Color(0xFFFFD143)],
                ).createShader(bounds);
              },
              child: Image.asset(
                imageAsset,
                height: 40,
                width: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              brand,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Color(0xFFFF9153),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  final User loggedUser;
  const FilterPage({
    Key? key,
    required this.loggedUser
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final ApiService _apiService = ApiService();

  DateTime? _pickupDate;
  DateTime? _returnDate;
  final _pickupDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  double _minPrice = 0;
  double _maxPrice = 1000000;
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  int _minPassengerCount = 8;
  final _minPassengerCountController = TextEditingController();
  List<String> transmissionTypes = ['', 'manual', 'matic'];
  List<bool> _selectedTransmission = [true, false, false];
  String _selectedBrand = '';
  final _indonesianCurrencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _minPriceController.text = _indonesianCurrencyFormat.format(_minPrice);
    _maxPriceController.text = _indonesianCurrencyFormat.format(_maxPrice);
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
          _pickupDateController.text = DateFormat('dd-MM-yyyy').format(_pickupDate!);
        } else {
          _returnDate = picked;
          _returnDateController.text = DateFormat('dd-MM-yyyy').format(_returnDate!);
        }
      });
    }
  }

  void _updateTransmissionFilter(int index) {
    setState(() {
      for (int i = 0; i < _selectedTransmission.length; i++) {
        _selectedTransmission[i] = i == index;
      }
    });
  }

  void _updateBrandFilter(String brand) {
    setState(() {
      _selectedBrand = brand;
      // Update your API call here if needed
    });
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
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Filter Mobil',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
            height: MediaQuery.of(context).size.height * 0.83, // 50% of screen height
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
          // Form container
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13, // Adjust this value as needed
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
                  SizedBox(height: 10),
                  Text('Tanggal Rental',
                      style:
                      TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: AbsorbPointer(
                            child: SizedBox(
                              height: 40,  // Explicitly set the height
                              child: TextField(
                                controller: _pickupDateController,
                                decoration: InputDecoration(
                                  labelText: 'Ambil',
                                  labelStyle: TextStyle(fontSize: 14),
                                  hintText: _pickupDate == null
                                      ? 'Pilih Tanggal'
                                      : DateFormat('yyyy-MM-dd').format(_pickupDate!),
                                  suffixIcon: Icon(Icons.calendar_today, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  isDense: true,  // Make the TextField compact
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
                              height: 40,  // Explicitly set the height
                              child: TextField(
                                controller: _returnDateController,
                                decoration: InputDecoration(
                                  labelText: 'Kembali',
                                  labelStyle: TextStyle(fontSize: 14),
                                  hintText: _returnDate == null
                                      ? 'Pilih Tanggal'
                                      : DateFormat('yyyy-MM-dd').format(_returnDate!),
                                  suffixIcon: Icon(Icons.calendar_today, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  isDense: true,  // Make the TextField compact
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                          height: 40,  // Explicitly set the height
                          child: TextField(
                            controller: _minPriceController,
                            decoration: InputDecoration(
                              labelText: 'Rp',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust padding
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
                          height: 40,  // Explicitly set the height
                          child: TextField(
                            controller: _maxPriceController,
                            decoration: InputDecoration(
                              labelText: 'Rp',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust padding
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
                  Text(
                    'Jumlah Penumpang',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0), // This flips the slider horizontally
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFFF9153), Color(0xFFFFD143)],
                        ).createShader(bounds);
                      },
                      child: Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.transparent,
                        value: _minPassengerCount.toDouble(),
                        min: 1,
                        max: 8,
                        divisions: 7,
                        onChanged: (double value) {
                          setState(() {
                            _minPassengerCount = value.round();
                            _minPassengerCountController.text = _minPassengerCount.toString();
                            // Update your API call here
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25), // Adjust the padding as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(8, (index) {
                        return Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 16),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Create the tranmission options here (semua, manual, matic)
                  Text(
                    'Transmisi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GradientToggleButton(
                        text: 'Semua',
                        isSelected: _selectedTransmission[0],
                        onPressed: () => _updateTransmissionFilter(0),
                      ),
                      GradientToggleButton(
                        text: 'Manual',
                        isSelected: _selectedTransmission[1],
                        onPressed: () => _updateTransmissionFilter(1),
                      ),
                      GradientToggleButton(
                        text: 'Matic',
                        isSelected: _selectedTransmission[2],
                        onPressed: () => _updateTransmissionFilter(2),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Car brand selection here
                  Text(
                    'Brand Mobil',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        CarBrandItem(
                          brand: 'Semua',
                          imageAsset: 'assets/img/img-logoAll.png',
                          isSelected: _selectedBrand == '',
                          onPressed: () => _updateBrandFilter(''),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Toyota',
                          isSelected: _selectedBrand == 'toyota',
                          imageAsset: 'assets/img/img-logoToyota.png',
                          onPressed: () => _updateBrandFilter('toyota'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Honda',
                          imageAsset: 'assets/img/img-logoHonda.png',
                          isSelected: _selectedBrand == 'honda',
                          onPressed: () => _updateBrandFilter('honda'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Mitsubishi',
                          isSelected: _selectedBrand == 'mitsubishi',
                          imageAsset: 'assets/img/img-logoMitsubishipng.png',
                          onPressed: () => _updateBrandFilter('mitsubishi'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Nissan',
                          imageAsset: 'assets/img/img-logoNissan.png',
                          isSelected: _selectedBrand == 'nissan',
                          onPressed: () => _updateBrandFilter('nissan'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Suzuki',
                          imageAsset: 'assets/img/img-logoSuzuki.png',
                          isSelected: _selectedBrand == 'suzuki',
                          onPressed: () => _updateBrandFilter('suzuki'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Daihatsu',
                          imageAsset: 'assets/img/img-logoDaihatsu.png',
                          isSelected: _selectedBrand == 'daihatsu',
                          onPressed: () => _updateBrandFilter('daihatsu'),
                        ),
                        SizedBox(width: 10),
                        CarBrandItem(
                          brand: 'Ford',
                          imageAsset: 'assets/img/img-logoFord.png',
                          isSelected: _selectedBrand == 'ford',
                          onPressed: () => _updateBrandFilter('ford'),
                        ),
                      ],
                    ),
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
                      print('Min Passenger Count: ${9 - _minPassengerCount}');
                      print('Selected Transmission: ${transmissionTypes[_selectedTransmission.indexOf(true)]}');
                      print('Selected Brand: $_selectedBrand');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterResultPage(
                            pickupDate: formattedPickupDate.toString(),
                            returnDate: formattedReturnDate.toString(),
                            minPrice: int.parse(_minPriceController.text.replaceAll('.', '')),
                            maxPrice: int.parse(_maxPriceController.text.replaceAll('.', '')),
                            numPassengers: 9 - _minPassengerCount,
                            brand: _selectedBrand,
                            transmission: transmissionTypes[_selectedTransmission.indexOf(true)],
                            loggedUser: widget.loggedUser,
                          ),
                        ),
                      );
                    },
                    text: 'Cari Mobil',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}