import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDate;
  bool isDateSet = false;
  String? date;
  String? flightNo;
  bool isFlightSet = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final TextEditingController _textEditingController =
        TextEditingController();

    return Scaffold(
        body: Container(
            height: SizeConfig.screenHeight,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(70)),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: Text(
                          'Search your upcoming \nflight',
                          style: GoogleFonts.hammersmithOne(
                            textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(35.0),
                      child: CupertinoSearchTextField(
                        onChanged: (String value) {
                          setState(() {
                            flightNo = value;
                            isFlightSet = true;
                          });
                        },
                        placeholder: "Enter flight number...",
                        onSubmitted: (String value) {
                          setState(() {
                            flightNo = value;
                            isFlightSet = true;
                          });
                        },
                      )),
                  SizedBox(height: getProportionateScreenWidth(35)),
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      flightNo == null
                          ? "Flight Number:"
                          : "Flight Number: $flightNo",
                      style: GoogleFonts.hammersmithOne(
                        textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      selectedDate == null
                          ? "Select Date:"
                          : "Select Date: ${selectedDate.toString().substring(0, 10)}",
                      style: GoogleFonts.hammersmithOne(
                        textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 300,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          minimumDate: DateTime.now(),
                          onDateTimeChanged: (newValue) {
                            if (newValue != null && newValue != selectedDate) {
                              setState(() {
                                selectedDate = newValue;
                                isDateSet = true;
                                date = selectedDate.toString().substring(0, 10);
                              });
                            }
                          },
                        ),
                      )),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  CupertinoButton(
                    color: Colors.indigo,
                    onPressed: () {},
                    child: const Text('Search'),
                  ),
                ],
              ),
            )));
  }
}
