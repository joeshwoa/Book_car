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

class BookingExitDialogCustom extends StatelessWidget {

  const BookingExitDialogCustom({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      content: SizedBox(
        width: Unit(context).getWidthSize*0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s16),
              child: CircleAvatar(
                backgroundColor: ColorData.customColor1,
                radius: Unit(context).width(SizeData.s44),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.bookTaxiMegaphoneIcon,
                    width: Unit(context).iconSize(SizeData.s64),
                    height: Unit(context).iconSize(SizeData.s64),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kAreYouSureYouWantToExitQ.tr(),
                style: StyleData.textStyleGray500M14,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kSaveAndCompleteLater.tr(),
                style: StyleData.textStyleGray400R12,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
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
                    context.pop();
                  },
                  text: LocaleKeys.kSave.tr(),
                  textStyle: StyleData.textStylePrimary50M16,
                  color: ColorData.primaryColor500,
                ),
              ),
            ),
            Expanded(
              child: MainButtonCustom(
                onTap: () {
                  context.pop();
                },
                text: LocaleKeys.kNo.tr(),
                textStyle: StyleData.textStylePrimary500M14,
                color: ColorData.primaryColor50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}