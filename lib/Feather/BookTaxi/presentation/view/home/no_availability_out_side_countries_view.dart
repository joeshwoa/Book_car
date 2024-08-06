import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/generated/assets.dart';

class NoAvailabilityOutSideCountriesView extends StatelessWidget {

  NoAvailabilityOutSideCountriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kFindDriver.tr(), iconOneType: IconOneType.back, iconTwoType: IconTwoType.call,),
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
                        Container(
                          margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SizeData.s6),
                            border: Border(
                                left: BorderSide(
                                    width: Unit(context).width(SizeData.s6),
                                    color: ColorData.warningColor200
                                )
                            ),
                          ),
                          padding: EdgeInsets.all(SizeData.s8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.kSorry.tr(),
                                    style: StyleData.textStyleWarning800M16,
                                  ),
                                  Text(
                                    LocaleKeys.kNoCarAvailableNowTryLater.tr(),
                                    style: StyleData.textStyleWarning700R12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Unit(context).iconSize(SizeData.s150),
                          height: Unit(context).iconSize(SizeData.s150),
                          child: LottieBuilder.asset(
                            Assets.lottieSad,
                            alignment: Alignment.center,
                            width: Unit(context).iconSize(SizeData.s150),
                            height: Unit(context).iconSize(SizeData.s150),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                          child: Text(
                            LocaleKeys.kUnfortunatelyWeDoNotHaveAnAvailableCarNowPleaseTryAgainLater.tr(),
                            textAlign: TextAlign.center,
                            style: StyleData.textStyleGray600R12,
                          ),
                        ),
                        /*ExpansionTileCustom(
                            title: Text(
                              LocaleKeys.kTripDetails.tr(),
                              textAlign: TextAlign.center,
                              style: StyleData.textStyleGray500R14,
                            ),
                            trailing: SvgPicture.asset(
                              Assets.userArrowRightIcon,
                              height: Unit(context).iconSize(SizeData.s22),
                              width: Unit(context).iconSize(SizeData.s22),
                              fit: BoxFit.scaleDown,
                              color: ColorData.grayColor600,
                            ),
                            trailingAngels: TrailingAngels.upAndDown,
                            initiallyExpanded: false,
                            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: SizeData.s4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                          child: Text(
                                            LocaleKeys.kTripRoute.tr(),
                                            textAlign: TextAlign.center,
                                            style: StyleData.textStyleGray600M12,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.kPickUp.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500R12,
                                                  ),
                                                  Text(
                                                    cubit.bookingDetails!.departureLocation!,
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500M12,
                                                  ),
                                                  Text(
                                                    LocaleKeys.kDate.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500R12,
                                                  ),
                                                  Text(
                                                    DateFormat('d MMM').format(cubit.bookingDetails!.departureDateTime!),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500M12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys.kDropOff.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500R12,
                                                  ),
                                                  Text(
                                                    cubit.bookingDetails!.arrivalLocation!,
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500M12,
                                                  ),
                                                  Text(
                                                    LocaleKeys.kPickUpTime.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500R12,
                                                  ),
                                                  Text(
                                                    MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay(hour: cubit.bookingDetails!.departureDateTime!.hour, minute: cubit.bookingDetails!.departureDateTime!.minute), alwaysUse24HourFormat: false),
                                                    textAlign: TextAlign.center,
                                                    style: StyleData.textStyleGray500M12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeData.s8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                            child: Text(
                                              LocaleKeys.kAdditionalDetails.tr(),
                                              textAlign: TextAlign.center,
                                              style: StyleData.textStyleGray600M12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      LocaleKeys.kPassengers.tr(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500R12,
                                                    ),
                                                    Text(
                                                      cubit.bookingDetails!.numberOfPassengers!.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500M12,
                                                    ),
                                                    Text(
                                                      LocaleKeys.kSpecialLuggage.tr(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500R12,
                                                    ),
                                                    Text(
                                                      '${cubit.bookingDetails!.ski! > 0 ? '${cubit.bookingDetails!.ski} Ski ' : ''}${cubit.bookingDetails!.golf! > 0 ? '${cubit.bookingDetails!.golf} Golf ' : ''}${cubit.bookingDetails!.bicycle! > 0 ? '${cubit.bookingDetails!.bicycle} Bicycle ' : ''}${cubit.bookingDetails!.surfboard! > 0 ? '${cubit.bookingDetails!.surfboard} Surfboard' : ''}',
                                                      textAlign: TextAlign.start,
                                                      style: StyleData.textStyleGray500M12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      LocaleKeys.kLuggages.tr(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500R12,
                                                    ),
                                                    Text(
                                                      cubit.bookingDetails!.numberOfLuggages!.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500M12,
                                                    ),
                                                    Text(
                                                      LocaleKeys.kPets.tr(),
                                                      textAlign: TextAlign.center,
                                                      style: StyleData.textStyleGray500R12,
                                                    ),
                                                    Text(
                                                      '${cubit.bookingDetails!.cats! > 0 ? '${cubit.bookingDetails!.cats} Cats ' : ''}${cubit.bookingDetails!.dogs! > 0 ? '${cubit.bookingDetails!.dogs} Dogs ' : ''}',
                                                      textAlign: TextAlign.start,
                                                      style: StyleData.textStyleGray500M12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),*/
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: MainButtonCustom(
                    onTap: () {
                      context.pop();
                    },
                    text: LocaleKeys.kBack.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
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
