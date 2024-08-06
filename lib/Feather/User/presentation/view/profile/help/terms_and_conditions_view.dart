import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';

class TermsAndConditionsView extends StatefulWidget {

  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kTermsAndConditions.tr()),
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
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Text(
                                  'title 1',
                                  style: StyleData.textStyleGray600R14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeData.s8),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad',
                                style: StyleData.textStyleGray400R12,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Text(
                                  'title 1',
                                  style: StyleData.textStyleGray600R14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeData.s8),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad',
                                style: StyleData.textStyleGray400R12,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                                child: Text(
                                  'title 1',
                                  style: StyleData.textStyleGray600R14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeData.s8),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad',
                                style: StyleData.textStyleGray400R12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
