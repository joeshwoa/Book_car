import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/dialogs/modification_request_sent_success_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class ModificationRequestDialogCustom extends StatefulWidget {

  final String id;

  ModificationRequestDialogCustom({super.key, this.id = ''});

  @override
  State<ModificationRequestDialogCustom> createState() => _ModificationRequestDialogCustomState();
}

class _ModificationRequestDialogCustomState extends State<ModificationRequestDialogCustom> {
  late final MyBookingCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();
    }
    return BlocBuilder<MyBookingCubit, MyBookingState>(
      builder: (context, state) {
        if (state is SuccessModificationRequestState) {
          cubit.updateStateLessPageVar(change: () {
            cubit.modificationRequestSanded = true;
          });

          context.pop();
          showDialog(
              context: context,
              builder: (context) =>
              const ModificationRequestSentSuccessDialogCustom());
        }
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: ColorData.whiteColor200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeData.s8),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.lottieModificationRequestDialog,
                width: Unit(context).iconSize(SizeData.s150),
                height: Unit(context).iconSize(SizeData.s150),
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: Text(
                  'are you sure you want to send modification request?',
                  style: StyleData.textStyleGray500M14,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                child: Text(
                  'We will contact you to finalise your modification request. This message is not a definitive confirmation.',
                  style: StyleData.textStyleGray500R12,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: SizeData.s8),
                    child: MainButtonCustom(
                      onTap: () {
                        cubit.updateStateLessPageVar(change: (){
                          cubit.modificationRequestSanded = false;
                        });

                        cubit.modificationRequest(id: widget.id,);
                      },
                      text: LocaleKeys.kSend.tr(),
                      textStyle: StyleData.textStylePrimary50M16,
                      color: ColorData.primaryColor1000,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MainButtonCustom(
                    onTap: () {
                      context.pop();
                    },
                    text: LocaleKeys.kClose.tr(),
                    textStyle: StyleData.textStylePrimary500M14,
                    color: ColorData.primaryColor50,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}