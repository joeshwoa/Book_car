import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class CarArrivedSuccessfullyDialogCustom extends StatelessWidget {
  const CarArrivedSuccessfullyDialogCustom({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: SvgPicture.asset(
              Assets.bookTaxiCarArrivedSuccessfullyImage,
              width: Unit(context).iconSize(SizeData.s80),
              height: Unit(context).iconSize(SizeData.s80),
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s16),
            child: Text(
              LocaleKeys.kYourCarIsArrivedSuccessfully.tr(),
              style: StyleData.textStyleGray500M14,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kWeHopeYouHaveAPleasantTripAndAppreciateYourTrustInOurServices.tr(),
              style: StyleData.textStyleGray500R12,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        MainButtonCustom(
          onTap: () {
            context.pop();
          },
          text: LocaleKeys.kClose.tr(),
          textStyle: StyleData.textStylePrimary500M14,
          color: ColorData.primaryColor50,
        ),
      ],
    );
  }
}