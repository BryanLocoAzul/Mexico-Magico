import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CustomMarkerInfoWindowScreen2 extends StatefulWidget {
  const CustomMarkerInfoWindowScreen2({Key? key}) : super(key: key);

  @override
  _CustomMarkerInfoWindowScreenState2 createState() =>
      _CustomMarkerInfoWindowScreenState2();
}

class _CustomMarkerInfoWindowScreenState2
    extends State<CustomMarkerInfoWindowScreen2> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final LatLng _origin = LatLng(20.448631425422246, -101.62292316127323);
  final LatLng _destination = LatLng(20.530291360674216, -101.6710908781036);
  final double _zoom = 15.0;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  List<String> images = [
    'assets/imagenes/restaurante.png',
    'assets/imagenes/lugar.png',
  ];

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(images[i].toString(), 100);

      if (i == 1) {
        _markers.add(
          Marker(
            markerId: MarkerId('2'),
            position: _destination,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://tequilacorralejo.mx/assets/base/img/visitanos/nuestros-complejos.jpg',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.green,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Tequilera',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'hola',
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'El mejor lugar para explorar con tus amigos y nunca volver a casa',
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                _destination,
              );
            },
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: _origin,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Pizzas el bisco',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '',
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'las mejores pizzas de penjamo, recetas caseras.',
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                _origin,
              );
            },
          ),
        );
      }
      
    }

    setState(() {});

    
    await getDirections();
  }

  Future<void> getDirections() async {
    String apiKey = 'AIzaSyCeDpvcrOLxZbLwEyf0P9m3m4VxlOpiwRc';
    String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<LatLng> points = _decodePolylinePoints(
          decoded['routes'][0]['overview_polyline']['points']);
      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 4,
            points: points,
          ),
        );
      });
    } else {
      print('Error al obtener las direcciones');
    }
  }

  List<LatLng> _decodePolylinePoints(String encoded) {
    List<LatLng> decodedPoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latLngScale = 1e5;
      double latitude = lat / latLngScale;
      double longitude = lng / latLngScale;

      decodedPoints.add(LatLng(latitude, longitude));
    }

    return decodedPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de rutas'),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            markers: _markers,
            polylines: _polylines,
            initialCameraPosition: CameraPosition(
              target: _origin,
              zoom: _zoom,
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
