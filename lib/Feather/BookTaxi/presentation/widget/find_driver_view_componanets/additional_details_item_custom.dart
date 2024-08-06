import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

enum ItemType {
  adults,
  children,
  infants,
  big,
  medium,
  small,
  surfboard,
  skiBoard,
  golf,
  bicycle,
  cats,
  dogs
}

class AdditionalDetailsItemCustom extends StatelessWidget {

  final ItemType type;
  final Function(int)? onChange;
  final int number;
  const AdditionalDetailsItemCustom({super.key, required this.type, this.onChange, this.number = 0});

  @override
  Widget build(BuildContext context) {

    switch(type) {
      case ItemType.adults:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiAdultsIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.kAdults.tr(),
                    style: StyleData.textStyleGray600M14,
                  ),
                  Text(
                    LocaleKeys.kAge13OrAbove.tr(),
                    style: StyleData.textStyleGray400R12,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.children:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiChildrenIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.kChildren.tr(),
                    style: StyleData.textStyleGray600M14,
                  ),
                  Text(
                    LocaleKeys.kAge2To12.tr(),
                    style: StyleData.textStyleGray400R12,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.infants:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiInfantsIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.kInfants.tr(),
                    style: StyleData.textStyleGray600M14,
                  ),
                  Text(
                    LocaleKeys.kUnder2.tr(),
                    style: StyleData.textStyleGray400R12,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.big:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiBigLuggageIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kBig.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.medium:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiMediumLuggageIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kMedium.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.small:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiSmallLuggageIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kSmall.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.surfboard:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiSurfboardIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kSurfboard.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.skiBoard:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiSkiBoardIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kSkiBoard.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.golf:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiGolfIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kGolf.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.bicycle:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiBicycleIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kBicycle.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.cats:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiCatsIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kCats.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case ItemType.dogs:
        return Padding(
          padding: EdgeInsets.symmetric(vertical: SizeData.s16, horizontal: SizeData.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Unit(context).iconSize(SizeData.s48),
                height: Unit(context).iconSize(SizeData.s48),
                child: SvgPicture.asset(
                  Assets.bookTaxiDogsIcon,
                  width: Unit(context).iconSize(SizeData.s48),
                  height: Unit(context).iconSize(SizeData.s48),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                LocaleKeys.kDogs.tr(),
                style: StyleData.textStyleGray600M14,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: Unit(context).width(SizeData.s100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(number > 0) {
                            if(onChange!= null) {
                              onChange!(number-1);
                            }
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiMinusBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
                      ),
                    ),
                    Text(
                      number.toString(),
                      style: StyleData.textStyleGray600M18,
                    ),
                    GestureDetector(
                      onTap: () {
                        
                          if(onChange!= null) {
                            onChange!(number+1);
                          }
                      },
                      child: SvgPicture.asset(
                        Assets.bookTaxiAddBoxIcon,
                        width: Unit(context).iconSize(SizeData.s24),
                        height: Unit(context).iconSize(SizeData.s24),
                        fit: BoxFit.scaleDown,
                        color: ColorData.primaryColor300,
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
}
