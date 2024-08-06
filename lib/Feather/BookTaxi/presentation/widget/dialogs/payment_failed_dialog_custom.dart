import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class PaymentFailedDialogCustom extends StatelessWidget {
  const PaymentFailedDialogCustom({super.key,});


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
          SvgPicture.asset(
            Assets.lottiePaymentFailedDialog,
            width: Unit(context).iconSize(SizeData.s150),
            height: Unit(context).iconSize(SizeData.s150),
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kPaymentFailed.tr(),
              style: StyleData.textStyleGray500M14,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kYourPaymentIsFailedPleaseTryAgain.tr(),
              style: StyleData.textStyleGray600R12,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: SizeData.s8),
                child: MainButtonCustom(
                  onTap: () {
                    context.go(AppRouter.kLayoutView, extra: true);
                  },
                  text: LocaleKeys.kHome.tr(),
                  textStyle: StyleData.textStylePrimary500M14,
                  color: ColorData.primaryColor50,
                ),
              ),
            ),
            Expanded(
              child: MainButtonCustom(
                onTap: () {
                  context.pop();
                },
                text: LocaleKeys.kTryAgain.tr(),
                textStyle: StyleData.textStylePrimary50M16,
                color: ColorData.primaryColor1000,
              ),
            ),
          ],
        ),
      ],
    );
  }
}