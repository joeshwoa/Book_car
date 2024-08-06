import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/helper/sussess_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Core/widget/buttons/current_location_button_custom.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/buttons/out_line_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/search_location_input_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';

class AddSavedPlacesView extends StatefulWidget {
  final bool isEdit;
  final String title;
  final String address;
  final String id;
  const AddSavedPlacesView({super.key, required this.isEdit, required this.title, required this.address, required this.id});

  @override
  State<AddSavedPlacesView> createState() => _AddSavedPlacesViewState();
}

class _AddSavedPlacesViewState extends State<AddSavedPlacesView> {

  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.title;
    addressController.text = widget.address;
    super.initState();
  }

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
    context.locale;
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: BlocConsumer<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return Stack(
            children: [
              AppBarCustom(title: LocaleKeys.kPlaceDetails.tr()),
              Container(
                margin : EdgeInsets.only(top: Unit(context).getHeightSize*0.15,
                  left: SizeData.s15,
                  right: SizeData.s15,),
                decoration: BoxDecoration(
                    color: ColorData.whiteColor200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeData.s20),
                      topRight: Radius.circular(SizeData.s20),
                    )
                ),
                child: Form(
                  key: kForm,
                  child: Padding(
                    padding: EdgeInsets.all(SizeData.s8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeData.s10,),
                        Text(LocaleKeys.kTitle.tr(),
                          style: StyleData.textStyle14.copyWith(
                              color: ColorData.grayColor500,
                              fontSize: Unit(context).getWidthSize*0.037
                          ),
                        ),
                        SizedBox(height: SizeData.s10,),
                        InputTextCustom(controller: titleController,
                            hintText: LocaleKeys.kTitle.tr()),

                        SizedBox(height: SizeData.s20,),

                        Text(LocaleKeys.kAddress.tr(),
                          style: StyleData.textStyle14.copyWith(
                              color: ColorData.grayColor500,
                              fontSize: Unit(context).getWidthSize*0.037
                          ),
                        ),
                        SizedBox(height: SizeData.s10,),

                        (widget.isEdit)?
                        InputTextCustom(
                            controller: addressController,
                            minLines: 3,
                            hintText: LocaleKeys.kAddress.tr()):
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SearchGoogleInputCustom(
                              hintText: LocaleKeys.kAddress.tr(),
                              addressController: addressController,
                              isCrossBtnShown: false,
                            ),

                            SizedBox(height: SizeData.s15,),
                            CurrentLocationButtonCustom(
                              fun: () async {
                                // Detect your location
                                Position position = await determinePosition();
                                List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

                                // Get the first placemark which contains the address details
                                Placemark place = placemarks[0];
                                String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

                                // You can now use position.latitude, position.longitude and address
                                //print("Latitude: ${position.latitude}, Longitude: ${position.longitude}, Address: $address");

                              },
                            ),

                          ],
                        ),

                        Expanded(child: SizedBox()),

                        (widget.isEdit)?
                        (state is LoadingEditPlacesState)?
                        const LoadingAppCustom():
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MainButtonCustom(
                              onTap: () {
                                if(kForm.currentState!.validate()){
                                  cubit.changePlace(title: titleController.text, address: addressController.text, id: widget.id);
                                }
                              },
                              text: LocaleKeys.kSaveChanges.tr(),
                              textStyle: StyleData.textStyle14.copyWith(
                                  color: ColorData.whiteColor200,
                                  fontSize: Unit(context).getWidthSize*0.042
                              ),
                              color: ColorData.primaryColor1000,
                            ),

                            SizedBox(height: SizeData.s15,),

                            OutLineButtonCustom(
                              onTap: () {},
                              text: LocaleKeys.kDelete.tr(),
                              textStyle: StyleData.textStyleDanger500M14,
                              color: ColorData.dangerColor500,
                            ),
                          ],
                        ):
                        (state is LoadingSavePlacesState)?
                        const LoadingAppCustom():
                        MainButtonCustom(
                          onTap: () {
                            if(kForm.currentState!.validate()){
                              cubit.savePlace(
                                address: addressController.text,
                                title: titleController.text
                              );
                            }
                          },
                          text: LocaleKeys.kSavePlace.tr(),
                          textStyle: StyleData.textStyle14.copyWith(
                              color: ColorData.whiteColor200,
                              fontSize: Unit(context).getWidthSize*0.042
                          ),
                          color: ColorData.primaryColor1000,
                        ),

                        SizedBox(height: SizeData.s20,),

                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
        listener: (context,state){
          if(state is SuccessEditPlacesState){
            Navigator.pop(context);
            BlocProvider.of<UserCubit>(context).getPlaces();
          }else if(state is ErrorEditPlacesState || state is ErrorSavePlacesState){
            showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
          }else if(state is SuccessSavePlacesState){
            Navigator.pop(context);
            showSuccessToast(context: context,msg: state.msg??'');
            BlocProvider.of<UserCubit>(context).getPlaces();
          }
        },
      ),
    );
  }
}
