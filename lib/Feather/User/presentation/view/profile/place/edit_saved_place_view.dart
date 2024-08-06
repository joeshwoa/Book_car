import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/user_avatar_custom.dart';
import 'package:public_app/Core/widget/top_bars/layout_app_bar_custom.dart';

class EditSavedPlacesView extends StatefulWidget {

  const EditSavedPlacesView({super.key});

  @override
  State<EditSavedPlacesView> createState() => _EditSavedPlacesViewState();
}

class _EditSavedPlacesViewState extends State<EditSavedPlacesView> {

  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: Stack(
        children: [
          LayoutAppBarCustom(title: LocaleKeys.kPlaceDetails.tr()),
          Padding(
            padding: EdgeInsets.only(
              top: SizeData.s107,
              left: SizeData.s16,
              right: SizeData.s16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserAvatarCustom(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.kTitle.tr(),
                                style: StyleData.textStyleGray500R14,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                child: TextFormField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    border: BorderData.outlineInputBorderGray200W1R8,
                                    enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                                    focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                                    errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                    focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                    hintText: LocaleKeys.kTitle.tr(),
                                    hintStyle: StyleData.textStyleGray500R12,
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return LocaleKeys.kPleaseFillThisField.tr();
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  autofillHints: const [],
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.kAddress.tr(),
                                style: StyleData.textStyleGray500R14,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                child: TextFormField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    border: BorderData.outlineInputBorderGray200W1R8,
                                    enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                                    focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                                    errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                    focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                                    hintText: LocaleKeys.kAddress.tr(),
                                    hintStyle: StyleData.textStyleGray500R12,
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return LocaleKeys.kPleaseFillThisField.tr();
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  autofillHints: const [AutofillHints.addressCityAndState],
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  keyboardType: TextInputType.streetAddress,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      context.pop();
                    },
                    text: LocaleKeys.kSaveChanges.tr(),
                    textStyle: StyleData.textStylePrimary50M16,
                    color: ColorData.primaryColor1000,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                  child: MainButtonCustom(
                    onTap: () {
                      context.pop();
                    },
                    text: LocaleKeys.kDelete.tr(),
                    textStyle: StyleData.textStyleDanger500M14,
                    border: Border.all(
                      color: ColorData.dangerColor500,
                      width: SizeData.s1
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
