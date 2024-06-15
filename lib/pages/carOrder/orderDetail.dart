import 'package:flutter/material.dart';
import 'package:gaskeun_mobile/layouts/pageOnBG.dart';
import 'package:gaskeun_mobile/components/GradientButton.dart';
import 'package:gaskeun_mobile/components/mapPicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gaskeun_mobile/models/Car.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gaskeun_mobile/api/api_create_pesanan.dart';
import "package:gaskeun_mobile/models/Profile.dart";
import './orderSuccess.dart';

class OrderDetailPage extends StatefulWidget {
  final Car car;
  final User user;

  OrderDetailPage({
    Key? key,
    required this.car,
    required this.user,
  }) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  LatLng? pickupLocation;
  LatLng? returnLocation;
  DateTime? pickupDate;
  DateTime? returnDate;
  String? phone;
  String? emergencyPhone;
  PlatformFile? license;

  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController returnLocationController = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        license = result.files.first;
      });
    }
  }

  bool _isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  var _approvedTnC = false;

  Future<String> _getAddressFromLatLng(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}";
    }
    return '';
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final paymentId = await ApiService.createPayment();
        final orderId = await ApiService.createOrder(
          widget.user.id, // Replace with the actual id_pemesan
          widget.car.id,
          paymentId!,
          fullName!,
          pickupDate!.toIso8601String(),
          returnDate!.toIso8601String(),
          license!.path!,
          titikAntar: pickupLocationController.text,
          titikJemput: returnLocationController.text,
        );

        // Navigate to success page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderSuccessPage(loggedUser: widget.user),
          ),
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(error.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Detail Pemesanan',
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
              top: 30,
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
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nama Lengkap',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukan Nama Lengkap anda';
                              }
                              return null;
                            },
                            onSaved: (value) => fullName = value,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Alamat Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukan Alamat Email Anda';
                              }
                              return null;
                            },
                            onSaved: (value) => email = value,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final selectedLocation = await showDialog<LatLng>(
                                context: context,
                                barrierDismissible:
                                    false, // Prevents closing the dialog by tapping outside
                                builder: (context) => Dialog(
                                  insetPadding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7, // Adjust the height as needed
                                    child: MapPicker(),
                                  ),
                                ),
                              );

                              // 'pickupLocation' now contains the selected location's LatLng
                              if (selectedLocation != null) {
                                String address = await _getAddressFromLatLng(
                                    selectedLocation);
                                setState(() {
                                  pickupLocation = selectedLocation;
                                  pickupLocationController.text = address;
                                });
                              } else {
                                setState(() {
                                  pickupLocation = null;
                                  pickupLocationController.text = '';
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: pickupLocationController,
                                decoration: const InputDecoration(
                                  labelText: 'Lokasi Pengambilan',
                                  helperText: 'Kosongkan bila diambil di kantor',
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final selectedLocation = await showDialog<LatLng>(
                                context: context,
                                barrierDismissible:
                                    false, // Prevents closing the dialog by tapping outside
                                builder: (context) => Dialog(
                                  insetPadding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7, // Adjust the height as needed
                                    child: MapPicker(),
                                  ),
                                ),
                              );

                              // 'returnLocation' now contains the selected location's LatLng
                              if (selectedLocation != null) {
                                String address = await _getAddressFromLatLng(
                                    selectedLocation);
                                setState(() {
                                  returnLocation = selectedLocation;
                                  returnLocationController.text = address;
                                });
                              } else {
                                setState(() {
                                  returnLocation = null;
                                  returnLocationController.text = '';
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: returnLocationController,
                                decoration: const InputDecoration(
                                  labelText: 'Lokasi Pengembalian',
                                  helperText: 'Kosongkan bila dikembalikan di kantor',
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Tanggal Ambil',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukan Tanggal Ambil';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        pickupDate = pickedDate;
                                      });
                                    }
                                  },
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: pickupDate != null
                                        ? "${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}"
                                        : '',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Tanggal Kembali',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Masukan Tanggal Kembali';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        returnDate = pickedDate;
                                      });
                                    }
                                  },
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: returnDate != null
                                        ? "${returnDate!.day}/${returnDate!.month}/${returnDate!.year}"
                                        : '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType
                                .number, // Set keyboard type to numeric
                            decoration: const InputDecoration(
                              labelText: 'No Telepon',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukan No Telepon';
                              } else if (!_isNumeric(value)) {
                                return 'No Telepon tidak valid';
                              }
                              return null;
                            },
                            onSaved: (value) => phone = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'No Telepon Darurat',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukan No Telepon Darurat';
                              } else if (!_isNumeric(value)) {
                                return 'No Telepon tidak valid';
                              }
                              return null;
                            },
                            onSaved: (value) => emergencyPhone = value,
                          ),
                          GestureDetector(
                            onTap: _pickFile,
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Surat Izin Mengemudi Kategori A',
                                  suffixIcon: Icon(Icons.file_upload),
                                ),
                                controller: TextEditingController(
                                  text: license?.name ?? 'No file selected',
                                ),
                                validator: (value) {
                                  if (license == null) {
                                    return 'Please select a file';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: _approvedTnC,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _approvedTnC = value!;
                                  });
                                },
                              ),
                              const Expanded(
                                child: Text(
                                  'Saya Menyetujui bahwa data diri saya akan disimpan dan digunakan sesuai dengan kebijakan yang berlaku',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFFF6969),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GradientButton(
                            onPressed: (!_approvedTnC
                                ? null
                                : () {
                                    _submitForm();
                                  }),
                            text: 'Konfirmasi Pemesanan',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Add more widgets here if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
