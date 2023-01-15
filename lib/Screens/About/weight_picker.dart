import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_diet_app_onboarding/Screens/About/weight_slider.dart';
import 'widget_utils.dart';

class WeightCard extends StatelessWidget {
  final int weight;
  final ValueChanged<int> onChanged;

  const WeightCard({Key? key, this.weight = 70, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: screenAwareWidthSize(16.0, context),
        right: screenAwareWidthSize(4.0, context),
        top: screenAwareWidthSize(4.0, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenAwareWidthSize(16.0, context)),
                child: _drawSlider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
            minValue: 20,
            maxValue: 210,
            value: weight,
            onChanged: (val) => onChanged(val),
            width: constraints.maxWidth,
          );
        },
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareWidthSize(100.0, context),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
            BorderRadius.circular(screenAwareWidthSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          height: screenAwareWidthSize(10.0, context),
          width: screenAwareWidthSize(18.0, context),
        ),
      ],
    );
  }
}
