import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../sizeConfig.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
        body: Container(
            height: SizeConfig.screenHeight,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // stops: [
              //   0.1,
              //   0.4,
              //   0.6,
              //   0.9,
              // ],
              colors: [
                // Colors.yellow,
                // Colors.red,
                Colors.indigo,
                Colors.purple,
              ],
            )),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenWidth(45)),
                  Stack(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.all(12.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("\n    Hello,",
                            style: const TextStyle(color: Colors.black)),
                      ),

                      Text(
                        'This is Google Fonts',
                        style: GoogleFonts.stylish(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // SizedBox(height: getProportionateScreenWidth(25)),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              CupertinoIcons.bell,
                              color: Colors.black,
                            )),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: MyPrefilledSearch(),
                  ),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  //const areaOfInterestMain()
                ],
              ),
            ))));
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
      placeholder: "Start to search your dream job...",
      onSubmitted: (String value) {
        print('Submitted text: $value');
      },
    );
  }
}
