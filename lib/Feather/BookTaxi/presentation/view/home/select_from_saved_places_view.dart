import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/Feather/User/presentation/view/widget/saved_place_item_custom.dart';

class SelectFromSavedPlacesView extends StatefulWidget {
  const SelectFromSavedPlacesView({super.key});

  @override
  State<SelectFromSavedPlacesView> createState() => _SelectFromSavedPlacesViewState();
}

class _SelectFromSavedPlacesViewState extends State<SelectFromSavedPlacesView> {

  Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        double latitude = location.latitude;
        double longitude = location.longitude;

        return {
          'lat': latitude,
          'lng': longitude
        };

      } else {
        debugPrint("No locations found");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
        backgroundColor: ColorData.whiteColor200,
        body: BlocBuilder<UserCubit,UserState>(
          builder: (context,state){
            var cubit = UserCubit.get(context);
            return Stack(
              children: [
                AppBarCustom(title: LocaleKeys.kSavedPlaces.tr()),
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(SizeData.s10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        (state is LoadingGetPlacesState)?
                        const LoadingAppCustom():
                        Column(
                          children: [
                            ...cubit.listPlaces.map((e){
                              return SavedPlaceItemCustom(
                                  title: e.title??'',
                                  address: e.address??'',
                                  id: e.id??'',
                                  onTap: () async {
                                    Map<String, double> latAndLng = await getCoordinatesFromAddress(e.address??'') ?? {
                                      'lat': 0.0,
                                      'lng': 0.0
                                    };
                                    Map<String, dynamic> returnMap = {
                                      'address': e.address??'',
                                      'lat': latAndLng['lat'],
                                      'lng': latAndLng['lng']
                                    };
                                    if (context.mounted) {
                                      context.pop(returnMap);
                                    }
                                  }
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: SizeData.s15,),

                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kAddSavedPlacesView,
                                extra: {
                                  'IsEdit':false,
                                  'Address':'',
                                  'Title':'',
                                  'Id':''
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(SizeData.s15),
                                decoration: BoxDecoration(
                                    color: ColorData.grayColor50,
                                    shape: BoxShape.circle
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: Unit(context).getWidthSize*0.056,
                                    color: ColorData.blueColor400,
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeData.s10,),
                              Expanded(
                                child: Text(LocaleKeys.kAddNewPlace.tr(),
                                  style: StyleData.textStyle14.copyWith(
                                      color: ColorData.blueColor400,
                                      fontSize: Unit(context).getWidthSize*0.037
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        )
    );
  }
}
