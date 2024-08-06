import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_phone_custom.dart';
import 'package:public_app/Feather/User/presentation/view/widget/functions/forget_mail_sent_done_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class ForgetDialogCustom extends StatefulWidget {

  final String title;
  const ForgetDialogCustom({super.key, required this.title});

  @override
  State<ForgetDialogCustom> createState() => _ForgetDialogCustomState();
}

class _ForgetDialogCustomState extends State<ForgetDialogCustom> {

  TextEditingController phoneController = TextEditingController();
  late FocusNode phoneFocusNode;
  bool phoneIsFocused = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool valid = true;

  PhoneCountryData? selectedCountry;
  late List<PhoneCountryData> countryItems;

  @override
  void initState() {
    super.initState();
    countryItems = PhoneCodes.getAllCountryDatas();
    selectedCountry = countryItems.firstWhere(
          (element) => element.countryCode == 'FR',
    );
    phoneFocusNode = FocusNode();
    phoneFocusNode.addListener(() {
      setState(() {
        phoneIsFocused = phoneFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: ColorData.whiteColor200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            widget.title,
            style: StyleData.textStyleGray700M14,
          ),
          Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: Unit(context).iconSize(SizeData.s24),
                    color: ColorData.grayColor700,
                  ),
                ),
              )
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*SizedBox(
              width: Unit(context).getWidthSize*0.7,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: SizedBox(
                  height: Unit(context).height(SizeData.s56),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(right: SizeData.s16),
                        child: SizedBox(
                          width: Unit(context).width(SizeData.s81),
                          child: CountryPickerDropdownCustom(
                            initialValue: 'FR',
                            itemBuilder: buildDropdownItem,
                            isExpanded: false,
                            decoration: InputDecoration(
                              border: BorderData.outlineInputBorderPrimary200W1R8,
                              enabledBorder: BorderData.outlineInputBorderPrimary200W1R8,
                              focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                              errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                              focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'please fill this field';
                              }
                              return null;
                            },
                            iconSize: Unit(context).iconSize(SizeData.s19),
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.black,
                              size: Unit(context).iconSize(SizeData.s19),
                            ),
                            sortComparator:
                                (Country a, Country b) => a
                                .isoCode
                                .compareTo(b.isoCode),
                            onValuePicked: (Country country) {
                              setState(() {
                                selectedCountry =
                                    countryItems.firstWhere(
                                          (element) =>
                                      element.phoneCode ==
                                          country.phoneCode,
                                    );
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          focusNode: phoneFocusNode,
                          decoration: InputDecoration(
                            border: BorderData.outlineInputBorderPrimary200W1R8,
                            enabledBorder: BorderData.outlineInputBorderPrimary200W1R8,
                            focusedBorder: BorderData.outlineInputBorderPrimary700W1R8,
                            errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                            prefixText: phoneIsFocused
                                ? '+${selectedCountry?.phoneCode} '
                                : '',
                            hintText: phoneIsFocused
                                ? selectedCountry
                                ?.phoneMaskWithoutCountryCode
                                : '+${selectedCountry?.phoneCode} ${selectedCountry?.phoneMaskWithoutCountryCode}',
                            errorStyle: const TextStyle(
                              fontSize: 0
                            ),
                            hintStyle: StyleData.textStyleGray500R12,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          inputFormatters: [
                            PhoneInputFormatter(
                              allowEndlessPhone: false,
                              shouldCorrectNumber: true,
                              defaultCountryCode:
                              selectedCountry
                                  ?.countryCode,
                            )
                          ],
                          autofocus: false,
                          autofillHints: const [
                            AutofillHints.telephoneNumber
                          ],
                          textInputAction:
                          TextInputAction.next,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: InputPhoneCustom(
                controller: phoneController,
                labelText: '+33 659556556',
                onCountryChanged: (val){

                },
              ),
            ),
            if(!valid)SizedBox(
              width: Unit(context).getWidthSize*0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeData.s4),
                    child: SvgPicture.asset(
                      Assets.bookTaxiWarningIcon,
                      width: Unit(context).iconSize(SizeData.s16),
                      height: Unit(context).iconSize(SizeData.s16),
                      color: ColorData.dangerColor300,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.kThisPhoneNumberDoesNotExits.tr(),
                          style: StyleData.textStyleDanger300R12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        MainButtonCustom(
          onTap: () {
            if(formKey.currentState!.validate()) {
              setState(() {
                valid = true;
              });
              context.pop();
              showDialog(context: context, builder: (context) => const ForgetMailSentDoneDialogCustom());
            } else {
              setState(() {
                valid = false;
              });
            }
          },
          text: LocaleKeys.kNext.tr(),
          textStyle: phoneController.text.isNotEmpty ? StyleData.textStylePrimary50M16 : StyleData.textStyleGray400M16,
          color: phoneController.text.isNotEmpty ? ColorData.primaryColor1000 : ColorData.grayColor300,
        ),
      ],
    );
  }

  Widget buildDropdownItem(Country country) => Container(
    height: SizeData.s24,
    width: SizeData.s36,
    decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(SizeData.s3_64)),
    clipBehavior: Clip.antiAlias,
    child: CountryPickerUtils.getDefaultFlagImage(country),
  );
}