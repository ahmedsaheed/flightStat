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
  final String? departureIATA;
  final String? arrivalIATA;
  final String? departureTime;
  final String? arrivalTime;

  const flightDetails(
      {Key? key,
      this.flightIATA,
      this.flightNo,
      this.flightDate,
      this.flightStatus,
      this.departureCity,
      this.arrivalCity,
      this.airline,
      this.departureIATA,
      this.arrivalIATA,
      this.departureTime,
      this.arrivalTime})
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
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Stack(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: getProportionateScreenHeight(50)),
                          Text(
                            "Flight ${widget.flightIATA.toString()}",
                            style: GoogleFonts.hammersmithOne(
                              textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(30),
                              ),
                            ),
                          ),
                          Text(
                            "Departure: ${widget.departureCity.toString()[0].toUpperCase()}${widget.departureCity.toString().substring(1)}",
                            style: GoogleFonts.stylish(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Arrival: ${widget.arrivalCity.toString()[0].toUpperCase()}${widget.arrivalCity.toString().substring(1)}",
                            style: GoogleFonts.stylish(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Status: Flight ${widget.flightStatus.toString()[0].toUpperCase()}${widget.flightStatus.toString().substring(1).toLowerCase()}",
                            style: GoogleFonts.stylish(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "Airline: ${widget.airline.toString()[0].toUpperCase()}${widget.airline.toString().substring(1)}",
                            style: GoogleFonts.stylish(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Date: ${widget.flightDate.toString()}",
                            style: GoogleFonts.stylish(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                                height: SizeConfig.screenHeight / 7,
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: Container(
                                          width: SizeConfig.screenWidth / 1.2,
                                          height: SizeConfig.screenWidth / 4.5,
                                          color: Colors.transparent,
                                          child: Column(children: <Widget>[
                                            Text(
                                                widget.departureIATA.toString(),
                                                style: GoogleFonts.hammersmithOne(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            22),
                                                    color: Colors.white)),
                                            Text(widget.arrivalTime.toString(),
                                                style: GoogleFonts.stylish(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            20),
                                                    color: Colors.white)),
                                          ])),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: Container(
                                        width: SizeConfig.screenWidth / 1.2,
                                        height: SizeConfig.screenWidth / 2,
                                        color: Colors.transparent,
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 22),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Icon(CupertinoIcons.airplane,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: Container(
                                          width: SizeConfig.screenWidth / 1.2,
                                          height: SizeConfig.screenWidth / 4.5,
                                          color: Colors.transparent,
                                          child: Column(children: <Widget>[
                                            Text(widget.arrivalIATA.toString(),
                                                style: GoogleFonts.hammersmithOne(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            22),
                                                    color: Colors.white)),
                                            Text(widget.arrivalTime.toString(),
                                                style: GoogleFonts.stylish(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            20),
                                                    color: Colors.white)),
                                          ])),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ]))),
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
