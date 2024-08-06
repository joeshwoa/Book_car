import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/profile_view_componanets/chat_message_box_custom.dart';
import 'package:public_app/generated/assets.dart';

class ChatWithUsView extends StatefulWidget {

  const ChatWithUsView({super.key});

  @override
  State<ChatWithUsView> createState() => _ChatWithUsViewState();
}

class _ChatWithUsViewState extends State<ChatWithUsView> {

  List<Map<String, String>> messages = [
    {
      'type': 'user',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
    {
      'type': 'system',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
    {
      'type': 'user',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
    {
      'type': 'system',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
    {
      'type': 'user',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
    {
      'type': 'system',
      'time': '7:20',
      'msg': 'Lorem ipsum dolor sit amet consectetur. Nunc auctor tortor duis vestibulum quisque in vulputate enim. Consequat sit elit cursus consectetur.',
    },
  ];

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kChatWithUs.tr()),
          Padding(
            padding: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorData.whiteColor200,
                borderRadius: BorderRadius.circular(SizeData.s16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: EdgeInsets.all(SizeData.s16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; i < messages.length; i++)...[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s16),
                                child: ChatMessageBoxCustom(type: messages[i]['type'] == 'system' ? MessageType.system : MessageType.user, msg: messages[i]['msg']!, time: messages[i]['time']!,),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Unit(context).height(SizeData.s80),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Unit(context).height(SizeData.s80),
              decoration: BoxDecoration(
                  color: ColorData.whiteColor200,
                  boxShadow: ShadowData.boxShadow2
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeData.s8),
                  child: Container(
                    height: Unit(context).height(SizeData.s48),
                    decoration: BoxDecoration(
                        color: ColorData.grayColor25,
                      borderRadius: BorderRadius.circular(SizeData.s8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: BorderData.outlineInputBorderGray25W0R8,
                              enabledBorder: BorderData.outlineInputBorderGray25W0R8,
                              focusedBorder: BorderData.outlineInputBorderGray25W0R8,
                              errorBorder: BorderData.outlineInputBorderGray25W0R8,
                              focusedErrorBorder: BorderData.outlineInputBorderGray25W0R8,
                              hintText: LocaleKeys.kTypeYourMessageHere.tr(),
                              hintStyle: StyleData.textStyleGray300R12,
                            ),
                            autofocus: false,
                            autofillHints: const [],
                            textInputAction:
                            TextInputAction.send,
                            obscureText: false,
                            keyboardType:
                            TextInputType.multiline,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeData.s8),
                          child: GestureDetector(
                            onTap: () {
                              // todo: send msg
                            },
                            child: SvgPicture.asset(
                              Assets.userSendIcon,
                              height: Unit(context).iconSize(SizeData.s24),
                              width: Unit(context).iconSize(SizeData.s24),
                              color: ColorData.primaryColor600,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
