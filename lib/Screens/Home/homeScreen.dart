import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final TextEditingController _textEditingController =
        TextEditingController();

    return Scaffold(
        body: Container(
            height: SizeConfig.screenHeight / 1.5,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.zero,
                ),
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
                  SizedBox(height: getProportionateScreenWidth(60)),
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
                      SizedBox(height: getProportionateScreenWidth(35)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: MyPrefilledSearch(),
                  ),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(
                      'Select Date:',
                      style: GoogleFonts.hammersmithOne(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (newValue) {},
                          // print(newDateTime);
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

class MyPrefilledSearch extends StatefulWidget {
  const MyPrefilledSearch({Key? key}) : super(key: key);

  @override
  State<MyPrefilledSearch> createState() => _MyPrefilledSearchState();
}

class _MyPrefilledSearchState extends State<MyPrefilledSearch> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: (String value) {
        print('The text has changed to: $value');
      },
      placeholder: "Enter flight number...",
      onSubmitted: (String value) {
        print('Submitted text: $value');
      },
    );
  }
}

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text("Show DatePicker"),
          onPressed: () {
            showDatePicker();
          },
        ),
        Text(selectedDate == null ? "" : "$selectedDate")
      ],
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (newValue) {
                if (newValue != null && newValue != selectedDate) {
                  setState(() {
                    selectedDate = newValue;
                  });
                }
              },
            ),
          );
        });
  }
}
