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
  bool isFound = false;

  @override
  void initState() {
    super.initState();
    retriveData();
  }

  retriveData() async {
    Flight mounted = await fetchFlight(widget.flightNo, widget.date);
    flight = mounted.data;
    //FOR LIVE DATA:  mounted.data?.where((i) => i.live != null).toList();
    if (flight != null && flight!.isNotEmpty) {
      setState(() {
        isLoaded = true;
        isFound = true;
      });
    }
  }

  //"Airline Name: ${flight![0].airline!.name} \n Departure: ${flight![0].departure!.iata}\n Departure Time: ${flight![0].departure!.scheduled}(${flight![0].departure!.timezone})\n Departure Terminal:${flight![0].departure!.terminal} \n Departure Gate:${flight![0].departure!.gate} \n Arrival: ${flight![0].arrival!.iata} \n Arrival Terminal:${flight![0].arrival!.terminal}\nArrival Time ${flight![0].arrival!.scheduled}(${flight![0].arrival!.timezone})\n Arrival Gate:${flight![0].arrival!.gate} \n Flight Number: ${flight![0].flight!.number} \n Flight Status: ${flight![0].flightStatus}"),

  whatToDo() {
    if (isFound && isLoaded) {
      return SafeArea(
          child: Scaffold(
        body: Container(
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
          child: ListView.builder(
              itemCount: flight!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(
                    "Airline Name: ${flight![i].airline!.name}\nNumber: ${flight![i].flight!.number}\nArrival: ${flight![i].arrival!.iata}\nArrival Time: ${flight![i].arrival!.scheduled}(${flight![i].arrival!.timezone})\nArrival Terminal:${flight![i].arrival!.terminal}\nArrival Gate:${flight![i].arrival!.gate}\nDeparture: ${flight![i].departure!.iata}\nDeparture Time: ${flight![i].departure!.scheduled}(${flight![i].departure!.timezone})\nDeparture Terminal:${flight![i].departure!.terminal}\nDeparture Gate:${flight![i].departure!.gate}\nFlight Status: ${flight![i].flightStatus}",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                );
              }),
        ),
      ));
    } else if (!isFound && !isLoaded) {
      return const CupertinoActivityIndicator(
        animating: true,
        radius: 30,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CupertinoPageScaffold(
        backgroundColor: Color.fromARGB(255, 249, 240, 240),
        navigationBar: CupertinoNavigationBar(
          // Try removing opacity to observe the lack of a blur effect and of sliding content.
          backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
          middle: const Text('Flight Details'),
        ),
        child: Container(
            height: SizeConfig.screenHeight,
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
            child: whatToDo()));
  }
}
