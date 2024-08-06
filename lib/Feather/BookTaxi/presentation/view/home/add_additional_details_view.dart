import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:group_button/group_button.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/buttons/out_line_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/switch_to_van_dialog_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/find_driver_view_componanets/additional_details_item_custom.dart';
import 'package:public_app/generated/assets.dart';

class AddAdditionalDetailsView extends StatelessWidget {

  final int tabNumber;
  final bool firstTrip;
  AddAdditionalDetailsView({super.key, required this.tabNumber, this.firstTrip = true});

  late final BookTaxiCubit cubit;
  bool first = true;

  GroupButtonController buttonController = GroupButtonController(selectedIndex: 0);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<BookTaxiCubit>();
      cubit.updateStateLessPageVar(change: () {
        cubit.tempAdditionalPageIndex = tabNumber;

        cubit.tempAdult = cubit.adult;
        cubit.tempAdultRoundTrip = cubit.adultRoundTrip;
        cubit.tempChild = cubit.child;
        cubit.tempChildRoundTrip = cubit.childRoundTrip;
        cubit.tempInfant = cubit.infant;
        cubit.tempInfantRoundTrip = cubit.infantRoundTrip;

        cubit.tempBig = cubit.big;
        cubit.tempBigRoundTrip = cubit.bigRoundTrip;
        cubit.tempMedium = cubit.medium;
        cubit.tempMediumRoundTrip = cubit.mediumRoundTrip;
        cubit.tempSmall = cubit.small;
        cubit.tempSmallRoundTrip = cubit.smallRoundTrip;

        cubit.tempGolf = cubit.golf;
        cubit.tempGolfRoundTrip = cubit.golfRoundTrip;
        cubit.tempSkiBoard = cubit.skiBoard;
        cubit.tempSkiBoardRoundTrip = cubit.skiBoardRoundTrip;
        cubit.tempSurfboard = cubit.surfboard;
        cubit.tempSurfboardRoundTrip = cubit.surfboardRoundTrip;
        cubit.tempBicycle = cubit.bicycle;
        cubit.tempBicycleRoundTrip = cubit.bicycleRoundTrip;

        cubit.tempCats = cubit.cats;
        cubit.tempCatsRoundTrip = cubit.catsRoundTrip;
        cubit.tempDogs = cubit.dogs;
        cubit.tempDogsRoundTrip = cubit.dogsRoundTrip;
      },);
      buttonController = GroupButtonController(selectedIndex: cubit.tempAdditionalPageIndex);
    }
    return BlocListener<BookTaxiCubit, BookTaxiState>(
  listener: (context, state) {
    if (state is SwitchToVanMandatoryForTempState) {
      showDialog(
          context: context,
          builder: (context) => SwitchToVanDialogCustom(optionally: false, roundTrip: !firstTrip,));
    }
    if (state is SwitchToVanOptionalForTempState) {
      showDialog(
          context: context,
          builder: (context) => SwitchToVanDialogCustom(optionally: true, roundTrip: !firstTrip,));
    }
    if (state is SwitchToVanMandatoryForTempRoundTripState) {
      showDialog(
          context: context,
          builder: (context) => SwitchToVanDialogCustom(optionally: false, roundTrip: !firstTrip,));
    }
    if (state is SwitchToVanOptionalForTempRoundTripState) {
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
              LayoutAppBarCustom(title: LocaleKeys.kAdditionalDetails.tr()),
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: SizeData.s8),
                              decoration: BoxDecoration(
                                  color: ColorData.whiteColor200,
                                  borderRadius: BorderRadius.circular(SizeData.s16),
                                  boxShadow: ShadowData.boxShadow1
                              ),
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorData.primaryColor50,
                                        borderRadius: BorderRadius.circular(SizeData.s8)
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                    child: GroupButton(
                                      buttons: [LocaleKeys.kPassengers.tr(), LocaleKeys.kLuggage.tr(), LocaleKeys.kExtraData.tr()],
                                      options: GroupButtonOptions(
                                        borderRadius: BorderRadius.circular(SizeData.s8),
                                        groupingType: GroupingType.row,
                                        mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                                        selectedColor: ColorData.primaryColor400,
                                        unselectedTextStyle: StyleData.textStyleGray400R12,
                                        selectedTextStyle: StyleData.textStyleWhite200R12,
                                        buttonWidth: Unit(context).width(SizeData.s85),
                                        spacing: 0,
                                        runSpacing: 0,
                                        unselectedColor: ColorData.primaryColor50,
                                        selectedShadow: [],
                                        unselectedShadow: [],
                                      ),
                                      controller: buttonController,
                                      onSelected: (value, index, isSelected) {
                                        cubit.updateStateLessPageVar(change: () {
                                          cubit.tempAdditionalPageIndex = index;
                                        },);
                                      },
                                    ),
                                  ),
                                  IndexedStack(
                                    index: cubit.tempAdditionalPageIndex,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          if(cubit.tempAdditionalPageIndex == 0) AdditionalDetailsItemCustom(
                                            type: ItemType.adults,
                                            number: firstTrip ? cubit.tempAdult : cubit.tempAdultRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempAdult : cubit.tempAdultRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempAdult = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempAdult = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempAdultRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempAdultRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 0) AdditionalDetailsItemCustom(
                                            type: ItemType.children,
                                            number: firstTrip ? cubit.tempChild : cubit.tempChildRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempChild : cubit.tempChildRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempChild = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempChild = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempChildRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempChildRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 0) AdditionalDetailsItemCustom(
                                            type: ItemType.infants,
                                            number: firstTrip ? cubit.tempInfant : cubit.tempInfantRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempInfant : cubit.tempInfantRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempInfant = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempInfant = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempInfantRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempInfantRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          if(cubit.tempAdditionalPageIndex == 1) AdditionalDetailsItemCustom(
                                            type: ItemType.big,
                                            number: firstTrip ? cubit.tempBig : cubit.tempBigRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempBig : cubit.tempBigRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempBig = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempBig = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempBigRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempBigRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 1) AdditionalDetailsItemCustom(
                                            type: ItemType.medium,
                                            number: firstTrip ? cubit.tempMedium : cubit.tempMediumRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempMedium : cubit.tempMediumRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempMedium = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempMedium = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempMediumRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempMediumRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 1) AdditionalDetailsItemCustom(
                                            type: ItemType.small,
                                            number: firstTrip ? cubit.tempSmall : cubit.tempSmallRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempSmall : cubit.tempSmallRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempSmall = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempSmall = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempSmallRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempSmallRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          if(cubit.tempAdditionalPageIndex == 2)Text(
                                            LocaleKeys.kSpecialLuggage.tr(),
                                            style: StyleData.textStyleGray600M14,
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 2) AdditionalDetailsItemCustom(
                                            type: ItemType.surfboard,
                                            number: firstTrip ? cubit.tempSurfboard : cubit.tempSurfboardRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempSurfboard : cubit.tempSurfboardRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempSurfboard = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempSurfboard = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempSurfboardRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempSurfboardRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 2) AdditionalDetailsItemCustom(
                                            type: ItemType.skiBoard,
                                            number: firstTrip ? cubit.tempSkiBoard : cubit.tempSkiBoardRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempSkiBoard : cubit.tempSkiBoardRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempSkiBoard = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempSkiBoard = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempSkiBoardRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempSkiBoardRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 2) AdditionalDetailsItemCustom(
                                            type: ItemType.golf,
                                            number: firstTrip ? cubit.tempGolf : cubit.tempGolfRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempGolf : cubit.tempGolfRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempGolf = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempGolf = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempGolfRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempGolfRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                          if(cubit.tempAdditionalPageIndex == 2) AdditionalDetailsItemCustom(
                                            type: ItemType.bicycle,
                                            number: firstTrip ? cubit.tempBicycle : cubit.tempBicycleRoundTrip,
                                            onChange: (int value) {
                                              cubit.updateStateLessPageVar(change: () {
                                                int temp = firstTrip ? cubit.tempBicycle : cubit.tempBicycleRoundTrip;
                                                if(firstTrip) {
                                                  cubit.tempBicycle = value;
                                                  if(!cubit.checkCapacity()){
                                                    cubit.tempBicycle = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedan();
                                                } else {
                                                  cubit.tempBicycleRoundTrip = value;
                                                  if(!cubit.checkCapacityRoundTrip()){
                                                    cubit.tempBicycleRoundTrip = temp;
                                                  }
                                                  cubit.checkTempCapacityOfSedanRoundTrip();
                                                }
                                              },);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if(cubit.tempAdditionalPageIndex == 2)Container(
                              margin: EdgeInsets.only(bottom: SizeData.s8),
                              decoration: BoxDecoration(
                                  color: ColorData.whiteColor200,
                                  borderRadius: BorderRadius.circular(SizeData.s16),
                                  boxShadow: ShadowData.boxShadow1
                              ),
                              padding: EdgeInsets.all(SizeData.s16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.kPets.tr(),
                                    style: StyleData.textStyleGray600M14,
                                  ),
                                  AdditionalDetailsItemCustom(
                                    type: ItemType.cats,
                                    number: firstTrip ? cubit.tempCats : cubit.tempCatsRoundTrip,
                                    onChange: (int value) {
                                      cubit.updateStateLessPageVar(change: () {
                                        int temp = firstTrip ? cubit.tempCats : cubit.tempCatsRoundTrip;
                                        if(firstTrip) {
                                          cubit.tempCats = value;
                                          print(value);
                                          if(!cubit.checkCapacity()){
                                            cubit.tempCats = temp;
                                          }
                                          cubit.checkTempCapacityOfSedan();
                                        } else {
                                          cubit.tempCatsRoundTrip = value;
                                          if(!cubit.checkCapacityRoundTrip()){
                                            cubit.tempCatsRoundTrip = temp;
                                          }
                                          cubit.checkTempCapacityOfSedanRoundTrip();
                                        }
                                      },);
                                    },
                                  ),
                                  AdditionalDetailsItemCustom(
                                      type: ItemType.dogs,
                                      number: cubit.tempDogs,
                                      onChange: (int value) {
                                        cubit.updateStateLessPageVar(change: () {
                                          int temp = firstTrip ? cubit.tempDogs : cubit.tempDogsRoundTrip;
                                          if(firstTrip) {
                                            cubit.tempDogs = value;
                                            if(!cubit.checkCapacity()){
                                              cubit.tempDogs = temp;
                                            }
                                            cubit.checkTempCapacityOfSedan();
                                          } else {
                                            cubit.tempDogsRoundTrip = value;
                                            if(!cubit.checkCapacityRoundTrip()){
                                              cubit.tempDogsRoundTrip = temp;
                                            }
                                            cubit.checkTempCapacityOfSedanRoundTrip();
                                          }
                                        },);
                                      }
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTileCustom(
                                title: Text(
                                  LocaleKeys.kAddComment.tr(),
                                  style: StyleData.textStyleGray600R14,
                                ),
                                trailing: SvgPicture.asset(
                                  Assets.userArrowRightIcon,
                                  height: Unit(context).iconSize(SizeData.s22),
                                  width: Unit(context).iconSize(SizeData.s22),
                                  fit: BoxFit.scaleDown,
                                  color: ColorData.grayColor600,
                                ),
                                trailingAngels: TrailingAngels.upAndDown,
                                initiallyExpanded: true,
                                padding: EdgeInsets.only(bottom: SizeData.s8),
                                children: [
                                  TextFormField(
                                    controller: commentController,
                                    decoration: InputDecoration(
                                      border: BorderData.outlineInputBorderGray200W1R8,
                                      enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                                      focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                                      errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                      focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                      hintText: LocaleKeys.kTypeHere.tr(),
                                      hintStyle: StyleData.textStyleGray400R12,
                                    ),
                                    autofocus: false,
                                    autofillHints: const [],
                                    textInputAction:
                                    TextInputAction.done,
                                    obscureText: false,
                                    keyboardType:
                                    TextInputType.multiline,
                                    minLines: 5,
                                    maxLines: 10,
                                  )
                                ]
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: SizeData.s8),
                      child: MainButtonCustom(
                        onTap: () {
                          if (firstTrip) {
                            cubit.submitAdditionalDetails();
                          } else {
                            cubit.submitAdditionalDetailsRoundTrip();
                          }
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
                          context.pop();
                        },
                        text: LocaleKeys.kSubmit.tr(),
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: SizeData.s16),
                      child: OutLineButtonCustom(
                        onTap: () {
                          if(cubit.tempAdditionalPageIndex != 1) {
                            context.pop();
                          } else {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempAdditionalPageIndex = 2;
                            },);
                          }
                        },
                        text: cubit.tempAdditionalPageIndex != 1? LocaleKeys.kCancel.tr() : LocaleKeys.kExtraData.tr(),
                        icon: cubit.tempAdditionalPageIndex != 1? null : Icons.arrow_forward_rounded,
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
