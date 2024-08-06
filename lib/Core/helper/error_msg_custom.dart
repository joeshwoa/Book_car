
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';


class ErrorMsgCustom extends StatelessWidget {
  final String msg;
  const ErrorMsgCustom({Key? key,required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: ColorData.dangerColor300,
            size: Unit(context).getWidthSize*0.042,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Text(msg,style: StyleData.textStyleDanger300R12.copyWith(
                color: ColorData.dangerColor300,
                fontSize: Unit(context).getWidthSize*0.032
            ),),
          ),
        ],
      ),
    );
  }
}