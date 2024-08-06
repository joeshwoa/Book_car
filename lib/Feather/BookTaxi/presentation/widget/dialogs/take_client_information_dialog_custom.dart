import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/helper/error_app_custom.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/helper/sussess_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_phone_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/log_in_to_view_price_dialog_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/generated/assets.dart';

class TakeClientInformationDialogCustom extends StatefulWidget {
  const TakeClientInformationDialogCustom({super.key});

  @override
  State<TakeClientInformationDialogCustom> createState() => _TakeClientInformationDialogCustomState();
}

class _TakeClientInformationDialogCustomState extends State<TakeClientInformationDialogCustom> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late FocusNode phoneFocusNode;
  bool phoneIsFocused = false;
  String countryCode = '+33';
  String starsPhoneNumber = '*********';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool visionPassword = false;
  bool createAccount = true;

  bool existAccount = false;

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
            LocaleKeys.kClientInformation.tr(),
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
                    size: SizeData.s24,
                    color: ColorData.grayColor700,
                  ),
                ),
              )
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: BlocConsumer<UserCubit,UserState>(
  listener: (context, state) {
    if(state is SuccessLoginGuestState){
      Navigator.pop(context);
      showSuccessToast(context: context,msg: state.msg??'');
    }else if(state is ErrorLoginGuestState){
      Navigator.pop(context);
      showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
    }else if(state is FailLoginGuestUserExistsState){
      existAccount = true;
    }else if(state is LoadingLoginGuestState){
      existAccount = false;
    }
  },
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  border: BorderData.outlineInputBorderGray200W1R8,
                  enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                  focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                  errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                  focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(SizeData.s4),
                    child: SvgPicture.asset(
                      Assets.userUserNameIcon,
                      height: Unit(context).iconSize(SizeData.s24),
                      width: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.grayColor200,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: SizeData.s24+8,
                    maxHeight: SizeData.s24+8,
                  ),
                  errorStyle: const TextStyle(
                      fontSize: 0
                  ),
                  hintText: LocaleKeys.kFullName.tr(),
                  hintStyle: StyleData.textStyleGray500R12,
                ),
                onChanged: (value) {
                  setState(() {
                    existAccount = false;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.kPleaseFillThisField.tr();
                  }
                  return null;
                },
                autofocus: false,
                autofillHints: const [AutofillHints.name],
                textInputAction: TextInputAction.next,
                obscureText: false,
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: BorderData.outlineInputBorderGray200W1R8,
                  enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                  focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                  errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                  focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(SizeData.s4),
                    child: SvgPicture.asset(
                      Assets.userMessageIcon,
                      width: Unit(context).iconSize(SizeData.s24),
                      height: Unit(context).iconSize(SizeData.s24),
                      color: ColorData.grayColor200,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: SizeData.s24+8,
                    maxHeight: SizeData.s24+8,
                  ),
                  errorStyle: const TextStyle(
                      fontSize: 0
                  ),
                  hintText: LocaleKeys.kEmail.tr(),
                  hintStyle: StyleData.textStyleGray500R12,
                ),
                onChanged: (value) {
                  setState(() {
                    existAccount = false;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.kPleaseFillThisField.tr();
                  }
                  if (existAccount) {
                    return LocaleKeys.kThisAccountAlreadyExistsPleaseLogIn.tr();
                  }
                  return null;
                },
                autofocus: false,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            if(state is FailLoginGuestUserExistsState)SizedBox(
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
                          LocaleKeys.kThisAccountAlreadyExistsPleaseLogIn.tr(),
                          style: StyleData.textStyleDanger300R12,
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            /*Padding(
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
                      const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: Unit(context).height(SizeData.s81),
                        child: CountryPickerDropdownCustom(
                          initialValue: 'FR',
                          itemBuilder: buildDropdownItem,
                          isExpanded: false,
                          decoration: InputDecoration(
                            border: BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          iconSize: 19,
                          icon: const Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.black,
                            size: 19,
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
                          border: BorderData.outlineInputBorderGray200W1R8,
                          enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                          focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                          errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                          focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                          prefixText: phoneIsFocused
                              ? '+${selectedCountry?.phoneCode} '
                              : '',
                          hintText: phoneIsFocused
                              ? selectedCountry
                              ?.phoneMaskWithoutCountryCode
                              : '+${selectedCountry?.phoneCode} ${selectedCountry?.phoneMaskWithoutCountryCode}',
                          hintStyle: StyleData.textStyleGray500R12,
                          errorStyle: const TextStyle(
                              fontSize: 0
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            existAccount = false;
                          });
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
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputPhoneCustom(
                controller: phoneController,
                labelText: '+$countryCode $starsPhoneNumber',
                onCountryChanged: (val){
                  countryCode = '+${val.dialCode}';
                  starsPhoneNumber = '';
                  for(int i = 0; i < val.maxLength; i++) {
                    starsPhoneNumber += '*';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeData.s4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: createAccount,
                    onChanged: (value) {
                      setState(() {
                        createAccount = value?? false;
                      });
                    },
                    activeColor: ColorData.blueColor400,
                  ),
                  SizedBox(
                    width: Unit(context).getWidthSize*0.55,
                    child: Text(
                      LocaleKeys.kIConsentToCreateAnAccount.tr(),
                      style: StyleData.textStyleGray500R14,
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            if(state is FailLoginGuestState)SizedBox(
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
                          LocaleKeys.kEnterAValidData.tr(),
                          style: StyleData.textStyleDanger300R12,
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            (state is LoadingLoginState)?
            const LoadingAppCustom():
            MainButtonCustom(
              onTap: (){
                if(fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                  if(!existAccount) {
                    if(formKey.currentState!.validate()) {
                      cubit.loginGuest(
                          email: emailController.text,
                          name: fullNameController.text,
                          phone: '$countryCode ${phoneController.text}');
                    }
                  } else {
                    context.pop();
                    showDialog(context: context, builder: (context) => const LogInToViewPriceDialogCustom(showRememberMeRow: true,));
                  }
                }
              },
                text: existAccount ? LocaleKeys.kSignIntoMyAccount.tr() : LocaleKeys.kViewPrices.tr(),
                textStyle: fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty ? StyleData.textStylePrimary50M16 : StyleData.textStyleGray400M16,
                color: fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty ? ColorData.primaryColor1000 : ColorData.grayColor300,
            ),
          ],
        );
  },
),
      ),
      /*actions: [
        MainButtonCustom(
          onTap: () {
            if(!existAccount) {
              if(formKey.currentState!.validate()) {
                cubit.login(
                    email: emailController.text,
                    password: passwordController.text);
              }
            } else {
              context.pop();
              showDialog(context: context, builder: (context) => const LogInToViewPriceDialogCustom(showRememberMeRow: true,));
            }
          },
          text: existAccount ? LocaleKeys.kSignIntoMyAccount.tr() : LocaleKeys.kViewPrices.tr(),
          textStyle: fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty ? StyleData.textStylePrimary50M16 : StyleData.textStyleGray400M16,
          color: fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty ? ColorData.primaryColor1000 : ColorData.grayColor300,
        ),
      ],*/
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