import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/services/launch_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/BookTaxi/presentation/widget/dialogs/invoice_sent_success_dialog_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/generated/assets.dart';

class InvoiceForFinishedBookingsBottomSheetCustom extends StatelessWidget {

  final String id;
  final bool cardOnlinePayment;
  InvoiceForFinishedBookingsBottomSheetCustom({super.key, required this.id, required this.cardOnlinePayment});

  late final MyBookingCubit cubit;

  bool first = true;

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  List<String> mrOrMs = [LocaleKeys.kMR.tr(), LocaleKeys.kMS.tr()];

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();

      firstNameController.text = cubit.tempFirstName;
      lastNameController.text = cubit.tempLastName;
      userNameController.text = cubit.tempUsername;
      companyNameController.text = cubit.tempCompanyName;
      addressController.text = cubit.tempAddress;
    }
    return BlocBuilder<MyBookingCubit, MyBookingState>(
      builder: (context, state) {
        if (state is SuccessCreateInvoiceState) {
          cubit.updateStateLessPageVar(change: () {
            cubit.invoiceSanded = true;
          });
          context.pop();
          showDialog(
              context: context,
              builder: (context) =>
              InvoiceSentSuccessDialogCustom(cardOnlinePayment: cardOnlinePayment,));
        }
        return Container(
          decoration: BoxDecoration(
            color: ColorData.whiteColor200,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeData.s16),
                topLeft: Radius.circular(SizeData.s16)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Scaffold(
            backgroundColor: ColorData.whiteColor200,
            body: Container(
              margin: EdgeInsets.all(SizeData.s12),
              decoration: BoxDecoration(
                color: ColorData.whiteColor200,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(SizeData.s16),
                    topLeft: Radius.circular(SizeData.s16)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            LocaleKeys.kInvoiceInformation.tr(),
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
                                    color: ColorData.grayColor600,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                      child: GestureDetector(
                        onTap: () {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempIsCompany = false;
                          },);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: SizeData.s8),
                              child: SvgPicture.asset(
                                Assets.bookTaxiIndividualIcon,
                                width: Unit(context).iconSize(SizeData.s24),
                                height:
                                Unit(context).iconSize(SizeData.s24),
                                fit: BoxFit.scaleDown,
                                color: !cubit.tempIsCompany
                                    ? ColorData.primaryColor500
                                    : ColorData.grayColor500,
                              ),
                            ),
                            Text(
                              LocaleKeys.kIndividual.tr(),
                              style: StyleData.textStyleGray600R14,
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              width: Unit(context).width(SizeData.s16),
                              height: Unit(context).width(SizeData.s16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: !cubit.tempIsCompany
                                        ? Unit(context).width(SizeData.s4)
                                        : Unit(context).width(SizeData.s1),
                                    color: !cubit.tempIsCompany
                                        ? ColorData.blueColor400
                                        : ColorData.grayColor300,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                      child: GestureDetector(
                        onTap: () {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempIsCompany = true;
                          },);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: SizeData.s8),
                              child: SvgPicture.asset(
                                Assets.bookTaxiCompanyIcon,
                                width: Unit(context).iconSize(SizeData.s24),
                                height:
                                Unit(context).iconSize(SizeData.s24),
                                fit: BoxFit.scaleDown,
                                color: cubit.tempIsCompany
                                    ? ColorData.primaryColor500
                                    : ColorData.grayColor500,
                              ),
                            ),
                            Text(
                              LocaleKeys.kCompany.tr(),
                              style: StyleData.textStyleGray600R14,
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              width: Unit(context).width(SizeData.s16),
                              height: Unit(context).width(SizeData.s16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: cubit.tempIsCompany
                                        ? Unit(context).width(SizeData.s4)
                                        : Unit(context).width(SizeData.s1),
                                    color: cubit.tempIsCompany
                                        ? ColorData.blueColor400
                                        : ColorData.grayColor300,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (cubit.tempIsCompany)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeData.s8),
                        child: TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            border:
                            BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kUserName.tr(),
                            hintStyle: StyleData.textStyleGray400R12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempUsername = value;
                            },);
                          },
                          autofocus: false,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    if (cubit.tempIsCompany)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeData.s8),
                        child: DropdownButtonFormField<String>(
                          items: mrOrMs.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          decoration: InputDecoration(
                            border:
                            BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kGender.tr()
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempCourtesyTitles = value ?? '';
                            },);
                          },
                          autofocus: false,
                          value: cubit.tempCourtesyTitles != '' ? cubit.tempCourtesyTitles : null,
                        ),
                      ),
                    if (cubit.tempIsCompany)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeData.s8),
                        child: TextFormField(
                          controller: companyNameController,
                          decoration: InputDecoration(
                            border:
                            BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kCompanyName.tr(),
                            hintStyle: StyleData.textStyleGray400R12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempCompanyName = value;
                            },);
                          },
                          autofocus: false,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    if (!cubit.tempIsCompany)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeData.s8),
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border:
                            BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kFirstName.tr(),
                            hintStyle: StyleData.textStyleGray400R12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempFirstName = value;
                            },);
                          },
                          autofocus: false,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    if (!cubit.tempIsCompany)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeData.s8),
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            border:
                            BorderData.outlineInputBorderGray200W1R8,
                            enabledBorder:
                            BorderData.outlineInputBorderGray200W1R8,
                            focusedBorder:
                            BorderData.outlineInputBorderPrimary500W1R8,
                            errorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            focusedErrorBorder:
                            BorderData.outlineInputBorderDanger400W1R8,
                            hintText: LocaleKeys.kLastName.tr(),
                            hintStyle: StyleData.textStyleGray400R12,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill this field';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.updateStateLessPageVar(change: () {
                              cubit.tempLastName = value?? '';
                            },);
                          },
                          autofocus: false,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeData.s8),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          border: BorderData.outlineInputBorderGray200W1R8,
                          enabledBorder:
                          BorderData.outlineInputBorderGray200W1R8,
                          focusedBorder:
                          BorderData.outlineInputBorderPrimary500W1R8,
                          errorBorder:
                          BorderData.outlineInputBorderDanger400W1R8,
                          focusedErrorBorder:
                          BorderData.outlineInputBorderDanger400W1R8,
                          hintText: LocaleKeys.kAddress.tr(),
                          hintStyle: StyleData.textStyleGray400R12,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill this field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempAddress = value?? '';
                          },);
                        },
                        autofocus: false,
                        autofillHints: const [
                          AutofillHints.addressCityAndState
                        ],
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                      child: MainButtonCustom(
                        onTap: () {
                          cubit.changeIsCompany(value: cubit.tempIsCompany);
                          if (cubit.tempIsCompany) {
                            cubit.changeCompanyName(
                                value: companyNameController.text);
                            cubit.changeUserName(
                                value: userNameController.text);
                            cubit.changeCourtesyTitles(
                                value: cubit.tempCourtesyTitles);
                          } else {
                            cubit.changeFirstName(
                                value: firstNameController.text);
                            cubit.changeLastName(
                                value: lastNameController.text);
                          }
                          cubit.changeAddress(
                              value: addressController.text);
                          cubit.updateStateLessPageVar(change: () {
                            cubit.invoiceSanded = false;
                          });
                          if (cardOnlinePayment) {
                            cubit.createInvoiceForCardOnline(id: id);
                          } else {
                            cubit.createInvoiceForCardOnBoardAndCash(id: id);
                          }
                        },
                        text: cardOnlinePayment ? LocaleKeys.kCreateInvoice.tr() : LocaleKeys.kSendRequest,
                        textStyle: StyleData.textStylePrimary50M16,
                        color: ColorData.primaryColor1000,
                        loading: !cubit.invoiceSanded,
                        loadingColor: ColorData.primaryColor50,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: SizeData.s12),
                      child: GestureDetector(
                        onTap: () async {
                          await launchLink(
                              Uri(
                                scheme: 'tel',
                                path: ConstantData.callUsKiro.replaceAll(" ", ""),
                              )
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(SizeData.s8),
                            border: Border.all(
                                width: Unit(context).width(SizeData.s1),
                                color: ColorData.primaryColor100),
                          ),
                          padding: EdgeInsets.all(SizeData.s10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(right: SizeData.s8),
                                child: Text(
                                  LocaleKeys.kCustomerService.tr(),
                                  style: StyleData.textStylePrimary500R14,
                                ),
                              ),
                              SizedBox(
                                width:
                                Unit(context).iconSize(SizeData.s24),
                                height:
                                Unit(context).iconSize(SizeData.s24),
                                child: SvgPicture.asset(
                                  Assets.bookTaxiHalfPhoneIcon,
                                  width: Unit(context)
                                      .iconSize(SizeData.s24),
                                  height: Unit(context)
                                      .iconSize(SizeData.s24),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
