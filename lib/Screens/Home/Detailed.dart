import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../sizeConfig.dart';

class flightDetails extends StatefulWidget {
  final String? flightIATA;
  final String? flightNo;
  final String? flightDate;
  final String? flightStatus;
  final String? departureCity;
  final String? arrivalCity;
  final String? airline;

  const flightDetails(
      {Key? key,
      this.flightIATA,
      this.flightNo,
      this.flightDate,
      this.flightStatus,
      this.departureCity,
      this.arrivalCity,
      this.airline})
      : super(key: key);

  @override
  _flightDetailsState createState() => _flightDetailsState();
}

class _flightDetailsState extends State<flightDetails> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(53.3379, -6.2591);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

// Text(
//                   widget.flightIATA.toString() +
//                       "\n" +
//                       widget.flightDate.toString() +
//                       "\n" +
//                       widget.flightStatus.toString() +
//                       "\n" +
//                       widget.departureCity.toString() +
//                       "\n" +
//                       widget.arrivalCity.toString() +
//                       "\n" +
//                       widget.airline.toString(),
//                   style: GoogleFonts.roboto(
//                       fontWeight: FontWeight.w500, color: Colors.white),
//                 ),
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: Column(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
              height: SizeConfig.screenHeight / 2,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Colors.yellow,
                  // Colors.red,
                  Colors.indigo,
                  Colors.purple,
                ],
              )),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(children: <Widget>[]))),
        ),
        Expanded(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        )
      ]),
    );
  }
}
