import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPicker extends StatefulWidget {
  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? selectedLocation;
  String? selectedAddress;
  final LatLng defaultLocation = LatLng(-6.8961489, 107.617235); // Example: San Francisco
  final _controller = Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  bool _isVisible = true;

  Future<void> _onMapTapped(LatLng location) async {
    final placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    final place = placemarks.first;
    final address = '${place.street}, ${place.locality}, ${place.country}';

    setState(() {
      selectedLocation = location;
      selectedAddress = address;
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
      ));
    });
  }

  void _onHapusTapped() {
    setState(() {
      selectedLocation = null;
      selectedAddress = null;
      _markers.clear();
    });
  }

  void _onPilihTapped(BuildContext context) {
    if (selectedLocation != null) {
      Navigator.of(context).pop(selectedLocation);
    }
  }

  void _onCloseTapped(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _zoomIn() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set the scaffold background to transparent
      body: Container(
        color: Colors.transparent, // Ensure the container is also transparent
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 5), // Adjust the padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pilih Lokasi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.black),
                        onPressed: () => _onCloseTapped(context),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isVisible)
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(target: defaultLocation, zoom: 12),
                        onTap: _onMapTapped,
                        onMapCreated: (controller) => _controller.complete(controller),
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false, // Disable the default zoom controls
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                      ),
                      if (selectedAddress != null)
                        Positioned(
                          top: 20,
                          left: 20,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              selectedAddress!,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              mini: true,
                              onPressed: _zoomIn,
                              child: Icon(Icons.add),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            SizedBox(height: 8),
                            FloatingActionButton(
                              mini: true,
                              onPressed: _zoomOut,
                              child: Icon(Icons.remove),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 90,
                        child: FloatingActionButton(
                          onPressed: _onHapusTapped,
                          child: Icon(Icons.delete),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: FloatingActionButton(
                          onPressed: () => _onPilihTapped(context),
                          child: Icon(Icons.check),
                          backgroundColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}