
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class CurrentLocationButtonCustom extends StatelessWidget {
  final Function() fun;
  const CurrentLocationButtonCustom({Key? key,required this.fun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.userYourLocationIcon,
              width: Unit(context).getWidthSize*0.064,
              height: Unit(context).getWidthSize*0.064,
              color: ColorData.primaryColor500,
            ),
          ),
          SizedBox(width: SizeData.s10,),
          Expanded(
            child: Text(LocaleKeys.kYourLocation.tr(),
              style: StyleData.textStyle14.copyWith(
                  fontSize: Unit(context).getWidthSize*0.037,
                  color: ColorData.primaryColor500
              ),
            ),
          )
        ],
      ),
    );
  }
}
