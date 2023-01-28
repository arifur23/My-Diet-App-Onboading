import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diet_app_onboarding/Screens/custom_animation.dart';
import '../Widgets/custom_paint_class.dart';
import '../Widgets/height_picker.dart';
import 'dart:math' as math;

enum Gender{
  male,
  female
}

class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> with TickerProviderStateMixin {

  int height = 153;
  int weight = 70;
  double width = 430;
  int minValue = 20;
  int maxValue = 210;
  int value = 70;


  late Gender gender;

  late ScrollController scrollController;
  double get itemExtent => width / 7;

  int _indexToValue(int index) => minValue + (index - 1);

  late AnimationController animationController;


  @override
  void initState() {

    scrollController = ScrollController(
      initialScrollOffset: (weight - 3.7) * width / 7,
    );
    gender = Gender.male;

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );

    animationController.addListener(() {
      if(animationController.isCompleted){
        getBack().then((_){animationController.reset();});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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

                    setState(() {
                      animationController.forward();
                    });
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
                              child: NotificationListener(
                                onNotification: _onNotification,
                                child: ListView.builder(
                                    controller: scrollController,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 210,
                                    itemExtent: size.width / 7,
                                    itemBuilder: (context, index) {
                                      int item = 1 + index;
                                      return Transform(
                                          transform: decidePosition(index, item),
                                          child: Text(item.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                          )
                                      );
                                    }
                                ),
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
                          Positioned(
                              bottom: 10.0,
                              left: 180,
                              child: Text('$weight kg', style:
                              const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),)
                          )
                        ]
                    )
                ),
                const SizedBox(height: 20,)
              ]
          ),
        ),
        CustomAnimation(animationController: animationController)
      ],
    );
  }

  getBack() async{
    return Navigator.pop(context);
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 7) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        setState(() {
          weight = middleValue - 16;
        }); //update selection
      }
    }
    return true;
  }

  Matrix4 matrix4( double x, double y, double z){
    return Matrix4.identity()..translate(x, y, z);
  }

  Matrix4 decidePosition(int index, int value){

    if( weight == index + 2){
      return Matrix4.identity()..translate(30.0, 45.0, 10);
    }
    else if( weight == index + 3){
      return Matrix4.identity()..translate(30.0, 75.0, 20.0);
    }
    else if( weight == index + 4){
      return Matrix4.identity()..translate(30.0, 105.0, 30.0);
    }
    else if( weight == index + 5){
      return Matrix4.identity()..translate(30.0, 135.0, 40.0);
    }
    else if( weight == index){
      return Matrix4.identity()..translate(30.0, 45.0, 10.0);
    }
    else if( weight == index - 1){
      return Matrix4.identity()..translate(30.0, 75.0, 20.0);
    }
    else if( weight == index - 2){
      return Matrix4.identity()..translate(30.0, 105.0, 30.0);
    }
    else if( weight == index - 3){
      return Matrix4.identity()..translate(30.0, 135.0, 40.0);
    }
    else{
      return Matrix4.identity()..translate(30.0, 30.0, 0.0);
    }
  }
}
