import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/bottom_sheets/enter_card_details_bottom_sheet_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/bottom_sheets/invoice_bottom_sheet_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/invoice_sent_success_dialog_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/payment_failed_dialog_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/payment_success_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class BookingSummaryView extends StatelessWidget {
  BookingSummaryView({super.key});

  late final BookTaxiCubit cubit;

  bool first = true;

  TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
    }
    return BlocListener<BookTaxiCubit, BookTaxiState>(
  listener: (context, state) async {
    if (state is SuccessBookTaxiState) {
      cubit.updateStateLessPageVar(change: (){
        cubit.bookingRequestSanded = true;
      });
      if(!cubit.isSchedule() && cubit.pricingMethod == 'fixed') {
        context.push(AppRouter.kRequestSandedView, extra: {
          'showCancelButton': false
        });
      } else if (cubit.isSchedule() && cubit.pricingMethod == 'fixed') {
        await showDialog(
        context: context,
        builder: (context) =>
            PaymentSuccessDialogCustom(cardOnlinePayment: cubit.payment == 'card_online',));
        if(cubit.invoice) {
          await showDialog(
              context: context,
              builder: (context) =>
                  InvoiceSentSuccessDialogCustom(cardOnlinePayment: cubit.payment == 'card_online',));
        }
        if(context.mounted) {
          context.go(AppRouter.kLayoutView, extra: true);
        }
        cubit.reset();
      }
    }
    if (state is FiledPaymentBookTaxiState) {
      cubit.updateStateLessPageVar(change: (){
        cubit.bookingRequestSanded = true;
      });
      await showDialog(
          context: context,
          builder: (context) =>
              PaymentFailedDialogCustom());
    }
    if (state is AlreadyExistsBookErrorState && cubit.pricingMethod == 'fixed') {
      context.push(AppRouter.kRequestAlreadyExistView, extra: {
        'id': state.id
      });
    }
  },
  child: BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
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
                                      cubit.vehicleType == 'sedan'
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
                                          cubit.vehicleType == 'sedan'
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
                                      '€${cubit.roundTrip ? cubit.price+cubit.priceRoundTrip : cubit.price}',
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
                                              cubit.pickUpAddress,
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
                                              cubit.dropOffAddress,
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
                                                  .format(cubit.date),
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
                                                  cubit.date.copyWith(
                                                      hour: cubit
                                                          .time.hour,
                                                      minute: cubit
                                                          .time
                                                          .minute)),
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
                                                  (cubit.adult +
                                                          cubit.child +
                                                          cubit.infant)
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
                                                if(cubit.surfboard +
                                                    cubit
                                                        .skiBoard +
                                                    cubit.golf +
                                                    cubit.bicycle > 0)Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      if(cubit.surfboard > 0) SvgPicture.asset(
                                                        Assets.bookTaxiSurfboardIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.surfboard > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.surfboard)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if(cubit.skiBoard > 0) SvgPicture.asset(
                                                        Assets.bookTaxiSkiBoardIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.skiBoard > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.skiBoard)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if(cubit.golf > 0) SvgPicture.asset(
                                                        Assets.bookTaxiGolfIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.golf > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.golf)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if(cubit.bicycle > 0) SvgPicture.asset(
                                                        Assets.bookTaxiBicycleIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.bicycle > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.bicycle)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if(cubit.surfboard +
                                                    cubit
                                                        .skiBoard +
                                                    cubit.golf +
                                                    cubit.bicycle == 0)Text(
                                                  (cubit.surfboard +
                                                      cubit
                                                          .skiBoard +
                                                      cubit.golf +
                                                      cubit.bicycle)
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
                                                  (cubit.big +
                                                          cubit.medium +
                                                          cubit.small)
                                                      .toString(),
                                                  style: StyleData
                                                      .textStyleGray400R12,
                                                ),
                                                Text(
                                                  LocaleKeys.kPets.tr(),
                                                  style: StyleData
                                                      .textStyleGray600R12,
                                                ),
                                                if(cubit.dogs +
                                                    cubit.cats > 0)Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      if(cubit.dogs > 0) SvgPicture.asset(
                                                        Assets.bookTaxiDogsIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.dogs > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.dogs)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                      if(cubit.cats > 0) SvgPicture.asset(
                                                        Assets.bookTaxiCatsIcon,
                                                        width: Unit(context).iconSize(SizeData.s18),
                                                        height: Unit(context).iconSize(SizeData.s18),
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      if(cubit.cats > 0) Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                                                        child: Text(
                                                          (cubit.cats)
                                                              .toString(),
                                                          style: StyleData
                                                              .textStyleGray400R12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if(cubit.dogs +
                                                    cubit.cats == 0)Text(
                                                  (cubit.dogs +
                                                          cubit.cats)
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
                                      LocaleKeys.kPaymentMethod.tr(),
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
                                        cubit.payment == 'cash'
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
                                        cubit.payment == 'cash'
                                            ? LocaleKeys.kCash.tr()
                                            : cubit.payment ==
                                                    'card_onboard'
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
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: cubit.invoice,
                                  onChanged: (value) {
                                    if (!cubit.lockInvoice) {
                                      if (value == true) {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) => InvoiceBottomSheetCustom(),
                                        );
                                      } else {
                                        cubit.changeInvoice(value: false);
                                      }
                                    }
                                  },
                                  activeColor: ColorData.blueColor400,
                                ),
                                Text(
                                  LocaleKeys.kDoYouNeedInvoice.tr(),
                                  style: StyleData.textStyleGray400R14,
                                )
                              ]),
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () async {
                      if (cubit.payment == 'card_online') {
                        bool? entered = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => EnterCardDetailsBottomSheetCustom(),
                        );
                        if (entered != null && entered) {
                          cubit.updateStateLessPageVar(change: (){
                            cubit.bookingRequestSanded = false;
                          });
                          if (cubit.idUncompletedBook.isNotEmpty) {
                            cubit.completeBook();
                          } else {
                            if(cubit.pricingMethod == 'fixed') {
                              cubit.bookTaxiWithFixedPrice();
                            } else {
                              cubit.bookTaxiWithFlexiblePrice();
                            }
                          }
                        }
                      } else {
                        cubit.updateStateLessPageVar(change: (){
                          cubit.bookingRequestSanded = false;
                        });
                        if (cubit.idUncompletedBook.isNotEmpty) {
                          cubit.completeBook();
                        } else {
                          if(cubit.pricingMethod == 'fixed') {
                            cubit.bookTaxiWithFixedPrice();
                          } else {
                            cubit.bookTaxiWithFlexiblePrice();
                          }
                        }
                      }
                    },
                    text: cubit.isSchedule() && cubit.pricingMethod != 'flexible'? (cubit.payment == 'card_online' ? LocaleKeys.kPayment.tr() : LocaleKeys.kBook.tr()) : LocaleKeys.kSendRequest.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
                    loading: !cubit.bookingRequestSanded,
                    loadingColor: ColorData.primaryColor50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      cubit.saveUnCompleteBook();
                      context.go(AppRouter.kLayoutView, extra: true);
                      cubit.reset();
                    },
                    text: LocaleKeys.kSaveAndCompleteLater.tr(),
                    border: Border.all(
                        color: ColorData.primaryColor500,
                        width: Unit(context).width(SizeData.s1)),
                    textStyle: StyleData.textStylePrimary500M14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeData.s16),
                  child: MainButtonCustom(
                    onTap: () {
                      context.push(AppRouter.kRequestCancelledView, extra: {
                        'id': ''
                      });
                    },
                    text: LocaleKeys.kCancel.tr(),
                    border: Border.all(
                        color: ColorData.dangerColor500,
                        width: Unit(context).width(SizeData.s1)),
                    textStyle: StyleData.textStyleDanger500M14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  },
),
);
  }
}
