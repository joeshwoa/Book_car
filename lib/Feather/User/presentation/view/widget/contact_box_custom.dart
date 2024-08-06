import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';

class ContactBoxCustom extends StatelessWidget {
  final String text;
  final String image;
  final Function() fct;
  const ContactBoxCustom({super.key, required this.text, required this.image, required this.fct});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fct,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SizeData.s12),
        margin: EdgeInsets.symmetric(vertical: SizeData.s5),
        decoration: BoxDecoration(
          color: ColorData.grayColor100,
          borderRadius: BorderRadius.circular(SizeData.s16)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeData.s14, vertical: SizeData.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(image,
                height: Unit(context).getWidthSize*0.064,
                width: Unit(context).getWidthSize*0.064,
                color: ColorData.grayColor400,
              ),
              SizedBox(width: SizeData.s15,),
              Expanded(
                child: Text(text,
                  style: StyleData.textStyleGray500R12.copyWith(
                    color: ColorData.grayColor500,
                    fontSize: Unit(context).getWidthSize*0.032
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
