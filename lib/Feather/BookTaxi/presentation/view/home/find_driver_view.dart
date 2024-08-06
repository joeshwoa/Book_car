import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/buttons/out_line_button_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/buttons/tab_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/switch_to_van_dialog_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/take_client_information_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class FindDriverView extends StatelessWidget {
  final bool firstTrip;
  FindDriverView({super.key, this.firstTrip = true});

  late final BookTaxiCubit cubit;

  bool first = true;

  TextEditingController flightPickUpNumberController = TextEditingController();
  TextEditingController flightDropOffNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  ScrollController scrollController = ScrollController();
  GlobalKey roundTripKey = GlobalKey();

  bool containsAirport(String input) {
    // Convert the input to lowercase to make the search case-insensitive
    String lowerInput = input.toLowerCase();

    // Check for "airport" in English and French
    if (lowerInput.contains('airport') || lowerInput.contains('aéroport')) {
      return true;
    }

    return false;
  }

  Future<bool> isAddressInCountries({required String address, List<String> countries = const ["fr", "ch"], required AddressType addressType}) async {
    try {
      // Get the location from the address
      List<Location> locations = await locationFromAddress(address);
      if (locations.isEmpty) {
        return false;
      }
      Location location = locations[0];

      // Get the placemarks from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isEmpty) {
        return false;
      }
      if (addressType == AddressType.pickUp) {
        cubit.updateStateLessPageVar(change: () {
          cubit.pickUpAddressError = false;
        },);
      } else {
        cubit.updateStateLessPageVar(change: () {
          cubit.dropOffAddressError = false;
        },);
      }
      Placemark place = placemarks[0];

      // Check if the country code is in the list of allowed countries
      return countries.contains(place.isoCountryCode?.toLowerCase());
    } catch (e) {
      if (addressType == AddressType.pickUp) {
        cubit.updateStateLessPageVar(change: () {
          cubit.pickUpAddressError = true;
        },);
      } else {
        cubit.updateStateLessPageVar(change: () {
          cubit.dropOffAddressError = true;
        },);
      }
      return false;
    }
  }

  bool valid = true;

  bool sending = false;

  void updateValid() {
    if (cubit.adult + cubit.child + cubit.infant > 0) {
      cubit.updateStateLessPageVar(change: () {
        cubit.validPassengers = true;
      },);
    } else {
      cubit.updateStateLessPageVar(change: () {
        cubit.validPassengers = false;
      },);
    }
    if (cubit.roundTrip) {
      if (cubit.adultRoundTrip + cubit.childRoundTrip + cubit.infantRoundTrip >
          0) {
        cubit.updateStateLessPageVar(change: () {
          cubit.validPassengersRoundTrip = true;
        },);
      } else {
        cubit.updateStateLessPageVar(change: () {
          cubit.validPassengersRoundTrip = false;
        },);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      /*if(completeBook){
        cubit.resetVarToCompleteBooking(model: model!);
      }*/
      flightPickUpNumberController = TextEditingController(text: cubit.flightNumber);
      flightDropOffNumberController = TextEditingController(text: cubit.flightNumberRoundTrip);
      cubit.updateStateLessPageVar(change: () {
        cubit.viewPricePressed = false;
      },);
    }
    return BlocListener<BookTaxiCubit, BookTaxiState>(
      listener: (context, state) {
        if (state is SwitchToVanMandatoryState) {
          showDialog(
              context: context,
              builder: (context) => SwitchToVanDialogCustom(optionally: false, roundTrip: !firstTrip,));
        }
        if (state is SwitchToVanOptionalState) {
          showDialog(
              context: context,
              builder: (context) => SwitchToVanDialogCustom(optionally: true, roundTrip: !firstTrip,));
        }
        if (state is SwitchToVanMandatoryRoundTripState) {
          showDialog(
              context: context,
              builder: (context) => SwitchToVanDialogCustom(optionally: false, roundTrip: !firstTrip,));
        }
        if (state is SwitchToVanOptionalRoundTripState) {
          showDialog(
              context: context,
              builder: (context) => SwitchToVanDialogCustom(optionally: true, roundTrip: !firstTrip,));
        }
      },
      child: BlocBuilder<BookTaxiCubit, BookTaxiState>(
  builder: (context, state) {
    return Scaffold(
        backgroundColor: ColorData.whiteColor200,
        body: Stack(
          children: [
            LayoutAppBarCustom(
              title: LocaleKeys.kFindDriver.tr(),
              iconOneType: IconOneType.logo,
              iconTwoType: IconTwoType.call,
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeData.s107,
                left: SizeData.s16,
                right: SizeData.s16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeData.s16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical:SizeData.s8),
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
                                  Align(
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Text(
                                        LocaleKeys
                                            .kChooseDestination
                                            .tr(),
                                        style: StyleData
                                            .textStyleGray700M14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(
                                        SizeData.s8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: ColorData.grayColor200,
                                      ),
                                      borderRadius: BorderRadius.circular(SizeData.s6),
                                    ),
                                    padding: EdgeInsets.all(SizeData.s16),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      mainAxisSize:MainAxisSize.min,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kPickUpAddress.tr(),
                                            style: StyleData.textStyleGray700M14,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            if(firstTrip){
                                              GoRouter.of(context).push(AppRouter.kAddAddressView, extra: {
                                                'addressType': AddressType.pickUp,
                                              });
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                Assets.userLocationIcon,
                                                width: Unit(context).iconSize(SizeData.s22),
                                                height: Unit(context).iconSize(SizeData.s22),
                                                color: ColorData.primaryColor600,
                                              ),
                                              SizedBox(width:SizeData.s10),
                                              Expanded(
                                                child: Text((firstTrip? cubit.pickUpAddress : cubit.dropOffAddress ).isEmpty? LocaleKeys.kPickUpAddress.tr(): (firstTrip? cubit.pickUpAddress : cubit.dropOffAddress ),
                                                    style:StyleData.textStyleGray400R12 ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (cubit.pickUpAddressError) Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    SizeData
                                                        .s4),
                                                child: SvgPicture
                                                    .asset(
                                                  Assets
                                                      .bookTaxiWarningIcon,
                                                  width: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  height: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  color: ColorData
                                                      .dangerColor300,
                                                  fit: BoxFit
                                                      .scaleDown,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  LocaleKeys.kThePickUpAddressIsInvalid.tr(),
                                                  style: StyleData
                                                      .textStyleDanger300R12,
                                                  textAlign:
                                                  TextAlign
                                                      .start,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        (!firstTrip)?SizedBox(height: SizeData.s20,):Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Divider(
                                                color: ColorData.grayColor100,
                                                endIndent: SizeData.s20,
                                              ),
                                            ),
                                            Center(
                                              child:
                                              GestureDetector(
                                                onTap: () {
                                                  String pickUpAddressTemp = cubit.pickUpAddress;
                                                  double pickUpLatTemp = cubit.pickUpAddressLat;
                                                  double pickUpLngTemp = cubit.pickUpAddressLng;
                                                  bool pickupErrorTemp = cubit.pickUpAddressError;
                                                  cubit.changePickUpAddress(
                                                      value: cubit.dropOffAddress, lng: cubit.dropOffAddressLng, lat: cubit.dropOffAddressLat);
                                                  cubit.changeDropOffAddress(
                                                      value: pickUpAddressTemp, lng: pickUpLngTemp, lat: pickUpLatTemp);
                                                  cubit.updateStateLessPageVar(change: () {
                                                    cubit.pickUpAddressError = cubit.dropOffAddressError;
                                                    cubit.dropOffAddressError = pickupErrorTemp;
                                                  },);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(SizeData.s8),
                                                  decoration: BoxDecoration(
                                                    color: ColorData.primaryColor50,
                                                    borderRadius: BorderRadius.circular(SizeData.s8),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    Assets.bookTaxiSwapArrowIcon,
                                                    height: Unit(context).iconSize(SizeData.s20),
                                                    width: Unit(context).iconSize(SizeData.s20),
                                                    color: ColorData.primaryColor500,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(bottom: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kDropOffAddress.tr(),
                                            style: StyleData.textStyleGray700M14,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            if(firstTrip){
                                              GoRouter.of(context).push(AppRouter.kAddAddressView, extra: {
                                                'addressType': AddressType.dropOff,
                                              });
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                Assets.userLocationIcon,
                                                width: Unit(context).iconSize(SizeData.s22),
                                                height: Unit(context).iconSize(SizeData.s22),
                                                color: ColorData.primaryColor600,
                                              ),
                                              SizedBox(width:SizeData.s10),
                                              Expanded(
                                                child: Text((firstTrip? cubit.dropOffAddress : cubit.pickUpAddress ).isEmpty? LocaleKeys.kDropOffAddress.tr(): (firstTrip? cubit.dropOffAddress : cubit.pickUpAddress ),
                                                    style:StyleData.textStyleGray400R12 ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (cubit.dropOffAddressError) Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    SizeData
                                                        .s4),
                                                child: SvgPicture
                                                    .asset(
                                                  Assets
                                                      .bookTaxiWarningIcon,
                                                  width: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  height: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  color: ColorData
                                                      .dangerColor300,
                                                  fit: BoxFit
                                                      .scaleDown,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  LocaleKeys.kTheDropOffAddressIsInvalid.tr(),
                                                  style: StyleData
                                                      .textStyleDanger300R12,
                                                  textAlign:
                                                  TextAlign
                                                      .start,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        if (cubit.dropOffAddress == cubit.pickUpAddress && cubit.dropOffAddress.isNotEmpty) Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    SizeData
                                                        .s4),
                                                child: SvgPicture
                                                    .asset(
                                                  Assets
                                                      .bookTaxiWarningIcon,
                                                  width: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  height: Unit(
                                                      context)
                                                      .iconSize(
                                                      SizeData
                                                          .s16),
                                                  color: ColorData
                                                      .dangerColor300,
                                                  fit: BoxFit
                                                      .scaleDown,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  LocaleKeys.kDepartureLocationIsTheSameAsTheArrivalLocation.tr(),
                                                  style: StyleData
                                                      .textStyleDanger300R12,
                                                  textAlign:
                                                  TextAlign
                                                      .start,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (firstTrip && containsAirport(cubit.pickUpAddress))Align(
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Text(
                                        LocaleKeys.kFlightNumber
                                            .tr(),
                                        style: StyleData
                                            .textStyleGray700M14,
                                      ),
                                    ),
                                  ),
                                  if (firstTrip && containsAirport(cubit.pickUpAddress))TextFormField(
                                    controller:
                                    flightPickUpNumberController,
                                    decoration: InputDecoration(
                                      border: BorderData
                                          .outlineInputBorderGray200W1R8,
                                      enabledBorder: BorderData
                                          .outlineInputBorderGray200W1R8,
                                      focusedBorder: BorderData
                                          .outlineInputBorderPrimary500W1R8,
                                      errorBorder: BorderData
                                          .outlineInputBorderDanger400W1R8,
                                      focusedErrorBorder: BorderData
                                          .outlineInputBorderDanger400W1R8,
                                      hintText: LocaleKeys
                                          .kTypeHere
                                          .tr(),
                                      hintStyle: StyleData
                                          .textStyleGray400R14,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(
                                            SizeData.s8),
                                        child: SvgPicture.asset(
                                          Assets
                                              .bookTaxiAirplaneIcon,
                                          width: Unit(context)
                                              .iconSize(
                                              SizeData.s22),
                                          height: Unit(context)
                                              .iconSize(
                                              SizeData.s22),
                                          color: ColorData
                                              .grayColor400,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return LocaleKeys.kPleaseFillThisField.tr();
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    autofillHints: const [],
                                    textInputAction:
                                    TextInputAction.next,
                                    obscureText: false,
                                    keyboardType:
                                    const TextInputType
                                        .numberWithOptions(
                                        signed: false,
                                        decimal: false),
                                    onChanged: (value) {
                                      cubit
                                          .changeFlightNumber(
                                          value: value);
                                    },
                                  ),
                                  if (!firstTrip && containsAirport(cubit.dropOffAddress))Align(
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Text(
                                        LocaleKeys.kFlightNumber
                                            .tr(),
                                        style: StyleData
                                            .textStyleGray700M14,
                                      ),
                                    ),
                                  ),
                                  if (!firstTrip && containsAirport(cubit.dropOffAddress))TextFormField(
                                    controller:
                                    flightDropOffNumberController,
                                    decoration: InputDecoration(
                                      border: BorderData
                                          .outlineInputBorderGray200W1R8,
                                      enabledBorder: BorderData
                                          .outlineInputBorderGray200W1R8,
                                      focusedBorder: BorderData
                                          .outlineInputBorderPrimary500W1R8,
                                      errorBorder: BorderData
                                          .outlineInputBorderDanger400W1R8,
                                      focusedErrorBorder: BorderData
                                          .outlineInputBorderDanger400W1R8,
                                      hintText: LocaleKeys
                                          .kTypeHere
                                          .tr(),
                                      hintStyle: StyleData
                                          .textStyleGray400R14,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(
                                            SizeData.s8),
                                        child: SvgPicture.asset(
                                          Assets
                                              .bookTaxiAirplaneIcon,
                                          width: Unit(context)
                                              .iconSize(
                                              SizeData.s22),
                                          height: Unit(context)
                                              .iconSize(
                                              SizeData.s22),
                                          color: ColorData
                                              .grayColor400,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return LocaleKeys.kPleaseFillThisField.tr();
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    autofillHints: const [],
                                    textInputAction:
                                    TextInputAction.next,
                                    obscureText: false,
                                    keyboardType:
                                    const TextInputType
                                        .numberWithOptions(
                                        signed: false,
                                        decimal: false),
                                    onChanged: (value) {
                                      cubit
                                          .changeFlightNumberRoundTrip(
                                          value: value);
                                    },
                                  ),
                                  Align(
                                    alignment:
                                    Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Text(
                                        LocaleKeys.kDateAndTime
                                            .tr(),
                                        style: StyleData
                                            .textStyleGray700M14,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Map<String, dynamic>
                                                extra = {
                                                  'timeSection':
                                                  false,
                                                  'firstTrip': firstTrip,
                                                };
                                                context.push(
                                                    AppRouter
                                                        .kAddDepartureDateView,
                                                    extra: extra);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: !firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day) ? ColorData.dangerColor500 : ColorData.grayColor200,
                                                  ),
                                                  color: !firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day) ? ColorData.dangerColor100 : null,
                                                  borderRadius: BorderRadius.circular(SizeData.s8),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: SizeData.s10, vertical: SizeData.s16),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.start,
                                                  crossAxisAlignment:CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          (firstTrip? cubit.dateTimeSelected : cubit.dateTimeSelectedRoundTrip )? (firstTrip? cubit.date.toIso8601String().split('T')[0] : cubit.dateRoundTrip.toIso8601String().split('T')[0]) : LocaleKeys.kSelect.tr(),
                                                          style:StyleData.textStyleGray400R14 ),
                                                    ),
                                                    SizedBox(width:SizeData.s4),
                                                    SvgPicture.asset(
                                                      Assets.bookTaxiCalendarIcon,
                                                      width: Unit(context).iconSize(SizeData.s22),
                                                      height: Unit(context).iconSize(SizeData.s22),
                                                      color: ColorData.grayColor400,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if(!firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day)) Padding(
                                              padding:
                                              EdgeInsets.symmetric(vertical: SizeData.s8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        SizeData
                                                            .s4),
                                                    child: SvgPicture
                                                        .asset(
                                                      Assets
                                                          .bookTaxiWarningIcon,
                                                      width: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      height: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      color: ColorData
                                                          .dangerColor300,
                                                      fit: BoxFit
                                                          .scaleDown,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      LocaleKeys.kReturnTripDateMustBeAfterTheFirstTripDate.tr(),
                                                      style: StyleData
                                                          .textStyleDanger300R12,
                                                      textAlign:
                                                      TextAlign
                                                          .start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeData.s8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Map<String, dynamic>
                                                extra = {
                                                  'timeSection':
                                                  true,
                                                  'firstTrip': firstTrip,
                                                };
                                                context.push(
                                                    AppRouter
                                                        .kAddDepartureDateView,
                                                    extra: extra);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: !firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day || (firstTrip && cubit.notLateTimeError && (cubit.dateTimeSelected || cubit.viewPricePressed)) || (!firstTrip && cubit.notLateTimeErrorRoundTrip && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed)) ? ColorData.dangerColor500 : ColorData.grayColor200,
                                                  ),
                                                  color: !firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day || (firstTrip && cubit.notLateTimeError && (cubit.dateTimeSelected || cubit.viewPricePressed)) || (!firstTrip && cubit.notLateTimeErrorRoundTrip && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed)) ? ColorData.dangerColor100 : null,
                                                  borderRadius: BorderRadius.circular(SizeData.s8),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: SizeData.s10, vertical: SizeData.s16),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.start,
                                                  crossAxisAlignment:CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          (firstTrip? cubit.dateTimeSelected : cubit.dateTimeSelectedRoundTrip )? (firstTrip? '${cubit.time.hour<10?'0':''}${cubit.time.hour}:${cubit.time.minute<10?'0':''}${cubit.time.minute}' : '${cubit.timeRoundTrip.hour<10?'0':''}${cubit.timeRoundTrip.hour}:${cubit.timeRoundTrip.minute<10?'0':''}${cubit.timeRoundTrip.minute}') : LocaleKeys.kSelect.tr(),
                                                          style:StyleData.textStyleGray400R14 ),
                                                    ),
                                                    SizedBox(width:SizeData.s4),
                                                    SvgPicture.asset(
                                                      Assets.bookTaxiClockIcon,
                                                      width: Unit(context).iconSize(SizeData.s22),
                                                      height: Unit(context).iconSize(SizeData.s22),
                                                      color: ColorData.grayColor400,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if((firstTrip && cubit.notLateTimeError && (cubit.dateTimeSelected || cubit.viewPricePressed)) || (!firstTrip && cubit.notLateTimeErrorRoundTrip && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed))) Padding(
                                              padding:
                                              EdgeInsets.symmetric(vertical: SizeData.s8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        SizeData
                                                            .s4),
                                                    child: SvgPicture
                                                        .asset(
                                                      Assets
                                                          .bookTaxiWarningIcon,
                                                      width: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      height: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      color: ColorData
                                                          .dangerColor300,
                                                      fit: BoxFit
                                                          .scaleDown,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${LocaleKeys.kTheValueMustBe.tr()} ${DateTime.now().add(Duration(minutes: 11)).hour<10?'0':''}${DateTime.now().add(Duration(minutes: 11)).hour}:${DateTime.now().add(Duration(minutes: 11)).minute<10?'0':''}${DateTime.now().add(Duration(minutes: 11)).minute} ${LocaleKeys.kOrLater.tr()}',
                                                      style: StyleData
                                                          .textStyleDanger300R12,
                                                      textAlign:
                                                      TextAlign
                                                          .start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            if(!firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day) Padding(
                                              padding:
                                              EdgeInsets.symmetric(vertical: SizeData.s8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(
                                                        SizeData
                                                            .s4),
                                                    child: SvgPicture
                                                        .asset(
                                                      Assets
                                                          .bookTaxiWarningIcon,
                                                      width: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      height: Unit(
                                                          context)
                                                          .iconSize(
                                                          SizeData
                                                              .s16),
                                                      color: ColorData
                                                          .dangerColor300,
                                                      fit: BoxFit
                                                          .scaleDown,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${LocaleKeys.kTheValueMustBe.tr()} ${cubit.time.hour<10?'0':''}${cubit.time.hour}:${cubit.time.minute<10?'0':''}${cubit.time.minute} ${LocaleKeys.kOrLater.tr()}',
                                                      style: StyleData
                                                          .textStyleDanger300R12,
                                                      textAlign:
                                                      TextAlign
                                                          .start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: SizeData.s8),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Text(
                                        LocaleKeys.kSelectVehicleType
                                            .tr(),
                                        style:
                                        StyleData.textStyleGray700M14,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (firstTrip) {
                                            cubit.changeVehicleType(
                                                value: 'sedan');
                                            cubit.checkCapacityOfSedan();
                                          } else {
                                            cubit
                                                .changeVehicleTypeRoundTrip(
                                                value: 'sedan');
                                            cubit.checkCapacityOfSedanRoundTrip();
                                          }
                                        },
                                        child: Container(
                                          width: Unit(context)
                                              .width(SizeData.s150),
                                          decoration: BoxDecoration(
                                            color: (firstTrip
                                                ? cubit.vehicleType ==
                                                'sedan'
                                                : cubit.vehicleTypeRoundTrip ==
                                                'sedan')
                                                ? ColorData
                                                .primaryColor50
                                                : null,
                                            border: (firstTrip
                                                ? cubit.vehicleType ==
                                                'sedan'
                                                : cubit.vehicleTypeRoundTrip ==
                                                'sedan')
                                                ? Border.all(
                                              color: ColorData
                                                  .primaryColor500,
                                              width: Unit(context)
                                                  .width(SizeData
                                                  .s1_5),
                                            )
                                                : null,
                                            borderRadius:
                                            BorderRadius.circular(
                                                SizeData.s8),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                                  child: Image.asset(
                                                    Assets
                                                        .bookTaxiSedan,
                                                    width: Unit(
                                                        context)
                                                        .width(
                                                        SizeData
                                                            .s94),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: SizeData.s8),
                                                  child: Text(
                                                    LocaleKeys.kSedan
                                                        .tr(),
                                                    style: (firstTrip
                                                        ? cubit.vehicleType ==
                                                        'sedan'
                                                        : cubit.vehicleTypeRoundTrip ==
                                                        'sedan')
                                                        ? StyleData
                                                        .textStyleGray500R14
                                                        : StyleData
                                                        .textStyleGray400R14,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (firstTrip) {
                                            cubit.changeVehicleType(
                                                value: 'van');
                                          } else {
                                            cubit
                                                .changeVehicleTypeRoundTrip(
                                                value: 'van');
                                          }
                                        },
                                        child: Container(
                                          width: Unit(context)
                                              .width(SizeData.s150),
                                          decoration: BoxDecoration(
                                            color: (firstTrip
                                                ? cubit.vehicleType ==
                                                'van'
                                                : cubit.vehicleTypeRoundTrip ==
                                                'van')
                                                ? ColorData
                                                .primaryColor50
                                                : null,
                                            border: (firstTrip
                                                ? cubit.vehicleType ==
                                                'van'
                                                : cubit.vehicleTypeRoundTrip ==
                                                'van')
                                                ? Border.all(
                                              color: ColorData
                                                  .primaryColor500,
                                              width: Unit(context)
                                                  .width(SizeData
                                                  .s1_5),
                                            )
                                                : null,
                                            borderRadius:
                                            BorderRadius.circular(
                                                SizeData.s8),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                                  child: Image.asset(
                                                    Assets
                                                        .bookTaxiVan,
                                                    width: Unit(
                                                        context)
                                                        .width(
                                                        SizeData
                                                            .s94),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: SizeData.s8),
                                                  child: Text(
                                                    LocaleKeys.kVan
                                                        .tr(),
                                                    style: (firstTrip
                                                        ? cubit.vehicleType ==
                                                        'van'
                                                        : cubit.vehicleTypeRoundTrip ==
                                                        'van')
                                                        ? StyleData
                                                        .textStyleGray500R14
                                                        : StyleData
                                                        .textStyleGray400R14,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
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
                                  boxShadow: ShadowData.boxShadow1),
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                        child: Text(
                                          LocaleKeys.kAdditionalDetails
                                              .tr(),
                                          style: StyleData
                                              .textStyleGray700M14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeData.s8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        TabButtonCustom(
                                          text: LocaleKeys.kPassengers
                                              .tr(),
                                          onTap: () async {
                                            Map<String, dynamic> extra =
                                            {
                                              'tabNumber': 0,
                                              'firstTrip':
                                              firstTrip
                                            };
                                            await context.push(
                                                AppRouter
                                                    .kAddAdditionalDetailsView,
                                                extra: extra);
                                            if (cubit.viewPricePressed) {
                                              updateValid();
                                            }
                                          },
                                          filled: firstTrip
                                              ? (cubit.adult > 0 ||
                                              cubit.child > 0 ||
                                              cubit.infant > 0)
                                              : (cubit.adultRoundTrip >
                                              0 ||
                                              cubit.childRoundTrip >
                                                  0 ||
                                              cubit.infantRoundTrip >
                                                  0),
                                          numberOfItems: firstTrip
                                              ? (cubit.adult +
                                              cubit.child +
                                              cubit.infant)
                                              : (cubit.adultRoundTrip +
                                              cubit.childRoundTrip +
                                              cubit
                                                  .infantRoundTrip),
                                          valid: firstTrip ? cubit.validPassengers : cubit.validPassengersRoundTrip,
                                        ),
                                        TabButtonCustom(
                                          text:
                                          LocaleKeys.kLuggage.tr(),
                                          onTap: () async {
                                            Map<String, dynamic> extra =
                                            {
                                              'tabNumber': 1,
                                              'firstTrip':
                                              firstTrip
                                            };
                                            await context.push(
                                                AppRouter
                                                    .kAddAdditionalDetailsView,
                                                extra: extra);
                                            if (cubit.viewPricePressed) {
                                              updateValid();
                                            }
                                          },
                                          filled: firstTrip
                                              ? (cubit.big > 0 ||
                                              cubit.medium > 0 ||
                                              cubit.small > 0)
                                              : (cubit.bigRoundTrip >
                                              0 ||
                                              cubit.mediumRoundTrip >
                                                  0 ||
                                              cubit.smallRoundTrip >
                                                  0),
                                          numberOfItems: firstTrip
                                              ? (cubit.big +
                                              cubit.medium +
                                              cubit.small)
                                              : (cubit.bigRoundTrip +
                                              cubit
                                                  .mediumRoundTrip +
                                              cubit.smallRoundTrip),
                                        ),
                                        TabButtonCustom(
                                          text: LocaleKeys.kExtraData
                                              .tr(),
                                          onTap: () async {
                                            Map<String, dynamic> extra =
                                            {
                                              'tabNumber': 2,
                                              'firstTrip':
                                              firstTrip
                                            };
                                            await context.push(
                                                AppRouter
                                                    .kAddAdditionalDetailsView,
                                                extra: extra);
                                            if (cubit.viewPricePressed) {
                                              updateValid();
                                            }
                                          },
                                          filled: firstTrip
                                              ? (cubit.surfboard > 0 ||
                                              cubit.skiBoard > 0 ||
                                              cubit.golf > 0 ||
                                              cubit.bicycle > 0 ||
                                              cubit.dogs > 0 ||
                                              cubit.cats > 0)
                                              : (cubit.surfboardRoundTrip > 0 ||
                                              cubit.skiBoardRoundTrip >
                                                  0 ||
                                              cubit.golfRoundTrip >
                                                  0 ||
                                              cubit.bicycleRoundTrip >
                                                  0 ||
                                              cubit.dogsRoundTrip >
                                                  0 ||
                                              cubit.catsRoundTrip >
                                                  0),
                                          numberOfItems: firstTrip
                                              ? (cubit.surfboard +
                                              cubit.skiBoard +
                                              cubit.golf +
                                              cubit.bicycle +
                                              cubit.dogs +
                                              cubit.cats)
                                              : (cubit.surfboardRoundTrip +
                                              cubit
                                                  .skiBoardRoundTrip +
                                              cubit.golfRoundTrip +
                                              cubit
                                                  .bicycleRoundTrip +
                                              cubit.dogsRoundTrip +
                                              cubit.catsRoundTrip),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((firstTrip && cubit.validPassengers != null && !cubit.validPassengers!) || (!firstTrip && cubit.validPassengersRoundTrip != null && !cubit.validPassengersRoundTrip!))
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                SizeData.s4),
                                            child: SvgPicture.asset(
                                              Assets.bookTaxiWarningIcon,
                                              width: Unit(context)
                                                  .iconSize(SizeData.s16),
                                              height: Unit(context)
                                                  .iconSize(SizeData.s16),
                                              color: ColorData
                                                  .dangerColor300,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  LocaleKeys.kPleaseEnterPassengersDetails.tr(),
                                                  style: StyleData
                                                      .textStyleDanger300R12,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                            if (firstTrip)
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    side: BorderSide(
                                        color: ColorData.grayColor300),
                                    activeColor:
                                    ColorData.primaryColor1000,
                                    onChanged: (value) {
                                      cubit.changeRoundTrip(
                                          value: value ?? false);
                                      if (value == true) {
                                        // Scroll to the bottom when the checkbox is checked
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          Scrollable.ensureVisible(
                                            roundTripKey.currentContext!,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        });
                                      }
                                    },
                                    value: cubit.roundTrip,
                                  ),
                                  Text(
                                    LocaleKeys.kRoundTrip.tr(),
                                    style: StyleData.textStyleGray700R14,
                                  )
                                ],
                              ),
                            if (cubit.roundTrip && firstTrip)
                              Container(
                                key: roundTripKey,
                                margin: EdgeInsets.symmetric(
                                    vertical: SizeData.s8),
                                decoration: BoxDecoration(
                                    color: ColorData.whiteColor200,
                                    borderRadius: BorderRadius.circular(
                                        SizeData.s16),
                                    boxShadow: ShadowData.boxShadow1),
                                padding: EdgeInsets.all(SizeData.s16),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                          child: Text(
                                            LocaleKeys.kSecondTrip.tr(),
                                            style: StyleData
                                                .textStyleGray700M14,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.push(
                                                AppRouter
                                                    .kFindDriverView,
                                                extra: {
                                                  'firstTrip' : false,
                                                });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                LocaleKeys.kModifyTrip
                                                    .tr(),
                                                style: StyleData
                                                    .textStyleBlue400R14,
                                              ),
                                              SvgPicture.asset(
                                                Assets.userEditIcon,
                                                height: Unit(context)
                                                    .iconSize(
                                                    SizeData.s22),
                                                width: Unit(context)
                                                    .iconSize(
                                                    SizeData.s22),
                                                color: ColorData
                                                    .blueColor400,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (firstTrip && containsAirport(cubit.dropOffAddress))Align(
                                      alignment:
                                      Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                        child: Text(
                                          LocaleKeys.kFlightNumber
                                              .tr(),
                                          style: StyleData
                                              .textStyleGray700M14,
                                        ),
                                      ),
                                    ),
                                    if (firstTrip && containsAirport(cubit.dropOffAddress))TextFormField(
                                      controller:
                                      flightDropOffNumberController,
                                      decoration:
                                      InputDecoration(
                                        border: BorderData
                                            .outlineInputBorderGray200W1R8,
                                        enabledBorder: BorderData
                                            .outlineInputBorderGray200W1R8,
                                        focusedBorder: BorderData
                                            .outlineInputBorderPrimary500W1R8,
                                        errorBorder: BorderData
                                            .outlineInputBorderDanger400W1R8,
                                        focusedErrorBorder:
                                        BorderData
                                            .outlineInputBorderDanger400W1R8,
                                        hintText: LocaleKeys
                                            .kTypeHere
                                            .tr(),
                                        hintStyle: StyleData
                                            .textStyleGray400R14,
                                        prefixIcon: Padding(
                                          padding:
                                          EdgeInsets.all(
                                              SizeData.s8),
                                          child:
                                          SvgPicture.asset(
                                            Assets
                                                .bookTaxiAirplaneIcon,
                                            width: Unit(context)
                                                .iconSize(
                                                SizeData
                                                    .s22),
                                            height: Unit(
                                                context)
                                                .iconSize(
                                                SizeData
                                                    .s22),
                                            color: ColorData
                                                .grayColor400,
                                            fit: BoxFit
                                                .scaleDown,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return LocaleKeys.kPleaseFillThisField.tr();
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      autofillHints: const [],
                                      textInputAction:
                                      TextInputAction.next,
                                      obscureText: false,
                                      keyboardType:
                                      const TextInputType
                                          .numberWithOptions(
                                          signed: false,
                                          decimal: false),
                                      onChanged: (value) {
                                        cubit
                                            .changeFlightNumberRoundTrip(
                                            value: value);
                                      },
                                    ),
                                    Align(
                                      alignment:
                                      Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                        child: Text(
                                          LocaleKeys.kDateAndTime
                                              .tr(),
                                          style: StyleData
                                              .textStyleGray700M14,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize:
                                      MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Map<String, dynamic>
                                                  extra = {
                                                    'timeSection':
                                                    false,
                                                    'firstTrip': false,
                                                  };
                                                  context.push(
                                                      AppRouter
                                                          .kAddDepartureDateView,
                                                      extra: extra);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day) ? ColorData.dangerColor500 :ColorData.grayColor200,
                                                    ),
                                                    borderRadius: BorderRadius.circular(SizeData.s8),
                                                    color: firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day) ? ColorData.dangerColor100 : null
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: SizeData.s10, vertical: SizeData.s16),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.start,
                                                    crossAxisAlignment:CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            cubit.dateTimeSelectedRoundTrip ? cubit.dateRoundTrip.toIso8601String().split('T')[0] : LocaleKeys.kSelect.tr(),
                                                            style:StyleData.textStyleGray400R14 ),
                                                      ),
                                                      SizedBox(width:SizeData.s4),
                                                      SvgPicture.asset(
                                                        Assets.bookTaxiCalendarIcon,
                                                        width: Unit(context).iconSize(SizeData.s22),
                                                        height: Unit(context).iconSize(SizeData.s22),
                                                        color: ColorData.grayColor400,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if(firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && (cubit.date.year > cubit.dateRoundTrip.year || cubit.date.month > cubit.dateRoundTrip.month || cubit.date.day > cubit.dateRoundTrip.day)) Padding(
                                                padding:
                                                EdgeInsets.symmetric(vertical: SizeData.s8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.all(
                                                          SizeData
                                                              .s4),
                                                      child: SvgPicture
                                                          .asset(
                                                        Assets
                                                            .bookTaxiWarningIcon,
                                                        width: Unit(
                                                            context)
                                                            .iconSize(
                                                            SizeData
                                                                .s16),
                                                        height: Unit(
                                                            context)
                                                            .iconSize(
                                                            SizeData
                                                                .s16),
                                                        color: ColorData
                                                            .dangerColor300,
                                                        fit: BoxFit
                                                            .scaleDown,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        LocaleKeys.kReturnTripDateMustBeAfterTheFirstTripDate.tr(),
                                                        style: StyleData
                                                            .textStyleDanger300R12,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeData.s8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Map<String, dynamic>
                                                  extra = {
                                                    'timeSection':
                                                    true,
                                                    'firstTrip': false,
                                                  };
                                                  context.push(
                                                      AppRouter
                                                          .kAddDepartureDateView,
                                                      extra: extra);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day ? ColorData.dangerColor500 : ColorData.grayColor200,
                                                    ),
                                                    borderRadius: BorderRadius.circular(SizeData.s8),
                                                      color: firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day ? ColorData.dangerColor100 : null
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: SizeData.s10, vertical: SizeData.s16),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.start,
                                                    crossAxisAlignment:CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            cubit.dateTimeSelectedRoundTrip ? '${cubit.timeRoundTrip.hour<10?'0':''}${cubit.timeRoundTrip.hour}:${cubit.timeRoundTrip.minute<10?'0':''}${cubit.timeRoundTrip.minute}' : LocaleKeys.kSelect.tr(),
                                                            style:StyleData.textStyleGray400R14 ),
                                                      ),
                                                      SizedBox(width:SizeData.s4),
                                                      SvgPicture.asset(
                                                        Assets.bookTaxiClockIcon,
                                                        width: Unit(context).iconSize(SizeData.s22),
                                                        height: Unit(context).iconSize(SizeData.s22),
                                                        color: ColorData.grayColor400,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if(firstTrip && cubit.roundTrip && cubit.firstTimeNotBeforeRoundTripTimeError && (cubit.dateTimeSelectedRoundTrip || cubit.viewPricePressed) && cubit.date.year <= cubit.dateRoundTrip.year && cubit.date.month <= cubit.dateRoundTrip.month && cubit.date.day <= cubit.dateRoundTrip.day) Padding(
                                                padding:
                                                EdgeInsets.symmetric(vertical: SizeData.s8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.all(
                                                          SizeData
                                                              .s4),
                                                      child: SvgPicture
                                                          .asset(
                                                        Assets
                                                            .bookTaxiWarningIcon,
                                                        width: Unit(
                                                            context)
                                                            .iconSize(
                                                            SizeData
                                                                .s16),
                                                        height: Unit(
                                                            context)
                                                            .iconSize(
                                                            SizeData
                                                                .s16),
                                                        color: ColorData
                                                            .dangerColor300,
                                                        fit: BoxFit
                                                            .scaleDown,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${LocaleKeys.kTheValueMustBe.tr()} ${cubit.time.hour<10?'0':''}${cubit.time.hour}:${cubit.time.minute<10?'0':''}${cubit.time.minute} ${LocaleKeys.kOrLater.tr()}',
                                                        style: StyleData
                                                            .textStyleDanger300R12,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                          if(!sending) {
                            sending = true;
                            cubit.updateStateLessPageVar(change: () {
                              cubit.viewPricePressed = true;
                            },);
                            updateValid();
                            cubit.checkIfTimeDateIsEnable(cubit.time, true);
                            cubit.checkIfTimeDateIsEnable(cubit.timeRoundTrip, false);
                            if(cubit.roundTrip && (cubit.validPassengersRoundTrip == null || !cubit.validPassengersRoundTrip!) && firstTrip) {
                              context.push(
                                  AppRouter
                                      .kFindDriverView,
                                  extra: {
                                    'firstTrip' : false,
                                  });
                            }
                            if(cubit.notLateTimeError && !firstTrip) {
                              context.pushReplacement(
                                  AppRouter
                                      .kFindDriverView,
                                  extra: {
                                    'firstTrip' : true,
                                  });
                            } else if(!firstTrip && (cubit.validPassengers == null || !cubit.validPassengers!)) {
                              context.pushReplacement(
                                  AppRouter
                                      .kFindDriverView,
                                  extra: {
                                    'firstTrip' : true,
                                  });
                            }
                            bool checkPickUpInCountries = await isAddressInCountries(address: cubit.pickUpAddress, addressType: AddressType.pickUp);
                            bool checkDropOffInCountries = await isAddressInCountries(address: cubit.dropOffAddress, addressType: AddressType.dropOff);
                            if (
                            formKey.currentState!.validate() &&
                                (cubit.validPassengers != null && cubit.validPassengers!) &&
                                ((cubit.roundTrip && cubit.validPassengersRoundTrip != null && cubit.validPassengersRoundTrip!) || !cubit.roundTrip)&&
                                !cubit.notLateTimeError &&
                                ((!cubit.notLateTimeErrorRoundTrip && cubit.roundTrip) || !cubit.roundTrip) &&
                                ((!cubit.firstTimeNotBeforeRoundTripTimeError && cubit.roundTrip) || !cubit.roundTrip) &&
                                !cubit.pickUpAddressError &&
                                !cubit.dropOffAddressError &&
                                (cubit.dropOffAddress != cubit.pickUpAddress)
                            ) {
                              if ((SharedPreferencesServices.getData(key: ConstantData.kToken)??'').isNotEmpty) {

                                if (checkPickUpInCountries && checkDropOffInCountries) {
                                  if(context.mounted) {
                                    cubit.updateStateLessPageVar(change: () {
                                      cubit.selectedPriceNumber = -1;
                                      cubit.selectedPriceNumberRoundTrip = -1;
                                    },);
                                    context.push(AppRouter.kViewPriceView, extra: {
                                      'secondPriceInRoundTrip': false
                                    });
                                  }
                                } else {
                                  if (!cubit.pickUpAddressError && !cubit.dropOffAddressError) {
                                    if(context.mounted) {
                                      context.push(AppRouter.kNoAvailabilityOutSideCountriesView,);
                                    }
                                  }
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                    const TakeClientInformationDialogCustom());
                              }
                            }
                            sending = false;
                          }
                        },
                        text: LocaleKeys.kViewPrices.tr(),
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                      ),
                    ),
                    if (!firstTrip)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeData.s16),
                        child: OutLineButtonCustom(
                          onTap: () {
                            context.pop();
                          },
                          text: LocaleKeys.kBackToFirstTrip.tr(),
                          icon: Icons.arrow_back_rounded,
                          textFirstIfIcon: false,
                        ),
                      ),
                  ],
                ),
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
