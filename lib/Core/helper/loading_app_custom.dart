import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:public_app/Core/unit/color_data.dart';

class LoadingAppCustom extends StatelessWidget {
  const LoadingAppCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 65,
        width: 65,
        child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [ColorData.primaryColor1000.withOpacity(0.2),ColorData.primaryColor500.withOpacity(0.5),ColorData.primaryColor25],
            strokeWidth: 10,
            pathBackgroundColor: ColorData.whiteColor200,
        ),
      ),
    );
  }
}
