import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class IntroTopBarCustom extends StatelessWidget {
  const IntroTopBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeData.s15, vertical: SizeData.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.kKiroTravel.tr(),
            style: StyleData.textStyleWhite200M14.copyWith(
              fontSize: Unit(context).getWidthSize*0.032
            ),
          ),
          SvgPicture.asset(
            Assets.userLogo,
            height: Unit(context).getWidthSize*0.112,
            width: Unit(context).getWidthSize*0.112,
          )
        ],
      ),
    );
  }
}
