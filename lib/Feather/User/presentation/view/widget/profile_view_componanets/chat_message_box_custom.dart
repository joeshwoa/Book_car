import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/view/widget/shape/message_tail_shape_custom.dart';
import 'package:public_app/generated/assets.dart';

class ChatMessageBoxCustom extends StatelessWidget {

  final MessageType type;
  final String msg;
  final String time;
  const ChatMessageBoxCustom({super.key, required this.type, required this.msg, required this.time});

  @override
  Widget build(BuildContext context) {
    return type == MessageType.system ? Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: Unit(context).width(SizeData.s310),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              width: Unit(context).width(SizeData.s310),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorData.primaryColor25,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(SizeData.s16),
                          topLeft: Radius.circular(SizeData.s16),
                          topRight: Radius.circular(SizeData.s16),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeData.s8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg,
                            style: StyleData.textStyleGray500R14,
                          ),
                          SizedBox(
                            height: Unit(context).height(SizeData.s20),
                          )
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        width: Unit(context).width(SizeData.s45),
                        height: Unit(context).height(SizeData.s56),
                        decoration: ShapeDecoration(
                            shape: MessageTailShapeCustom(
                                radius: SizeData.s48,
                                fillColor:ColorData.primaryColor25,
                                borderWidth: 0,
                                bottomRight: true,
                                bottomLeft: false
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeData.s8),
                        child: Container(
                          width: Unit(context).iconSize(SizeData.s56),
                          height: Unit(context).iconSize(SizeData.s56),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorData.whiteColor200,
                              boxShadow: ShadowData.boxShadow3
                          ),
                          child: SvgPicture.asset(
                            Assets.userColoredLogo,
                            width: Unit(context).iconSize(SizeData.s32),
                            height: Unit(context).iconSize(SizeData.s32),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: SizeData.s32, bottom: SizeData.s64),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeData.s8),
                      color: ColorData.primaryColor500
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(SizeData.s4),
                        child: GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: msg));
                          },
                          child: SvgPicture.asset(
                            Assets.userClipboardIcon,
                            height: Unit(context).iconSize(SizeData.s16),
                            width: Unit(context).iconSize(SizeData.s16),
                            color: ColorData.whiteColor200,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeData.s4),
                        child: GestureDetector(
                          onTap: () {
                            // todo: like
                          },
                          child: SvgPicture.asset(
                            Assets.userLikeIcon,
                            height: Unit(context).iconSize(SizeData.s16),
                            width: Unit(context).iconSize(SizeData.s16),
                            color: ColorData.whiteColor200,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeData.s4),
                        child: GestureDetector(
                          onTap: () {
                            // todo: dislike
                          },
                          child: SvgPicture.asset(
                            Assets.userDislikeIcon,
                            height: Unit(context).iconSize(SizeData.s16),
                            width: Unit(context).iconSize(SizeData.s16),
                            color: ColorData.whiteColor200,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )
        : Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: Unit(context).width(SizeData.s290),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorData.grayColor25,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeData.s16),
                    topLeft: Radius.circular(SizeData.s16),
                    topRight: Radius.circular(SizeData.s16),
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(SizeData.s8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg,
                      style: StyleData.textStyleGray500R14,
                    ),
                    SizedBox(
                      height: Unit(context).height(SizeData.s20),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: StyleData.textStyleCustom2R12,
                    ),
                    SizedBox(
                      width: Unit(context).width(SizeData.s1),
                    ),
                    Icon(
                      Icons.done_all_outlined,
                      size: Unit(context).iconSize(SizeData.s16),
                      color: ColorData.customColor3,
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: Unit(context).width(SizeData.s45),
                      height: Unit(context).height(SizeData.s56),
                      decoration: ShapeDecoration(
                        shape: MessageTailShapeCustom(
                            radius: SizeData.s48,
                            fillColor:ColorData.grayColor25,
                            borderWidth: 0,
                            bottomRight: false,
                            bottomLeft: true
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeData.s8),
                      child: Container(
                        width: Unit(context).iconSize(SizeData.s56),
                        height: Unit(context).iconSize(SizeData.s56),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorData.grayColor25,
                            boxShadow: ShadowData.boxShadow3
                        ),
                        child: Center(
                          child: Text(
                            'EM',
                            style: StyleData.textStyleGray500R24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
