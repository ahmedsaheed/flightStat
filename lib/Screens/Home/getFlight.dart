import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/airport.dart';
import '../../sizeConfig.dart';
import '../../models/flightDetails.dart';
import 'dart:math';
import 'Detailed.dart';

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
  bool isError = false;

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
    } else {
      isError = true;
    }
  }

  timeDiff(DateTime? departure, DateTime? arrival) {
    Random random = new Random();
    int randomNumber = random.nextInt(50) + 10;

    if (arrival!.difference(departure!).inHours < 1) {
      return arrival.difference(departure).inMinutes.toString() + "min";
    }

    return arrival.difference(departure).inHours.toString() +
        "h " +
        randomNumber.toString() +
        "m";
  }

  getAirport(String airportAITA) async {
    List<double> data = [];
    Airport airports = await airport(airportAITA);
    data.add(double.parse(airports.location!.lat.toString()));
    data.add(double.parse(airports.location!.lon.toString()));
    return data;
  }

  whatToDo() {
    if (isFound && isLoaded) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
            itemCount: flight!.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Container(
                    height: SizeConfig.screenWidth / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.loose,
                                    child: Container(
                                        color: Colors.transparent,
                                        width: SizeConfig.screenWidth / 1.2,
                                        height: SizeConfig.screenWidth / 6.92,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                "${flight![i].departure!.iata}",
                                                style: GoogleFonts.stylish(
                                                  fontSize:
                                                      SizeConfig.screenWidth /
                                                          20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                )),
                                            Text(
                                              " ${flight![i].departure!.scheduled.toString().substring(11, 16)}",
                                              style: GoogleFonts.hammersmithOne(
                                                fontSize:
                                                    SizeConfig.screenWidth / 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        color: Colors.transparent,
                                        width: SizeConfig.screenWidth / 10,
                                        height: SizeConfig.screenWidth / 6.92,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 1,
                                                    child: Container(
                                                        child: const Text(
                                                            "----------"))),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 1,
                                                    child: Container(
                                                        child: const Icon(
                                                      CupertinoIcons.airplane,
                                                      color: Colors.indigo,
                                                    ))),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 1,
                                                    child: Container(
                                                        child: const Text(
                                                            "----------"))),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.loose,
                                    child: Container(
                                        color: Colors.transparent,
                                        width: SizeConfig.screenWidth / 1.2,
                                        height: SizeConfig.screenWidth / 6.92,
                                        child: Column(
                                          children: <Widget>[
                                            Text("${flight![i].arrival!.iata}",
                                                style: GoogleFonts.stylish(
                                                  fontSize:
                                                      SizeConfig.screenWidth /
                                                          20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                )),
                                            Text(
                                              " ${flight![i].arrival!.scheduled.toString().substring(11, 16)}",
                                              style: GoogleFonts.hammersmithOne(
                                                fontSize:
                                                    SizeConfig.screenWidth / 25,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
                                  child: Container(
                                      color: Colors.transparent,
                                      width: SizeConfig.screenWidth / 1.2,
                                      height: SizeConfig.screenWidth / 20.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                        child: Text(
                                            "${flight![i].flight!.iata}",
                                            style: GoogleFonts.stylish(
                                              fontSize:
                                                  SizeConfig.screenWidth / 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      color: Colors.transparent,
                                      width: SizeConfig.screenWidth / 1.2,
                                      height: SizeConfig.screenWidth / 11.1,
                                      child: Center(
                                          child: TextButton.icon(
                                        icon: const Icon(CupertinoIcons.info,
                                            size: 15),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      flightDetails(
                                                        flightIATA: flight![i]
                                                            .flight!
                                                            .iata
                                                            .toString(),
                                                        airline: flight![i]
                                                            .airline!
                                                            .name
                                                            .toString(),
                                                        flightDate: flight![i]
                                                            .departure!
                                                            .scheduled
                                                            .toString()
                                                            .substring(0, 10),
                                                        flightStatus: flight![i]
                                                            .flightStatus
                                                            .toString()
                                                            .substring(13),
                                                        departureCity:
                                                            flight![i]
                                                                .departure!
                                                                .airport
                                                                .toString(),
                                                        arrivalCity: flight![i]
                                                            .arrival!
                                                            .airport
                                                            .toString(),
                                                        departureIATA:
                                                            flight![i]
                                                                .departure!
                                                                .iata
                                                                .toString(),
                                                        arrivalIATA: flight![i]
                                                            .arrival!
                                                            .iata
                                                            .toString(),
                                                        departureTime:
                                                            flight![i]
                                                                .departure!
                                                                .scheduled
                                                                .toString()
                                                                .substring(
                                                                    11, 16),
                                                        arrivalTime: flight![i]
                                                            .arrival!
                                                            .scheduled
                                                            .toString()
                                                            .substring(11, 16),
                                                        // departureLat:
                                                        //     getAirport(flight![
                                                        //             i]
                                                        //         .departure!
                                                        //         .iata
                                                        //         .toString())[0],
                                                        // departureLng:
                                                        //     getAirport(flight![
                                                        //             i]
                                                        //         .departure!
                                                        //         .iata
                                                        //         .toString())[1],
                                                        // arrivalLat: getAirport(
                                                        //     flight![i]
                                                        //         .arrival!
                                                        //         .iata
                                                        //         .toString())[0],
                                                        // arrivalLng: getAirport(
                                                        //     flight![i]
                                                        //         .arrival!
                                                        //         .iata
                                                        //         .toString())[1],
                                                      )));
                                        },
                                        style: TextButton.styleFrom(
                                          primary: Colors.grey, // Text Color
                                        ),
                                        label: Text('Flight Info',
                                            style: GoogleFonts.hammersmithOne(
                                              fontSize:
                                                  SizeConfig.screenWidth / 29,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            )),
                                      ))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
                                  child: Container(
                                      width: SizeConfig.screenWidth / 1.2,
                                      height: SizeConfig.screenWidth / 20.5,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const WidgetSpan(
                                              child: Icon(CupertinoIcons.clock,
                                                  size: 12, color: Colors.grey),
                                            ),
                                            TextSpan(
                                                text:
                                                    "${timeDiff(flight![i].departure!.scheduled, flight![i].arrival!.scheduled)}",
                                                style:
                                                    GoogleFonts.hammersmithOne(
                                                  fontSize:
                                                      SizeConfig.screenWidth /
                                                          35,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                )),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              );
            }),
      ));
    } else {
      return Center(
        child: Text('No flights found',
            style: GoogleFonts.hammersmithOne(
              fontSize: SizeConfig.screenWidth / 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 230, 241, 241),
      child: isLoaded
          ? SingleChildScrollView(
              child: Stack(
              children: <Widget>[
                Container(
                    height: SizeConfig.screenHeight / 4.5,
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
                      child: Text(
                        "Flight Details",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight / 5.9, left: 8, right: 8),
                    child: Container(
                      color: Colors.transparent,
                      height: SizeConfig.screenHeight,
                      width: SizeConfig.screenWidth,
                      child: whatToDo(),
                    ))
              ],
            ))
          : Container(
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
              child: const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 30,
                  color: Colors.white,
                ),
              )),
    );
  }
}
