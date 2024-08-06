import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';

class CardProfileCustom extends StatelessWidget {

  Function()? fct;
  final String text;
  final String image;

  CardProfileCustom({super.key,this.fct, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s10),
      child: GestureDetector(
        onTap: fct??(){},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: SizeData.s10,vertical: SizeData.s12),
          //margin: EdgeInsets.symmetric(vertical: SizeData.s10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeData.s16),
            border: Border.all(
              color: ColorData.grayColor300,)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(image,
                color: fct!=null ? ColorData.grayColor500 : ColorData.grayColor300,
                width: Unit(context).getWidthSize*0.064,
                height: Unit(context).getWidthSize*0.064,
              ),
              SizedBox(width: SizeData.s15,),
              Text(
                text, style:  StyleData.textStyleGray500M14.copyWith(
                color: fct!=null ? ColorData.grayColor500 : ColorData.grayColor300,
              ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: fct!=null ? ColorData.grayColor500 : ColorData.grayColor300,
                size: Unit(context).getWidthSize*0.053,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
