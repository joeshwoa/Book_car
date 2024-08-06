import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/generated/assets.dart';

class OfferView extends StatelessWidget {

  final String id;
  OfferView({super.key, this.id = ''});

  TextEditingController promoCodeController = TextEditingController();

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
    if (state is SuccessOfferAcceptState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.offerRejectSanded = true;
      });
    }
    if (state is SuccessOfferRejectState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.offerAcceptSanded = true;
      });
    }
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kOffer.tr(), iconOneType: IconOneType.back, iconTwoType: IconTwoType.empty,),
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
                        Container(
                          margin: EdgeInsets.symmetric(vertical: SizeData.s16),
                          decoration: BoxDecoration(
                              color: ColorData.whiteColor200,
                              borderRadius: BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1
                          ),
                          padding: EdgeInsets.all(SizeData.s8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: SvgPicture.asset(
                                  Assets.bookTaxiOfferImage,
                                  width: Unit(context).width(SizeData.s250),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                  child: Text(
                                    LocaleKeys.kTripOffer.tr(),
                                    style: StyleData.textStyleGray500SB16,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  LocaleKeys.kWaitingForYourApproval.tr(),
                                  style: StyleData.textStyleGray500R12,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                                decoration: BoxDecoration(
                                  color: ColorData.primaryColor25,
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
                                      style: StyleData.textStyleGray400R12,
                                    ),
                                    Text(
                                      '€${cubit.offer!.price}',
                                      style: StyleData.textStylePrimary500SB16,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: EasyRichText(
                                  '${LocaleKeys.kTaxi.tr()}: ${cubit.bookingDetails!.vehicleType! == TaxiType.van ? LocaleKeys.kVan.tr() : LocaleKeys.kSedan.tr()}',
                                  textAlign: TextAlign.center,
                                  defaultStyle: StyleData.textStyleGray700M14,
                                  patternList: [
                                    EasyRichTextPattern(
                                      targetString: '${LocaleKeys.kTaxi.tr()}:',
                                      style: StyleData.textStyleGray500R14,
                                    ),
                                  ],

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 0/*cubit.offer!.rating!*/,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      maxRating: 5,
                                      updateOnDrag: false,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemSize: Unit(context).iconSize(SizeData.s16),
                                      unratedColor: ColorData.grayColor200,
                                      itemPadding: EdgeInsets.symmetric(horizontal: SizeData.s1),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star_rounded,
                                        color: ColorData.warningColor250,
                                        size: Unit(context).iconSize(SizeData.s16),
                                      ),
                                      onRatingUpdate: (rate) {},
                                    ),
                                    SizedBox(
                                      width: Unit(context).iconSize(SizeData.s4),
                                    ),
                                    Text(
                                      'cubit.offer!.reviews ${LocaleKeys.kReview.tr()}',
                                      style: StyleData.textStyleGray500R12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: SizeData.s8),
                          decoration: BoxDecoration(
                              color: ColorData.whiteColor200,
                              borderRadius: BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1
                          ),
                          padding: EdgeInsets.all(SizeData.s16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.kTripDetails.tr(),
                                textAlign: TextAlign.center,
                                style: StyleData.textStyleGray600R14,
                              ),
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
                                                      '${cubit.bookingDetails!.ski! > 0 ? '${cubit.bookingDetails!.ski} ${LocaleKeys.kSki.tr()} ' : ''}${cubit.bookingDetails!.golf! > 0 ? '${cubit.bookingDetails!.golf} ${LocaleKeys.kGolf.tr()} ' : ''}${cubit.bookingDetails!.bicycle! > 0 ? '${cubit.bookingDetails!.bicycle} ${LocaleKeys.kBicycle.tr()} ' : ''}${cubit.bookingDetails!.surfboard! > 0 ? '${cubit.bookingDetails!.surfboard} ${LocaleKeys.kSurfboard.tr()}Surfboard' : ''}',
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
                            ],
                          ),
                        ),
                        ExpansionTileCustom(
                            title: EasyRichText(
                              LocaleKeys.kPromotionalCodeOptional.tr(),
                              textAlign: TextAlign.center,
                              defaultStyle: StyleData.textStyleGray600R14,
                              patternList: [
                                EasyRichTextPattern(
                                  targetString: '[(]${LocaleKeys.kOptional.tr()}[)]',
                                  style: StyleData.textStyleGray300R14,
                                ),
                              ],
                            ),
                            trailing: SvgPicture.asset(
                              Assets.userArrowRightIcon,
                              height: Unit(context).iconSize(SizeData.s22),
                              width: Unit(context).iconSize(SizeData.s22),
                              fit: BoxFit.scaleDown,
                              color: ColorData.grayColor600,
                            ),
                            trailingAngels: TrailingAngels.rightAndDown,
                            initiallyExpanded: false,
                            padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center, // Ensures children stretch to the full height
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: SizeData.s8),
                                      child: SizedBox(
                                        height: SizeData.s44,
                                        child: TextFormField(
                                          controller: promoCodeController,
                                          decoration: InputDecoration(
                                            border: BorderData.outlineInputBorderGray200W1R8,
                                            enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                                            focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                                            errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                            focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                            hintText: LocaleKeys.kEnterPromoCode.tr(),
                                            hintStyle: StyleData.textStyleGray300R12,
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(right: SizeData.s4, top: SizeData.s4, bottom: SizeData.s4, left: SizeData.s8),
                                              child: SvgPicture.asset(
                                                Assets.bookTaxiDiscountCircleIcon,
                                                width: Unit(context).iconSize(SizeData.s24),
                                                height: Unit(context).iconSize(SizeData.s24),
                                                color: ColorData.primaryColor500,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                            prefixIconConstraints: BoxConstraints(
                                              maxWidth: Unit(context).iconSize(SizeData.s32),
                                              maxHeight: Unit(context).iconSize(SizeData.s32),
                                            ),
                                          ),
                                          autofocus: false,
                                          autofillHints: const [],
                                          textInputAction: TextInputAction.done,
                                          obscureText: false,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MainButtonCustom(
                                      onTap: () {
                                        // TODO: apply promo code
                                      },
                                      text: LocaleKeys.kApply.tr(),
                                      height: SizeData.s44,
                                      textStyle: StyleData.textStyleCustom9R12,
                                      color: promoCodeController.text.isNotEmpty ? ColorData.primaryColor600 : ColorData.grayColor200,
                                    ),
                                  ),
                                ],
                              )
                            ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.kFreeCallAndNoEngagement.tr(),
                                style: StyleData.textStyleGray500R12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: SizeData.s8),
                                    width: Unit(context).iconSize(SizeData.s32),
                                    height: Unit(context).iconSize(SizeData.s32),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorData.primaryColor500,
                                        width: Unit(context).width(SizeData.s1),
                                      )
                                    ),
                                    padding: EdgeInsets.all(SizeData.s4),
                                    child: SvgPicture.asset(
                                      Assets.userPhoneIcon,
                                      width: Unit(context).iconSize(SizeData.s9),
                                      height: Unit(context).iconSize(SizeData.s9),
                                      color: ColorData.primaryColor500,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    Assets.userWhatsapp,
                                    width: Unit(context).iconSize(SizeData.s32),
                                    height: Unit(context).iconSize(SizeData.s32),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ]
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (cubit.offerLoaded)Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MainButtonCustom(
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.offerRejectSanded = false;
                            },);
                            cubit.rejectOffer(id: cubit.offer!.id!);
                          },
                          text: LocaleKeys.kReject.tr(),
                          textStyle: StyleData.textStyleDanger500R14,
                          loading: !cubit.offerRejectSanded,
                          loadingColor: ColorData.dangerColor500,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: MainButtonCustom(
                          onTap: () {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.offerAcceptSanded = false;
                            },);
                            cubit.acceptOffer(id: cubit.offer!.id!);
                          },
                          text: LocaleKeys.kAccept.tr(),
                          textStyle: StyleData.textStylePrimary50M16,
                          color: ColorData.primaryColor1000,
                          loading: !cubit.offerAcceptSanded,
                          loadingColor: ColorData.primaryColor50,
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
  },
);
  }
}
