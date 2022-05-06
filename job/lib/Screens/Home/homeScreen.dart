import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sizeConfig.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(45)),
              Stack(
                children: const [
                  // Padding(
                  //   padding: EdgeInsets.all(12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\n    Hello,",
                        style: TextStyle(color: Colors.black)),
                  ),

                  Text(
                    "\n\n  Ahmed Saheed",
                    style: TextStyle(
                        color: Colors.black,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),

                  // Icon(CupertinoIcons.alert,)
                ],
              ),
              // SizedBox(height: getProportionateScreenWidth(5)),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: MyPrefilledSearch(),
              ),
              SizedBox(height: getProportionateScreenWidth(15)),
            ],
          ),
        )));

    //const MyPrefilledSearch();
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
      onSubmitted: (String value) {
        print('Submitted text: $value');
      },
    );
  }
}
