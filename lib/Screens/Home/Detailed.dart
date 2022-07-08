import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/airport.dart';
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
  static double departureLat = 0;
  static double departureLng = 0;
  static double arrivalLat = 0;
  static double arrivalLng = 0;

  @override
  void initState() {
    super.initState();
    getDepartueAirport();
    getArrivalAirport();
  }

  getDepartueAirport() async {
    Airport depart = await airport(widget.departureIATA.toString());

    departureLat = depart.location!.lat!;
    departureLng = depart.location!.lon!;
  }

  getArrivalAirport() async {
    Airport airports = await airport(widget.arrivalIATA.toString());
    setState(() {
      arrivalLat = airports.location!.lat!;
      arrivalLng = airports.location!.lon!;
    });
  }

  late GoogleMapController mapController;

//FOR SOME REASON THE INITIAL LAT & LONG ARE SET TO (0,0) AND ARE ONLY UPDATED ON REFRESH
  final LatLng _center = LatLng(departureLat, departureLng);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
                          //SizedBox(height: getProportionateScreenHeight(5)),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                                height: SizeConfig.screenHeight / 9,
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
                                            Text(
                                                widget.departureTime.toString(),
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
