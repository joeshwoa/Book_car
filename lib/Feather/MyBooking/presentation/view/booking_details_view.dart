import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/bottom_sheets/invoice_for_finished_bookings_bottom_sheet_custom.dart';
import 'package:public_app/generated/assets.dart';

class BookingDetailsView extends StatelessWidget {

  final BookingModel model;
  BookingDetailsView({super.key, required this.model,});

  late final MyBookingCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();
    }
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(
            title: LocaleKeys.kTaxiBookingSummary.tr(),
            iconOneType: IconOneType.back,
            iconTwoType: IconTwoType.empty,
          ),
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
                              color: ColorData.whiteColor200,
                              borderRadius:
                              BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1),
                          padding: EdgeInsets.all(SizeData.s16),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      model.vehicleType == TaxiType.sedan
                                          ? Assets.bookTaxiSedan
                                          : Assets.bookTaxiVan,
                                      width: Unit(context)
                                          .width(SizeData.s73),
                                      fit: BoxFit.scaleDown,
                                    ),
                                    SizedBox(
                                      width: Unit(context)
                                          .width(SizeData.s8),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.vehicleType == TaxiType.sedan
                                              ? LocaleKeys.kSedan.tr()
                                              : LocaleKeys.kVan.tr(),
                                          style: StyleData
                                              .textStyleGray700M14,
                                        ),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          maxRating: 5,
                                          updateOnDrag: false,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          unratedColor:
                                          ColorData.grayColor200,
                                          itemSize: Unit(context)
                                              .iconSize(SizeData.s12),
                                          itemPadding:
                                          EdgeInsets.symmetric(
                                              horizontal:
                                              SizeData.s1),
                                          itemBuilder: (context, _) =>
                                              Icon(
                                                Icons.star_rounded,
                                                color: ColorData
                                                    .warningColor250,
                                                size: Unit(context)
                                                    .iconSize(SizeData.s12),
                                              ),
                                          onRatingUpdate: (rate) {},
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.kTotalTaxiPrice.tr(),
                                      style:
                                      StyleData.textStyleGray500R14,
                                    ),
                                    Text(
                                      '€${model.price}',
                                      style: StyleData
                                          .textStylePrimary500B16,
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
                              borderRadius:
                              BorderRadius.circular(SizeData.s16),
                              boxShadow: ShadowData.boxShadow1,
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: ColorData.primaryColor300,
                                      width: Unit(context)
                                          .width(SizeData.s2)))),
                          padding: EdgeInsets.all(SizeData.s16),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.all(SizeData.s4),
                                    child: Text(
                                      LocaleKeys.kBookingDetails.tr(),
                                      style: StyleData
                                          .textStyleGray600M12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              LocaleKeys.kPickUp.tr(),
                                              style: StyleData
                                                  .textStyleGray600R12,
                                            ),
                                            Text(
                                              model.departureLocation!,
                                              style: StyleData
                                                  .textStyleGray400R12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              LocaleKeys.kDropOff.tr(),
                                              style: StyleData
                                                  .textStyleGray600R12,
                                            ),
                                            Text(
                                              model.arrivalLocation!,
                                              style: StyleData
                                                  .textStyleGray400R12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              LocaleKeys.kDate.tr(),
                                              style: StyleData
                                                  .textStyleGray600R12,
                                            ),
                                            Text(
                                              DateFormat(
                                                  'd MMM, yyyy')
                                                  .format(model.departureDateTime!),
                                              style: StyleData
                                                  .textStyleGray400R12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              LocaleKeys.kTime.tr(),
                                              style: StyleData
                                                  .textStyleGray600R12,
                                            ),
                                            Text(
                                              DateFormat('HH:mm').format(
                                                  model.departureDateTime!),
                                              style: StyleData
                                                  .textStyleGray400R12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: ColorData
                                                  .primaryColor50,
                                              width: Unit(context)
                                                  .width(
                                                  SizeData.s1)))),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.all(SizeData.s4),
                                        child: Text(
                                          LocaleKeys.kInfoDetails.tr(),
                                          style: StyleData
                                              .textStyleGray600M12,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  LocaleKeys.kPassengers
                                                      .tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  (model.numberOfPassengers)
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  LocaleKeys
                                                      .kSpecialLuggages
                                                      .tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                if((model.surfboard??0) +
                                                    (model
                                                        .ski??0) +
                                                    (model.golf??0) +
                                                    (model.bicycle??0) > 0)Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      if((model.surfboard??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiSurfboardIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.surfboard??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.surfboard)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if((model.ski??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiSkiBoardIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.ski??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.ski)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if((model.golf??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiGolfIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.golf??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.golf)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if((model.bicycle??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiBicycleIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.bicycle??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.bicycle)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if((model.surfboard??0) +
                                                    (model
                                                        .ski??0) +
                                                    (model.golf??0) +
                                                    (model.bicycle??0) == 0)Text(
                                                  ((model.surfboard??0) +
                                                      (model
                                                          .ski??0) +
                                                      (model.golf??0) +
                                                      (model.bicycle??0))
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  (model.numberOfSpecialLuggages)
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  LocaleKeys.kLuggages
                                                      .tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                Text(
                                                  (model.numberOfLuggages)
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  LocaleKeys.kPets.tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                if((model.dogs??0) +
                                                    (model.cats??0) > 0)Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      if((model.dogs??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiDogsIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.dogs??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.dogs)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if((model.cats??0) > 0) SvgPicture.asset(
                                                        Assets.bookTaxiCatsIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if((model.cats??0) > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (model.cats)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if((model.dogs??0) +
                                                    (model.cats??0) == 0)Text(
                                                  ((model.dogs??0) +
                                                      (model.cats??0))
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.all(SizeData.s4),
                                    child: Text(
                                      'Payment Method',
                                      style: StyleData
                                          .textStyleGray600M12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        model.payment == Payment.cash
                                            ? Assets.bookTaxiCashIcon
                                            : Assets.bookTaxiCardIcon,
                                        width: Unit(context)
                                            .iconSize(SizeData.s24),
                                        height: Unit(context)
                                            .iconSize(SizeData.s24),
                                        fit: BoxFit.scaleDown,
                                      ),
                                      SizedBox(
                                        width: Unit(context)
                                            .width(SizeData.s8),
                                      ),
                                      Text(
                                        model.payment == Payment.cash
                                            ? LocaleKeys.kCash.tr()
                                            : model.payment ==
                                            Payment.cardOnBoard
                                            ? LocaleKeys
                                            .kCreditCardOnBoard
                                            : LocaleKeys
                                            .kCreditCardOnline,
                                        style: StyleData
                                            .textStyleGray400R12,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Price',
                                style: StyleData.textStyleCustom13R12,
                              ),
                              Text(
                                '€${model.price}',
                                style: StyleData.textStyleCustom13R12,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Discount',
                                style: StyleData.textStyleCustom13R12,
                              ),
                              Text(
                                '€0',
                                style: StyleData.textStyleCustom13R12,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: ColorData.customColor14,
                          height: SizeData.s10,
                          thickness: SizeData.s1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: StyleData.textStyleCustom13M14,
                              ),
                              Text(
                                '€${model.price}',
                                style: StyleData.textStyleCustom13M14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(model.status != Status.waitingConfirmation)Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      context.push(AppRouter.kTicketView, extra: {
                        'id': model.id,
                      });
                    },
                    text: LocaleKeys.kShowTicket.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
                  ),
                ),
                if(model.status != Status.waitingConfirmation)Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s16),
                  child: MainButtonCustom(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => InvoiceForFinishedBookingsBottomSheetCustom(id: model.id!, cardOnlinePayment: model.payment == Payment.cardOnLine),
                      );
                    },
                    text: 'Invoice',
                    border: Border.all(
                        color: ColorData.primaryColor1000,
                        width: Unit(context).width(SizeData.s1)),
                    textStyle: StyleData.textStylePrimary1000M16,
                    loading: !cubit.invoiceSanded,
                    loadingColor: ColorData.primaryColor50,
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
