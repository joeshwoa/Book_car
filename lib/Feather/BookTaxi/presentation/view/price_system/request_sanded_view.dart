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
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/generated/assets.dart';

class RequestSandedView extends StatelessWidget {

  final bool showCancelButton;
  const RequestSandedView({super.key, this.showCancelButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kRequest.tr(), iconOneType: IconOneType.back, iconTwoType: IconTwoType.call,),
          Container(
            margin: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            decoration: BoxDecoration(
              color: ColorData.whiteColor200,
              borderRadius: BorderRadius.circular(SizeData.s16),
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(SizeData.s16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Unit(context).iconSize(SizeData.s200),
                          height: Unit(context).iconSize(SizeData.s200),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              /*LottieBuilder.asset(
                                Assets.lottieSadLottie,
                                alignment: Alignment.center,
                                height: Unit(context).iconSize(SizeData.s200),
                                width: Unit(context).iconSize(SizeData.s200),
                                fit: BoxFit.scaleDown,
                              ),*/
                              SvgPicture.asset(
                                Assets.bookTaxiBlueCar,
                                width: Unit(context).iconSize(SizeData.s200),
                                height: Unit(context).iconSize(SizeData.s200),
                                alignment: Alignment.center,
                                fit: BoxFit.scaleDown,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Text(
                            LocaleKeys.kTaxiRequestSentSuccessfully.tr(),
                            textAlign: TextAlign.center,
                            style: StyleData.textStyleGray600SB16,
                          ),
                        ),
                        Text(
                          LocaleKeys.kWeHaveReceivedYourRequestSubjectToAvailabilityStayTunedForAnOfferArrivingInYourWhatsAppOrEmailThankYouForChoosingOurService.tr(),
                          textAlign: TextAlign.center,
                          style: StyleData.textStyleGray500R14,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(showCancelButton)Expanded(
                        flex: 1,
                        child: MainButtonCustom(
                          onTap: () {
                            context.push(AppRouter.kRequestCancelledView, extra: {
                              'id': BookTaxiCubit.get(context).bookingID,
                            });
                          },
                          text: LocaleKeys.kCancel.tr(),
                          textStyle: StyleData.textStyleDanger500R14,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: MainButtonCustom(
                          onTap: () {
                            BookTaxiCubit.get(context).reset();
                            context.go(AppRouter.kLayoutView, extra: true);
                          },
                          text: LocaleKeys.kHome.tr(),
                          textStyle: StyleData.textStylePrimary50M16,
                          color: ColorData.primaryColor1000,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
