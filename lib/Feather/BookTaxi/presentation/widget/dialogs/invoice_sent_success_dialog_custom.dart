import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/generated/assets.dart';

class InvoiceSentSuccessDialogCustom extends StatelessWidget {

  final bool cardOnlinePayment;
  const InvoiceSentSuccessDialogCustom({super.key, required this.cardOnlinePayment});


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
            Lottie.asset(
              Assets.lottieForgetMailSentDone,
              width: SizeData.s150,
              height: SizeData.s150,
              alignment: Alignment.center,
            ),
            if(!cardOnlinePayment)Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kYourInvoiceWillBeSentOnceTheTransferHasBeenCompleted.tr(),
                style: StyleData.textStyleGray500M14,
                textAlign: TextAlign.center,
              ),
            ),
            if(cardOnlinePayment)Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kYourInvoiceHasBeenSentSuccessfully.tr(),
                style: StyleData.textStyleGray500M14,
                textAlign: TextAlign.center,
              ),
            ),
            if(cardOnlinePayment)Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                LocaleKeys.kPleaseCheckYourEmail.tr(),
                style: StyleData.textStyleGray500R12,
                textAlign: TextAlign.center,
              ),
            ),
            if(cardOnlinePayment)Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Text(
                SharedPreferencesServices.getData(key: ConstantData.kEmail)??'${LocaleKeys.kExample.tr()}@mail.com',
                style: StyleData.textStyleBlue400R16,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
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