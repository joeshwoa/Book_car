import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/generated/assets.dart';

class RequestConfirmationView extends StatelessWidget {

  final String id;
  RequestConfirmationView({super.key, this.id = ''});

  Duration arriveTime = const Duration(minutes: 10);

  late final BookTaxiCubit cubit;

  bool first = true;

  String formatDuration(DateTime dateTime) {
    Duration duration = DateTime.now().difference(dateTime);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    String hoursPart = hours > 0 ? '$hours hr' : '';
    String minutesPart = minutes > 0 ? '$minutes min' : '';

    if (hours > 0 && minutes > 0) {
      return '$hoursPart $minutesPart';
    } else if (hours > 0) {
      return hoursPart;
    } else {
      return minutesPart;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      cubit.updateStateLessPageVar(change: () {
        cubit.offerLoaded = false;
      });
      if(id.isNotEmpty) {
        cubit.getOfferDetailsByOfferID(id: id);
      }
    }
    return BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
    if (state is SuccessBookingDetailsState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.offerLoaded = true;
      });
    }
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
                if (!cubit.offerLoaded)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (cubit.offerLoaded)Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Unit(context).width(SizeData.s250),
                          child: LottieBuilder.asset(
                            Assets.lottieMovingCar,
                            alignment: Alignment.center,
                            width: Unit(context).width(SizeData.s250),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                          child: TimerCountdown(
                            format: CountDownTimerFormat.hoursMinutesSeconds,
                            endTime: DateTime.now().add(arriveTime,),
                            timeTextStyle: StyleData.textStylePrimary500SB20,
                            enableDescriptions: false,
                            onEnd: () {
                            },
                            onTick: (remainingTime) {
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Text(
                            LocaleKeys.kYourCarArriveIn.tr(),
                            textAlign: TextAlign.center,
                            style: StyleData.textStyleGray500M14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Text(
                            LocaleKeys.kWeAreWaitingForYourApproval.tr(),
                            textAlign: TextAlign.center,
                            style: StyleData.textStyleGray600R12,
                          ),
                        ),
                        ExpansionTileCustom(
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
                                                      '${cubit.bookingDetails!.ski! > 0 ? '${cubit.bookingDetails!.ski} ${LocaleKeys.kSki.tr()} ' : ''}${cubit.bookingDetails!.golf! > 0 ? '${cubit.bookingDetails!.golf} ${LocaleKeys.kGolf.tr()} ' : ''}${cubit.bookingDetails!.bicycle! > 0 ? '${cubit.bookingDetails!.bicycle} ${LocaleKeys.kBicycle.tr()} ' : ''}${cubit.bookingDetails!.surfboard! > 0 ? '${cubit.bookingDetails!.surfboard} ${LocaleKeys.kSurfboard.tr()}' : ''}',
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
                                                      '${cubit.bookingDetails!.cats! > 0 ? '${cubit.bookingDetails!.cats} ${LocaleKeys.kCats.tr()} ' : ''}${cubit.bookingDetails!.dogs! > 0 ? '${cubit.bookingDetails!.dogs} ${LocaleKeys.kDogs.tr()} ' : ''}',
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
                        ),
                      ],
                    ),
                  ),
                ),
                if (cubit.offerLoaded)Container(
                  margin: EdgeInsets.only(bottom: SizeData.s16),
                  height: Unit(context).height(SizeData.s64),
                  decoration: BoxDecoration(
                    color: ColorData.primaryColor50,
                    borderRadius: BorderRadius.circular(SizeData.s8),
                  ),
                  padding: EdgeInsets.all(SizeData.s8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.kTotalPrice.tr(),
                        style: StyleData.textStyleGray500M14,
                      ),
                      Text(
                        '€${cubit.offer!.price}',
                        style: StyleData.textStylePrimary500SB20,
                      ),
                    ],
                  ),
                ),
                if (cubit.offerLoaded)Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: MainButtonCustom(
                    onTap: () {
                      context.go(AppRouter.kLayoutView, extra: true);
                    },
                    text: LocaleKeys.kHome.tr(),
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
  },
);
  }
}
