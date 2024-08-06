
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class ListTileHelpCustom extends StatelessWidget {
  final String title;
  final String image;
  final Function() fct;
  const ListTileHelpCustom({Key? key, required this.title, required this.fct, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fct,
      child: Container(
        decoration: ConstantData.decorationUser,
        padding: EdgeInsets.all(SizeData.s10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(image,
              height: Unit(context).getWidthSize*0.064,
              width: Unit(context).getWidthSize*0.064,
              color:  ColorData.grayColor500,
            ),
            SizedBox(width: SizeData.s10,),
            Text(
              title,
              style: StyleData.textStyleGray400R14 ,
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeData.s8),
              child: SvgPicture.asset(
                Assets.userArrowRightIcon,
                color:  ColorData.grayColor500,
                width: Unit(context).getWidthSize*0.058,
                height: Unit(context).getWidthSize*0.058,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
