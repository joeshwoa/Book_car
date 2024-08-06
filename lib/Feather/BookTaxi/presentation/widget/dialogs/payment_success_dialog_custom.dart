import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class PaymentSuccessDialogCustom extends StatelessWidget {

  final bool cardOnlinePayment;
  const PaymentSuccessDialogCustom({super.key, required this.cardOnlinePayment});


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
            Assets.bookTaxiSuper,
            width: Unit(context).iconSize(SizeData.s150),
            height: Unit(context).iconSize(SizeData.s150),
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
          ),
          if(cardOnlinePayment)Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kPaymentSuccessfulYourReservationHasBeenConfirmed.tr(),
              style: StyleData.textStyleGray600M14,
              textAlign: TextAlign.center,
            ),
          ),
          if(!cardOnlinePayment)Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kYourReservationHasBeenConfirmed.tr(),
              style: StyleData.textStyleGray600M14,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: EasyRichText(
              '${LocaleKeys.kYouWillReceiveAConfirmationMailAt.tr()} ${SharedPreferencesServices.getData(key: ConstantData.kEmail)}',
              textAlign: TextAlign.center,
              defaultStyle: StyleData.textStyleGray500R12,
              patternList: [
                EasyRichTextPattern(
                  targetString: '${SharedPreferencesServices.getData(key: ConstantData.kEmail)}',
                  style: StyleData.textStyleBlue400R12,
                ),
              ],

            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
            child: Text(
              LocaleKeys.kWeWillNotifyYouOnceTheDriverHasReachedYourPickupPoint.tr(),
              style: StyleData.textStyleGray500R12,
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
                    context.pop();
                    context.push(AppRouter.kTicketView);
                  },
                  text: LocaleKeys.kShowTicket.tr(),
                  textStyle: StyleData.textStylePrimary50M16,
                  color: ColorData.primaryColor1000,
                ),
              ),
            ),
            Expanded(
              child: MainButtonCustom(
                onTap: () {
                  context.go(AppRouter.kLayoutView, extra: true);
                },
                text: LocaleKeys.kHomePage.tr(),
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