import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diet_app_onboarding/Screens/About/weight_picker.dart';
import 'dart:math' as math;
import 'custom_paint_class.dart';
import 'height_picker.dart';
import 'weight_slider.dart';

enum Gender{
  male,
  female
}

class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {

  int height = 153;
  int weight = 70;

  late Gender gender;

  @override
  void initState() {
    gender = Gender.male;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text('About You',
            style: GoogleFonts.rubik(fontSize: 38, fontWeight: FontWeight.w600, color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 35,
                width: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green
                ),
                child: const Center(
                  child: Icon(Icons.check, size: 25, color: Colors.white,),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Container(
            height: 50,
            width: size.width * .3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width * .15,
                      decoration: BoxDecoration(
                        color: gender == Gender.male ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: gender == Gender.male ? Colors.red : Colors.transparent, width: 2)
                      ),
                      child: Opacity(
                          opacity: gender == Gender.male ? 1 : .4,
                          child: Image.asset('images/man.png',)
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        gender = Gender.female;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: size.width * .15,
                      decoration: BoxDecoration(
                          color: gender == Gender.female ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: gender == Gender.female ? Colors.red : Colors.transparent, width: 2)
                      ),
                      child: Opacity(
                        opacity: gender == Gender.female ? 1 : .4,
                          child: Image.asset('images/woman.png',)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: size.height * .53,
            width: size.width,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints)
              {
                return HeightPicker(
                  widgetHeight: constraints.maxHeight,
                  height: height,
                  gender: gender,
                  onChange: (val) {
                    setState(() {
                      height = val;
                    });
                  },
                );
              },),
          ),
          const SizedBox(height: 10,),
          Container(
            height: size.height * .2,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  height: size.height * .2,
                  width: size.width,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(20.0, 120.0, 0.0),
                    child: CustomPaint(
                      painter: CustomPaintClass(),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 0.0,
                  child: Container(
                    height: 130,
                    width: size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 200,
                        itemExtent: size.width / 7,
                        itemBuilder: (context, index) {
                          int item = 1 + index;
                          return Transform(
                              transform: matrix4(30.0, 30.0, 0.0),
                              child: Text(item.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                              )
                          );
                        }
                    ),
                  ),
                ),
                Positioned(
                  bottom: 56,
                    left: 203,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * .100,
                          width: 2,
                          color: Colors.black,
                        ),
                        Container(
                          height: 5,
                          width: 8,
                          color: Colors.black,
                        )
                      ],
                    )
                ),
                const Positioned(
                  bottom: 10.0,
                    left: 180,
                    child: Text('70 kg', style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),)
                )
              ]
            )


              // Container(
              //   height: size.height * .19,
              //   width: size.width * .328,
              //   color: Colors.white,
              //   child: WeightBackground(
              //     child: LayoutBuilder(
              //       builder: (context, constraints) {
              //         return constraints.isTight
              //             ? Container()
              //             : WeightSlider(
              //           minValue: 20,
              //           maxValue: 210,
              //           value: weight,
              //           onChanged: (val) {
              //             setState(() {
              //               weight = val;
              //             });
              //           },
              //           width: constraints.maxWidth,
              //         );
              //       },
              //     ),
              //   )
              //
               ),
          const SizedBox(height: 20,)
        ]
      ),
    );
  }

  Matrix4 matrix4( double x, double y, double z){
    return Matrix4.identity()..translate(x, y, z);
  }
}



// Column(
//   children: [
//     Container(
//       height: 80,
//       width: 300,
//       color: Colors.grey,
//       child: Transform(
//         transform: Matrix4.identity()
//           ..translate(-100.0, 30.0, 10.0),
//         child: Transform.rotate(
//           angle: -1,
//           child: const Center(child: Text('50')),
//         ),
//       ),
//     ),
//     Transform(
//       transform: Matrix4.identity()
//         ..translate(60.0, -30.0, 10.0),
//       child: Transform.rotate(
//         angle: 1,
//         child: const Center(child: Text('50')),
//       ),
//     )
//   ],
// ),

