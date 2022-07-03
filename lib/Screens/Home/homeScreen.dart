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
                  // SizedBox(height: getProportionateScreenWidth(25)),
                  Padding(
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
      placeholder: "Start to search your dream job...",
      onSubmitted: (String value) {
        print('Submitted text: $value');
      },
    );
  }
}

// class areaOfInterestMain extends StatelessWidget {
//   const areaOfInterestMain({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         sectionTitle(
//           text: "Latest Postings",
//           press: () {},
//         ),
//         SizedBox(height: getProportionateScreenHeight(5)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               areaOfInterest(
//                 image: "assets/images/test.png",
//                 category: "Lorem ipsum",
//                 press: () {},
//               ),
//               areaOfInterest(
//                 image: "assets/images/test.png",
//                 category: "Lorem ipsum",
//                 press: () {},
//               ),
//               areaOfInterest(
//                 image: "assets/images/test.png",
//                 category: "Lorem ipsum",
//                 press: () {},
//               ),
//               areaOfInterest(
//                 image: "assets/images/test.png",
//                 category: "Lorem ipsum",
//                 press: () {},
//               ),
//               SizedBox(
//                 width: getProportionateScreenWidth(20),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class areaOfInterest extends StatelessWidget {
//   const areaOfInterest({
//     Key? key,
//     required this.category,
//     required this.image,
//     //required this.numOfAreas,
//     required this.press,
//   }) : super(key: key);
//   final String category, image;
//   //final int numOfAreas;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//       child: SizedBox(
//         width: SizeConfig.screenWidth - 140,
//         height: SizeConfig.screenHeight * 0.25,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Stack(
//             children: [
//               Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   //color: Color.
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       const Color.fromARGB(240, 149, 81, 0).withOpacity(0.4),
//                       const Color.fromARGB(240, 149, 81, 0).withOpacity(0.15),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenHeight(15),
//                     vertical: getProportionateScreenWidth(10)),
//                 child: Text.rich(TextSpan(
//                     style: const TextStyle(color: Colors.white),
//                     children: [
//                       TextSpan(
//                         text: "$category\n",
//                         style: TextStyle(
//                             fontSize: getProportionateScreenWidth(18),
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const TextSpan(
//                           text:
//                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu felis id est suscipit convallis. Fusce auctor molestie sem, feugiat laoreet sapien bibendum et. Aliquam sed posuere odio, sed luctus lacus."),
//                     ])),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class sectionTitle extends StatelessWidget {
//   const sectionTitle({
//     Key? key,
//     required this.text,
//     required this.press,
//   }) : super(key: key);
//   final String text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: getProportionateScreenWidth(13),
//               color: Colors.black,
//             ),
//           ),
//           GestureDetector(onTap: press, child: const Text("")),
//         ],
//       ),
//     );
//   }
// }
