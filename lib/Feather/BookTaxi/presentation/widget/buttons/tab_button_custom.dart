
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';

class TabButtonCustom extends StatelessWidget {

  final Function() onTap;
  final bool? valid;
  final bool filled;
  final String text;
  final int? numberOfItems;
  const TabButtonCustom({super.key, required this.onTap, required this.text, this.valid, this.filled = false, this.numberOfItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeData.s8),
            color: valid != null ? (valid! ? ColorData.primaryColor300 : ColorData.dangerColor100) : (filled ? ColorData.primaryColor300 : ColorData.grayColor200 ),
            border: valid != null ? (valid! ? null : Border.all(
              width: Unit(context).width(SizeData.s0_5),
              color: ColorData.dangerColor300
            )) : null,
          ),
          constraints: BoxConstraints(
            minWidth: Unit(context).width(SizeData.s90),
          ),
          padding: EdgeInsets.all(SizeData.s8),
          child: Center(
            child: Text(
              numberOfItems != null && numberOfItems != 0? '${numberOfItems}x ${text}' : text,
              style: valid != null ? (valid! ? StyleData.textStyleWhite200R12 : StyleData.textStyleDanger400R12) : (filled ? StyleData.textStyleWhite200R12 : StyleData.textStyleGray500R12 ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }
}
