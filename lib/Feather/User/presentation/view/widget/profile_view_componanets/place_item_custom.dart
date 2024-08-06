import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class PlaceItemCustom extends StatelessWidget {

  final String address;
  final Function() onTap;
  final bool? isSelected;
  const PlaceItemCustom({super.key, required this.address, required this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: isSelected != null ? (isSelected! ? ColorData.primaryColor50 : null) : null,
          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeData.s4),
                child: Container(
                  height: Unit(context).iconSize(SizeData.s40),
                  width: Unit(context).iconSize(SizeData.s40),
                  decoration: BoxDecoration(
                    color: isSelected != null ? (isSelected! ? ColorData.primaryColor100 : ColorData.primaryColor50) : ColorData.primaryColor50,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.userLocationIcon,
                      width: Unit(context).iconSize(SizeData.s24),
                      height: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.primaryColor500,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: SizeData.s4),
                      child: Text(
                        address,
                        style: isSelected != null ? (isSelected! ? StyleData.textStylePrimary800M16 : StyleData.textStyleGray500M14) : StyleData.textStyleGray500M14,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
