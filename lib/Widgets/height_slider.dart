import 'package:flutter/material.dart';
import 'height_styles.dart';

class HeightSlider extends StatelessWidget {
  final int height;

  const HeightSlider({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Row(
            children: <Widget>[
              const Expanded(child: SliderLine()),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: 40,
                    color: Colors.black,
                  ),
                  Container(
                    height: 20,
                    width: 5,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5,)
                ],
              )
            ],
          ),
          // const SizedBox(height: 5,),
          SliderLabel(height: height),
        ],
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  const SliderLabel({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(4.0, context),
        bottom: screenAwareSize(2.0, context),
      ),
      child: Text(
        "$height" ' cm' ,
        style: const TextStyle(
          fontSize: selectedLabelFontSize,
          color: Colors.green,
          fontWeight: FontWeight.bold,

        ),
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  const SliderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          40,
              (i) => Expanded(
            child: Container(
              height: 2.0,
              decoration: BoxDecoration(
                  color: i.isEven
                      ? Colors.yellow
                      : Colors.white),
            ),
          )),
    );
  }
}
