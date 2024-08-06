
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';

class OutLineButtonCustom extends StatelessWidget {

  final Function() onTap;
  final IconData? icon;
  final String text;
  final bool textFirstIfIcon;
  final Color? color;
  final TextStyle? textStyle;
  const OutLineButtonCustom({super.key, required this.onTap, this.icon, required this.text, this.textFirstIfIcon = true, this.color, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeData.s8),
            border: Border.all(
              width: Unit(context).width(SizeData.s1),
              color: color??ColorData.gradientColor7,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeData.s12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(icon != null && !textFirstIfIcon)Padding(
                  padding: EdgeInsets.only(right: SizeData.s8),
                  child: SizedBox(
                    width: Unit(context).iconSize(SizeData.s24),
                    height: Unit(context).iconSize(SizeData.s24),
                    child: Icon(
                      icon,
                      color: ColorData.primaryColor500,
                      size: Unit(context).iconSize(SizeData.s24),
                    ),
                  ),
                ),
                Text(
                  text,
                  style: textStyle??StyleData.textStylePrimary500R14,
                ),
                if(icon != null && textFirstIfIcon)Padding(
                  padding: EdgeInsets.only(left: SizeData.s8),
                  child: SizedBox(
                    width: Unit(context).iconSize(SizeData.s24),
                    height: Unit(context).iconSize(SizeData.s24),
                    child: Icon(
                      icon,
                      color: ColorData.primaryColor500,
                      size: Unit(context).iconSize(SizeData.s24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
