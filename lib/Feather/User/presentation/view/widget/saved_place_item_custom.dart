import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class SavedPlaceItemCustom extends StatelessWidget {
  final String title;
  final String address;
  final String id;
  final Function() onTap;
  const SavedPlaceItemCustom({super.key, required this.title, required this.address, required this.id, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical: SizeData.s5),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(SizeData.s10),
              decoration: BoxDecoration(
                color: ColorData.grayColor50,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.userSavedPlaceIcon,
                  width: Unit(context).getWidthSize*0.064,
                  height: Unit(context).getWidthSize*0.064,
                  color: ColorData.warningColor300,
                ),
              ),
            ),
            SizedBox(width: SizeData.s15,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: StyleData.textStyleGray500M14.copyWith(
                    color: ColorData.grayColor500,
                    fontSize: Unit(context).getWidthSize*0.037
                  )),
                  Text(
                    address,
                    style: StyleData.textStyleGray400R14.copyWith(
                        color: ColorData.grayColor400,
                        fontSize: Unit(context).getWidthSize*0.032
                    ),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
