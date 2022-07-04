import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';
import '../../models/flightDetails.dart';

class GetFlight extends StatefulWidget {
  final String flightNo;
  final String date;
  const GetFlight({Key? key, required this.flightNo, required this.date})
      : super(key: key);

  @override
  _GetFlightState createState() => _GetFlightState();
}

class _GetFlightState extends State<GetFlight> {
  List<FlightData>? flight;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    retriveData();
  }

  retriveData() async {
    Flight mounted = await fetchFlight(widget.flightNo, widget.date);
    flight = mounted.data;

    print("Actual Data :${flight![0].flightStatus}");
    if (flight != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
        body: Container(
      height: isLoaded ? SizeConfig.screenHeight / 2 : SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          // Colors.yellow,
          // Colors.red,
          Colors.indigo,
          Colors.purple,
        ],
      )),
      child: Center(
          child: isLoaded
              ? Text(
                  "Airline Name: ${flight![0].airline!.name} \n Departure: ${flight![0].departure!.iata}\n Departure Time: ${flight![0].departure!.scheduled}(${flight![0].departure!.timezone})\n Departure Terminal:${flight![0].departure!.terminal} \n Departure Gate:${flight![0].departure!.gate} \n Arrival: ${flight![0].arrival!.iata} \n Arrival Terminal:${flight![0].arrival!.terminal}\nArrival Time ${flight![0].arrival!.scheduled}(${flight![0].arrival!.timezone})\n Arrival Gate:${flight![0].arrival!.gate} \n Flight Number: ${flight![0].flight!.number} \n Flight Status: ${flight![0].flightStatus}")
              : const CupertinoActivityIndicator(
                  animating: true,
                  radius: 30,
                  color: Colors.white,
                )),
    ));
  }
}
