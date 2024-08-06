/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/view/widget/profile_view_componanets/place_item_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/generated/assets.dart';

class AddNewPlaceView extends StatefulWidget {

  const AddNewPlaceView({super.key});

  @override
  State<AddNewPlaceView> createState() => _AddNewPlaceViewState();
}

class _AddNewPlaceViewState extends State<AddNewPlaceView> {

  TextEditingController addressController = TextEditingController();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kSavedPlaces.tr()),
          Padding(
            padding: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: SizeData.s8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorData.whiteColor200,
                                borderRadius: BorderRadius.circular(SizeData.s16),
                                boxShadow: ShadowData.boxShadow1
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: GooglePlaceAutoCompleteTextField(
                                      showError: true,
                                      boxDecoration: const BoxDecoration(),
                                      textEditingController: addressController,
                                      googleAPIKey: dotenv.env['GOOGLE_API_KEY']!,
                                      inputDecoration: InputDecoration(
                                        border: BorderData.outlineInputBorderGray200W1R8,
                                        enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                                        focusedBorder: BorderData.outlineInputBorderPrimary600W1R8,
                                        errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                        focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: SizeData.s8),
                                          child: SvgPicture.asset(
                                            Assets.userLocationIcon,
                                            height: Unit(context).iconSize(SizeData.s24),
                                            width: Unit(context).iconSize(SizeData.s24),
                                            color: ColorData.primaryColor600,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                          maxWidth: Unit(context).width(SizeData.s40),
                                          maxHeight: Unit(context).height(SizeData.s24),
                                        ),
                                        hintText: LocaleKeys.kEnterYourDestination.tr(),
                                        hintStyle: StyleData.textStyleGray500R12,
                                      ),
                                      debounceTime: 800,
                                      countries: const ["fr", "ch"],
                                      isLatLngRequired: true,
                                      getPlaceDetailWithLatLng: (Prediction prediction) async {

                                      },
                                      itemClick: (Prediction prediction) {
                                        addressController.text = prediction.description.toString();
                                        addressController.selection = TextSelection.fromPosition(
                                            TextPosition(offset: prediction.description!.length));
                                        context.push(AppRouter.kAddSavedPlacesView);
                                      },
                                      itemBuilder: (context, index, Prediction prediction) {
                                        if (prediction.types!.contains("country")) {
                                          return const SizedBox();
                                        }
                                        return Container(
                                          padding: EdgeInsets.all(SizeData.s8),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: SizeData.s7),
                                                child: const Icon(Icons.star_border, color: Colors.grey),
                                              ),
                                              Expanded(child: Text(prediction.description ?? ""))
                                            ],
                                          ),
                                        );
                                      },
                                      seperatedBuilder: const Divider(),
                                      isCrossBtnShown: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Detect your location
                                        Position position = await determinePosition();
                                        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

                                        // Get the first placemark which contains the address details
                                        Placemark place = placemarks[0];
                                        String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

                                        // You can now use position.latitude, position.longitude and address
                                        print("Latitude: ${position.latitude}, Longitude: ${position.longitude}, Address: $address");
                                      },
                                      child: SizedBox(
                                        height: Unit(context).height(SizeData.s48),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: Unit(context).iconSize(SizeData.s40),
                                                width: Unit(context).iconSize(SizeData.s40),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    Assets.userYourLocationIcon,
                                                    width: Unit(context).iconSize(SizeData.s24),
                                                    height: Unit(context).iconSize(SizeData.s24),
                                                    color: ColorData.primaryColor500,
                                                    fit: BoxFit.scaleDown
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  LocaleKeys.kYourLocation.tr(),
                                                  style: StyleData.textStylePrimary500M14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      LocaleKeys.kRecentPlaces.tr(),
                                      style: StyleData.textStyleGray700R14,
                                    ),
                                  ),
                                  for(int i = 0; i < 3; i++)...[
                                    PlaceItemCustom(
                                      address: 'Mall of Egypt | Egypt',
                                      description: 'Wahat road - Cairo',
                                      onTap: () {
                                        setState(() {
                                          context.push(AppRouter.kAddSavedPlacesView);
                                        });
                                      },
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                              border: BorderData.outlineInputBorderGray200W1R8,
                              enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                              focusedBorder: BorderData.outlineInputBorderPrimary600W1R8,
                              errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                              focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(SizeData.s4),
                                child: SvgPicture.asset(
                                  Assets.userLocationIcon,
                                  height: Unit(context).iconSize(SizeData.s24),
                                  width: Unit(context).iconSize(SizeData.s24),
                                  color: ColorData.primaryColor600,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: Unit(context).iconSize(SizeData.s32),
                                maxHeight: Unit(context).iconSize(SizeData.s32),
                              ),
                              hintText: LocaleKeys.kAddress.tr(),
                              hintStyle: StyleData.textStyleGray500R12,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill this field';
                              }
                              return null;
                            },
                            autofocus: false,
                            autofillHints: const [AutofillHints.addressCityAndState],
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: Unit(context).height(SizeData.s48),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Unit(context).iconSize(SizeData.s40),
                                      width: Unit(context).iconSize(SizeData.s40),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          Assets.userYourLocationIcon,
                                          width: Unit(context).iconSize(SizeData.s24),
                                          height: Unit(context).iconSize(SizeData.s24),
                                          color: ColorData.primaryColor500,
                                          fit: BoxFit.scaleDown
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.kYourLocation.tr(),
                                        style: StyleData.textStylePrimary500M14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          LocaleKeys.kRecentPlaces.tr(),
                          style: StyleData.textStyleGray700R14,
                        ),
                        PlaceItemCustom(
                            address: 'Mall of Egypt | Egypt',
                            description: 'Wahat road - Cairo',
                            onTap: () {
                              context.push(AppRouter.kAddSavedPlacesView);
                            }
                        ),
                        PlaceItemCustom(
                            address: 'Mall of Egypt | Egypt',
                            description: 'Wahat road - Cairo',
                            onTap: () {
                              context.push(AppRouter.kAddSavedPlacesView);
                            }
                        ),
                        PlaceItemCustom(
                            address: 'Mall of Egypt | Egypt',
                            description: 'Wahat road - Cairo',
                            onTap: () {
                              context.push(AppRouter.kAddSavedPlacesView);
                            }
                        ),
                      ],
                    ),
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
*/
