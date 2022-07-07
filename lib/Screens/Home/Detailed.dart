import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';

class flightDetails extends StatefulWidget {
  final String? flightIATA;
  final String? flightNo;
  final String? flightDate;
  final String? flightStatus;
  final String? departureCity;
  final String? arrivalCity;

  const flightDetails({
    Key? key,
    this.flightIATA,
    this.flightNo,
    this.flightDate,
    this.flightStatus,
    this.departureCity,
    this.arrivalCity,
  }) : super(key: key);

  @override
  _flightDetailsState createState() => _flightDetailsState();
}

class _flightDetailsState extends State<flightDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            widget.flightIATA.toString() +
                "\n" +
                widget.flightDate.toString() +
                "\n" +
                widget.flightStatus.toString() +
                "\n" +
                widget.departureCity.toString() +
                "\n" +
                widget.arrivalCity.toString(),
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ));
  }
}
