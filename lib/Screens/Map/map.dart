import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappers extends StatefulWidget {
  const Mappers({Key? key}) : super(key: key);

  @override
  _MappersState createState() => _MappersState();
}

class _MappersState extends State<Mappers> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(53.3379, -6.2591);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('Live Data'),
      ),
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 1.0,
        ),
      ),
    );
  }
}
