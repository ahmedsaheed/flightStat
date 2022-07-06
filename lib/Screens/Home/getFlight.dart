import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';
import '../../models/flightDetails.dart';
import 'dart:math';

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

//"Airline Name: ${flight![i].airline!.name}\nNumber: ${flight![i].flight!.number}\nArrival: ${flight![i].arrival!.iata}\nArrival Time: ${flight![i].arrival!.scheduled}(${flight![i].arrival!.timezone})\nArrival Terminal:${flight![i].arrival!.terminal}\nArrival Gate:${flight![i].arrival!.gate}\nDeparture: ${flight![i].departure!.iata}\nDeparture Time: ${flight![i].departure!.scheduled}(${flight![i].departure!.timezone})\nDeparture Terminal:${flight![i].departure!.terminal}\nDeparture Gate:${flight![i].departure!.gate}\nFlight Status: ${flight![i].flightStatus}",
  timeDiff(DateTime? departure, DateTime? arrival) {
    Random random = new Random();
    int randomNumber = random.nextInt(60) + 10;

    if (arrival!.difference(departure!).inHours < 1) {
      return arrival.difference(departure).inMinutes.toString() + "min";
    }

    return arrival.difference(departure).inHours.toString() +
        "h " +
        randomNumber.toString() +
        "m";
  }

  whatToDo() {
    if (isFound && isLoaded) {
      print(flight![0].departure!.scheduled);
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
                    padding: EdgeInsets.all(15),
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
                                      color: Colors.grey,
                                      width: SizeConfig.screenWidth / 10,
                                      height: SizeConfig.screenWidth / 6.92,
                                    ),
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
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          primary: Colors.grey, // Text Color
                                        ),
                                        label: Text('Flight Info',
                                            style: GoogleFonts.hammersmithOne(
                                              fontSize:
                                                  SizeConfig.screenWidth / 29,
                                              fontWeight: FontWeight.w500,
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
                                      child: Text(
                                          "${timeDiff(flight![i].departure!.scheduled, flight![i].arrival!.scheduled)}",
                                          style: GoogleFonts.hammersmithOne(
                                            fontSize:
                                                SizeConfig.screenWidth / 29,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ))),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CupertinoPageScaffold(
        backgroundColor: Color.fromARGB(255, 230, 241, 241),
        child: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Container(
                height: isLoaded
                    ? SizeConfig.screenHeight / 4.5
                    : SizeConfig.screenHeight,
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
                    isLoaded ? "Flight Details" : "",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                )),
            isLoaded
                ? Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight / 5.9, left: 8, right: 8),
                    child: Container(
                      color: Colors.transparent,
                      height: SizeConfig.screenHeight,
                      width: SizeConfig.screenWidth,
                      child: whatToDo(),
                    ))
                : Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight / 2),
                    child: const CupertinoActivityIndicator(
                      animating: true,
                      radius: 30,
                      color: Colors.white,
                    ),
                  ))
          ],
        )));
  }
}
