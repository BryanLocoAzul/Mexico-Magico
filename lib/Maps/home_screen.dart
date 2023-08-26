import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.442999590760706, -101.65292727661607),
    zoom: 14,
  );

  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
    locationPermission();
    getCurrentLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void locationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Manejar la denegación del permiso de ubicación aquí
    }
  }

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Manejar servicios de ubicación deshabilitados aquí
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Manejar el permiso de ubicación denegado permanentemente aquí
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Manejar la denegación del permiso de ubicación aquí
        return;
      }
    }

    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
        updateMarker();
      });

      // Centrar el mapa en la ubicación actual
      _googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }, onError: (error) {
      // Manejar errores de obtención de ubicación aquí
    });
  }

  void updateMarker() {
    setState(() {
      _markers.clear();
      if (_currentPosition != null) {
        _markers.add(
          Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            infoWindow: InfoWindow(title: 'Estás actualmente aquí'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          trafficEnabled: false,
          rotateGesturesEnabled: true,
          buildingsEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _googleMapController = controller;
          },
        ),
      ),
    );
  }
}
